#!/bin/sh

FTDI_DEVPATH="${1}"
FTDI_LATENCY_TIMER="${FTDI_DEVPATH}/device/latency_timer"
FTDI_DELAY_MS=__VAL_DELAY_MS__

if [ -f "${FTDI_LATENCY_TIMER}" ]; then
	echo ${FTDI_DELAY_MS} > "${FTDI_LATENCY_TIMER}"
fi
