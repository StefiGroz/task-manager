-- Initialize database with sample data
-- This script creates the tasks table (if not exists), ensures the schema is current, and inserts sample tasks

CREATE TABLE IF NOT EXISTS tasks (
  id SERIAL PRIMARY KEY,
  title TEXT,
  description TEXT,
  status TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

ALTER TABLE tasks
  ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT NOW();

-- Index on created_at
CREATE INDEX IF NOT EXISTS idx_tasks_created_at ON tasks(created_at DESC);

-- Insert sample data (only if table is empty)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM tasks) THEN
    INSERT INTO tasks (title, description, status, created_at) VALUES
      ('Complete project setup', 'Set up the initial project structure and dependencies', 'DONE', NOW() - INTERVAL '5 days'),
      ('Implement backend API', 'Create REST API endpoints for task management', 'IN_PROGRESS', NOW() - INTERVAL '3 days'),
      ('Build frontend interface', 'Create React components for task display and management', 'IN_PROGRESS', NOW() - INTERVAL '2 days'),
      ('Database schema design', 'Design and create PostgreSQL database schema', 'DONE', NOW() - INTERVAL '4 days'),
      ('Write unit tests', 'Write unit tests for API endpoints', 'TODO', NOW() - INTERVAL '1 day'),
      ('Deploy to production', 'Set up production deployment pipeline', 'TODO', NOW());
  END IF;
END$$;
