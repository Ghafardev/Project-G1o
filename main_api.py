from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field
from typing import List
import time

app = FastAPI(title="Emergency Chatbot Sync API")


@app.get("/api/v1/health")
async def health_check():
    return {"status": "ok", "timestamp": int(time.time())}


class ChatMessage(BaseModel):
    id: str = Field(..., min_length=1, max_length=128)
    session_id: str = Field(..., min_length=1, max_length=128)
    sender_type: str = Field(..., pattern=r"^(user|ai)$")
    message: str = Field(..., min_length=1, max_length=10000)
    timestamp: int


class SyncRequest(BaseModel):
    device_id: str = Field(..., min_length=1, max_length=128)
    unsynced_messages: List[ChatMessage] = Field(..., max_length=500)


@app.post("/api/v1/sync")
async def sync_offline_chats(request: SyncRequest):
    if not request.unsynced_messages:
        return {"status": "success", "message": "Tidak ada data baru untuk disinkronkan."}

    print(f"Menerima {len(request.unsynced_messages)} pesan dari perangkat {request.device_id}")

    for msg in request.unsynced_messages:
        print(f"[{msg.sender_type.upper()}] {msg.message}")
    synced_ids = [msg.id for msg in request.unsynced_messages]

    return {
        "status": "success",
        "message": "Data darurat berhasil diamankan ke server pusat.",
        "synced_message_ids": synced_ids,
        "server_timestamp": int(time.time()),
    }


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)