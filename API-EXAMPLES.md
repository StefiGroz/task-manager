# Task Manager API Examples

Complete API documentation with practical examples using curl, JavaScript fetch, and Python requests.

## 🎯 Base URL

```
http://localhost:5000/api
```

## 📊 Health Check

### Check Server and Database Status

**Endpoint**: `GET /health`

**cURL**:
```bash
curl http://localhost:5000/health
```

**Response** (200 OK):
```json
{
  "status": "OK",
  "timestamp": "2024-06-23T10:30:00.000Z",
  "database": "connected"
}
```

**Response** (503 Service Unavailable):
```json
{
  "status": "UNHEALTHY",
  "timestamp": "2024-06-23T10:30:00.000Z",
  "database": "disconnected",
  "error": "Error message"
}
```

---

## 📝 Task Operations

### 1. Get All Tasks

**Endpoint**: `GET /api/tasks`

**cURL**:
```bash
curl http://localhost:5000/api/tasks
```

**JavaScript Fetch**:
```javascript
fetch('http://localhost:5000/api/tasks')
  .then(response => response.json())
  .then(data => console.log(data))
  .catch(error => console.error('Error:', error));
```

**Python Requests**:
```python
import requests

response = requests.get('http://localhost:5000/api/tasks')
tasks = response.json()
print(tasks)
```

**Response** (200 OK):
```json
[
  {
    "id": 1,
    "title": "Complete project setup",
    "description": "Set up the initial project structure and dependencies",
    "status": "DONE",
    "created_at": "2024-06-18T14:30:00.000Z"
  },
  {
    "id": 2,
    "title": "Implement backend API",
    "description": "Create REST API endpoints for task management",
    "status": "IN_PROGRESS",
    "created_at": "2024-06-20T09:15:00.000Z"
  }
]
```

---

### 2. Get Single Task

**Endpoint**: `GET /api/tasks/:id`

**Example**: `GET /api/tasks/1`

**cURL**:
```bash
curl http://localhost:5000/api/tasks/1
```

**JavaScript Fetch**:
```javascript
const taskId = 1;
fetch(`http://localhost:5000/api/tasks/${taskId}`)
  .then(response => response.json())
  .then(data => console.log(data))
  .catch(error => console.error('Error:', error));
```

**Python Requests**:
```python
import requests

task_id = 1
response = requests.get(f'http://localhost:5000/api/tasks/{task_id}')
task = response.json()
print(task)
```

**Response** (200 OK):
```json
{
  "id": 1,
  "title": "Complete project setup",
  "description": "Set up the initial project structure and dependencies",
  "status": "DONE",
  "created_at": "2024-06-18T14:30:00.000Z"
}
```

**Response** (404 Not Found):
```json
{
  "error": "Task not found"
}
```

---

### 3. Create New Task

**Endpoint**: `POST /api/tasks`

**Request Headers**:
```
Content-Type: application/json
```

**Request Body**:
```json
{
  "title": "Buy groceries",
  "description": "Milk, eggs, bread, and vegetables"
}
```

**cURL**:
```bash
curl -X POST http://localhost:5000/api/tasks \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Buy groceries",
    "description": "Milk, eggs, bread, and vegetables"
  }'
```

**JavaScript Fetch**:
```javascript
const taskData = {
  title: "Buy groceries",
  description: "Milk, eggs, bread, and vegetables"
};

fetch('http://localhost:5000/api/tasks', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify(taskData)
})
  .then(response => response.json())
  .then(data => console.log('Task created:', data))
  .catch(error => console.error('Error:', error));
```

**Python Requests**:
```python
import requests

task_data = {
    'title': 'Buy groceries',
    'description': 'Milk, eggs, bread, and vegetables'
}

response = requests.post('http://localhost:5000/api/tasks', json=task_data)
new_task = response.json()
print('Task created:', new_task)
```

**Response** (201 Created):
```json
{
  "id": 7,
  "title": "Buy groceries",
  "description": "Milk, eggs, bread, and vegetables",
  "status": "TODO",
  "created_at": "2024-06-23T10:30:00.000Z"
}
```

**Response** (400 Bad Request):
```json
{
  "error": "Title is required"
}
```

**Response** (500 Internal Server Error):
```json
{
  "error": "Failed to create task"
}
```

---

### 4. Update Task

**Endpoint**: `PUT /api/tasks/:id`

**Example**: `PUT /api/tasks/1`

**Request Body** (all fields optional):
```json
{
  "title": "Updated task title",
  "description": "Updated description",
  "status": "IN_PROGRESS"
}
```

**Update Status Only**:
```json
{
  "status": "IN_PROGRESS"
}
```

**Update Title Only**:
```json
{
  "title": "New title"
}
```

**cURL** - Update Status:
```bash
curl -X PUT http://localhost:5000/api/tasks/1 \
  -H "Content-Type: application/json" \
  -d '{
    "status": "IN_PROGRESS"
  }'
```

**cURL** - Update All Fields:
```bash
curl -X PUT http://localhost:5000/api/tasks/1 \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Updated title",
    "description": "Updated description",
    "status": "DONE"
  }'
```

**JavaScript Fetch** - Update Status:
```javascript
const taskId = 1;
const updates = {
  status: "IN_PROGRESS"
};

fetch(`http://localhost:5000/api/tasks/${taskId}`, {
  method: 'PUT',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify(updates)
})
  .then(response => response.json())
  .then(data => console.log('Task updated:', data))
  .catch(error => console.error('Error:', error));
```

**Python Requests** - Update Status:
```python
import requests

task_id = 1
updates = {
    'status': 'IN_PROGRESS'
}

response = requests.put(f'http://localhost:5000/api/tasks/{task_id}', json=updates)
updated_task = response.json()
print('Task updated:', updated_task)
```

**Response** (200 OK):
```json
{
  "id": 1,
  "title": "Updated title",
  "description": "Updated description",
  "status": "IN_PROGRESS",
  "created_at": "2024-06-23T10:30:00.000Z"
}
```

**Response** (404 Not Found):
```json
{
  "error": "Task not found"
}
```

**Response** (400 Bad Request):
```json
{
  "error": "No fields to update"
}
```

---

### 5. Delete Task

**Endpoint**: `DELETE /api/tasks/:id`

**Example**: `DELETE /api/tasks/1`

**cURL**:
```bash
curl -X DELETE http://localhost:5000/api/tasks/1
```

**JavaScript Fetch**:
```javascript
const taskId = 1;

fetch(`http://localhost:5000/api/tasks/${taskId}`, {
  method: 'DELETE'
})
  .then(response => response.json())
  .then(data => console.log('Task deleted:', data))
  .catch(error => console.error('Error:', error));
```

**Python Requests**:
```python
import requests

task_id = 1

response = requests.delete(f'http://localhost:5000/api/tasks/{task_id}')
result = response.json()
print('Task deleted:', result)
```

**Response** (200 OK):
```json
{
  "message": "Task deleted successfully",
  "id": 1
}
```

**Response** (404 Not Found):
```json
{
  "error": "Task not found"
}
```

---

## 🔄 Complete Workflow Example

### JavaScript Example

```javascript
// 1. Get all tasks
async function getAllTasks() {
  const response = await fetch('http://localhost:5000/api/tasks');
  return response.json();
}

// 2. Create a new task
async function createTask(title, description) {
  const response = await fetch('http://localhost:5000/api/tasks', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ title, description })
  });
  return response.json();
}

// 3. Update task status
async function updateTaskStatus(id, status) {
  const response = await fetch(`http://localhost:5000/api/tasks/${id}`, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ status })
  });
  return response.json();
}

// 4. Delete a task
async function deleteTask(id) {
  const response = await fetch(`http://localhost:5000/api/tasks/${id}`, {
    method: 'DELETE'
  });
  return response.json();
}

// Usage
(async () => {
  try {
    // Get all tasks
    const tasks = await getAllTasks();
    console.log('All tasks:', tasks);

    // Create new task
    const newTask = await createTask('Learn React', 'Complete React tutorial');
    console.log('Created task:', newTask);

    // Update task status
    const updated = await updateTaskStatus(newTask.id, 'IN_PROGRESS');
    console.log('Updated task:', updated);

    // Get updated tasks list
    const updatedTasks = await getAllTasks();
    console.log('Updated tasks:', updatedTasks);

    // Delete task
    const deleted = await deleteTask(newTask.id);
    console.log('Deleted:', deleted);
  } catch (error) {
    console.error('Error:', error);
  }
})();
```

### Python Example

```python
import requests
import json

BASE_URL = 'http://localhost:5000/api'

def get_all_tasks():
    response = requests.get(f'{BASE_URL}/tasks')
    return response.json()

def create_task(title, description=''):
    data = {'title': title, 'description': description}
    response = requests.post(f'{BASE_URL}/tasks', json=data)
    return response.json()

def update_task_status(task_id, status):
    data = {'status': status}
    response = requests.put(f'{BASE_URL}/tasks/{task_id}', json=data)
    return response.json()

def delete_task(task_id):
    response = requests.delete(f'{BASE_URL}/tasks/{task_id}')
    return response.json()

# Usage
if __name__ == '__main__':
    try:
        # Get all tasks
        tasks = get_all_tasks()
        print('All tasks:', json.dumps(tasks, indent=2))

        # Create new task
        new_task = create_task('Learn Python', 'Complete Python course')
        print('Created task:', json.dumps(new_task, indent=2))

        # Update task status
        updated = update_task_status(new_task['id'], 'IN_PROGRESS')
        print('Updated task:', json.dumps(updated, indent=2))

        # Get updated tasks
        updated_tasks = get_all_tasks()
        print('Updated tasks:', json.dumps(updated_tasks, indent=2))

        # Delete task
        deleted = delete_task(new_task['id'])
        print('Deleted:', json.dumps(deleted, indent=2))
    except Exception as e:
        print(f'Error: {e}')
```

---

## 📋 Task Status Values

- `TODO` - Task not started
- `IN_PROGRESS` - Task currently being worked on
- `DONE` - Task completed

---

## ⚠️ Error Codes Summary

| Code | Meaning | Example |
|------|---------|---------|
| 200 | OK | Request successful |
| 201 | Created | Task successfully created |
| 400 | Bad Request | Missing or invalid fields |
| 404 | Not Found | Task with given ID doesn't exist |
| 500 | Server Error | Unexpected server error |
| 503 | Unavailable | Database connection failed |

---

## 🧪 Testing with Postman

1. Create a new collection: "Task Manager"
2. Set base URL: `http://localhost:5000`
3. Create requests:
   - GET /api/tasks
   - POST /api/tasks (with JSON body)
   - PUT /api/tasks/1 (with JSON body)
   - DELETE /api/tasks/1
4. Test health endpoint: GET /health

---

## 💡 Tips

- Always include `Content-Type: application/json` header for POST/PUT requests
- Use appropriate HTTP methods (GET for reading, POST for creating, PUT for updating, DELETE for removing)
- Handle errors gracefully in your client code
- Use the health endpoint to verify service connectivity before making requests
- For bulk operations, consider pagination (future enhancement)

---

**Last Updated**: June 2024
