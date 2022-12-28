#!/bin/bash
# If you want to get the PID by selecting the window:
# xdotool selectwindow

xdotool search --name Qalculate! windowactivate --sync %1 type "(12x*250)" &&xdotool key ctrl+s
