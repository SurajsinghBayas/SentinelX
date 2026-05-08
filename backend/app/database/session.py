"""
Database Session Management
Provides an async-compatible SQLAlchemy engine and session factory.
"""

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, Session
from typing import Generator

from app.core.config import settings
from app.core.logging import get_logger

logger = get_logger(__name__)

# ─── Engine ───────────────────────────────────────────────────────────────────
engine = create_engine(
    settings.DATABASE_URL,
    pool_size=settings.DB_POOL_SIZE,
    max_overflow=settings.DB_MAX_OVERFLOW,
    pool_pre_ping=True,          # Detect stale connections
    echo=settings.DEBUG,         # Log SQL in debug mode
)

# ─── Session Factory ──────────────────────────────────────────────────────────
SessionLocal = sessionmaker(
    bind=engine,
    autocommit=False,
    autoflush=False,
)


# ─── Dependency ───────────────────────────────────────────────────────────────
def get_db() -> Generator[Session, None, None]:
    """
    FastAPI dependency that yields a database session and ensures cleanup.

    Usage:
        @router.get("/")
        def endpoint(db: Session = Depends(get_db)):
            ...
    """
    db: Session = SessionLocal()
    try:
        yield db
    except Exception:
        db.rollback()
        raise
    finally:
        db.close()
