#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Tripwire Lab Policy Deployment Script
#
# This script replaces the default Tripwire policy (twpol.txt) with a simplified
# and controlled policy designed for Debian-based lab environments.
#
# Purpose:
# - To create a clean and understandable Tripwire policy for integrity monitoring
# - To focus on critical system areas (binaries, configuration, boot files)
# - To exclude noisy and frequently changing paths to produce meaningful reports
#
# What this script does:
# 1. Backs up the current Tripwire policy file
# 2. Writes a predefined lab-oriented policy to /etc/tripwire/twpol.txt
# 3. Reinitializes the Tripwire database using the new policy
# ------------------------------------------------------------------------------

set -euo pipefail

[[ "$EUID" -eq 0 ]] || { echo "Please run this script as root."; exit 1; }

SITE_PASSPHRASE="${LAB_TW_SITE_PASSPHRASE:-tripwire-site-lab-pass}"
LOCAL_PASSPHRASE="${LAB_TW_LOCAL_PASSPHRASE:-tripwire-local-lab-pass}"

POLICY_TXT="/etc/tripwire/twpol.txt"
BACKUP_FILE="/etc/tripwire/twpol.txt.bak.$(date +%Y%m%d-%H%M%S)"

echo "Backing up current policy file..."
cp "$POLICY_TXT" "$BACKUP_FILE"

echo "Writing lab policy to $POLICY_TXT ..."
cat > "$POLICY_TXT" <<'EOF'
##############################################################################
# Tripwire lab policy for Debian systems
# This policy is intentionally simplified for educational/lab purposes.
##############################################################################

@@section GLOBAL

TWBIN = /usr/sbin;
TWPOL = /etc/tripwire;
TWDB  = /var/lib/tripwire;

##############################################################################
# Critical system binaries
##############################################################################
(
  rulename = "Critical system binaries",
  severity = 100
)
{
  /bin      -> $(ReadOnly);
  /sbin     -> $(ReadOnly);
  /usr/bin  -> $(ReadOnly);
  /usr/sbin -> $(ReadOnly);
}

##############################################################################
# Critical configuration files
##############################################################################
(
  rulename = "Critical configuration",
  severity = 90
)
{
  /etc -> $(ReadOnly);

  !/etc/mtab;
  !/etc/resolv.conf;
  !/etc/adjtime;
}

##############################################################################
# Boot files
##############################################################################
(
  rulename = "Boot configuration",
  severity = 95
)
{
  /boot -> $(ReadOnly);
}

##############################################################################
# Excluding noisy directories
##############################################################################
!/proc;
!/sys;
!/tmp;
!/run;
!/var/log;
!/etc/tripwire;
EOF

echo "Rebuilding Tripwire database with the new policy..."
tripwire --init --local-passphrase "$LOCAL_PASSPHRASE"

echo
echo "Policy applied successfully."
echo "Backup of previous policy: $BACKUP_FILE"
echo "You can now run:"
echo "    tripwire --check --local-passphrase \"$LOCAL_PASSPHRASE\""

