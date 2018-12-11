#!/bin/bash
echo this is ServiceMonitor install test
path=$1
folder=$2
ip=$3
#replicaSetName=$4 
#testname=$5
a=-s
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

cp -R /mnt/servicemonitor/* /etc/
echo copy monitor to directory etc successfully
umount -l /mnt/servicemonitor
echo umount  ${path} successfully

cd /etc/
tar -xvf netbrain-servicemonitoragent-linux-x86_64-rhel7.tar.gz
cd /etc/ServiceMonitorAgent/
sed -i -e "s|^Server_Url.*|Server_Url             https://${ip}/ServicesAPI|" install_monitor.conf

echo begain to install ServiceMonitorAgent
./install.sh
