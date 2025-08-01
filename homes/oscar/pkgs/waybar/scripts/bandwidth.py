#!/usr/bin/env python
# source: https://github.com/Alexays/Waybar/issues/2162#issuecomment-1537366689

import subprocess
from time import sleep


def default_interface():
    process = subprocess.run(
        ["ip", "route"], check=True, text=True, capture_output=True
    )
    for line in process.stdout.splitlines():
        if line.startswith("default via"):
            return line.split()[4]
    raise RuntimeError("No default interface found")


def get_rx_tx_bytes(iface):
    with open("/proc/net/dev") as f:
        for line in f:
            line = line.strip()
            if not line.startswith(f"{iface}:"):
                continue
            rx_bytes = int(line.split()[1])
            tx_bytes = int(line.split()[9])
            return rx_bytes, tx_bytes
    raise RuntimeError("Interface not found")


def format_size(size):
    power_labels = {0: "B", 1: "K", 2: "M", 3: "G", 4: "T"}
    kilo = 2**10
    power = 0
    while size > kilo:
        size /= kilo
        power += 1
    return f"{size:3.0f} {power_labels[power]}"


def main():
    refresh_interval = 2
    rx_icon = " "
    tx_icon = " "
    fmt_str = f"{rx_icon}{{rx}}{{unit_suffix}}  " f"{tx_icon}{{tx}}{{unit_suffix}}"
    unit_suffix = ""
    iface = default_interface()

    rx_bytes, tx_bytes = get_rx_tx_bytes(iface)

    while True:
        prev_rx_bytes, prev_tx_bytes = rx_bytes, tx_bytes
        rx_bytes, tx_bytes = get_rx_tx_bytes(iface)
        drx = format_size((rx_bytes - prev_rx_bytes) / refresh_interval)
        dtx = format_size((tx_bytes - prev_tx_bytes) / refresh_interval)
        line = fmt_str.format(rx=drx, tx=dtx, unit_suffix=unit_suffix)
        print(line, flush=True)
        sleep(refresh_interval)


if __name__ == "__main__":
    main()
