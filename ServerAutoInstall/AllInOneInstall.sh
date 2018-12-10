#/bin/bash
path=$1
folder=$2
ip=$3
replicaSetName=$4
config=$5
webIP=$6

echo "########################################"
echo "begain to excute mongodbInstall.sh"
./mongodbInstall.sh ${path} ${folder} ${ip} ${replicaSetName} ${config}
sleep 3

echo "##########################################"
echo "begain to excute elasticSearchInstall.sh"
./elasticSearchInstall.sh ${path} ${folder} ${ip} ${config}
sleep 3

echo "#########################################"
echo "begain to excute licenseAgentInstall.sh"
./licenseAgentInstall.sh ${path} ${folder} ${config}
sleep 3


echo "##########################################"
echo "begain to excute ServiceMonitor.sh"
./ServiceMonitor.sh ${path} ${folder} ${webIP}
sleep 3
