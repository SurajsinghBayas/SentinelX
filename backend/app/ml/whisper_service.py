"""
OpenAI Whisper Speech-to-Text Service
Transcribes audio files to text for call transcript analysis.
"""

from __future__ import annotations

import os
import tempfile
from pathlib import Path
from typing import Optional, Tuple

from app.core.config import settings
from app.core.logging import get_logger

logger = get_logger(__name__)


class WhisperService:
    """
    Wraps OpenAI Whisper for speech-to-text transcription.

    Lazy-loads the model on first use to avoid startup delay.
    Falls back gracefully if torch/whisper is unavailable.
    """

    def __init__(self) -> None:
        self._model = None
        self._loaded = False

    def _load(self) -> None:
        if self._loaded:
            return
        try:
            import whisper  # type: ignore

            logger.info(f"Loading Whisper model '{settings.WHISPER_MODEL_SIZE}'…")
            self._model = whisper.load_model(
                settings.WHISPER_MODEL_SIZE,
                download_root=settings.ML_CACHE_DIR,
            )
            logger.info("Whisper model loaded successfully.")
        except Exception as exc:
            logger.error(f"Failed to load Whisper model: {exc}")
        finally:
            self._loaded = True

    def transcribe_file(self, file_path: str) -> Tuple[str, Optional[str], Optional[float]]:
        """
        Transcribe an audio file.

        Args:
            file_path: Path to audio file (wav, mp3, m4a, flac, etc.)

        Returns:
            (transcript_text, detected_language, duration_seconds)
        """
        self._load()

        if self._model is None:
            raise RuntimeError(
                "Whisper model is not available. "
                "Ensure torch and openai-whisper are installed."
            )

        logger.info(f"Transcribing audio file: {file_path}")
        result = self._model.transcribe(file_path, fp16=False)

        transcript: str = result.get("text", "").strip()
        language: Optional[str] = result.get("language")

        # Calculate duration from segments if available
        segments = result.get("segments", [])
        duration: Optional[float] = None
        if segments:
            duration = segments[-1].get("end")

        logger.info(f"Transcription complete. Language: {language}, Duration: {duration}s")
        return transcript, language, duration

    async def transcribe_upload(self, audio_bytes: bytes, filename: str) -> Tuple[str, Optional[str], Optional[float]]:
        """
        Transcribe audio from uploaded bytes.

        Writes to a temporary file, transcribes, then cleans up.
        """
        suffix = Path(filename).suffix or ".wav"
        with tempfile.NamedTemporaryFile(suffix=suffix, delete=False) as tmp:
            tmp.write(audio_bytes)
            tmp_path = tmp.name

        try:
            return self.transcribe_file(tmp_path)
        finally:
            os.unlink(tmp_path)


whisper_service = WhisperService()
