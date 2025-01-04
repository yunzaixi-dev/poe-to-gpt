import requests
import json
import os

# API endpoint
url = "http://localhost:8000/v1/chat/completions"

# Get access token from environment variable
access_token = os.getenv("ACCESS_TOKEN", "your-access-token-here")

# Request headers
headers = {
    "Content-Type": "application/json",
    "Authorization": f"Bearer {access_token}"
}

# Request body
data = {
    "model": "gpt-3.5-turbo",
    "messages": [
        {"role": "user", "content": "Hello! How are you?"}
    ]
}

# Make the request
try:
    response = requests.post(url, headers=headers, json=data)
    print(f"Status Code: {response.status_code}")
    print("Response Headers:")
    print(json.dumps(dict(response.headers), indent=2))
    print("\nResponse Body:")
    print(json.dumps(response.json(), indent=2))
except Exception as e:
    print(f"Error: {e}")
