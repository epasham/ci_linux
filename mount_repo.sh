#use //192.168.33.101/Cloud_Containers to save images

mkdir /mnt/netbrain_container_repo
mount -t cifs -o username=netbrain,password=netbrain //192.168.33.101/Cloud_Containers /mnt/netbrain_container_repo
