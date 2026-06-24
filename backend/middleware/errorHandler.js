const pool = require('../db');

const errorHandler = (err, req, res, next) => {
  console.error('Error:', err);
  
  if (err.message.includes('connection')) {
    return res.status(503).json({ 
      error: 'Database connection error',
      message: 'Service temporarily unavailable' 
    });
  }
  
  res.status(500).json({ 
    error: 'Internal server error',
    message: process.env.NODE_ENV === 'development' ? err.message : 'An error occurred'
  });
};

module.exports = errorHandler;
