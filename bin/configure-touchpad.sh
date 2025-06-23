#!/bin/bash

###############################################################################
# Create Touchpad Config with enabled Tapping and Natural Scrolling
###############################################################################
# DOCS: man libinput.4
# Useful Info in /usr/share/X11/xorg.conf.d/40-libinput.conf

XORG_CONFIG_DIR="/etc/X11/xorg.conf.d"
TOUCHPAD_CONFIG_FILE="${XORG_CONFIG_DIR}/30-touchpad.conf"

if [[ $EUID -ne 0 ]]; then
    exec sudo "$0" "$@"
fi

mkdir -p "${XORG_CONFIG_DIR}"

echo -ne "Creating touchpad configuration file at ${TOUCHPAD_CONFIG_FILE}... "
cat <<EOF > "${TOUCHPAD_CONFIG_FILE}"
Section "InputClass"
        Identifier "Touchpad"
        MatchDriver "libinput"
        MatchIsTouchpad "on"
        Option "Tapping" "on"
        Option "NaturalScrolling" "on"
EndSection
EOF
echo "Done"

echo "Logout (or Reboot) for changes to take effect."
