#!/bin/bash
# Name of the k3d cluster
CLUSTER_NAME="sampleapp"

# If Docker is available
if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed. Please install Docker and try again."
    exit 1
fi

# If Docker daemon is running
if ! docker info &> /dev/null; then
    echo "Error: Docker daemon is not running. Please start Docker and try again."
    exit 1
fi

# If k3d is installed
if ! command -v k3d &> /dev/null; then
    echo "k3d is not installed. Attempting to install using Homebrew..."

    # If Homebrew is installed
    if ! command -v brew &> /dev/null; then
        echo "Error: Homebrew is not installed. Please install Homebrew and try again."
        exit 1
    fi

    # Install k3d using Homebrew
    brew install k3d

    # If installation was successful
    if [ $? -eq 0 ]; then
        echo "k3d has been successfully installed."
    else
        echo "Error: Failed to install k3d. Please check the installation logs for more details."
        exit 1
    fi
fi


# If the k3d cluster is already running
if k3d cluster get $CLUSTER_NAME &> /dev/null; then
    echo "Cluster $CLUSTER_NAME is already running."
else
    echo "Cluster $CLUSTER_NAME is not running. Creating a new cluster with 2 agents..."

    # Create a new k3d cluster with 2 agents
    k3d cluster create $CLUSTER_NAME --agents 2

    # If cluster creation was successful
    if [ $? -eq 0 ]; then
        echo "Cluster $CLUSTER_NAME created successfully with 2 agents."
    else
        echo "Error: Failed to create cluster $CLUSTER_NAME. Please check the logs for more details."
        exit 1
    fi
fi

kubectl apply -f deployment.yaml

echo "Waiting for the deployment to be complete"
kubectl wait --for=condition=available deployment/sample-app --timeout=300s

echo "Running port forward with kubectl port-forward svc sample-app-service 8080:80. Exit with CTRL+C."
kubectl port-forward svc/sample-app-service 8080:80
