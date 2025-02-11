#!/bin/sh
# Based on https://github.com/matco/connectiq-tester/blob/master/downloader.sh

set -e

CONNECTIQ_SDK_URL="https://developer.garmin.com/downloads/connect-iq/sdks"
CONNECTIQ_SDK_INFO_URL="${CONNECTIQ_SDK_URL}/sdks.json"

filename=$(/usr/bin/curl -s "${CONNECTIQ_SDK_INFO_URL}" | /usr/bin/jq -r --arg version "$CONNECT_IQ_VERSION" '.[] | select(.version==$version) | .linux')
url="${CONNECTIQ_SDK_URL}/${filename}"

echo "Downloading from $url"

curl -s "${url}" -o /tmp/connectiq.zip
unzip -q /tmp/connectiq.zip -d "${CONNECT_IQ_HOME}" -x "doc/*" "resources/*" "samples/*" "*.html"

echo "Downloaded $VERSION"