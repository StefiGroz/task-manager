#!/bin/bash

# Task Manager - Quick Start Script
# This script helps you quickly set up the Task Manager application

set -e

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║         Task Manager - Complete Setup Assistant               ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check for prerequisites
echo -e "${YELLOW}Checking prerequisites...${NC}"
echo ""

# Check Node.js
if command -v node &> /dev/null; then
    NODE_VERSION=$(node -v)
    echo -e "${GREEN}✓${NC} Node.js installed: $NODE_VERSION"
else
    echo -e "${RED}✗${NC} Node.js not found. Please install Node.js v14+"
    exit 1
fi

# Check npm
if command -v npm &> /dev/null; then
    NPM_VERSION=$(npm -v)
    echo -e "${GREEN}✓${NC} npm installed: $NPM_VERSION"
else
    echo -e "${RED}✗${NC} npm not found. Please install npm"
    exit 1
fi

# Check PostgreSQL
if command -v psql &> /dev/null; then
    PG_VERSION=$(psql --version)
    echo -e "${GREEN}✓${NC} PostgreSQL installed: $PG_VERSION"
else
    echo -e "${RED}✗${NC} PostgreSQL not found. Please install PostgreSQL v12+"
    exit 1
fi

echo ""
echo -e "${YELLOW}All prerequisites satisfied!${NC}"
echo ""

# Ask user if they want to continue
read -p "Continue with setup? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

echo ""
echo -e "${YELLOW}Step 1: Backend Setup${NC}"
echo ""

cd backend
echo "Installing backend dependencies..."
npm install --silent
echo -e "${GREEN}✓${NC} Backend dependencies installed"

if [ ! -f .env ]; then
    echo "Creating .env file..."
    cp .env.example .env
    echo -e "${GREEN}✓${NC} .env file created"
else
    echo -e "${GREEN}✓${NC} .env file already exists"
fi

cd ..

echo ""
echo -e "${YELLOW}Step 2: Frontend Setup${NC}"
echo ""

cd frontend
echo "Installing frontend dependencies..."
npm install --silent
echo -e "${GREEN}✓${NC} Frontend dependencies installed"

cd ..

echo ""
echo -e "${YELLOW}Step 3: Database Setup${NC}"
echo ""
echo "Please run the following commands to set up the database:"
echo ""
echo -e "  ${YELLOW}psql -U postgres${NC}"
echo ""
echo "Then in PostgreSQL prompt, run:"
echo ""
echo -e "  ${YELLOW}CREATE DATABASE taskdb;${NC}"
echo -e "  ${YELLOW}CREATE USER taskuser WITH PASSWORD 'taskpass';${NC}"
echo -e "  ${YELLOW}GRANT ALL PRIVILEGES ON DATABASE taskdb TO taskuser;${NC}"
echo -e "  ${YELLOW}ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO taskuser;${NC}"
echo -e "  ${YELLOW}ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO taskuser;${NC}"
echo -e "  ${YELLOW}\\c taskdb${NC}"
echo ""
echo "Then initialize the schema:"
echo ""
echo -e "  ${YELLOW}\\i $(pwd)/database/init.sql${NC}"
echo ""
echo "Or use this single command:"
echo ""
echo -e "  ${YELLOW}psql -U postgres -f $(pwd)/database/init.sql${NC}"
echo ""

read -p "Have you set up the database? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}Please set up the database and run this script again${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}✓${NC} Setup complete!"
echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                 Ready to Start!                               ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "To run the application:"
echo ""
echo -e "  ${YELLOW}Terminal 1 - Backend:${NC}"
echo -e "    cd backend && npm start"
echo ""
echo -e "  ${YELLOW}Terminal 2 - Frontend:${NC}"
echo -e "    cd frontend && npm start"
echo ""
echo "The application will be available at:"
echo -e "  Frontend: ${GREEN}http://localhost:3000${NC}"
echo -e "  Backend:  ${GREEN}http://localhost:5000${NC}"
echo -e "  API:      ${GREEN}http://localhost:5000/api/tasks${NC}"
echo ""
echo "For more information, see:"
echo -e "  ${YELLOW}README.md${NC} - Full documentation"
echo -e "  ${YELLOW}SETUP.md${NC} - Detailed setup guide"
echo -e "  ${YELLOW}API-EXAMPLES.md${NC} - API usage examples"
echo ""
