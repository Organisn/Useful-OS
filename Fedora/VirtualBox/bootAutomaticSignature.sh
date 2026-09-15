sudo /usr/src/kernels/$(uname -r)/scripts/sign-file sha256 /root/MOK.priv /root/MOK.der $(modinfo -n vboxdrv)
sudo modprobe vboxdrv