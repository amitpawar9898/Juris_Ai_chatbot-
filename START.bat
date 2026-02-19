@echo off
echo ===========================================
echo Starting Legal AI Chatbot
echo ===========================================
echo.
echo Starting Backend Server...
start cmd /k "cd backend && python -m venv .venv && .venv\Scripts\activate && pip install -r requirements.txt && uvicorn main:app --reload --port 8000"
timeout /t 3 /nobreak >nul
echo.
echo Starting Frontend Server...
start cmd /k "cd frontend && python -m http.server 5500"
timeout /t 2 /nobreak >nul
echo.
echo Opening browser...
start http://127.0.0.1:5500/index.html
echo.
echo ===========================================
echo Servers are starting...
echo Frontend: http://127.0.0.1:5500/index.html
echo Backend: http://127.0.0.1:8000
echo ===========================================
echo.
echo Press any key to exit this window...
pause >nul
