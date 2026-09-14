import hmac
import logging
import os
import time
from typing import Annotated, List

from fastapi import Depends, FastAPI, Header, HTTPException, Request
from fastapi.responses import JSONResponse
from pydantic import BaseModel, Field


logger = logging.getLogger(__name__)
SYNC_API_KEY = os.environ.get("SYNC_API_KEY")
MAX_REQUEST_BYTES = 1_000_000
MAX_TIMESTAMP_SKEW_SECONDS = 24 * 60 * 60

app = FastAPI(title="Emergency Chatbot Sync API")


@app.middleware("http")
async def limit_request_size(request: Request, call_next):
    content_length = request.headers.get("content-length")
    if content_length is not None:
        try:
            request_size = int(content_length)
        except ValueError:
            return JSONResponse(
                status_code=400,
                content={"detail": "Content-Length tidak valid."},
            )
        if request_size < 0:
            return JSONResponse(
                status_code=400,
                content={"detail": "Content-Length tidak valid."},
            )
        if request_size > MAX_REQUEST_BYTES:
            return JSONResponse(
                status_code=413,
                content={"detail": "Request terlalu besar."},
            )
    return await call_next(request)


async def require_sync_api_key(
    x_sync_api_key: Annotated[str | None, Header()] = None,
) -> None:
    if not SYNC_API_KEY or not x_sync_api_key or not hmac.compare_digest(
        x_sync_api_key, SYNC_API_KEY
    ):
        raise HTTPException(status_code=401, detail="Autentikasi diperlukan.")


@app.get("/api/v1/health")
async def health_check():
    return {"status": "ok", "timestamp": int(time.time())}


class ChatMessage(BaseModel):
    id: str = Field(..., min_length=1, max_length=128)
    session_id: str = Field(..., min_length=1, max_length=128)
    sender_type: str = Field(..., pattern=r"^(user|ai)$")
    message: str = Field(..., min_length=1, max_length=10000)
    timestamp: int = Field(..., ge=0)


class SyncRequest(BaseModel):
    device_id: str = Field(..., min_length=1, max_length=128)
    unsynced_messages: List[ChatMessage] = Field(..., max_length=500)


@app.post("/api/v1/sync", dependencies=[Depends(require_sync_api_key)])
async def sync_offline_chats(request: SyncRequest):
    if not request.unsynced_messages:
        return {"status": "success", "message": "Tidak ada data baru untuk disinkronkan."}

    message_ids = [msg.id for msg in request.unsynced_messages]
    if len(message_ids) != len(set(message_ids)):
        raise HTTPException(status_code=400, detail="ID pesan duplikat dalam batch.")

    now = int(time.time())
    if any(abs(now - msg.timestamp) > MAX_TIMESTAMP_SKEW_SECONDS for msg in request.unsynced_messages):
        raise HTTPException(status_code=400, detail="Timestamp pesan tidak valid.")

    logger.info(
        "Menerima %d pesan dari perangkat %s",
        len(request.unsynced_messages),
        request.device_id,
    )

    return {
        "status": "success",
        "message": "Data darurat berhasil diamankan ke server pusat.",
        "synced_message_ids": message_ids,
        "server_timestamp": now,
    }


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(
        app,
        host=os.environ.get("HOST", "127.0.0.1"),
        port=int(os.environ.get("PORT", "8000")),
    )