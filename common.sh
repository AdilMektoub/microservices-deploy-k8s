#!/bin/bash

## install packages debian docke ansible

IP=$(hostname -I | awk '{print $2}')

echo "[1]: install utils & ansible"
apt-get update -qq >/dev/null
apt-get install -qq -y git sshpass net-tools wget ansible gnupg2 python-dev curl python3-pip vim >/dev/null

echo "[2]: ansible custom"
sed -i 's/.*pipelining.*/pipelining = True/' /etc/ansible/ansible.cfg
sed -i 's/.*allow_world_readable_tmpfiles.*/allow_world_readable_tmpfiles = True/' /etc/ansible/ansible.cfg

echo "[3]: install docker & docker-composer"
curl -fsSL https://get.docker.com | sh; >/dev/null
usermod -aG docker vagrant # authorize docker for vagrant user
curl -sL "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose 

echo "[4]: use registry without ssl"
echo "
{
 \"insecure-registries\" : [\"192.168.5.3:5000\"]
}
" >/etc/docker/daemon.json
systemctl daemon-reload
systemctl restart docker

echo "[5]: add hosts"
sudo -u vagrant echo "172.16.16.100  kmaster.com master1" >> /etc/hosts
sudo -u vagrant echo "172.16.16.101  kworker.com worker1" >> /etc/hosts