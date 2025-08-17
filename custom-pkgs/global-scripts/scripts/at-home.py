#!/usr/bin/env python

from subprocess import check_output

current_wifi = check_output(["iwgetid", "-r"], text=True)
print(current_wifi)
