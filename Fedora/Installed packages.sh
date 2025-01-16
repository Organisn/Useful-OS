# List all installed packages
rpm -qa
# Check specific one
rpm -qa | grep gcc
# List orphaned packages
rpmorphane
# Remove orphaned packages (no more required by system)
sudo dnf autoremove
