#!/usr/bin/env python3
# Require Python 3.8

import json
import re
from datetime import datetime, timezone
from urllib.request import urlopen
from urllib.error import URLError, HTTPError

from datadog_checks.base.checks import AgentCheck

PLUGIN_HEALTH_ENGINES_URL = 'https://plugin-health.jenkins.io/actuator/health/engines'

class PluginHealthEngineStaleness(AgentCheck):
    """
        Checks plugin-health-scoring engine staleness from its actuator endpoint.
        Fetches the engines health group, computes the age of each engine's last
        success, and submits metrics.
    """

    def fetch_health(self, url):
        '''
            fetch_health fetches and parses the actuator health group
        '''
        try:
            resp = urlopen(url, timeout=10)
            if resp.code != 200:
                print(f'return code should be 200 but is {resp.code}')
                return None
            return json.loads(resp.read().decode('utf-8'))
        except HTTPError as err:
            print(f'Something went wrong with url {url}: {err}')
            return None
        except URLError as err:
            self.warning(f"PluginHealthEngineStaleness: URL error for {url}: {err}")
            return None

    def parse_last_success(self, value):
        '''
            parse_last_success parses the actuator timestamp. It carries nanosecond
            precision, which fromisoformat only accepts from Python 3.11, so the
            fraction is truncated to microseconds first.
        '''
        iso = value.replace('Z', '+00:00')
        return datetime.fromisoformat(re.sub(r'(\.\d{6})\d*', r'\1', iso))

    def check(self, instance):
        """
            Datadog custom check
        """
        url = PLUGIN_HEALTH_ENGINES_URL
        engines = instance['engines']
        threshold_in_minutes = instance['threshold_in_minutes']
        threshold_in_hours = threshold_in_minutes / 60

        data = self.fetch_health(url)

        if data is None:
            for engine in engines:
                self.gauge('jenkins.phs_engine.reachable', 0, tags=[f"engine:{engine}"])
                self.gauge('jenkins.phs_engine.engine_ok', 0, tags=[f"engine:{engine}"])
            return

        components = data.get('components', {})

        for engine in engines:
            base_tags = [f"engine:{engine}"]
            component = components.get(engine, {})

            status = component.get('status', 'UNKNOWN')
            tags = base_tags + [f"status:{status.lower()}"]

            self.gauge('jenkins.phs_engine.reachable', 1, tags=tags)

            engine_ok = 1 if status == 'UP' else 0
            self.gauge('jenkins.phs_engine.engine_ok', engine_ok, tags=tags)

            # Age of the last success. The status field is derived from the last
            # recorded success and never expires, so an engine that stops being
            # scheduled keeps reporting UP with an ageing timestamp: the age is what
            # detects that, not the status.
            try:
                ts = self.parse_last_success(component['details']['lastSuccess'])
                age_in_hours = (datetime.now(timezone.utc) - ts).total_seconds() / 3600
                stale = age_in_hours > threshold_in_hours
                staleness_tags = tags + [f"threshold_in_hours:{int(threshold_in_hours)}"]
                self.gauge('jenkins.phs_engine.age_in_hours', round(age_in_hours, 2), tags=staleness_tags)
                self.gauge('jenkins.phs_engine.threshold_in_hours', round(threshold_in_hours, 2), tags=staleness_tags)
                self.gauge('jenkins.phs_engine.stale', stale, tags=staleness_tags)
            except (KeyError, ValueError) as err:
                self.warning(f"PluginHealthEngineStaleness: Bad lastSuccess for {engine} in {url}: {err}")
