# 🏏 IPL Cricket Dashboard

A beautiful IPL Cricket Dashboard application deployed to Kubernetes (Minikube) with GitHub Actions CI/CD.

![Kubernetes](https://img.shields.io/badge/kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Docker](https://img.shields.io/badge/docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/github%20actions-2088FF?style=for-the-badge&logo=githubactions&logoColor=white)
![Python](https://img.shields.io/badge/python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Flask](https://img.shields.io/badge/flask-000000?style=for-the-badge&logo=flask&logoColor=white)

## 🌟 Features

- **IPL Teams Dashboard**: View all 10 IPL teams with their captains and trophy counts
- **Recent Matches**: Display recent match results with venues
- **Top Players**: Showcase top IPL players with their statistics
- **Health Endpoint**: Kubernetes-ready health check endpoint
- **REST API**: JSON APIs for teams, matches, and players

## 📁 Project Structure

```
ipl-cricket-app/
├── app.py                     # Flask application
├── requirements.txt           # Python dependencies
├── Dockerfile                 # Container configuration
├── .dockerignore              # Docker ignore rules
├── templates/
│   └── index.html             # Dashboard HTML template
├── k8s/                       # Kubernetes manifests
│   ├── namespace.yaml
│   ├── configmap.yaml
│   ├── deployment.yaml
│   ├── service.yaml
│   └── ingress.yaml
├── .github/
│   └── workflows/
│       └── deploy.yaml        # GitHub Actions CI/CD
└── scripts/
    ├── deploy-local.sh        # Local deployment script
    ├── setup-runner.sh        # Self-hosted runner setup
    └── cleanup.sh             # Cleanup script
```

## 🚀 Quick Start

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)

### Local Deployment

1. **Start Minikube**
   ```bash
   minikube start --driver=docker
   ```

2. **Deploy the application**
   ```bash
   chmod +x scripts/deploy-local.sh
   ./scripts/deploy-local.sh
   ```

3. **Access the application**
   ```bash
   minikube service ipl-cricket-service -n ipl-cricket
   ```

### Manual Deployment Steps

```bash
# 1. Start Minikube
minikube start

# 2. Use Minikube's Docker daemon
eval $(minikube docker-env)

# 3. Build Docker image
docker build -t ipl-cricket-app:latest .

# 4. Apply Kubernetes manifests
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

# 5. Check deployment status
kubectl get pods -n ipl-cricket
kubectl get services -n ipl-cricket

# 6. Access the app
minikube service ipl-cricket-service -n ipl-cricket
```

## 🔄 GitHub Actions CI/CD

The project includes a GitHub Actions workflow that:

1. **Builds** the Docker image on every push
2. **Deploys** to your local Minikube cluster using a self-hosted runner

### Setting up Self-Hosted Runner for Local Deployment

To deploy directly to your local Minikube:

1. **Go to your GitHub repository Settings**
2. **Navigate to**: Actions → Runners → New self-hosted runner
3. **Follow the setup instructions** for your OS
4. **Run the setup script**:
   ```bash
   chmod +x scripts/setup-runner.sh
   ./scripts/setup-runner.sh
   ```

5. **Start the runner**:
   ```bash
   cd actions-runner
   ./run.sh
   ```

Now, every push to `main` will automatically deploy to your local Minikube!

### Alternative: GitHub-hosted Runner

The workflow also includes a `test-kubernetes-manifests` job that runs on GitHub-hosted runners using the [setup-minikube action](https://github.com/medyagh/setup-minikube). This validates your Kubernetes manifests without requiring a self-hosted runner.

## 🔗 API Endpoints

| Endpoint | Description |
|----------|-------------|
| `GET /` | Main dashboard |
| `GET /api/teams` | JSON list of all IPL teams |
| `GET /api/matches` | JSON list of recent matches |
| `GET /api/players` | JSON list of top players |
| `GET /health` | Health check endpoint |

## 🐳 Docker Commands

```bash
# Build image
docker build -t ipl-cricket-app:latest .

# Run locally
docker run -p 5000:5000 ipl-cricket-app:latest

# Access at http://localhost:5000
```

## ☸️ Kubernetes Commands

```bash
# View pods
kubectl get pods -n ipl-cricket

# View logs
kubectl logs -f deployment/ipl-cricket-app -n ipl-cricket

# Scale deployment
kubectl scale deployment ipl-cricket-app --replicas=3 -n ipl-cricket

# Get service URL
minikube service ipl-cricket-service -n ipl-cricket --url

# Delete deployment
kubectl delete namespace ipl-cricket
```

## 🧹 Cleanup

```bash
chmod +x scripts/cleanup.sh
./scripts/cleanup.sh
```

## 📊 Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    GitHub Repository                      │
│                                                           │
│  ┌─────────────┐    ┌─────────────────────────────────┐  │
│  │   Code      │───▶│   GitHub Actions Workflow        │  │
│  │   Push      │    │   - Build Docker Image           │  │
│  └─────────────┘    │   - Run Tests                    │  │
│                     │   - Deploy to Minikube           │  │
│                     └───────────────┬─────────────────┘  │
└─────────────────────────────────────┼─────────────────────┘
                                      │
                                      ▼
┌─────────────────────────────────────────────────────────┐
│                 Local Machine (Self-Hosted Runner)        │
│                                                           │
│  ┌─────────────────────────────────────────────────────┐ │
│  │                     Minikube                         │ │
│  │  ┌─────────────────────────────────────────────┐    │ │
│  │  │            Namespace: ipl-cricket            │    │ │
│  │  │                                              │    │ │
│  │  │  ┌────────────┐    ┌────────────┐           │    │ │
│  │  │  │   Pod 1    │    │   Pod 2    │           │    │ │
│  │  │  │ ipl-app    │    │ ipl-app    │           │    │ │
│  │  │  └────────────┘    └────────────┘           │    │ │
│  │  │         │                │                   │    │ │
│  │  │         └────────┬───────┘                   │    │ │
│  │  │                  │                           │    │ │
│  │  │         ┌────────▼────────┐                  │    │ │
│  │  │         │    Service      │                  │    │ │
│  │  │         │  NodePort:30080 │                  │    │ │
│  │  │         └─────────────────┘                  │    │ │
│  │  └─────────────────────────────────────────────┘    │ │
│  └─────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────┘
```

## 🎯 CNCF Technologies Used

- **Kubernetes**: Container orchestration
- **Docker**: Containerization
- **GitHub Actions**: CI/CD pipeline
- **Minikube**: Local Kubernetes cluster

## 📝 License

This project is for educational purposes - CNCF Mysore Demo.

---

Made with ❤️ for CNCF Mysore
