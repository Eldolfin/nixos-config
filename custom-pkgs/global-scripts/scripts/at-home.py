#!/usr/bin/env python

from subprocess import check_output, CalledProcessError

HOME_WIFIS = ["Bali in Paris 5G", "Bali in Paris"]

try:
    current_wifi = check_output(["iwgetid", "-r"], text=True).strip()
except CalledProcessError:
    current_wifi = None
at_home = current_wifi in HOME_WIFIS
exit_code = 0 if at_home else 1
exit(exit_code)
