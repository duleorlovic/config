set -x
# Determine numbers of PCI graphic cards, look at first two digits
#
# lspci | grep VGA
# 04:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Cape Verde PRO [Radeon HD 7750/8740 / R7 250E]
# 05:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Barts PRO [Radeon HD 6850]
# 08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Cypress PRO [Radeon HD 5850]
# top is new low resolution 5850 08
# middle is old high resolution7750 04
# bottom is slim 6850 05

# this was with only two cards top and middle
# lspci | grep VGA
# 04:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Cypress PRO [Radeon HD 5850]
# 07:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Cypress PRO [Radeon HD 5850]
# top is 04 card0 (last number before drm)
# middle is 07 card1 (keep this at seat0)
#
# seat0 is default grabbing all
# sudo loginctl seat-status # this shows current seat number
# Create attach_seats.sh with description of hdmi and usb ports, for example:

# SEAT1 top graphic card
# sudo loginctl attach seat1 /sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/*
# sudo loginctl attach seat1 /sys/devices/pci0000:00/0000:00:03.1/0000:08:00.1/sound/*
# two usb on front above leds and power button
# sudo loginctl attach seat1 /sys/devices/pci0000:00/0000:00:01.2/0000:02:00.0/usb1/1-10
#
# SEAT2 bottom graphic card
# sudo loginctl attach seat2 /sys/devices/pci0000:00/0000:00:01.2/0000:02:00.2/0000:03:04.0/0000:05:00.0/drm/*
# sudo loginctl attach seat2 /sys/devices/pci0000:00/0000:00:01.2/0000:02:00.2/0000:03:04.0/0000:05:00.1/sound/*
# sudo loginctl attach seat2 /sys/devices/pci0000:00/0000:00:08.1/0000:0a:00.3/usb3
#
# git init .
# sudo ls
# ./seat_statuses.sh
# inspect all changes and determine the ports, card1 on restart could be card2
# git add .

# Note that when seat_statuses.sh is triggered, the devices should be already
# connected so for both old usb and usb3 protocol, you need to run when old
# device is connected and again when usb3 device is connected in the same ports
# When monitor is turned off than graphics/fb2 is not present
# On restart card1 could become card1

sudo loginctl seat-status seat0 > ~/config/loginctl_seats/seat0.seat-status.txt
sudo loginctl seat-status seat1 > ~/config/loginctl_seats/seat1.seat-status.txt || true
sudo loginctl seat-status seat2 > ~/config/loginctl_seats/seat2.seat-status.txt || true
# sudo loginctl seat-status seat3 > ~/config/loginctl_seats/seat3.seat-status.txt  || true
