# FTDI Latency Timer udev rule

By default, [FTDI chip set latency timer to 16 ms](https://www.ftdichip.com/Support/Knowledgebase/index.html?settingacustomdefaultlaten.htm). Sometime, this default value will disturb the serial communication especially when we're using high baud rate, i.e. 460800 bps.

This udev rule will set the latency timer to lower value (1ms) or any number between 0 - 255.

# Usage
```bash
$ ./install.sh -h
install.sh [OPTIONS] -- create udev rules for FTDI latency timer

OPTIONS:
  -h, --help    show this help
  -d, --delay   delay to write into FTDI latency timer in ms [default=1].

EXAMPLES:
  install.sh
  install.sh --delay 5

```