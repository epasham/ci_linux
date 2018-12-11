ssh-keygen -t rsa
ssh-keygen -f "/root/.ssh/known_hosts" -R 192.168.28.107
history |grep copy
ssh-copy-id -i /root/.ssh/id_rsa.pub root@192.168.28.107
ansible -m ping linux
