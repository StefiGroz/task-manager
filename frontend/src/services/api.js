const API_BASE_URL = process.env.REACT_APP_API_URL || '/api';

const apiCall = async (endpoint, options = {}) => {
  const url = `${API_BASE_URL}${endpoint}`;
  const defaultOptions = {
    headers: {},
  };

  const finalOptions = { ...defaultOptions, ...options };
  if (finalOptions.body && !finalOptions.headers['Content-Type']) {
    finalOptions.headers['Content-Type'] = 'application/json';
  }

  try {
    const response = await fetch(url, finalOptions);
    const responseText = await response.text();
    const responseData = responseText ? JSON.parse(responseText) : null;

    if (!response.ok) {
      throw new Error(responseData?.error || `HTTP error! status: ${response.status}`);
    }

    return responseData;
  } catch (error) {
    console.error('API call failed:', error);
    throw error;
  }
};

export const taskService = {
  getAllTasks: () => apiCall('/tasks'),
  getTaskById: (id) => apiCall(`/tasks/${id}`),
  createTask: (title, description) =>
    apiCall('/tasks', {
      method: 'POST',
      body: JSON.stringify({ title, description }),
    }),
  updateTask: (id, updates) =>
    apiCall(`/tasks/${id}`, {
      method: 'PUT',
      body: JSON.stringify(updates),
    }),
  deleteTask: (id) =>
    apiCall(`/tasks/${id}`, {
      method: 'DELETE',
    }),
};
