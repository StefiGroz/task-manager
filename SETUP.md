# Task Manager - Setup Guide

This document provides a step-by-step guide to run the Task Manager application locally.

## Prerequisites

- **Node.js**: Download from https://nodejs.org/ (v14.0.0 or higher)
- **PostgreSQL**: Download from https://www.postgresql.org/download/ (v12.0 or higher)
- **npm**: Usually comes with Node.js

## Step 1: PostgreSQL Setup (One-time)

### On Linux/Mac:

```bash
# Start PostgreSQL service
sudo systemctl start postgresql  # Linux
brew services start postgresql  # Mac

# Connect to PostgreSQL
psql -U postgres
```

### On Windows:

1. PostgreSQL should be running as a service after installation
2. Open Command Prompt or PowerShell and connect:
   ```
   psql -U postgres
   ```

### Create Database and User:

```sql
-- In PostgreSQL prompt:
CREATE DATABASE taskdb;
CREATE USER taskuser WITH PASSWORD 'taskpass';
GRANT ALL PRIVILEGES ON DATABASE taskdb TO taskuser;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO taskuser;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO taskuser;
\c taskdb
\i database/init.sql
\q
```

## Step 2: Backend Setup

```bash
# Navigate to backend directory
cd backend

# Install dependencies
npm install

# Create .env file
cp .env.example .env

# Verify .env contents (should look like this):
# DATABASE_HOST=localhost
# DATABASE_PORT=5432
# DATABASE_NAME=taskdb
# DATABASE_USER=taskuser
# DATABASE_PASSWORD=taskpass
# PORT=5000
# NODE_ENV=development

# Start backend server
npm start
```

Expected output:
```
Task Manager Backend server running on http://localhost:5000
Health check available at http://localhost:5000/health
API documentation: http://localhost:5000/api/tasks
```

## Step 3: Frontend Setup (In a new terminal)

```bash
# Navigate to frontend directory
cd frontend

# Install dependencies
npm install

# Start frontend development server
npm start
```

Expected output:
```
Compiled successfully!
You can now view task-manager-frontend in the browser.
Local:            http://localhost:3000
```

## Step 4: Verify Everything Works

1. **Check Backend Health**:
   ```bash
   curl http://localhost:5000/health
   ```

2. **Get All Tasks**:
   ```bash
   curl http://localhost:5000/api/tasks
   ```

3. **Open Frontend**: 
   - Navigate to http://localhost:3000 in your browser
   - You should see the Task Manager interface with sample tasks

## 🎯 Quick Verification Checklist

- [ ] PostgreSQL is running
- [ ] Backend is running on port 5000
- [ ] Frontend is running on port 3000
- [ ] You can see tasks in the frontend
- [ ] You can create a new task
- [ ] You can change task status
- [ ] You can delete a task

## 🆘 Common Issues

### "Cannot connect to database"
- Check PostgreSQL is running: `sudo systemctl status postgresql`
- Verify .env file has correct credentials
- Test connection: `psql -U taskuser -d taskdb`

### "Port 5000 already in use"
- Kill the process: `lsof -i :5000` then `kill -9 <PID>`
- Or change port in backend/.env

### "Frontend can't reach backend"
- Ensure backend is running on port 5000
- Check CORS errors in browser console
- Verify proxy setting in frontend/package.json

### "Module not found" errors
- Delete node_modules: `rm -rf node_modules`
- Reinstall: `npm install`

## 📝 Development Notes

- **Auto-reload Frontend**: Changes to React files auto-refresh in browser
- **Auto-reload Backend**: Use `npm run dev` instead of `npm start` for nodemon auto-reload
- **Database Changes**: Restart backend after schema changes
- **API Testing**: Use `curl` or tools like Postman or Insomnia

## 🛑 Stopping the Application

Press `Ctrl+C` in each terminal window running the servers.

## 📖 Next Steps

- Explore the API endpoints in the README.md
- Modify the React components to customize the UI
- Add new features to the backend API
- Set up Docker containers for deployment
- Configure CI/CD pipelines

---

**Ready to go!** If you encounter any issues, refer to the main README.md for more detailed troubleshooting.
