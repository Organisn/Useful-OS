# VirtualBox installation and secure boot kernel modules signature script for Fedora 44 Workstation
# To install downloaded .rpm packages, run the following command:
sudo dnf install Downloads/VirtualBox-7.2-7.2.16_174877_fedora40-1.x86_64.rpm
# If you have secure boot enabled, you will need to sign vbox kernel modules.
# First, be sure to have the following instruments installed to generate kernel modules:
sudo dnf install gcc make perl kernel-devel kernel-headers elfutils-libelf-devel
# Try to generate the vbox modules:
sudo /sbin/vboxconfig
# If errors occur, generate a new signing key pair
sudo openssl req -new -x509 -newkey rsa:2048 -keyout /root/MOK.priv -outform DER -out /root/MOK.der -nodes -days 36500 -subj "/CN=VirtualBox/"
# Check the generated key pair
sudo ls -l /root/MOK.der
# After enrolling the MOK key, you can sign the VirtualBox kernel module 
# (execute commands one by one and add eventual other modules signaled as unsigned by the error window)
sudo /usr/src/kernels/$(uname -r)/scripts/sign-file sha256 /root/MOK.priv /root/MOK.der $(modinfo -n vboxdrv)
sudo /usr/src/kernels/$(uname -r)/scripts/sign-file sha256 /root/MOK.priv /root/MOK.der $(modinfo -n vboxnetflt)
sudo /usr/src/kernels/$(uname -r)/scripts/sign-file sha256 /root/MOK.priv /root/MOK.der $(modinfo -n vboxnetadp)
# To tell the system to import the new key at reboot:
sudo mokutil --import /root/MOK.der
# You will be prompted to create a password for the MOK enrollment. 
# It is recommended to use a numerical one since in the pre-system environment, the keyboard layout may not be the same as in your current session.
# Make sure to remember this password, as you will need it during the next reboot.
# Reboot your system and follow the prompts to enroll the MOK key. You will be asked to enter the password you created earlier
reboot
# In the pre-system interface, select "Enroll MOK" and then "Continue". 
# You will be prompted to enter the password you created earlier. 
# After entering the password, select "Yes" to enroll the key. 
# Once the enrollment is complete, select "Reboot" to restart your system.
# After the system reboots, you can check if the key is correctly enrolled by running:
sudo mokutil --test-key /root/MOK.der
# Then regenerate vbox modules
sudo /sbin/vboxconfig
# If you encounter any issues, try resign them
sudo /usr/src/kernels/$(uname -r)/scripts/sign-file sha256 /root/MOK.priv /root/MOK.der $(modinfo -n vboxdrv)
sudo /usr/src/kernels/$(uname -r)/scripts/sign-file sha256 /root/MOK.priv /root/MOK.der $(modinfo -n vboxnetflt)
sudo /usr/src/kernels/$(uname -r)/scripts/sign-file sha256 /root/MOK.priv /root/MOK.der $(modinfo -n vboxnetadp)
# and manually launch the just signed driver
sudo modprobe vboxdrv

# If modules are unsigned every boot, made the signature procedure automatic
# Create an sh file containing
sudo /usr/src/kernels/$(uname -r)/scripts/sign-file sha256 /root/MOK.priv /root/MOK.der $(modinfo -n vboxdrv)
sudo modprobe vboxdrv
# Assign execution rights to it
chmod +x "/path/to/script.sh"
# Check the -x parameters is set as script right (ex: -rwxr-xr-x)
ls -l "/path/to/script.sh"
# Create a service configuration file
sudo nano /etc/systemd/system/script.service
# Paste and customize (use backslash before space in paths!)
[Unit]
Description=boot automatic signature and launch for vboxdrv VirtualBox module
After=network.target

[Service]
Type=simple
ExecStart=/path/to/script.sh

[Install]
WantedBy=multi-user.target
# Relaunch systemd demon and activate service automatic exec
sudo systemctl daemon-reload
sudo systemctl enable --now script.service
# Check service active state
sudo systemctl status script.service

# FOR FUTURE FEDORA KERNEL UPDATES, 
# you will need to repeat the signing process for the new kernel modules:
sudo /sbin/vboxconfig
sudo /usr/src/kernels/$(uname -r)/scripts/sign-file sha256 /root/MOK.priv /root/MOK.der $(modinfo -n vboxdrv)
sudo /usr/src/kernels/$(uname -r)/scripts/sign-file sha256 /root/MOK.priv /root/MOK.der $(modinfo -n vboxnetflt)
sudo /usr/src/kernels/$(uname -r)/scripts/sign-file sha256 /root/MOK.priv /root/MOK.der $(modinfo -n vboxnetadp)
