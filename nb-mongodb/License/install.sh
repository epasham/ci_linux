#!/bin/bash

while true; do 

if [ ! -d "/etc/netbrain" ]; then
   mkdir "/etc/netbrain"
fi

rpmLog=/etc/netbrain/install_licenseagent.log
if [ ! -f "/etc/netbrain/install_licenseagent.log" ]; then 
   touch $rpmLog
fi 
\date >> $rpmLog
echo "Running License Agent installation script." >> $rpmLog

if [ ! -f "/etc/redhat-release" ]; then 
   echo "File /etc/redhat-release does not exist." >> $rpmLog
   echo "The operation system is not supported." | tee -a $rpmLog
   break
fi

cat /etc/redhat-release >> $rpmLog

if $(cat /etc/redhat-release | grep -q "CentOS" ); then
   ostype=centos
elif $(cat /etc/redhat-release | grep -q "Red Hat" ); then
   ostype=redhat
else
   echo "The operation system is not supported." | tee -a $rpmLog
   break
fi

if $(cat /etc/redhat-release | grep -q " 7." ); then
   echo "The operation system version is supported." >> $rpmLog
else
   echo "The operation system version is not supported." | tee -a $rpmLog
   break
fi

#copy ./install_licenseagent.conf to /etc/netbrain/install_licenseagent.conf
\cp -rf ./install_licenseagent.conf /etc/netbrain/install_licenseagent.conf

if [ ! -f "/etc/netbrain/install_licenseagent.conf" ]; then 
   echo "Cannot find configuration file /etc/netbrain/install_licenseagent.conf. " | tee -a  $rpmLog
   break 
fi 

while IFS='' read -r line || [[ -n "$line" ]]; do 
   key=$(echo $line | cut -d "=" -f1) 
   value=$(echo $line | cut -d "=" -f2) 
   if [[ $key == "bindIp" ]]; then 
      bind_ip=$value  
   elif [[ $key == "port" ]]; then 
      port=$value 
   elif [[ $key == "UseSSL" ]]; then  
      ssl=$value  
   elif [[ $key == "Certificate" ]]; then  
      certFile=$value 
   elif [[ $key == "PrivateKey" ]]; then  
      certKey=$value  
   elif [[ $key == "binRootPath" ]]; then 
      prefix=$value 
   elif [[ $key == "path" ]]; then 
      topdir=$value 
      while [ ! -d $topdir ]; do
         topdir=$(dirname $topdir)
      done
      testchattr=$(lsattr -d $topdir | cut -d " " -f1 | grep -e "i" -e "a")
      if [ -n "$testchattr" ]; then
	     echo "The path $topdir is immutable."
		 break
      fi
   fi   
   if [[ $key != "sslKeyPassword" ]]; then 
      echo $key=$value >> $rpmLog
   fi
done < "/etc/netbrain/install_licenseagent.conf"  

if [ $ssl -ne 0 ]; then
   if ( echo "$certFile" | grep -q ' ' ); then
      echo "The certificate file $certFile is not specified. " | tee -a $rpmLog
      break 
    elif [ ! -f $certFile ]; then
      echo "The certificate file $certFile does not exist. " | tee -a $rpmLog
      break 
   fi

   if ( echo "$certKey" | grep -q ' ' ); then
      echo "The certificate key file $certKey is not specified. " | tee -a $rpmLog
      break 
    elif ! [ -f $certKey ]; then
      echo "The certificate key file $certKey does not exist. " | tee -a $rpmLog
      break 
   fi
fi

if [ -z "$prefix" ] ; then
   echo "Start to run rpm -ivh netbrainlicense-7-0.noarch.rpm." >> $rpmLog
   rpm -ivh netbrainlicense-7-0.noarch.rpm
   echo "After running rpm -ivh netbrainlicense-7-0.noarch.rpm." >> $rpmLog
else
   if [ -d "$prefix" ]; then
      topdir=$prefix
      while [ ! -d $topdir ]; do
         topdir=$(dirname $topdir)
      done
      testchattr=$(lsattr -d $topdir | cut -d " " -f1 | grep -e "i" -e "a")
      if [ -n "$testchattr" ]; then
	     echo "The path $topdir is immutable."
		 break
      fi
      echo "Start to run rpm -ivh --prefix $prefix netbrainlicense-7-0.noarch.rpm." >> $rpmLog
      rpm -ivh --prefix $prefix netbrainlicense-7-0.noarch.rpm
      echo "After running rpm -ivh --prefix $prefix netbrainlicense-7-0.noarch.rpm." >> $rpmLog
   else 
      echo "Path $prefix does not exist." | tee -a $rpmLog
   fi
fi

echo "Finished to execute install.sh" | tee -a $rpmLog
break
done
