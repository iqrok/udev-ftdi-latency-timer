#!/bin/sh

if [ $(id -u) != 0 ]; then
	echo "Please run as root!"
	exit 1
fi

DIR=$( cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P )

INSTALL_DIR="/usr/local/bin"

rm -f "/etc/udev/rules.d/99-ftdi-latency-timer.rules" "${INSTALL_DIR}/ftdi-latency-timer.sh"

udevadm control --reload
systemctl daemon-reload
