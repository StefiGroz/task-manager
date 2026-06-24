@echo off
REM Task Manager - Quick Start Script for Windows
REM This script helps you quickly set up the Task Manager application

echo.
echo ========================================================================
echo           Task Manager - Complete Setup Assistant
echo ========================================================================
echo.

REM Check for Node.js
echo Checking prerequisites...
echo.

where node >nul 2>nul
if errorlevel 1 (
    echo X Node.js not found. Please install Node.js v14+
    pause
    exit /b 1
) else (
    for /f "tokens=*" %%i in ('node -v') do set NODE_VERSION=%%i
    echo [OK] Node.js installed: %NODE_VERSION%
)

REM Check for npm
where npm >nul 2>nul
if errorlevel 1 (
    echo X npm not found. Please install npm
    pause
    exit /b 1
) else (
    for /f "tokens=*" %%i in ('npm -v') do set NPM_VERSION=%%i
    echo [OK] npm installed: %NPM_VERSION%
)

REM Check for PostgreSQL
where psql >nul 2>nul
if errorlevel 1 (
    echo X PostgreSQL not found. Please install PostgreSQL v12+
    pause
    exit /b 1
) else (
    echo [OK] PostgreSQL installed
)

echo.
echo All prerequisites satisfied!
echo.

set /p confirm="Continue with setup? (y/n): "
if /i not "%confirm%"=="y" exit /b 1

echo.
echo ========================================================================
echo Step 1: Backend Setup
echo ========================================================================
echo.

cd backend
echo Installing backend dependencies...
call npm install --silent
if errorlevel 1 (
    echo Failed to install backend dependencies
    cd ..
    pause
    exit /b 1
)
echo [OK] Backend dependencies installed

if not exist .env (
    echo Creating .env file...
    copy .env.example .env >nul
    echo [OK] .env file created
) else (
    echo [OK] .env file already exists
)

cd ..

echo.
echo ========================================================================
echo Step 2: Frontend Setup
echo ========================================================================
echo.

cd frontend
echo Installing frontend dependencies...
call npm install --silent
if errorlevel 1 (
    echo Failed to install frontend dependencies
    cd ..
    pause
    exit /b 1
)
echo [OK] Frontend dependencies installed

cd ..

echo.
echo ========================================================================
echo Step 3: Database Setup
echo ========================================================================
echo.
echo Please run the following commands to set up the database:
echo.
echo In Command Prompt:
echo   psql -U postgres
echo.
echo Then in PostgreSQL prompt:
echo   CREATE DATABASE taskdb;
echo   CREATE USER taskuser WITH PASSWORD 'taskpass';
echo   GRANT ALL PRIVILEGES ON DATABASE taskdb TO taskuser;
echo   ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO taskuser;
echo   ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO taskuser;
echo   \c taskdb
echo   \i %CD%\database\init.sql
echo   \q
echo.
echo Or use this single command (in Command Prompt):
echo   psql -U postgres -f %CD%\database\init.sql
echo.

set /p dbconf="Have you set up the database? (y/n): "
if /i not "%dbconf%"=="y" (
    echo Please set up the database and run this script again
    pause
    exit /b 1
)

echo.
echo ========================================================================
echo [OK] Setup complete!
echo ========================================================================
echo.
echo To run the application:
echo.
echo Terminal 1 - Backend:
echo   cd backend ^& npm start
echo.
echo Terminal 2 - Frontend:
echo   cd frontend ^& npm start
echo.
echo The application will be available at:
echo   Frontend: http://localhost:3000
echo   Backend:  http://localhost:5000
echo   API:      http://localhost:5000/api/tasks
echo.
echo For more information, see:
echo   README.md - Full documentation
echo   SETUP.md - Detailed setup guide
echo   API-EXAMPLES.md - API usage examples
echo.

pause
