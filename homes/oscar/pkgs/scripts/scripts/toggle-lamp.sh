#!/bin/sh
TASMOTA_ADDR="192.168.1.31"

curl "http://$TASMOTA_ADDR/\?m\=1\&o\=1" |
	grep -Eo '(ON|OFF)' |
	xargs notify-send 'Lamp is'
