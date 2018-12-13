#!/bin/bash
echo this is licenseAgent install test
path=$1
folder=$2
config=$3
a=-s
con1=-d
con2=-u
mkdir -p /mnt/licenseagent/
mkdir -p /mnt/nb-licenseagent/backup/

if [ ${path} == $a ]
then
  mount -t cifs -o username=netbrain,password=netbrain ${folder} /mnt/licenseagent/
  echo ${folder}
else
  mount -t cifs -o username=netbrain,password=netbrain ${path} /mnt/licenseagent/
  echo mount ${path} successfully

  cd /mnt/licenseagent
  #filename=`ls -l | tail -n 1 | awk '{print $9;exit}'`
  filename=`ls -At |head -n 1`
  echo ${filename}
  umount -l /mnt/licenseagent
  echo umount  ${path} successfully

  mount -t cifs -o username=netbrain,password=netbrain ${path}/${filename}/${folder}/LicenseAgent /mnt/licenseagent/
  echo mount ${path}/${filename}/${folder}/LicenseAgent successfully
fi
#
# checking if they are same pkg
newpkgname=$( ls /mnt/licenseagent/ )
oldpkgname=$( ls /etc/nb-licenseagent/backup/ )
if [ "$newpkgname" = "$oldpkgname" ]
then
    exit
fi
# end of checking
cp -R /mnt/licenseagent/* /etc/
pkgname=$( ls /mnt/licenseagent/ )

mkdir -p /etc/nb-licenseagent/backup/
rm -rf /etc/nb-licenseagent/backup/*
cp -R /mnt/licenseagent/* /etc/nb-licenseagent/backup/

#
cp -Rf /mnt/licenseagent/* /etc/
echo copy licenseAgent to directory home/licenseagentInstall successfully
umount -l /mnt/licenseagent
echo umount  ${path} successfully

cd /etc
tar -xvf $pkgname

echo begain to update licenseAgent config
cd /root/ci/installation
if [ ${config} == $con1 ]
then 
  LSport=`sed -n 3p configDefault.txt | awk '{print $2}'`
  cd /etc/License
  sed -i -e "s|^port.*|port=${LSport}|" install_licenseagent.conf
fi

if [ ${config} == $con2 ]
then
  LSport=`sed -n 3p configUpdate.txt | awk '{print $2}'`
  cd /etc/License
  sed -i -e "s|^port.*|port=${LSport}|" install_licenseagent.conf
fi

echo begain to install licenseAgent
./install.sh 

sleep 3 
