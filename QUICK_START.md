# 🚀 Quick Start - How to Run Legal AI Chatbot

## Simple 3-Step Guide

### Step 1: Start Backend Server

Open **Terminal/Command Prompt** and run:

```bash
cd "D:\Amit Boss\legal_ai\backend"
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
uvicorn main:app --reload --port 8000
```

**✅ Success:** You'll see "Uvicorn running on http://127.0.0.1:8000"

**🔑 IMPORTANT:** Copy the API key shown in the console (you'll need it for training)

---

### Step 2: Start Frontend Server

Open a **NEW Terminal** and run:

```bash
cd "D:\Amit Boss\legal_ai\frontend"
python -m http.server 5500
```

**✅ Success:** Server starts on port 5500

---

### Step 3: Open in Browser

Open your web browser and go to:

```
http://127.0.0.1:5500/index.html
```

**✅ Success:** You'll see the chatbot interface!

---

## 🎯 That's It! You're Ready!

- **Type a question** in the chat box
- **Click Send** or press Enter
- **Get an answer** from the chatbot!

---

## 📝 Optional: Train the Chatbot

To add your own Q&A pairs, use the API key from Step 1:

```bash
cd backend
python train_example.py YOUR_API_KEY_HERE
```

---

## ⚠️ Troubleshooting

**Problem:** "python: command not found"
- **Solution:** Use `python3` instead, or install Python from python.org

**Problem:** "Address already in use"
- **Solution:** Close other programs using ports 8000 or 5500, or use different ports

**Problem:** Frontend can't connect
- **Solution:** Make sure backend is running first (Step 1)

---

## 📋 Quick Reference

| Component | Port | URL |
|-----------|------|-----|
| Backend | 8000 | http://127.0.0.1:8000 |
| Frontend | 5500 | http://127.0.0.1:5500/index.html |

**Keep both terminals open** - servers need to keep running!
