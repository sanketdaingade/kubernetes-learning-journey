#!/bin/bash

set -e

echo "==== WORKER: Joining Kubernetes Cluster ===="

# Read kubeadm join command from user
read -p "Paste the kubeadm join command from master: " joincmd

# Execute join command with containerd CRI socket
sudo ${joincmd} --cri-socket unix:///run/containerd/containerd.sock

echo "==== WORKER: Successfully joined the Kubernetes Cluster! ===="