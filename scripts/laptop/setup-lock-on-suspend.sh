#!/bin/bash

###############################################################################
# Create a systemd service file to run before sleep.service
###############################################################################
# DOCS: https://wiki.archlinux.org/title/Slock#Lock_on_suspend

SYSTEMD_USER_SERVICE_DIR="/etc/systemd/system"
SYSTEMD_USER_SERVICE_FILE="${SYSTEMD_USER_SERVICE_DIR}/slock-on-suspend@.service"

if [[ $EUID -ne 0 ]]; then
    exec sudo "$0" "$@"
fi

mkdir -p "${SYSTEMD_USER_SERVICE_DIR}"

echo "Creating a systemd service file at ${SYSTEMD_USER_SERVICE_FILE}... "
cat << EOF > "${SYSTEMD_USER_SERVICE_FILE}"
[Unit]
Description=Lock X session using slock for user %i
Before=sleep.target

[Service]
User=%i
Environment=DISPLAY=:0
ExecStart=/usr/bin/slock

[Install]
WantedBy=sleep.target
EOF

echo "Enabling the service... "
systemctl enable --now "slock-on-suspend@$(logname).service"
