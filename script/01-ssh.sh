ssh-keygen -f "/root/.ssh/known_hosts" -R 192.168.28.112
ansible-playbook ssh.yml 
