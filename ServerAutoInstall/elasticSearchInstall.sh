#!/bin/bash
echo this is elasticsearch server install test
path=$1
folder=$2
ip=$3
config=$4
a=-s
con1=-d
con2=-u
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

  mount -t cifs -o username=netbrain,password=netbrain ${path}/${filename}/${folder}/Elasticsearch /mnt/mongodb/
  echo mount ${path}/${filename}/${folder}/Elasticsearch
fi

cp -R /mnt/mongodb/* /home/mongodbInstall
echo copy Elasticsearch to local successfully
umount -l /mnt/mongodb
echo umount  ${path} successfull

cd /home/mongodbInstall

echo uzip install.tar and get jdk packege name
tar -xvf elasticsearch-linux-rhel7-6.0.0.tar.gz
filename=`find -name \*.tar.gz`
echo ${filename}

cd /home/mongodbInstall/elasticsearch-linux-rhel7-6.0.0
echo begain to update conf

echo begain to update elasticsearch config
sed -i -e "s|^BindIp.*|BindIp             ${ip}|" install_elasticsearch.conf

cd /home/mongodbInstall
if [ ${config} == $con1 ]
then 
  ESport=`sed -n 2p configDefault.txt | awk '{print $2}'`
  ESname=`sed -n 2p configDefault.txt | awk '{print $3}'`
  ESpassword=`sed -n 2p configDefault.txt | awk '{print $4}'`

  cd /home/mongodbInstall/elasticsearch-linux-rhel7-6.0.0
  sed -i -e "s|^Port.*|Port             ${ESport}|" install_elasticsearch.conf
  sed -i -e "s|^User.*|User             ${ESname}|" install_elasticsearch.conf
  sed -i -e "s|^Password.*|Password             ${ESpassword}|" install_elasticsearch.conf
fi

if [ ${config} == $con2 ]
then 
  ESport=`sed -n 2p configUpdate.txt | awk '{print $2}'`
  ESname=`sed -n 2p configUpdate.txt | awk '{print $3}'`
  ESpassword=`sed -n 2p configUpdate.txt | awk '{print $4}'`

  cd /home/mongodbInstall/elasticsearch-linux-rhel7-6.0.0
  sed -i -e "s|^Port.*|Port             ${ESport}|" install_elasticsearch.conf
  sed -i -e "s|^User.*|User             ${ESname}|" install_elasticsearch.conf
  sed -i -e "s|^Password.*|Password             ${ESpassword}|" install_elasticsearch.conf
fi

echo begain to install Elaticsearch server
./install.sh
echo install Elaticsearch successfully

echo "####### check install elasticsearch ########"
echo "####### check install elasticsearch ########"
cd /home/mongodbInstall
./servicesCheck.sh elasticsearch
