# Legal AI Chatbot - How to Run

A **Legal AI Chatbot** application with **Q&A training capabilities**. Train it with your own question-answer pairs, and it will use similarity search to provide accurate answers.

---

## ⚡ QUICK COMMANDS

**Terminal 1 - Backend:**
```bash
cd backend
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
uvicorn main:app --reload --port 8000python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
uvicorn main:app --reload --port 8000
```

**Terminal 2 - Frontend:**
```bash
cd frontend
python -m http.server 5500
```

**Browser:**
```
http://127.0.0.1:5500/index.html
```

**Train (Optional):**
```bash
cd backend
python train_example.py YOUR_API_KEY
```

---

## 🚀 Quick Start Guide

### Step 1: Install Python

Make sure you have **Python 3.9 or higher** installed on your system.

**Check Python version:**
```bash
python --version
# or
python3 --version
```

If Python is not installed, download it from [python.org](https://www.python.org/downloads/).

---

### Step 2: Set Up Backend

1. **Open a terminal/command prompt** and navigate to the project folder:
   ```bash
   cd "D:\Amit Boss\legal_ai"
   ```

2. **Go to the backend folder:**
   ```bash
   cd backend
   ```

3. **Create a virtual environment** (recommended):
   
   **On Windows:**
   ```bash
   python -m venv .venv
   .venv\Scripts\activate
   ```
   
   **On Mac/Linux:**
   ```bash
   python3 -m venv .venv
   source .venv/bin/activate
   ```

4. **Install required packages:**
   ```bash
   pip install -r requirements.txt
   ```

5. **Start the backend server:**
   ```bash
   uvicorn main:app --reload --port 8000
   ```

   You should see output like:
   ```
   INFO:     Uvicorn running on http://127.0.0.1:8000 (Press CTRL+C to quit)
   INFO:     Started reloader process
   INFO:     Started server process
   INFO:     Waiting for application startup.
   INFO:     Application startup complete.
   ```

   **🔑 IMPORTANT:** When you first start the server, an **API key will be automatically generated** and displayed in the console. **Copy and save this key** - you'll need it for training the chatbot!

   Example output:
   ```
   ============================================================
   🔑 API KEY GENERATED AUTOMATICALLY
   ============================================================
   API Key: legal_ai_abc123xyz456...
   ⚠️  Save this key securely! It won't be shown again.
   ============================================================
   ```

6. **Keep this terminal open** - the server needs to keep running.

---

### Step 3: Set Up Frontend

Open a **new terminal/command prompt** (keep the backend server running):

1. **Navigate to the frontend folder:**
   ```bash
   cd "D:\Amit Boss\legal_ai\frontend"
   ```

2. **Start a simple HTTP server:**
   ```bash
   python -m http.server 55
   ```

3. **Open your web browser** and go to:
   ```
   http://127.0.0.1:5500/index.html
   ```

   You should see the chatbot interface!

---

### Step 4: Test the Chatbot

1. Type a question in the chat box (e.g., "What is divorce?")
2. Click "Send" or press Enter
3. The chatbot will respond!

**Note:** Initially, the chatbot uses default responses. To improve it, you need to train it with your Q&A data (see Step 5).

---

### Step 5: Train the Chatbot (Optional)

To train the chatbot with your own Q&A pairs, you need your **API key** (from Step 2).

#### Option A: Use the Example Training Script

1. **Open a new terminal** (keep backend and frontend servers running)

2. **Navigate to backend folder:**
   ```bash
   cd "D:\Amit Boss\legal_ai\backend"
   ```

3. **Run the training script with your API key:**
   ```bash
   python train_example.py YOUR_API_KEY_HERE
   ```
   
   Replace `YOUR_API_KEY_HERE` with the API key you saved from Step 2.

   **Or use environment variable:**
   ```bash
   # Windows (PowerShell)
   $env:API_KEY="your_api_key_here"
   python train_example.py
   
   # Windows (CMD)
   set API_KEY=your_api_key_here
   python train_example.py
   
   # Mac/Linux
   export API_KEY=your_api_key_here
   python train_example.py
   ```

4. The script will add example Q&A pairs. You can edit `train_example.py` to add your own data.

#### Option B: Import from JSON File

1. Edit `backend/sample_qa_data.json` with your Q&A pairs

2. Run the import script:
   ```bash
   cd backend
   python import_qa_from_json.py sample_qa_data.json YOUR_API_KEY_HERE
   ```

#### Option C: Use the API Directly

```bash
curl -X POST "http://127.0.0.1:8000/api/train" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: YOUR_API_KEY_HERE" \
  -d '{
    "question": "What is divorce?",
    "answer": "Divorce is the legal dissolution of a marriage.",
    "category": "divorce"
  }'
```

---

## 📋 Complete Setup Summary

**Terminal 1 - Backend Server:**
```bash
cd "D:\Amit Boss\legal_ai\backend"
python -m venv .venv
.venv\Scripts\activate  # Windows
pip install -r requirements.txt
uvicorn main:app --reload --port 8000
```

**Terminal 2 - Frontend Server:**
```bash
cd "D:\Amit Boss\legal_ai\frontend"
python -m http.server 5500
```

**Terminal 3 - Training (Optional):**
```bash
cd "D:\Amit Boss\legal_ai\backend"
python train_example.py YOUR_API_KEY
```

**Browser:**
```
http://127.0.0.1:5500/index.html
```

---

## 🔧 Troubleshooting

### Problem: "python: command not found"
**Solution:** Use `python3` instead of `python` on Mac/Linux, or make sure Python is in your PATH.

### Problem: "pip: command not found"
**Solution:** Install pip or use `python -m pip` instead.

### Problem: "ModuleNotFoundError" when running uvicorn
**Solution:** Make sure you activated the virtual environment and installed requirements:
```bash
.venv\Scripts\activate  # Windows
pip install -r requirements.txt
```

### Problem: "Address already in use" error
**Solution:** Another process is using port 8000 or 5500. Either:
- Stop the other process
- Use a different port: `uvicorn main:app --reload --port 8001`

### Problem: Frontend can't connect to backend
**Solution:** 
- Make sure backend is running on `http://127.0.0.1:8000`
- Check browser console for errors (F12)
- Verify CORS is enabled (it should be by default)

### Problem: "Invalid or missing API key" error
**Solution:** 
- Make sure you copied the API key correctly from the server console
- The API key should start with `legal_ai_`
- Generate a new key if needed: `POST /api/keys/generate`

### Problem: Lost API key
**Solution:** Generate a new one:
```bash
curl -X POST "http://127.0.0.1:8000/api/keys/generate" \
  -H "Content-Type: application/json" \
  -d '{"name": "new_key", "description": "New API key"}'
```

---

## 📁 Project Structure

```
legal_ai/
├── backend/
│   ├── main.py                 # FastAPI application
│   ├── qa_knowledge_base.py    # Q&A knowledge base system
│   ├── api_key_manager.py      # API key management
│   ├── train_example.py        # Example training script
│   ├── import_qa_from_json.py  # Import Q&A from JSON
│   ├── requirements.txt        # Python dependencies
│   ├── data/                   # Data storage (auto-created)
│   │   ├── qa_knowledge_base.json
│   │   └── api_keys.json
│   └── nlp/                    # NLP modules
├── frontend/
│   ├── index.html             # Main HTML page
│   ├── styles.css             # Styling
│   └── app.js                 # Frontend JavaScript
└── README.md                  # This file
```

---

## 🔑 API Key Authentication

**Public Endpoints (No API Key Required):**
- `POST /api/chat` - Chat with the bot
- `GET /health` - Health check
- `GET /api/languages` - Get available languages
- `GET /api/lawyer-details` - Get lawyer details

**Protected Endpoints (API Key Required):**
- `POST /api/train` - Add Q&A pair
- `POST /api/train/batch` - Add multiple Q&A pairs
- `GET /api/knowledge-base/stats` - Get statistics
- `GET /api/knowledge-base/all` - Get all Q&A pairs
- `DELETE /api/knowledge-base/{id}` - Delete Q&A pair

**Use API Key:**
```bash
# Header method (recommended)
-H "X-API-Key: your_api_key_here"

# Query parameter method
?api_key=your_api_key_here
```

---

## 📚 API Endpoints

### Chat Endpoints
- `POST /api/chat` - Send a message to the chatbot

### Training Endpoints (Require API Key)
- `POST /api/train` - Add a single Q&A pair
- `POST /api/train/batch` - Add multiple Q&A pairs
- `GET /api/knowledge-base/stats` - Get knowledge base statistics
- `GET /api/knowledge-base/all` - Get all Q&A pairs
- `GET /api/knowledge-base/category/{category}` - Get Q&A by category
- `DELETE /api/knowledge-base/{qa_id}` - Delete a Q&A pair

### API Key Management
- `POST /api/keys/generate` - Generate a new API key
- `GET /api/keys/list` - List all API keys (requires auth)
- `GET /api/keys/stats` - Get API key statistics
- `DELETE /api/keys/revoke` - Revoke an API key

### Other Endpoints
- `GET /health` - Health check
- `GET /api/languages` - Get available languages
- `GET /api/lawyer-details` - Get lawyer contact details

---

## 💡 How It Works

1. **User asks a question** → Frontend sends request to `/api/chat`
2. **Backend searches** → First checks trained Q&A knowledge base using TF-IDF similarity
3. **Match found?** → Returns the matching answer (if similarity ≥ 0.3)
4. **No match?** → Falls back to intent-based default responses
5. **Response sent** → Frontend displays the answer

**Data Storage:**
- Q&A pairs: `backend/data/qa_knowledge_base.json`
- API keys: `backend/data/api_keys.json` (hashed for security)
- Search index: Automatically rebuilt when new Q&A pairs are added

---

## 🎯 Next Steps

1. **Train the chatbot** with your own Q&A pairs
2. **Customize responses** by editing the training data
3. **Adjust similarity threshold** in `backend/main.py` (currently 0.3)
4. **Add more features** like user authentication, logging, etc.
5. **Connect to LLM APIs** (OpenAI, etc.) for more advanced responses

---

## 📖 Additional Documentation

- **Training Guide:** See `TRAINING_GUIDE.md` for detailed training instructions
- **API Key Guide:** See `API_KEY_GUIDE.md` for API key management

---

## ✅ Verification Checklist

- [ ] Python 3.9+ installed
- [ ] Backend server running on port 8000
- [ ] Frontend server running on port 5500
- [ ] Browser opens `http://127.0.0.1:5500/index.html`
- [ ] Can send messages and receive responses
- [ ] API key saved from server console
- [ ] Training script runs successfully (optional)

---

## 🆘 Need Help?

1. Check the **Troubleshooting** section above
2. Verify all servers are running
3. Check browser console (F12) for errors
4. Review server console output for error messages
5. Make sure API key is correct (if using training endpoints)

---

