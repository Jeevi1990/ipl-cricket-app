#!/bin/bash

# ==============================================
# GitHub Actions Self-Hosted Runner Setup Script
# ==============================================

set -e

echo "🔧 Setting up GitHub Actions Self-Hosted Runner"
echo "================================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo ""
echo "Prerequisites:"
echo "1. Minikube installed and running"
echo "2. kubectl configured"
echo "3. Docker installed"
echo ""

# Check prerequisites
echo "Checking prerequisites..."

if command -v minikube &> /dev/null; then
    echo -e "${GREEN}✓ Minikube installed${NC}"
else
    echo -e "${RED}✗ Minikube not installed${NC}"
    exit 1
fi

if command -v kubectl &> /dev/null; then
    echo -e "${GREEN}✓ kubectl installed${NC}"
else
    echo -e "${RED}✗ kubectl not installed${NC}"
    exit 1
fi

if command -v docker &> /dev/null; then
    echo -e "${GREEN}✓ Docker installed${NC}"
else
    echo -e "${RED}✗ Docker not installed${NC}"
    exit 1
fi

echo ""
echo "=========================================="
echo "Setting up Self-Hosted Runner"
echo "=========================================="
echo ""
echo "Follow these steps to set up a self-hosted runner:"
echo ""
echo "1. Go to your GitHub repository"
echo "2. Navigate to Settings > Actions > Runners"
echo "3. Click 'New self-hosted runner'"
echo "4. Select your OS (macOS/Linux)"
echo "5. Follow the download and configure instructions"
echo ""
echo "After setup, start the runner with:"
echo -e "${YELLOW}./run.sh${NC}"
echo ""
echo "The GitHub Actions workflow will automatically deploy"
echo "to your local Minikube cluster on every push to main!"
echo ""
