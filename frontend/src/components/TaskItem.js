import React from 'react';
import './TaskItem.css';

const TaskItem = ({ task, onStatusChange, onDelete, isLoading }) => {
  const formatDate = (dateString) => {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
    });
  };

  const statusColors = {
    TODO: '#ff9800',
    IN_PROGRESS: '#2196F3',
    DONE: '#4CAF50',
  };

  const handleStatusChange = (newStatus) => {
    if (window.confirm(`Change task status to ${newStatus}?`)) {
      onStatusChange(task.id, newStatus);
    }
  };

  const handleDelete = () => {
    if (window.confirm('Are you sure you want to delete this task?')) {
      onDelete(task.id);
    }
  };

  return (
    <div className="task-item">
      <div className="task-content">
        <div className="task-header">
          <h3 className="task-title">{task.title}</h3>
          <span
            className="task-status"
            style={{ backgroundColor: statusColors[task.status] }}
          >
            {task.status}
          </span>
        </div>
        {task.description && <p className="task-description">{task.description}</p>}
        <p className="task-date">Created: {formatDate(task.created_at)}</p>
      </div>

      <div className="task-actions">
        <div className="status-buttons">
          {['TODO', 'IN_PROGRESS', 'DONE'].map((status) => (
            task.status !== status && (
              <button
                key={status}
                className="btn btn-sm btn-status"
                onClick={() => handleStatusChange(status)}
                disabled={isLoading}
                title={`Mark as ${status}`}
              >
                {status}
              </button>
            )
          ))}
        </div>
        <button
          className="btn btn-sm btn-danger"
          onClick={handleDelete}
          disabled={isLoading}
          title="Delete task"
        >
          Delete
        </button>
      </div>
    </div>
  );
};

export default TaskItem;
