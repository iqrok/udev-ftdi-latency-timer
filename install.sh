#!/bin/sh

set -e

show_help() {
echo "$(basename "$0") [OPTIONS] -- create udev rules for FTDI latency timer

OPTIONS:
  -h, --help    show this help
  -d, --delay   delay to write into FTDI latency timer in ms [default=1].

EXAMPLES:
  $(basename "$0")
  $(basename "$0") --delay 5
"
}

UPPER() {
	echo "${1}" | tr [a-z] [A-Z]
}

if [ "$(id -u)" != "0" ]; then
	show_help
	echo "Please run as root!"
	exit 1
fi

DIR=$( cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P )

TARGET_DIR="/usr/local/bin"
UDEV_DIR="/etc/udev/rules.d"

# Parse arguments
DELAY_MS=1

while :; do
	case ${1} in
		-h|--help)
			show_help
			exit 0
			;;

		-d|--delay)
			shift
			DELAY_MS=${1}
			shift
			;;

		*)
			break
			;;

	esac
done

echo "  - Installing FTDI Latency Timer rules..."

SHELL_FILE="ftdi-latency-timer.sh"
UDEV_FILE="99-ftdi-latency-timer.rules"

# install shell file
cp -t "${TARGET_DIR}" "${DIR}/assets/${SHELL_FILE}"
chmod a+x "${TARGET_DIR}/${SHELL_FILE}"
sed -i "s#__TARGET_DIR__#${TARGET_DIR}#g" "${TARGET_DIR}/${SHELL_FILE}"
sed -i "s#__VAL_DELAY_MS__#${DELAY_MS}#g" "${TARGET_DIR}/${SHELL_FILE}"

# install udev rule
cp -t "${UDEV_DIR}" "${DIR}/assets/${UDEV_FILE}"
sed -i "s#__TARGET_DIR__#${TARGET_DIR}#g" "${UDEV_DIR}/${UDEV_FILE}"

# Reload udev rules
echo "  - Reload udev rules"
udevadm control --reload-rules
udevadm trigger
