# Day 02 – Kubernetes Replication Controller & ReplicaSet

## Overview

On Day 02 of my Kubernetes Learning Journey, I learned about two important Kubernetes controllers: Replication Controller and ReplicaSet.

I understood how these controllers maintain the desired number of Pod replicas and automatically create replacement Pods when an existing Pod is deleted.

I also performed hands-on practicals by creating YAML configuration files and managing Pods using Kubernetes commands.

## Topics Covered

- Replication Controller
- Features and Benefits of Replication Controller
- ReplicaSet
- Features and Benefits of ReplicaSet
- Difference Between Replication Controller and ReplicaSet
- Hands-on Implementation
- Automatic Pod Replacement

---

# 1. Replication Controller

## What is a Replication Controller?

A Replication Controller is a Kubernetes resource that ensures a specified number of Pod replicas are running at all times.

If a Pod gets deleted or fails, the Replication Controller automatically creates a new Pod to maintain the desired number of replicas.

## Why Do We Use Replication Controller?

- To maintain the desired number of Pods.
- To provide application availability.
- To automatically replace deleted or failed Pods.
- To manage multiple Pod replicas.

## Features and Benefits

- Maintains the desired number of Pod replicas.
- Automatically creates replacement Pods.
- Helps improve application availability.
- Supports scaling by changing the replica count.
- Reduces manual Pod management.

## Hands-on Implementation

### Step 1: Create YAML File

Created a file named `rc.yaml` using Vim.

```bash
vim rc.yaml
```

### Step 2: Replication Controller YAML Configuration

```yaml
apiVersion: v1
kind: ReplicationController
metadata:
  name: nginx
spec:
  replicas: 3
  selector:
    app: nginx
  template:
    metadata:
      name: nginx
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
```

### Step 3: Create Replication Controller

```bash
kubectl apply -f rc.yaml
```

### Step 4: Verify Replication Controller

```bash
kubectl get rc
```

### Step 5: Verify Pods

```bash
kubectl get pods
```

Verified that three Nginx Pods were successfully created and running.

### Step 6: Test Automatic Pod Replacement

Deleted one Pod using its Pod name.

```bash
kubectl delete pod <pod-name>
```

Then checked the Pods again.

```bash
kubectl get pods
```

The Replication Controller automatically created a new Pod to maintain the desired replica count of three.

### Step 7: Delete Replication Controller

```bash
kubectl delete -f rc.yaml
```

---

# 2. ReplicaSet

## What is a ReplicaSet?

A ReplicaSet is a Kubernetes resource that maintains a stable set of running Pod replicas.

It ensures that the specified number of Pods are always running.

If any Pod gets deleted or fails, the ReplicaSet automatically creates a replacement Pod.

ReplicaSet is the newer and more advanced replacement for Replication Controller.

## Why Do We Use ReplicaSet?

- To maintain the desired number of Pod replicas.
- To improve application availability.
- To automatically replace deleted or failed Pods.
- To manage Pods using label selectors.
- To maintain consistent application instances.

## Features and Benefits

- Maintains the desired number of Pods.
- Automatically replaces missing Pods.
- Supports equality-based and set-based label selectors.
- Allows scaling by changing the replica count.
- Provides better flexibility than Replication Controller.

## Hands-on Implementation

### Step 1: Create YAML File

Created a file named `rs.yaml` using Vim.

```bash
vim rs.yaml
```

### Step 2: ReplicaSet YAML Configuration

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: frontend
  labels:
    app: guestbook
    tier: frontend
spec:
  replicas: 3
  selector:
    matchLabels:
      tier: frontend
  template:
    metadata:
      labels:
        tier: frontend
    spec:
      containers:
      - name: php-redis
        image: us-docker.pkg.dev/google-samples/containers/gke/gb-frontend:v5
```

### Step 3: Create ReplicaSet

```bash
kubectl apply -f rs.yaml
```

### Step 4: Verify ReplicaSet

```bash
kubectl get rs
```

### Step 5: Verify Pods

```bash
kubectl get pods
```

Verified that three Pods were successfully created.

### Step 6: Test Automatic Pod Replacement

Deleted one Pod using its Pod name.

```bash
kubectl delete pod <pod-name>
```

Checked the Pods again.

```bash
kubectl get pods
```

The ReplicaSet automatically created a new Pod to maintain the desired replica count of three.

### Step 7: Delete ReplicaSet

```bash
kubectl delete -f rs.yaml
```

---

# 3. Difference Between Replication Controller and ReplicaSet

| Replication Controller | ReplicaSet |
|---|---|
| Older Kubernetes controller. | Newer Kubernetes controller. |
| Supports equality-based selectors. | Supports equality-based and set-based selectors. |
| Uses `apiVersion: v1`. | Uses `apiVersion: apps/v1`. |
| Maintains the desired number of Pod replicas. | Maintains the desired number of Pod replicas. |
| Older approach to managing Pod replicas. | More flexible approach to managing Pod replicas. |

---

# 4. Important Kubernetes Commands

| Command | Description |
|---|---|
| `kubectl apply -f rc.yaml` | Creates Replication Controller. |
| `kubectl get rc` | Lists Replication Controllers. |
| `kubectl apply -f rs.yaml` | Creates ReplicaSet. |
| `kubectl get rs` | Lists ReplicaSets. |
| `kubectl get pods` | Lists Pods. |
| `kubectl describe pod <pod-name>` | Shows detailed Pod information. |
| `kubectl delete pod <pod-name>` | Deletes a Pod. |
| `kubectl delete -f rc.yaml` | Deletes Replication Controller. |
| `kubectl delete -f rs.yaml` | Deletes ReplicaSet. |

---

# 5. What I Learned

During Day 02 of my Kubernetes Learning Journey, I learned:

- What Replication Controller is and why it is used.
- How to create a Replication Controller using YAML.
- How Replication Controller maintains the desired number of Pods.
- What ReplicaSet is and why it is used.
- How to create a ReplicaSet using YAML.
- How label selectors work in ReplicaSet.
- How Kubernetes automatically replaces deleted Pods.
- The key differences between Replication Controller and ReplicaSet.
- How to manage these resources using kubectl commands.

## Practical Learning

I successfully implemented both Replication Controller and ReplicaSet on my Kubernetes cluster running on AWS EC2.

I verified that when one Pod was deleted, Kubernetes automatically created a replacement Pod to maintain the desired replica count.

---

## My Learning Journey

**Day 01:** Two-Node Kubernetes Cluster Setup on AWS EC2.

**Day 02:** Replication Controller and ReplicaSet.

More Kubernetes concepts and hands-on practicals coming soon!

#Kubernetes #DevOps #AWS #CloudComputing #LearningJourney #HandsOnLearning