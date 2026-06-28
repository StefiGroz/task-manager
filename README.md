# Task Manager

Full-stack task management app with React, Node.js/Express, PostgreSQL, and Kubernetes deployment on Minikube.

---

## Tech Stack

- **Frontend** — React (served via `serve`)
- **Backend** — Node.js / Express
- **Database** — PostgreSQL 16
- **Containerization** — Docker
- **Orchestration** — Kubernetes (Minikube)
- **Ingress** — NGINX Ingress Controller

---

## Features

- Create, read, update, delete tasks
- Task status: `TODO`, `IN_PROGRESS`, `DONE`
- REST API with health check endpoint
- PostgreSQL persistence with schema auto-init
- Kubernetes deployment with Ingress routing

---

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/tasks` | List all tasks |
| GET | `/api/tasks/:id` | Get task by ID |
| POST | `/api/tasks` | Create task |
| PUT | `/api/tasks/:id` | Update task |
| DELETE | `/api/tasks/:id` | Delete task |
| GET | `/health` | Backend health check |

---

## Local Development — Docker Compose

```bash
docker-compose up --build
```

- Frontend: `http://localhost:3000`
- Backend: `http://localhost:5000`

---

## Kubernetes Deployment (Minikube)

### Prerequisites

```bash
minikube start
minikube addons enable ingress
```

### Build the frontend image inside Minikube

React API URL is baked at build time. Build the image inside Minikube's Docker daemon so it uses `/api` as the base URL:

```bash
eval $(minikube docker-env)

docker build \
  --build-arg REACT_APP_API_URL=/api \
  -t stefi4/task-manager-frontend:latest \
  ./frontend/
```

### Apply manifests

```bash
kubectl apply -f k8s/
```

This creates the `task-manager` namespace and deploys:
- PostgreSQL StatefulSet with persistent volume
- Backend Deployment (with init container that runs schema migration)
- Frontend Deployment
- Services for all three
- NGINX Ingress

### Configure local DNS

```bash
echo "$(minikube ip) task-manager.local" | sudo tee -a /etc/hosts
```

### Access

```
http://task-manager.local
```

---

## Database Initialization

Schema is applied by an init container in the backend pod before the backend starts. It runs `init.sql` via `psql`, which uses `CREATE TABLE IF NOT EXISTS` — safe to run on both fresh and existing volumes.

---

## Environment Variables (Backend)

| Variable | Value in Kubernetes |
|----------|---------------------|
| `DATABASE_HOST` | `postgres` |
| `DATABASE_PORT` | `5432` |
| `DATABASE_NAME` | from Secret |
| `DATABASE_USER` | from Secret |
| `DATABASE_PASSWORD` | from Secret |
| `PORT` | `5000` |
| `NODE_ENV` | `production` |

Credentials are stored in `k8s/01-secret.yaml` as a Kubernetes Secret.

---

## Project Structure

```
task-manager/
├── frontend/          # React app
├── backend/           # Express API
├── database/          # init.sql, schema.sql
├── k8s/               # Kubernetes manifests
├── docker-compose.yml
└── .github/workflows/ # CI/CD pipeline
```
