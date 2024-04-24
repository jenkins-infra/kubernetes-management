#!/bin/bash
set -eu -o pipefail

: "${1?First argument expected (Java version to check)}"
: "${2?Second argument expected (Operating system)}"
: "${3?Third argument expected (CPU Architecture)}"

java_version="$1" # Has a 'jdk-' (or 'jdk') prefix
operating_system="$2"
cpu_architecture="$3"

# Fetch the download URL from the Adoptium API
api_url="https://api.adoptium.net/v3/binary/version/${java_version}/${operating_system}/${cpu_architecture}/jdk/hotspot/normal/eclipse?project=jdk"

download_url="$(curl --fail --write "%{redirect_url}" --silent --show-error "${api_url}")"
echo "${download_url}"
