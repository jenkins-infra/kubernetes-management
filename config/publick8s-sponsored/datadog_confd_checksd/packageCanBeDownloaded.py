#!/usr/bin/env python3
# Require Python 3.8

from urllib.request import urlopen
from urllib.error import URLError, HTTPError

import xml.etree.ElementTree as ET

from datadog_checks.base.checks import AgentCheck


def is_exist(distribution, url):
    '''
        is_exist test if a specific artifact exist on the destination
    '''
    try:
        return_code = urlopen(url).code
        if return_code != 200:
            print(f'return code should be 200 but is {return_code}')
        return 1
    except HTTPError as err:
        if err.code == 404:
            print(f'{distribution} package not found on {url}')
        else:
            print(f'Something went wrong with url {url} for {distribution} package: {err}')
        return 0


class PackageCanBeDownloaded(AgentCheck):
    """
        Tests that the latest jenkins packages can be downloaded
    """

    root = None

    def build_tree(self, metadataUrl='https://repo.jenkins-ci.org/releases/org/jenkins-ci/main/jenkins-war/maven-metadata.xml'):
        try:
            tree = ET.parse(urlopen(metadataUrl))
            root = tree.getroot()
            return root

        except URLError as err:
            self.warning(f"Error when building tree from metadata url: {err}")

    def get_latest_weekly_version(self):
        if not self.root:
            self.root = self.build_tree()
        return self.root.find('versioning/latest').text

    def get_latest_stable_version(self):
        """
        Input: a list of Jenkins versions
        Output: returns the latest stable version

        Jenkins versions follow the pattern X.Y.Z where:
            - X.Y is a weekly version
            - X.Y.Z is a stable version
        That is why we filter for stable versions with count('.') == 2.
        """
        if not self.root:
            self.root = self.build_tree()
        versions = self.root.findall('versioning/versions/version')
        stable_versions = [version.text for version in versions if version.text.count('.') == 2]

        def as_version(ele):
            major, minor, patch = ele.split('.')
            if not patch.isdigit():
                return [int(major), int(minor)]
            return [int(major), int(minor), int(patch)]

        stable_versions.sort(key=as_version, reverse=True)
        return stable_versions[0]


    def create_endpoints(self, hostname='get.jenkins.io'):
        weekly_version = self.get_latest_weekly_version()
        stable_version = self.get_latest_stable_version()

        endpoints = {
            'debian': f'https://{hostname}/debian/jenkins_{weekly_version}_all.deb',
            'rpm': f'https://{hostname}/rpm/jenkins-{weekly_version}-1.noarch.rpm',
            'windows': f'https://{hostname}/windows/{weekly_version}/jenkins.msi',
            'war': f'https://{hostname}/war/{weekly_version}/jenkins.war',
            'debian-stable': f'https://{hostname}/debian-stable/jenkins_{stable_version}_all.deb',
            'rpm-stable': f'https://{hostname}/rpm-stable/jenkins-{stable_version}-1.noarch.rpm',
            'windows-stable': f'https://{hostname}/windows-stable/{stable_version}/jenkins.msi',
            'war-stable': f'https://{hostname}/war-stable/{stable_version}/jenkins.war',
        }
        return endpoints

    def check(self, instance):
        """
            Datadog custom check
        """
        endpoints = self.create_endpoints()
        metric = 'jenkins.package.available'
        package = instance['package']
        self.warning(f"PackageAvailable: {package}")
        tags = ["package:" + package,]

        if package in endpoints:
            self.gauge(metric, is_exist(package, endpoints[package]), tags)
        else:
            self.warning(f"PackageCanDownload: Package {package} is not supported")


if __name__ == "__main__":
    '''
        This exists only for testing purposes
    '''
    p = PackageCanBeDownloaded()
    weekly_version = p.get_latest_weekly_version()
    stable_version = p.get_latest_stable_version()
    print(f"Latest weekly version: {weekly_version}")
    print(f"Latest stable version: {stable_version}")

    endpoints = p.create_endpoints()
    for package, message in endpoints.items():
        if not is_exist(package, message):
            print(f"Latest version for package {package} not available from {message}")
        else:
            print(f"Latest version for package {package} available from {message}")
