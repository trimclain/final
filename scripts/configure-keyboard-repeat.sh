#!/bin/bash

################################################################################
# Create Xorg Keyboard Config with 400 ms Repeat Delay and 25 Repeats per Second
################################################################################
# DOCS: man libinput.4
# Useful Info in /usr/share/X11/xorg.conf.d/40-libinput.conf

set -euo pipefail

XORG_CONFIG_DIR="/etc/X11/xorg.conf.d"
KEYBOARD_CONFIG_FILE="${XORG_CONFIG_DIR}/00-keyboard-repeat.conf"

if [[ $EUID -ne 0 ]]; then
    exec sudo "$0" "$@"
fi

mkdir -p "${XORG_CONFIG_DIR}"

printf 'Creating keyboard configuration file at %s... ' "${KEYBOARD_CONFIG_FILE}"
cat << EOF > "${KEYBOARD_CONFIG_FILE}"
Section "InputClass"
        Identifier "Keyboard Repeat"
        MatchIsKeyboard "on"
        Option "AutoRepeat" "400 25"
EndSection
EOF
echo "Done"

echo "Logout (or Reboot) for changes to take effect."
