import os
import requests

# Model URL and Destination
MODEL_URL = "https://huggingface.co/TheBloke/TinyLlama-1.1B-Chat-v1.0-GGUF/resolve/main/tinyllama-1.1b-chat-v1.0.Q4_K_M.gguf"
DEST_DIR = os.path.join("lib", "assets", "models")
FILE_NAME = "tinyllama-1.1b-chat-v1.0.Q4_K_M.gguf"
FILE_PATH = os.path.join(DEST_DIR, FILE_NAME)

def download_model():
    if not os.path.exists(DEST_DIR):
        os.makedirs(DEST_DIR)
        print(f"Created directory: {DEST_DIR}")

    if os.path.exists(FILE_PATH):
        print(f"Model already exists at: {FILE_PATH}")
        return

    print(f"Downloading model from {MODEL_URL}...")
    print("This might take a while depending on your internet connection.")
    
    try:
        response = requests.get(MODEL_URL, stream=True)
        response.raise_for_status()
        
        with open(FILE_PATH, 'wb') as f:
            for chunk in response.iter_content(chunk_size=8192):
                f.write(chunk)
        
        print(f"Successfully downloaded model to: {FILE_PATH}")
    except Exception as e:
        print(f"Error downloading model: {e}")

if __name__ == "__main__":
    download_model()
