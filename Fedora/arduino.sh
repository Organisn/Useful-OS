# Fedora /dev/ttyACM0 USB port setup
# Current session write rights 
 sudo chmod a+rw /dev/ttyACM0
 # Permanent write rights:
 # Paste 
 SUBSYSTEMS=="usb", ATTRS{idVendor}=="2a03", GROUP="plugdev", MODE="0666"
# (where "idVendor" can be found into pc connected device list)
lsusb -vvv
# into /etc/udev/rules.d/99-arduino.rules
# Refresh 'udev' rules
sudo udevadm control --reload
