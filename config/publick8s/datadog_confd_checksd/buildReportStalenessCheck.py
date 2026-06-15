#!/usr/bin/env python3
# Require Python 3.8

import json
from datetime import datetime, timezone
from urllib.request import urlopen
from urllib.error import URLError, HTTPError

from datadog_checks.base.checks import AgentCheck

BUILD_REPORTS_BASE = 'https://builds.reports.jenkins.io/build_status_reports'

class BuildReportStaleness(AgentCheck):
    """
        Checks build report staleness from builds.reports.jenkins.io.
        Fetches status.json, computes age, and submits metrics.
    """

    def fetch_report(self, url):
        '''
            fetch_report fetches and parses the status.json report
        '''
        try:
            resp = urlopen(url, timeout=10)
            if resp.code != 200:
                print(f'return code should be 200 but is {resp.code}')
                return None
            return json.loads(resp.read().decode('utf-8'))
        except HTTPError as err:
            if err.code == 404:
                print(f'Report not found at {url}')
            else:
                print(f'Something went wrong with url {url}: {err}')
            return None
        except URLError as err:
            self.warning(f"BuildReportStaleness: URL error for {url}: {err}")
            return None

    def check(self, instance):
        """
            Datadog custom check
        """
        controller = instance['controller']
        job = instance['job']
        url = f"{BUILD_REPORTS_BASE}/{controller}/{job}/status.json"
        threshold_in_minutes = instance['threshold_in_minutes']
        base_tags = [f"controller:{controller}"]

        self.warning(f"BuildReportStaleness: {controller}")

        data = self.fetch_report(url)

        if data is None:
            self.gauge('jenkins.build_report.reachable', 0, tags=base_tags)
            self.gauge('jenkins.build_report.build_ok', 0, tags=base_tags)
            return

        job_name = data.get('job_name', 'unknown')
        build_status = data.get('build_status', 'UNKNOWN')
        tags = base_tags + [
            f"job:{job_name}",
            f"build_status:{build_status.lower()}",
        ]

        # Reachable
        self.gauge('jenkins.build_report.reachable', 1, tags=tags)

        # Build status
        build_ok = 1 if build_status == 'SUCCESS' else 0
        self.gauge('jenkins.build_report.build_ok', build_ok, tags=tags)

        # Age (staleness)
        try:
            ts = datetime.fromtimestamp(int(data['report_timestamp']), tz=timezone.utc)
            age_in_hours = (datetime.now(timezone.utc) - ts).total_seconds() / 3600
            threshold_in_hours = threshold_in_minutes / 60
            stale = age_in_hours > threshold_in_hours
            staleness_tags = tags + [f"threshold_in_hours:{int(threshold_in_hours)}"]
            self.gauge('jenkins.build_report.age_in_hours', round(age_in_hours, 2), tags=staleness_tags)
            self.gauge('jenkins.build_report.threshold_in_hours', round(threshold_in_hours, 2), tags=staleness_tags)
            self.gauge('jenkins.build_report.stale', stale, tags=staleness_tags)
        except (KeyError, ValueError) as err:
            self.warning(f"BuildReportStaleness: Bad timestamp in {url}: {err}")
