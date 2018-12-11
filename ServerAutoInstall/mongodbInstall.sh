#!/bin/bash
echo this is mongodb install test
path=$1
folder=$2
ip=$(hostname -I)
replicaSetName=$4
config=$5 
a=-s
con1=-d
con2=-u
mkdir -p /mnt/mongodb/
if [ ${path} == $a ]
then
  mount -t cifs -o username=netbrain,password=netbrain ${folder} /mnt/mongodb/
  echo ${folder}
else
  mount -t cifs -o username=netbrain,password=netbrain ${path} /mnt/mongodb/
  echo mount ${path} successfully

  cd /mnt/mongodb
  #filename=`ls -l | tail -n 1 | awk '{print $9;exit}'`
  filename=`ls -At |head -n 1`
  echo ${filename}
  umount -l /mnt/mongodb
  echo umount  ${path} successfully

  mount -t cifs -o username=netbrain,password=netbrain ${path}/${filename}/${folder}/MongoRpm /mnt/mongodb/
  echo mount ${path}/${filename}/${folder}/MongoRpm successfully
fi

cp -R /mnt/mongodb/* /etc/
echo copy mongodb to directory etc successfully
umount -l /mnt/mongodb
echo umount  ${path} successfully

cd /etc/
tar -xvf mongodb-linux-x86_64-rhel7-3.6.4.tar.gz
cd /etc/MongoDB

echo begain to update config
sed -i -e "s|^BindIp.*|BindIp             ${ip}|" install_mongodb.conf
sed -i -e "s|^ReplicaSetName.*|ReplicaSetName             ${replicaSetName}|" install_mongodb.conf

cd /root/ci/installation
if [ ${config} == $con1 ]
then
  DBport=`sed -n 1p configDefault.txt | awk '{print $2}'`
  DBname=`sed -n 1p configDefault.txt | awk '{print $3}'`
  DBpassword=`sed -n 1p configDefault.txt | awk '{print $4}'` 
  
  cd /etc/MongoDB
  sed -i -e "s|^DBPort.*|DBPort             ${DBport}|" install_mongodb.conf
  sed -i -e "s|^DBUser.*|DBUser             ${DBname}|" install_mongodb.conf
  sed -i -e "s|^DBPassword.*|DBPassword             ${DBpassword}|" install_mongodb.conf
  sed -i -e "s|^ReplicaSetMembers.*|ReplicaSetMembers             ${ip}:${DBport}|" install_mongodb.conf

fi

if [ ${config} == $con2 ]
then 
  DBport=`sed -n 1p configUpdate.txt | awk '{print $2}'`
  DBname=`sed -n 1p configUpdate.txt | awk '{print $3}'`
  DBpassword=`sed -n 1p configUpdate.txt | awk '{print $4}'`

  cd /etc/MongoDB
  sed -i -e "s|^DBPort.*|DBPort             ${DBport}|" install_mongodb.conf
  sed -i -e "s|^DBUser.*|DBUser             ${DBname}|" install_mongodb.conf
  sed -i -e "s|^DBPassword.*|DBPassword             ${DBpassword}|" install_mongodb.conf
  sed -i -e "s|^ReplicaSetMembers.*|ReplicaSetMembers             ${ip}:${DBport}|" install_mongodb.conf
fi
echo begain to install mongodb
/etc/MongoDB/install.sh 

echo "######### check  mongodb services #########"
yum install numactl-2.0.9 -y
/root/ci/installation/servicesCheck.sh mongod

