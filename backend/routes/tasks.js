const express = require('express');
const router = express.Router();
const pool = require('../db');
const {
  getTaskById,
  createTask,
  updateTask,
  deleteTask,
} = require('../controllers/taskController');

// GET /api/tasks - return array of tasks
router.get('/', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM tasks ORDER BY created_at DESC');
    return res.json(result.rows);
  } catch (error) {
    console.error('Error in route GET /api/tasks:', error);
    return res.status(500).json({ error: 'Failed to fetch tasks' });
  }
});

// Other routes delegate to controllers
router.get('/:id', getTaskById);
router.post('/', createTask);
router.put('/:id', updateTask);
router.patch('/:id', updateTask);
router.delete('/:id', deleteTask);

module.exports = router;
