#!/bin/bash

echo "==========================================="
echo "Starting Legal AI Chatbot"
echo "==========================================="
echo ""
echo "Starting Backend Server..."
cd backend
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn main:app --reload --port 8000 &
BACKEND_PID=$!
cd ..

echo ""
echo "Starting Frontend Server..."
cd frontend
python3 -m http.server 5500 &
FRONTEND_PID=$!
cd ..

sleep 3

echo ""
echo "Opening browser..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    open http://127.0.0.1:5500/index.html
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    xdg-open http://127.0.0.1:5500/index.html
fi

echo ""
echo "==========================================="
echo "Servers are running!"
echo "Frontend: http://127.0.0.1:5500/index.html"
echo "Backend: http://127.0.0.1:8000"
echo "==========================================="
echo ""
echo "Press Ctrl+C to stop servers"
wait
