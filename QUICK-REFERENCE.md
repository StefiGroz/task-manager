# Task Manager - Quick Reference Guide

## 🚀 Quick Start (5 minutes)

```bash
# Terminal 1: Setup Database
psql -U postgres -f database/init.sql

# Terminal 2: Start Backend
cd backend && npm install && npm start
# Runs on http://localhost:5000

# Terminal 3: Start Frontend  
cd frontend && npm install && npm start
# Runs on http://localhost:3000
```

## 📱 Frontend URLs

| URL | Purpose |
|-----|---------|
| http://localhost:3000 | Main application |
| http://localhost:3000 | Task list display |

## 🔌 Backend API Base URLs

| URL | Purpose |
|-----|---------|
| http://localhost:5000 | Backend server |
| http://localhost:5000/health | Health check |
| http://localhost:5000/api/tasks | Tasks API |

## 📡 API Quick Reference

### All Tasks
```bash
GET http://localhost:5000/api/tasks
```

### Single Task
```bash
GET http://localhost:5000/api/tasks/1
```

### Create Task
```bash
POST http://localhost:5000/api/tasks
Body: {"title":"Task name","description":"..."}
```

### Update Status
```bash
PUT http://localhost:5000/api/tasks/1
Body: {"status":"IN_PROGRESS"}
```

### Update Title
```bash
PUT http://localhost:5000/api/tasks/1
Body: {"title":"New title"}
```

### Delete Task
```bash
DELETE http://localhost:5000/api/tasks/1
```

## 🔄 Task Status Values

| Status | Meaning |
|--------|---------|
| TODO | Not started |
| IN_PROGRESS | Currently working |
| DONE | Completed |

## 📂 Key Files

| Path | Purpose |
|------|---------|
| `backend/server.js` | Express server |
| `backend/controllers/taskController.js` | API logic |
| `frontend/src/App.js` | React app |
| `frontend/src/services/api.js` | API client |
| `database/init.sql` | Database setup |

## 🔧 Environment Variables

### Backend (.env)
```
DATABASE_HOST=localhost
DATABASE_PORT=5432
DATABASE_NAME=taskdb
DATABASE_USER=taskuser
DATABASE_PASSWORD=taskpass
PORT=5000
NODE_ENV=development
```

## 🧪 Testing

### Quick API Test
```bash
# Test health
curl http://localhost:5000/health

# Get tasks
curl http://localhost:5000/api/tasks

# Create task
curl -X POST http://localhost:5000/api/tasks \
  -H "Content-Type: application/json" \
  -d '{"title":"Test","description":"Test task"}'
```

### Run Full Test Suite
```bash
./test-api.sh
```

### Use Postman
Import: `Task-Manager-API.postman_collection.json`

## 🐛 Common Issues

### Database Connection Error
```bash
# Check PostgreSQL running
sudo systemctl status postgresql

# Test connection
psql -U taskuser -d taskdb
```

### Port in Use
```bash
# Find process on port 5000
lsof -i :5000

# Kill process
kill -9 <PID>
```

### Module Not Found
```bash
# Reinstall dependencies
rm -rf node_modules package-lock.json
npm install
```

## 📁 Directory Overview

```
task-manager/
├── backend/          # Express API server
├── frontend/         # React web app
├── database/         # PostgreSQL schema
└── docs/            # Documentation
```

## 🔄 Development Workflow

1. **Backend Changes**: Auto-reload with `npm run dev`
2. **Frontend Changes**: Auto-reload in browser
3. **Database Changes**: Restart backend and update schema

## 🚢 Deployment

### Local Development
```bash
npm start
```

### Production Build (Frontend)
```bash
npm run build
# Creates build/ folder
```

### Docker Build
```bash
# Backend
docker build -t task-manager-backend ./backend

# Frontend
docker build -t task-manager-frontend ./frontend
```

## 📊 Database

### Current Schema
```sql
CREATE TABLE tasks (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  status VARCHAR(50) DEFAULT 'TODO',
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

### Indexes
- `idx_tasks_created_at` - For sorting
- `idx_tasks_status` - For filtering

## 🎯 Key Endpoints Response Format

### Success (200, 201)
```json
{
  "id": 1,
  "title": "Task title",
  "description": "Description",
  "status": "TODO",
  "created_at": "2024-06-23T10:30:00.000Z"
}
```

### Error (400, 404, 500)
```json
{
  "error": "Error message describing what went wrong"
}
```

## 🔐 Security Notes

- ✅ Environment variables for secrets
- ✅ Parameterized queries (SQL injection protection)
- ✅ CORS enabled for local development
- ✅ Input validation on backend
- ✅ Error messages don't expose system details

## 📚 Documentation Files

| File | Content |
|------|---------|
| README.md | Full documentation |
| SETUP.md | Setup instructions |
| API-EXAMPLES.md | API usage examples |
| CI-CD-GUIDE.md | Deployment info |
| PROJECT-SUMMARY.md | Project overview |
| PROJECT-INVENTORY.md | File inventory |

## 🛠️ Useful Commands

```bash
# Backend development with auto-reload
npm run dev

# Frontend build
npm run build

# Test API
./test-api.sh

# Database dump
pg_dump taskdb > backup.sql

# Database restore
psql taskdb < backup.sql

# Install dependencies
npm install

# Update dependencies
npm update
```

## 🐳 Docker Quick Commands

```bash
# Build image
docker build -t task-manager .

# Run container
docker run -p 5000:5000 task-manager

# Run with environment
docker run -e PORT=5000 task-manager

# Docker Compose
docker-compose up
```

## ☸️ Kubernetes Quick Commands

```bash
# Create deployment
kubectl create -f k8s/backend-deployment.yaml

# Get pods
kubectl get pods

# View logs
kubectl logs <pod-name>

# Port forward
kubectl port-forward <pod-name> 5000:5000
```

## 💡 Tips & Tricks

### Faster npm install
```bash
npm ci
```

### Kill all node processes
```bash
killall node
```

### View active processes
```bash
lsof -i :5000
lsof -i :3000
```

### Test API with curl
```bash
curl -H "Content-Type: application/json" \
     -X POST http://localhost:5000/api/tasks \
     -d '{"title":"My Task"}'
```

### Format JSON response
```bash
curl http://localhost:5000/api/tasks | json_pp
# or
curl http://localhost:5000/api/tasks | python -m json.tool
```

## 📞 Support Resources

- [Express.js Docs](https://expressjs.com/)
- [React Docs](https://react.dev/)
- [PostgreSQL Docs](https://www.postgresql.org/docs/)
- [REST API Guide](https://restfulapi.net/)

---

**Last Updated**: June 2024
**Quick Reference Version**: 1.0
