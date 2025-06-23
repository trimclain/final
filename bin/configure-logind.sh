#!/bin/bash

###############################################################################
# Configure logind to suspend on power key press and when closing the lid
###############################################################################
# DOCS: man logind.conf

# It's a good practice to prefix the filename with a two-digit number and a dash
# (e.g., 60-custom.conf or 80-mylogind.conf). This helps with ordering.
LOGIND_DROPIN_DIR="/etc/systemd/logind.conf.d"
LOGIND_DROPIN_FILE="${LOGIND_DROPIN_DIR}/90-suspend-on-lid-and-power.conf"

if [[ $EUID -ne 0 ]]; then
    exec sudo "$0" "$@"
fi

mkdir -p "${LOGIND_DROPIN_DIR}"

echo -ne "Creating logind configuration file at ${LOGIND_DROPIN_FILE}... "
cat <<EOF > "${LOGIND_DROPIN_FILE}"
[Login]
# Options: ignore, poweroff, reboot, halt, suspend, hibernate, hybrid-sleep, lock

HandlePowerKey=suspend
HandleLidSwitch=suspend
EOF
echo "Done"

# Reload config
echo "Reboot or restart systemd-logind with the following command:"
echo "  sudo systemctl restart systemd-logind"
echo "WARNING: This will log you out of your current session."

# Verify changes
#systemd-analyze cat-config systemd/logind.conf
