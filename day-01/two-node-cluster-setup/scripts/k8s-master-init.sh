#!/bin/bash

set -e

echo "==== MASTER: Initializing Kubernetes Control Plane ===="

# Initialize Kubernetes with containerd runtime
sudo kubeadm init \
  --cri-socket unix:///run/containerd/containerd.sock \
  --pod-network-cidr=10.244.0.0/16

echo "==== Setting up kubeconfig for current user ===="

# Create kube directory
mkdir -p $HOME/.kube

# Copy admin config
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

# Change ownership
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "Kubeconfig setup complete."

echo "==== Installing Flannel CNI Plugin ===="

# Install Flannel Network Plugin
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml

echo "==== Kubernetes Control Plane is Ready ===="

echo ""
echo "Check cluster status:"
echo "kubectl get nodes"

echo ""
echo "Check all pods:"
echo "kubectl get pods -A"

echo ""
echo "Generate worker join command:"
echo "kubeadm token create --print-join-command"