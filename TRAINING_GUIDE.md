# Training Guide - Legal AI Chatbot

This guide explains how to train your chatbot with your own Q&A data.

## Quick Start

### 1. Install Dependencies

```bash
cd backend
pip install -r requirements.txt
```

### 2. Start the Backend Server

```bash
uvicorn main:app --reload --port 8000
```

**🔑 IMPORTANT:** When you first start the server, an **API key will be automatically generated** and displayed in the console. **Save this key** - you'll need it for training!

Example output:
```
============================================================
🔑 API KEY GENERATED AUTOMATICALLY
============================================================
API Key: legal_ai_abc123xyz...
⚠️  Save this key securely! It won't be shown again.
============================================================
```

### 3. Get Your API Key

If you lost your API key, you can:
- Check the server console output (if still running)
- Generate a new one: `POST /api/keys/generate`
- The key is stored in `backend/data/api_keys.json` (but it's hashed for security)

### 4. Train the Chatbot

You have several options:

#### Option A: Use the Example Script

```bash
# Pass your API key as argument
python train_example.py YOUR_API_KEY

# Or set as environment variable
export API_KEY=your_api_key_here
python train_example.py
```

This adds example Q&A pairs. Edit `train_example.py` to add your own data.

#### Option B: Import from JSON File

1. Create or edit `sample_qa_data.json` with your Q&A pairs:

```json
[
  {
    "question": "Your question here?",
    "answer": "Your answer here.",
    "category": "optional_category"
  }
]
```

2. Import the file with your API key:

```bash
# Pass API key as second argument
python import_qa_from_json.py sample_qa_data.json YOUR_API_KEY

# Or set as environment variable
export API_KEY=your_api_key_here
python import_qa_from_json.py sample_qa_data.json
```

#### Option C: Use the API Directly

**Add a single Q&A pair:**

```bash
curl -X POST "http://127.0.0.1:8000/api/train" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: your_api_key_here" \
  -d '{
    "question": "What is divorce?",
    "answer": "Divorce is the legal dissolution of a marriage.",
    "category": "divorce"
  }'
```

**Add multiple Q&A pairs:**

```bash
curl -X POST "http://127.0.0.1:8000/api/train/batch" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: your_api_key_here" \
  -d '{
    "qa_pairs": [
      {
        "question": "Question 1?",
        "answer": "Answer 1.",
        "category": "category1"
      },
      {
        "question": "Question 2?",
        "answer": "Answer 2.",
        "category": "category2"
      }
    ]
  }'
```

#### Option D: Use Python Code

```python
import requests

API_KEY = "your_api_key_here"  # Get from server console

# Single Q&A pair
response = requests.post(
    "http://127.0.0.1:8000/api/train",
    headers={"X-API-Key": API_KEY},
    json={
        "question": "What is divorce?",
        "answer": "Divorce is the legal dissolution of a marriage.",
        "category": "divorce"
    }
)
print(response.json())

# Multiple Q&A pairs
qa_pairs = [
    {"question": "Q1?", "answer": "A1.", "category": "cat1"},
    {"question": "Q2?", "answer": "A2.", "category": "cat2"},
]

response = requests.post(
    "http://127.0.0.1:8000/api/train/batch",
    headers={"X-API-Key": API_KEY},
    json={"qa_pairs": qa_pairs}
)
print(response.json())
```

## How It Works

1. **Storage**: Q&A pairs are stored in `backend/data/qa_knowledge_base.json`
2. **Search**: Uses TF-IDF vectorization for similarity matching
3. **Matching**: When a user asks a question, the chatbot searches for similar questions
4. **Threshold**: Returns answer if similarity ≥ 0.3 (configurable in `main.py`)
5. **Fallback**: If no match found, uses intent-based default responses

## Managing Your Knowledge Base

### View Statistics

```bash
curl -H "X-API-Key: your_api_key_here" \
  http://127.0.0.1:8000/api/knowledge-base/stats
```

### Get All Q&A Pairs

```bash
curl -H "X-API-Key: your_api_key_here" \
  http://127.0.0.1:8000/api/knowledge-base/all
```

### Get Q&A by Category

```bash
curl -H "X-API-Key: your_api_key_here" \
  http://127.0.0.1:8000/api/knowledge-base/category/divorce
```

### Delete a Q&A Pair

```bash
curl -X DELETE \
  -H "X-API-Key: your_api_key_here" \
  http://127.0.0.1:8000/api/knowledge-base/1
```

### Generate a New API Key

```bash
curl -X POST "http://127.0.0.1:8000/api/keys/generate" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "my_training_key",
    "description": "Key for training the chatbot",
    "expires_days": null
  }'
```

### List API Keys

```bash
curl -H "X-API-Key: your_api_key_here" \
  http://127.0.0.1:8000/api/keys/list
```

## Tips for Better Training

1. **Use Clear Questions**: Write questions as users would ask them
2. **Provide Complete Answers**: Include all relevant information
3. **Use Categories**: Categorize Q&A pairs for better organization
4. **Add Variations**: Add multiple ways to ask the same question
5. **Regular Updates**: Keep adding new Q&A pairs as you encounter new questions

## Example Q&A Format

```json
{
  "question": "How to file for divorce?",
  "answer": "To file for divorce: 1) Hire a lawyer, 2) Prepare documents, 3) File petition in family court, 4) Serve notice to spouse, 5) Attend hearings.",
  "category": "divorce"
}
```

## Troubleshooting

- **Server not running**: Make sure `uvicorn main:app --reload --port 8000` is running
- **Import errors**: Check that your JSON file is valid JSON
- **No matches**: Lower the similarity threshold in `main.py` (currently 0.3)
- **Slow search**: The vectorizer rebuilds automatically when new pairs are added

## Data Location

- Q&A data: `backend/data/qa_knowledge_base.json`
- Vectorizer: `backend/data/qa_vectorizer.pkl` (auto-generated)
- Vectors: `backend/data/qa_vectors.pkl` (auto-generated)

You can backup these files to preserve your training data.
