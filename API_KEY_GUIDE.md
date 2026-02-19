# API Key Guide - Legal AI Chatbot

## 🔑 Automatic API Key Generation

When you **first start the server**, an API key is **automatically generated** and displayed in the console.

**Example output:**
```
============================================================
🔑 API KEY GENERATED AUTOMATICALLY
============================================================
API Key: legal_ai_abc123xyz456...
⚠️  Save this key securely! It won't be shown again.
============================================================
```

**⚠️ IMPORTANT:** Save this key immediately - it won't be shown again!

## Using API Keys

### In HTTP Requests

**Option 1: Header (Recommended)**
```bash
curl -H "X-API-Key: your_api_key_here" \
  http://127.0.0.1:8000/api/train
```

**Option 2: Query Parameter**
```bash
curl "http://127.0.0.1:8000/api/train?api_key=your_api_key_here"
```

### In Python Scripts

```python
import requests

API_KEY = "your_api_key_here"

response = requests.post(
    "http://127.0.0.1:8000/api/train",
    headers={"X-API-Key": API_KEY},
    json={"question": "...", "answer": "..."}
)
```

### In Environment Variables

```bash
export API_KEY=your_api_key_here
python train_example.py
```

## Protected Endpoints

These endpoints **require** an API key:

- `POST /api/train` - Add Q&A pair
- `POST /api/train/batch` - Add multiple Q&A pairs
- `GET /api/knowledge-base/stats` - Get statistics
- `GET /api/knowledge-base/all` - Get all Q&A pairs
- `GET /api/knowledge-base/category/{category}` - Get by category
- `DELETE /api/knowledge-base/{qa_id}` - Delete Q&A pair
- `GET /api/keys/list` - List API keys
- `GET /api/keys/stats` - Get key statistics
- `DELETE /api/keys/revoke` - Revoke a key

## Public Endpoints

These endpoints **do not require** an API key:

- `POST /api/chat` - Chat with the bot
- `GET /health` - Health check
- `GET /api/languages` - Get languages
- `GET /api/lawyer-details` - Get lawyer details
- `POST /api/keys/generate` - Generate new API key

## Managing API Keys

### Generate a New API Key

```bash
curl -X POST "http://127.0.0.1:8000/api/keys/generate" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "my_key",
    "description": "My API key",
    "expires_days": null
  }'
```

Response includes the new API key (shown only once):
```json
{
  "success": true,
  "message": "API key 'my_key' generated successfully...",
  "api_key": "legal_ai_xyz123..."
}
```

### List All API Keys

```bash
curl -H "X-API-Key: your_api_key_here" \
  http://127.0.0.1:8000/api/keys/list
```

### Get API Key Statistics

```bash
curl -H "X-API-Key: your_api_key_here" \
  http://127.0.0.1:8000/api/keys/stats
```

### Revoke an API Key

```bash
curl -X DELETE \
  -H "X-API-Key: your_api_key_here" \
  "http://127.0.0.1:8000/api/keys/revoke?key_hash=abc123..."
```

## Security Notes

1. **Never commit API keys to version control**
2. **Store keys securely** - use environment variables or secure vaults
3. **Rotate keys regularly** - revoke old keys and generate new ones
4. **Use different keys** for different environments (dev, prod)
5. **API keys are hashed** - stored keys cannot be retrieved, only regenerated

## Troubleshooting

### "Invalid or missing API key" Error

- Check that you're using the correct API key
- Ensure the key starts with `legal_ai_`
- Verify the key hasn't expired (if expiration was set)
- Make sure you're sending it in the header or query parameter

### Lost API Key

If you lost your API key:
1. Generate a new one using `/api/keys/generate`
2. Revoke the old one if you remember its hash
3. Update all scripts/tools to use the new key

### Key Storage Location

API keys are stored in `backend/data/api_keys.json` (hashed for security).
You can backup this file, but individual keys cannot be recovered from hashes.
