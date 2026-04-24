#!/bin/bash

# ==============================================
# IPL Cricket App - Local Minikube Deployment Script
# ==============================================

set -e

echo "🏏 IPL Cricket App - Minikube Deployment"
echo "=========================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if minikube is installed
if ! command -v minikube &> /dev/null; then
    echo -e "${RED}Error: minikube is not installed${NC}"
    echo "Install minikube: https://minikube.sigs.k8s.io/docs/start/"
    exit 1
fi

# Check if kubectl is installed
if ! command -v kubectl &> /dev/null; then
    echo -e "${RED}Error: kubectl is not installed${NC}"
    echo "Install kubectl: https://kubernetes.io/docs/tasks/tools/"
    exit 1
fi

# Check if minikube is running
if ! minikube status | grep -q "Running"; then
    echo -e "${YELLOW}Starting Minikube...${NC}"
    minikube start --driver=docker
fi

echo -e "${GREEN}✓ Minikube is running${NC}"

# Use Minikube's Docker daemon
echo "Setting up Minikube Docker environment..."
eval $(minikube docker-env)

# Build the Docker image
echo -e "${YELLOW}Building Docker image...${NC}"
docker build -t ipl-cricket-app:latest .
echo -e "${GREEN}✓ Docker image built successfully${NC}"

# Apply Kubernetes manifests
echo -e "${YELLOW}Deploying to Kubernetes...${NC}"
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

# Wait for deployment to be ready
echo -e "${YELLOW}Waiting for deployment to be ready...${NC}"
kubectl rollout status deployment/ipl-cricket-app -n ipl-cricket --timeout=120s
echo -e "${GREEN}✓ Deployment is ready${NC}"

# Get deployment status
echo ""
echo "=========================================="
echo "Deployment Status:"
echo "=========================================="
kubectl get pods -n ipl-cricket
echo ""
kubectl get services -n ipl-cricket

# Get the URL
echo ""
echo "=========================================="
echo -e "${GREEN}🎉 Deployment Successful!${NC}"
echo "=========================================="
echo ""
echo "To access the application, run:"
echo -e "${YELLOW}minikube service ipl-cricket-service -n ipl-cricket${NC}"
echo ""
echo "Or get the URL:"
echo -e "${YELLOW}minikube service ipl-cricket-service -n ipl-cricket --url${NC}"
echo ""
