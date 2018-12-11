#!/bin/bash
echo this is elasticsearch server install test
path=$1
folder=$2
ip=$(hostname -I)
config=$4
a=-s
con1=-d
con2=-u

mkdir -p /mnt/elasticsearch/

if [ ${path} == $a ]
then
  mount -t cifs -o username=netbrain,password=netbrain ${folder} /mnt/elasticsearch/
  echo ${folder}
else
  mount -t cifs -o username=netbrain,password=netbrain ${path} /mnt/elasticsearch/
  echo mount ${path} successfully

  cd /mnt/elasticsearch/
  #filename=`ls -l | tail -n 1 | awk '{print $9;exit}'`
  filename=`ls -At |head -n 1`
  echo ${filename}
  #umount -l /mnt/elasticsearch
  echo umount  ${path} successfully

  mount -t cifs -o username=netbrain,password=netbrain ${path}/${filename}/${folder}/Elasticsearch /mnt/elasticsearch/
  echo mount ${path}/${filename}/${folder}/Elasticsearch
fi

rm -rf /home/elasticsearchInstall
mkdir -p /home/elasticsearchInstall
cp -rf /mnt/elasticsearch/* /home/elasticsearchInstall/

echo copy Elasticsearch to local successfully
umount -l /mnt/elasticsearch
echo umount  ${path} successfull

cd /home/elasticsearchInstall

echo uzip install.tar and get jdk packege name
tar -xvf elasticsearch-linux-rhel7-6.0.0.tar.gz
filename=`find -name \*.tar.gz`
echo ${filename}

cd /home/elasticsearchInstall/Elasticsearch/
echo begain to update conf

echo begain to update elasticsearch config
sed -i -e "s|^BindIp.*|BindIp             ${ip}|" install_elasticsearch.conf

cd /root/ci/installation/
if [ ${config} == $con1 ]
then 
  ESport=`sed -n 2p configDefault.txt | awk '{print $2}'`
  ESname=`sed -n 2p configDefault.txt | awk '{print $3}'`
  ESpassword=`sed -n 2p configDefault.txt | awk '{print $4}'`

  cd /home/elasticsearchInstall/Elasticsearch/
  sed -i -e "s|^Port.*|Port             ${ESport}|" install_elasticsearch.conf
  sed -i -e "s|^User.*|User             ${ESname}|" install_elasticsearch.conf
  sed -i -e "s|^Password.*|Password             ${ESpassword}|" install_elasticsearch.conf
fi

if [ ${config} == $con2 ]
then 
  ESport=`sed -n 2p configUpdate.txt | awk '{print $2}'`
  ESname=`sed -n 2p configUpdate.txt | awk '{print $3}'`
  ESpassword=`sed -n 2p configUpdate.txt | awk '{print $4}'`

  cd /home/elasticsearchInstall/Elasticsearch/
  sed -i -e "s|^Port.*|Port             ${ESport}|" install_elasticsearch.conf
  sed -i -e "s|^User.*|User             ${ESname}|" install_elasticsearch.conf
  sed -i -e "s|^Password.*|Password             ${ESpassword}|" install_elasticsearch.conf
fi

echo begain to install Elaticsearch server
/home/elasticsearchInstall/Elasticsearch/install.sh
echo install Elaticsearch successfully

echo "####### check install elasticsearch ########"
/root/ci/installation/servicesCheck.sh elasticsearch
