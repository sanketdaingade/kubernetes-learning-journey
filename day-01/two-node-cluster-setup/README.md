# Day 01 – Two-Node Kubernetes Cluster Setup on AWS 🚀

## Project Overview

In this hands-on project, I successfully deployed a Two-Node Kubernetes Cluster on AWS EC2 using kubeadm.

The cluster consists of one Control Plane (Master Node) and one Worker Node. I configured Containerd as the container runtime and Flannel as the CNI network plugin.

## Architecture

- Cloud Platform: AWS
- Master Node: Ubuntu EC2
- Worker Node: Ubuntu EC2
- Container Runtime: Containerd
- Cluster Management: kubeadm
- CNI Plugin: Flannel
- Kubernetes Version: v1.29.15

## AWS Infrastructure Configuration

Created two EC2 instances:

| Configuration | Master Node | Worker Node |
|---|---|---|
| Operating System | Ubuntu | Ubuntu |
| Instance Type | c7i-flex.large | c7i-flex.large |
| Hostname | masternode | slavenode |
| Key Pair | k8s-key | k8s-key |
| Security Group | k8s-sg | k8s-sg |

## Security Group Configuration

Configured the AWS Security Group with the following inbound rules:

| Type | Port | Purpose |
|---|---|---|
| SSH | 22 | Remote server access |
| Custom TCP | 6443 | Kubernetes API Server |
| Custom TCP | 10250 | Kubelet API |

**Outbound Rules:**

- Type: All Traffic
- Protocol: All
- Port Range: All
- Destination: 0.0.0.0/0

All outbound traffic was allowed during this learning lab to enable required external communication.

**Note:** Flannel VXLAN networking requires UDP port 8472 communication between cluster nodes. Security Group rules should permit this traffic between the nodes.

## Step 1 – Launch EC2 Instances

- Launched two Ubuntu EC2 instances on AWS.
- Configured the required Security Group.
- Connected to both instances using SSH.

## Step 2 – Configure Hostnames

On Master Node:

```bash
sudo hostnamectl set-hostname masternode
bash
```

On Worker Node:

```bash
sudo hostnamectl set-hostname slavenode
bash
```

## Step 3 – Install Containerd and Kubernetes Components

Created and executed the common setup script on both nodes:

```bash
chmod +x k8s-common-containerd.sh
sudo ./k8s-common-containerd.sh
```

The script performs the following tasks:

- Disabled swap.
- Loaded required kernel modules: overlay and br_netfilter.
- Configured kernel networking parameters.
- Installed required dependencies.
- Added the Docker repository.
- Installed Containerd.
- Configured Containerd with SystemdCgroup enabled.
- Installed kubeadm, kubelet, kubectl, and cri-tools.
- Held Kubernetes package versions to prevent automatic upgrades.

## Step 4 – Initialize Kubernetes Control Plane

On the Master Node, executed:

```bash
chmod +x k8s-master-init.sh
sudo ./k8s-master-init.sh
```

The script performs the following tasks:

- Initializes the Kubernetes Control Plane using kubeadm.
- Configures the containerd CRI socket.
- Sets the Pod Network CIDR to 10.244.0.0/16.
- Configures kubeconfig for the current user.
- Installs Flannel CNI networking.

## Step 5 – Join Worker Node to the Cluster

On the Master Node, generated the worker join command:

```bash
sudo kubeadm token create --print-join-command
```

Copied the generated command and executed the worker join script on the Worker Node:

```bash
chmod +x k8s-worker-join.sh
sudo ./k8s-worker-join.sh
```

Pasted the generated join command when prompted.

The Worker Node successfully joined the Kubernetes Cluster.

**Note:** Join tokens and CA hashes are temporary cluster credentials and are intentionally not included in this repository.

## Step 6 – Verify Kubernetes Nodes

Executed on the Master Node:

```bash
kubectl get nodes
```

Expected result:

```text
NAME         STATUS   ROLES           VERSION
masternode   Ready    control-plane   v1.29.15
slavenode    Ready    <none>          v1.29.15
```

Both nodes successfully reached the Ready status.

## Step 7 – Verify Kubernetes System Pods

Executed:

```bash
kubectl get pods -A
```

Verified that the Kubernetes system components and Flannel Pods were running successfully.

## Project Screenshots

All practical screenshots are available in the screenshots directory.

## Project Structure

```text
two-node-cluster-setup/
│
├── scripts/
│   ├── k8s-common-containerd.sh
│   ├── k8s-master-init.sh
│   └── k8s-worker-join.sh
│
├── screenshots/
│   ├── 01-ec2-instances.png
│   ├── 02-security-group.png
│   ├── 03-containerd-setup.png
│   ├── 04-kubernetes-installation.png
│   ├── 05-master-initialization.png
│   ├── 06-worker-node-join.png
│   ├── 07-kubernetes-nodes.png
│   └── 08-kubernetes-pods.png
│
└── README.md
```

## What I Learned

- Kubernetes Cluster Architecture.
- Control Plane and Worker Node configuration.
- Containerd installation and configuration.
- Kubernetes installation using kubeadm.
- Flannel CNI networking.
- Joining Worker Nodes to a Kubernetes Cluster.
- Kubernetes node and pod verification.
- AWS EC2 and Security Group configuration.

## Important Notes

- This project was created for hands-on learning and practice.
- Kubernetes v1.29.15 is used in this lab and is no longer supported. Future implementations should use a currently supported Kubernetes release.
- Do not upload AWS private keys, Kubernetes admin configuration files, join tokens, CA hashes, or other sensitive credentials.

---

**Status: Successfully Completed – Day 01** 🚀