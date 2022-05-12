# I do to allow of joint the cluster because if you try joint the cluster and that all VM are not to start up you can't
export FIRST_RUN=true
export PRIVATE_NETWORK=192.168.56
vagrant plugin install vagrant-vbguest

# 1) Launch all VM/NODES
vagrant up --provision-with update
export FIRST_RUN=false

# 2) Install kubectl and kubeadm
vagrant up --provision-with setup

# 3) to join cluster
vagrant up --provision-with deploy
