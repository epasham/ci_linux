#!/bin/bash
echo this is ServiceMonitor install test
path=$1
folder=$2
ip=$(hostname -I)
#replicaSetName=$4 
#testname=$5
a=-s
mkdir -p /mnt/servicemonitor/
mkdir -p /mnt/nb-servicemonitor/backup

if [ ${path} == $a ]
then
  mount -t cifs -o username=netbrain,password=netbrain ${folder} /mnt/servicemonitor/
  echo ${folder}
else
  mount -t cifs -o username=netbrain,password=netbrain ${path} /mnt/servicemonitor/
  echo mount ${path} successfully

  cd /mnt/servicemonitor
  #filename=`ls -l | tail -n 1 | awk '{print $9;exit}'`
  filename=`ls -At |head -n 1`
  echo ${filename}
  umount -l /mnt/servicemonitor
  echo umount  ${path} successfully

  mount -t cifs -o username=netbrain,password=netbrain ${path}/${filename}/${folder}/MONITOR /mnt/servicemonitor/
  echo mount ${path}/${filename}/${folder}/MONITOR successfully
fi
#
# checking if they are same pkg
newpkgname=$( ls /mnt/servicemonitor/ )
oldpkgname=$( ls /etc/nb-servicemonitor/backup/ )
if [ "$newpkgname" = "$oldpkgname" ]
then
    exit
fi
# end of checking
cp -R /mnt/servicemonitor/* /etc/
pkgname=$( ls /mnt/servicemonitor/ )

mkdir -p /etc/nb-servicemonitor/backup/
rm -rf /etc/nb-servicemonitor/backup/*
cp -R /mnt/servicemonitor/* /etc/nb-servicemonitor/backup/

#
cp -R /mnt/servicemonitor/* /etc/
echo copy monitor to directory etc successfully
umount -l /mnt/servicemonitor
echo umount  ${path} successfully

cd /etc/
tar -xvf $pkgname
cd /etc/ServiceMonitorAgent/
sed -i -e "s|^Server_Url.*|Server_Url             https://${ip}/ServicesAPI|" install_monitor.conf

echo begain to install ServiceMonitorAgent
./install.sh
