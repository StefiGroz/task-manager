# Task Manager - Full Stack Application

A complete full-stack web application for managing tasks, built with React (frontend), Express.js (backend), and PostgreSQL (database). This project is designed as a university project for learning CI/CD, and is suitable for Docker and Kubernetes deployment.

## 📋 Features

- ✅ Create, read, update, and delete tasks
- ✅ Change task status (TODO, IN_PROGRESS, DONE)
- ✅ Responsive and clean UI
- ✅ RESTful API with proper error handling
- ✅ Health check endpoint for monitoring
- ✅ PostgreSQL database with proper schema
- ✅ Environment-based configuration
- ✅ Production-ready code structure

## 🏗️ Project Structure

```
task-manager/
├── frontend/                 # React frontend application
│   ├── public/              # Public assets
│   ├── src/
│   │   ├── components/      # Reusable React components
│   │   ├── services/        # API service layer
│   │   ├── App.js
│   │   ├── App.css
│   │   └── index.js
│   ├── package.json
│   └── .gitignore
├── backend/                  # Express.js backend
│   ├── controllers/         # Business logic controllers
│   ├── routes/              # API routes
│   ├── middleware/          # Custom middleware
│   ├── db.js               # Database connection
│   ├── server.js           # Main server file
│   ├── package.json
│   ├── .env.example        # Environment variables template
│   └── .gitignore
├── database/                # Database files
│   ├── schema.sql          # Database schema
│   └── init.sql            # Initialization script with sample data
└── README.md               # This file
```

## 🛠️ Prerequisites

- Node.js (v14.0.0 or higher)
- PostgreSQL (v12.0 or higher)
- npm or yarn package manager

## 🚀 Quick Start

### 1. Set Up PostgreSQL Database

Create a new PostgreSQL database and user:

```bash
# Connect to PostgreSQL (may require sudo or password depending on your setup)
psql -U postgres

# Then run these commands in the PostgreSQL prompt:
CREATE DATABASE taskdb;
CREATE USER taskuser WITH PASSWORD 'taskpass';
GRANT ALL PRIVILEGES ON DATABASE taskdb TO taskuser;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO taskuser;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO taskuser;
\c taskdb

# Run the initialization script
\i /path/to/database/init.sql

# Exit PostgreSQL
\q
```

Alternatively, run the SQL file directly:

```bash
psql -U postgres -d taskdb -f database/init.sql
```

### 2. Set Up Backend

Navigate to the backend directory:

```bash
cd backend
```

Install dependencies:

```bash
npm install
```

Create `.env` file from the template:

```bash
cp .env.example .env
```

Update `.env` with your database credentials (the defaults should work if you followed step 1):

```
DATABASE_HOST=localhost
DATABASE_PORT=5432
DATABASE_NAME=taskdb
DATABASE_USER=taskuser
DATABASE_PASSWORD=taskpass
PORT=5000
NODE_ENV=development
```

Start the backend server:

```bash
npm start
```

The backend will start on `http://localhost:5000`

Test the health check:

```bash
curl http://localhost:5000/health
```

### 3. Set Up Frontend

In a new terminal, navigate to the frontend directory:

```bash
cd frontend
```

Install dependencies:

```bash
npm install
```

Start the development server:

```bash
npm start
```

The frontend will automatically open at `http://localhost:3000`

## 📡 API Documentation

All endpoints are prefixed with `/api`

### Health Check

- **GET** `/health` - Check server and database status

```bash
curl http://localhost:5000/health
```

Response:
```json
{
  "status": "OK",
  "timestamp": "2024-06-23T10:30:00.000Z",
  "database": "connected"
}
```

### Tasks

#### Get All Tasks

- **GET** `/api/tasks` - Retrieve all tasks

```bash
curl http://localhost:5000/api/tasks
```

#### Get Single Task

- **GET** `/api/tasks/:id` - Retrieve a specific task

```bash
curl http://localhost:5000/api/tasks/1
```

#### Create Task

- **POST** `/api/tasks` - Create a new task

```bash
curl -X POST http://localhost:5000/api/tasks \
  -H "Content-Type: application/json" \
  -d '{"title":"Buy groceries","description":"Milk, eggs, bread"}'
```

Request body:
```json
{
  "title": "Buy groceries",
  "description": "Milk, eggs, bread"
}
```

Response:
```json
{
  "id": 7,
  "title": "Buy groceries",
  "description": "Milk, eggs, bread",
  "status": "TODO",
  "created_at": "2024-06-23T10:30:00.000Z"
}
```

#### Update Task

- **PUT** `/api/tasks/:id` - Update a task

```bash
curl -X PUT http://localhost:5000/api/tasks/1 \
  -H "Content-Type: application/json" \
  -d '{"status":"IN_PROGRESS"}'
```

Request body (all fields optional):
```json
{
  "title": "Updated title",
  "description": "Updated description",
  "status": "IN_PROGRESS"
}
```

#### Delete Task

- **DELETE** `/api/tasks/:id` - Delete a task

```bash
curl -X DELETE http://localhost:5000/api/tasks/1
```

## 🗄️ Database Schema

### Tasks Table

```sql
CREATE TABLE tasks (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  status VARCHAR(50) NOT NULL DEFAULT 'TODO' CHECK (status IN ('TODO', 'IN_PROGRESS', 'DONE')),
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```

**Columns:**
- `id` - Auto-increment primary key
- `title` - Task title (required, max 255 characters)
- `description` - Task description (optional, unlimited text)
- `status` - Task status: TODO, IN_PROGRESS, or DONE
- `created_at` - Task creation timestamp
- `updated_at` - Last update timestamp

## 🎨 Frontend Components

### App Component
Main application component that manages state and coordinates between TaskForm and TaskList.

### TaskForm Component
Form component for creating new tasks with title and description fields.

### TaskList Component
Displays all tasks and handles loading and empty states.

### TaskItem Component
Individual task card showing title, description, status, and action buttons.

## 🔧 Configuration

### Backend Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| DATABASE_HOST | localhost | PostgreSQL host |
| DATABASE_PORT | 5432 | PostgreSQL port |
| DATABASE_NAME | taskdb | Database name |
| DATABASE_USER | taskuser | Database user |
| DATABASE_PASSWORD | taskpass | Database password |
| PORT | 5000 | Server port |
| NODE_ENV | development | Environment (development/production) |

### Frontend Configuration

The frontend automatically uses the backend API at `http://localhost:5000` in development. For production, update the `proxy` setting in `package.json` or set the `REACT_APP_API_URL` environment variable.

## 📦 Scripts

### Backend

```bash
npm start      # Start the production server
npm run dev    # Start with nodemon for development
npm test       # Run tests (currently a placeholder)
```

### Frontend

```bash
npm start      # Start development server
npm run build  # Build for production
npm test       # Run tests
npm run eject  # Eject from create-react-app (irreversible)
```

## 🔍 Troubleshooting

### Database Connection Error

If you get a connection error, check:
1. PostgreSQL is running: `sudo systemctl status postgresql`
2. Database exists: `psql -U postgres -l | grep taskdb`
3. User has permissions: `psql -U taskuser -d taskdb -c "SELECT 1"`
4. Environment variables in `.env` are correct

### Frontend Can't Connect to Backend

- Ensure backend is running on port 5000
- Check browser console for CORS errors
- Verify backend's `cors` middleware is configured
- In production, update the API URL in frontend config

### Port Already in Use

If port 5000 is already in use:
- Backend: Change `PORT` in `.env`
- Frontend: Kill the process using the port or configure a different port in `package.json`

```bash
# Find process using port 5000
lsof -i :5000

# Kill the process
kill -9 <PID>
```

## 📝 Development Workflow

1. **Backend Development**: Modify files in `/backend`, server auto-restarts with nodemon
2. **Frontend Development**: Modify files in `/frontend`, browser auto-reloads
3. **Database Changes**: Run SQL scripts in `/database`
4. **Testing**: Add curl commands or use Postman to test API endpoints

## 🌐 Production Deployment

### Preparing for Production

1. **Build Frontend**:
   ```bash
   cd frontend
   npm run build
   ```

2. **Set Production Environment Variables**:
   ```bash
   NODE_ENV=production
   PORT=5000
   ```

3. **Start Backend**:
   ```bash
   npm start
   ```

### For Docker/Kubernetes Deployment

This project is structured to be easily containerized. To add Docker support:

1. Create `Dockerfile` files in frontend and backend directories
2. Create `docker-compose.yml` for local testing
3. Create Kubernetes manifests in a `k8s/` directory
4. Configure CI/CD pipelines in `.github/workflows/` or equivalent

The current structure with environment variables and proper separation of concerns makes it ready for such deployment.

## 📚 Learning Resources

- [Express.js Documentation](https://expressjs.com/)
- [React Documentation](https://react.dev/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [RESTful API Best Practices](https://restfulapi.net/)

## 📄 License

MIT License - Feel free to use this project for educational purposes.

## 🤝 Contributing

This is a university project. For contributions or improvements, please create a pull request with your changes.

## ✉️ Contact

For questions about this project, please reach out to the development team.

---

**Last Updated**: June 2024
**Version**: 1.0.0
