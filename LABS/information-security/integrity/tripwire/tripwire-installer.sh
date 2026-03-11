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

echo "Installing Tripwire..."
apt-get install -y tripwire
echo "Initializing Tripwire database..."
tripwire --init --local-passphrase "${LAB_TW_LOCAL_PASSPHRASE}"
echo "Running first integrity check..."
tripwire --check --local-passphrase "${LAB_TW_LOCAL_PASSPHRASE}" || true

LATEST_REPORT="$(ls -1t /var/lib/tripwire/report/*.twr 2>/dev/null | head -n1 || true)"

echo ""
echo "Tripwire setup completed."
if [[ -n "$LATEST_REPORT" ]]; then
    echo "Latest report: $LATEST_REPORT"
    echo "Print report with:"
    echo "    twprint --print-report --twrfile \"$LATEST_REPORT\" | less"
else
    echo "[!] No report file found yet under /var/lib/tripwire/report/"
fi

