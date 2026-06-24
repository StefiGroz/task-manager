const { Pool } = require('pg');
require('dotenv').config();

// Support DATABASE_URL (useful for Docker, Kubernetes, and hosted DBs)
const connectionString = process.env.DATABASE_URL;

const poolConfig = connectionString
  ? { connectionString }
  : {
      host: process.env.DATABASE_HOST || 'postgres',
      port: process.env.DATABASE_PORT || 5432,
      database: process.env.DATABASE_NAME || 'taskdb',
      user: process.env.DATABASE_USER || 'taskuser',
      password: process.env.DATABASE_PASSWORD || 'taskpass',
    };

const pool = new Pool(poolConfig);

pool.on('error', (err) => {
  console.error('Unexpected error on idle client', err);
});

module.exports = pool;
