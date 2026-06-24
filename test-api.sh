#!/bin/bash

# Task Manager - API Testing Script
# This script tests all API endpoints

API_URL="http://localhost:5000"

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║           Task Manager - API Testing Script                   ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Check if API is running
echo -e "${YELLOW}Checking if API is running...${NC}"
if ! curl -s "$API_URL/health" > /dev/null; then
    echo -e "${RED}✗ API is not running at $API_URL${NC}"
    echo "Please start the backend server first: cd backend && npm start"
    exit 1
fi
echo -e "${GREEN}✓ API is running${NC}"
echo ""

# Test 1: Health Check
echo -e "${BLUE}Test 1: Health Check${NC}"
echo "GET /health"
curl -s -X GET "$API_URL/health" | python3 -m json.tool
echo ""

# Test 2: Get All Tasks
echo -e "${BLUE}Test 2: Get All Tasks${NC}"
echo "GET /api/tasks"
TASKS=$(curl -s -X GET "$API_URL/api/tasks")
echo "$TASKS" | python3 -m json.tool
echo ""

# Extract first task ID for subsequent tests
TASK_ID=$(echo "$TASKS" | python3 -c "import sys, json; tasks=json.load(sys.stdin); print(tasks[0]['id'] if tasks else '')" 2>/dev/null)

if [ -z "$TASK_ID" ]; then
    echo -e "${YELLOW}No tasks found, creating sample task...${NC}"
    echo ""
    
    # Test 3: Create Task
    echo -e "${BLUE}Test 3: Create Task${NC}"
    echo "POST /api/tasks"
    CREATED=$(curl -s -X POST "$API_URL/api/tasks" \
      -H "Content-Type: application/json" \
      -d '{
        "title": "Test Task Created at '$(date)'",
        "description": "This is a test task created by the testing script"
      }')
    echo "$CREATED" | python3 -m json.tool
    
    TASK_ID=$(echo "$CREATED" | python3 -c "import sys, json; task=json.load(sys.stdin); print(task.get('id', ''))" 2>/dev/null)
    echo ""
else
    echo -e "${YELLOW}Using existing task ID: $TASK_ID${NC}"
    echo ""
    
    # Test 3: Create Task
    echo -e "${BLUE}Test 3: Create Task${NC}"
    echo "POST /api/tasks"
    CREATED=$(curl -s -X POST "$API_URL/api/tasks" \
      -H "Content-Type: application/json" \
      -d '{
        "title": "Test Task Created at '$(date)'",
        "description": "This is a test task created by the testing script"
      }')
    echo "$CREATED" | python3 -m json.tool
    
    NEW_TASK_ID=$(echo "$CREATED" | python3 -c "import sys, json; task=json.load(sys.stdin); print(task.get('id', ''))" 2>/dev/null)
    if [ -n "$NEW_TASK_ID" ]; then
        TASK_ID=$NEW_TASK_ID
    fi
    echo ""
fi

if [ -z "$TASK_ID" ]; then
    echo -e "${RED}✗ Failed to create or find a task${NC}"
    exit 1
fi

# Test 4: Get Single Task
echo -e "${BLUE}Test 4: Get Single Task${NC}"
echo "GET /api/tasks/$TASK_ID"
curl -s -X GET "$API_URL/api/tasks/$TASK_ID" | python3 -m json.tool
echo ""

# Test 5: Update Task Status
echo -e "${BLUE}Test 5: Update Task Status${NC}"
echo "PUT /api/tasks/$TASK_ID"
echo "Updating status to IN_PROGRESS..."
curl -s -X PUT "$API_URL/api/tasks/$TASK_ID" \
  -H "Content-Type: application/json" \
  -d '{
    "status": "IN_PROGRESS"
  }' | python3 -m json.tool
echo ""

# Test 6: Update Task Title
echo -e "${BLUE}Test 6: Update Task Title${NC}"
echo "PUT /api/tasks/$TASK_ID"
echo "Updating title..."
curl -s -X PUT "$API_URL/api/tasks/$TASK_ID" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Updated Task Title - '$(date)'",
    "description": "Updated description from test script"
  }' | python3 -m json.tool
echo ""

# Test 7: Update Task to DONE
echo -e "${BLUE}Test 7: Update Task to DONE${NC}"
echo "PUT /api/tasks/$TASK_ID"
echo "Marking task as DONE..."
curl -s -X PUT "$API_URL/api/tasks/$TASK_ID" \
  -H "Content-Type: application/json" \
  -d '{
    "status": "DONE"
  }' | python3 -m json.tool
echo ""

# Test 8: Get Updated Tasks List
echo -e "${BLUE}Test 8: Get Updated Tasks List${NC}"
echo "GET /api/tasks"
curl -s -X GET "$API_URL/api/tasks" | python3 -m json.tool
echo ""

# Test 9: Delete Task
echo -e "${BLUE}Test 9: Delete Task${NC}"
echo "DELETE /api/tasks/$TASK_ID"
curl -s -X DELETE "$API_URL/api/tasks/$TASK_ID" | python3 -m json.tool
echo ""

# Test 10: Verify Task Deleted
echo -e "${BLUE}Test 10: Verify Task Deleted${NC}"
echo "GET /api/tasks/$TASK_ID (should return 404)"
curl -s -X GET "$API_URL/api/tasks/$TASK_ID" | python3 -m json.tool
echo ""

# Final Summary
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                   Testing Complete!                           ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo -e "${GREEN}All tests completed successfully!${NC}"
echo ""
echo "API Base URL: $API_URL"
echo "Health Check: $API_URL/health"
echo "Tasks API: $API_URL/api/tasks"
echo ""
