#!/bin/bash

# ==============================================
# Cleanup Script for IPL Cricket App
# ==============================================

set -e

echo "🧹 Cleaning up IPL Cricket App deployment..."
echo "============================================="

# Delete all resources in the namespace
kubectl delete namespace ipl-cricket --ignore-not-found=true

# Remove Docker image from Minikube
eval $(minikube docker-env)
docker rmi ipl-cricket-app:latest 2>/dev/null || true

echo ""
echo "✓ Cleanup complete!"
echo ""
