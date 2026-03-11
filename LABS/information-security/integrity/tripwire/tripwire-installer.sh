#!/usr/bin/env bash
set -euo pipefail

LAB_TW_SITE_PASSPHRASE="${LAB_TW_SITE_PASSPHRASE:-tripwire-site-lab-pass}"
LAB_TW_LOCAL_PASSPHRASE="${LAB_TW_LOCAL_PASSPHRASE:-tripwire-local-lab-pass}"

export DEBIAN_FRONTEND=noninteractive

echo "Updating package index"
apt-get update

echo "Tripwire debconf answers..."
echo "tripwire tripwire/site-passphrase password ${LAB_TW_SITE_PASSPHRASE}" | debconf-set-selections
echo "tripwire tripwire/site-passphrase-again password ${LAB_TW_SITE_PASSPHRASE}" | debconf-set-selections
echo "tripwire tripwire/local-passphrase password ${LAB_TW_LOCAL_PASSPHRASE}" | debconf-set-selections
echo "tripwire tripwire/local-passphrase-again password ${LAB_TW_LOCAL_PASSPHRASE}" | debconf-set-selections
echo "tripwire tripwire/use-sitekey boolean true" | debconf-set-selections
echo "tripwire tripwire/use-localkey boolean true" | debconf-set-selections
echo "tripwire tripwire/rebuild-config boolean true" | debconf-set-selections
echo "tripwire tripwire/rebuild-policy boolean true" | debconf-set-selections

