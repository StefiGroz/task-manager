import React, { useState, useEffect } from 'react';
import './App.css';
import TaskForm from './components/TaskForm';
import TaskList from './components/TaskList';
import { taskService } from './services/api';

function App() {
  const [tasks, setTasks] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState('');
  const [successMessage, setSuccessMessage] = useState('');

  // Fetch tasks on component mount
  useEffect(() => {
    fetchTasks();
  }, []);

  const fetchTasks = async () => {
    try {
      setIsLoading(true);
      setError('');
      const data = await taskService.getAllTasks();
      setTasks(data);
    } catch (err) {
      setError('Failed to load tasks. Please make sure the backend is running.');
      console.error(err);
    } finally {
      setIsLoading(false);
    }
  };

  const handleCreateTask = async (title, description) => {
    try {
      setIsLoading(true);
      const newTask = await taskService.createTask(title, description);
      setTasks([newTask, ...tasks]);
      setSuccessMessage('Task created successfully!');
      setTimeout(() => setSuccessMessage(''), 3000);
    } catch (err) {
      setError(err.message);
    } finally {
      setIsLoading(false);
    }
  };

  const handleStatusChange = async (taskId, newStatus) => {
    try {
      setIsLoading(true);
      const updatedTask = await taskService.updateTask(taskId, { status: newStatus });
      setTasks(tasks.map((task) => (task.id === taskId ? updatedTask : task)));
      setSuccessMessage('Task updated successfully!');
      setTimeout(() => setSuccessMessage(''), 3000);
    } catch (err) {
      setError(err.message);
    } finally {
      setIsLoading(false);
    }
  };

  const handleDeleteTask = async (taskId) => {
    try {
      setIsLoading(true);
      await taskService.deleteTask(taskId);
      setTasks(tasks.filter((task) => task.id !== taskId));
      setSuccessMessage('Task deleted successfully!');
      setTimeout(() => setSuccessMessage(''), 3000);
    } catch (err) {
      setError(err.message);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="app">
      <header className="app-header">
        <div className="container">
          <h1>📋 Task Manager</h1>
          <p>Manage your tasks efficiently</p>
        </div>
      </header>

      <main className="app-main">
        <div className="container">
          {error && (
            <div className="alert alert-error">
              {error}
              <button
                className="alert-close"
                onClick={() => setError('')}
                aria-label="Close error message"
              >
                ×
              </button>
            </div>
          )}

          {successMessage && (
            <div className="alert alert-success">
              {successMessage}
              <button
                className="alert-close"
                onClick={() => setSuccessMessage('')}
                aria-label="Close success message"
              >
                ×
              </button>
            </div>
          )}

          <TaskForm onSubmit={handleCreateTask} isLoading={isLoading} />

          <TaskList
            tasks={tasks}
            onStatusChange={handleStatusChange}
            onDelete={handleDeleteTask}
            isLoading={isLoading}
            error={error}
          />
        </div>
      </main>

      <footer className="app-footer">
        <div className="container">
          <p>&copy; 2024 Task Manager. A simple task management application.</p>
        </div>
      </footer>
    </div>
  );
}

export default App;
