#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Tripwire Lab Installation Script
#
# This script installs Tripwire on a Debian-based lab system, preconfigures its
# required passphrases non-interactively, initializes the Tripwire database,
# and performs the first integrity check.
#
# Purpose:
# - To automate Tripwire installation in lab and test environments
# - To make the setup process reproducible and non-interactive
# - To prepare a ready-to-use baseline for integrity monitoring exercises
#
# What this script does:
# 1. Updates the package index
# 2. Preseeds Tripwire debconf answers for site and local passphrases
# 3. Installs the Tripwire package
# 4. Initializes the Tripwire database
# 5. Runs the first integrity check
# 6. Prints the location of the latest Tripwire report if available
#
# Usage:
# - Run as root
# - Intended for lab, testing, and educational environments
# - Suitable for reproducible Debian-based Tripwire lab installations
#
# Security Notice:
# - This script embeds default lab passphrases for automation purposes
# - This is acceptable only in controlled lab or training environments
# - In production environments, Tripwire site/local keys and passphrases must
#   never be embedded in scripts and must be handled securely
#
# Notes:
# - The first integrity check may report violations depending on system state
# - The script does not stop if the initial check reports changes
# - Generated reports can be reviewed later with twprint
#
# Tested on:
# - Debian 12 (Bookworm)
# - Debian 13 (Trixie)
# ------------------------------------------------------------------------------

set -euo pipefail

[[ "$EUID" -eq 0 ]] || { echo "Please run this script as root."; exit 1; }
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
# The first check may report violations depending on system state. Do not stop the lab execution only because Tripwire reports changes.
tripwire --check --local-passphrase "${LAB_TW_LOCAL_PASSPHRASE}" || true

LATEST_REPORT="$(ls -1t /var/lib/tripwire/report/*.twr 2>/dev/null | head -n1 || true)"

echo
echo "Tripwire setup completed."
if [[ -n "$LATEST_REPORT" ]]; then
    echo "Latest report: $LATEST_REPORT"
    echo "Print report with:"
    echo "    twprint --print-report --twrfile \"$LATEST_REPORT\" | less"
else
    echo "[!] No report file found yet under /var/lib/tripwire/report/"
fi

