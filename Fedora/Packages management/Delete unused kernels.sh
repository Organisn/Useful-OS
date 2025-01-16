# Show currently used kernel
uname -sr
# Show all installed kernels
rpm -q kernel-core
# Delete multiple kernels
sudo dnf remove kernel-core-6.4.10* kernel-core-6.5*
