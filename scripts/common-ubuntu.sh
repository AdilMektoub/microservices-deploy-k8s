#! /bin/bash

###############################################################################
log()
{
   echo "********************************************************************************"
   echo [`date`] - $1
   echo "********************************************************************************"
}

###############################################################################
systemUpdate()
{
   log "Updating System pkgs"
   sudo apt update -y
   sudo apt install -y apt-utils net-tools curl gnupg2 software-properties-common apt-transport-https ca-certificates lsb-release
   sudo apt install -y python3-pip
   sudo ufw disable
   sudo swapoff -a; sed -i '/swap/d' /etc/fstab
   sudo cat >>/etc/sysctl.d/kubernetes.conf<<EOF
   net.bridge.bridge-nf-call-ip6tables = 1
   net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

}

###############################################################################
systemSettings()
{
   log "Setup sshd"
   sudo cat /vagrant/hosts >> /etc/hosts
   sudo service stop ssh
   sudo sed -i 's|#   PasswordAuthentication|PasswordAutentication|g' /etc/ssh/ssh_config
   sudo sed -i 's|#   IdentityFile|IdentityFile|g' /etc/ssh/ssh_config
   sudo sed -i 's|#   Port|Port|g' /etc/ssh/ssh_config
   sudo service start ssh
   sudo service restart ssh

   log "Disabling swap permanently"
  sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
  sudo swapoff -a

   log "Disable SELINUX permanently."
   # Disable Selinux, as this is required to allow containers to access the
   # host filesystem, which is needed by pod networks and other services.
   sudo setenforce 0
   sudo sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux

 sudo modprobe br_netfilter
 sudo lsmod | grep br_netfilter
}

###############################################################################
installDocker()
{
  sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt update
  sudo apt install -y docker-ce=5:19.03.10~3-0~ubuntu-focal containerd.io
}

###############################################################################
installKubernetes()
{
  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
  echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
  apt update && apt install -y kubeadm=1.18.5-00 kubelet=1.18.5-00 kubectl=1.18.5-00
}

###############################################################################
log
systemUpdate
systemSettings
installDocker
installKubernetes