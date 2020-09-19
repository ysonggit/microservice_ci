#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
dockerpath="ysongdocker/mlapp"

# Step 2
# Run the Docker Hub container with kubernetes
kubectl run mlapi20200920\
    --generator=run-pod/v1\
    --image=$dockerpath\
    --port=80 --labels app=mlapi20200920

# Step 3:
# List kubernetes pods
kubectl get pods
# Step 4:
# Forward the container port to a host
kubectl port-forward mlapi20200920 8000:80

# Run in Docker Hub container with kubernetes


