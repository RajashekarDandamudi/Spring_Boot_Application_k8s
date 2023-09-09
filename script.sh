#!/bin/bash
 apt update -y
 apt upgrade -y
 curl http://169.254.169.254/latest/meta-data/instance-id; echo
 lsb_release -a
 apt update
 cat << EOF | sudo tee /etc/modules-load.d/containerd.conf
 overlay
 br_netfilter
 EOF
EOF
sudo modprobe overlay
sudo modprobe br_netfilter
modprobe br_netfilter
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
sysctl --system
apt-get update && sudo apt-get install -y containerd
containerd config default | sudo tee
systemctl restart containerd
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo
apt-key add -
cat << EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
 sudo apt-get install -y kubelet=1.24.0-00 kubeadm=1.24.0-00
 kubectl=1.24.0-00
 sudo apt-mark hold kubelet kubeadm kubectl