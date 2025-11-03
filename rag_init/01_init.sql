-- pgvector extension
CREATE EXTENSION IF NOT EXISTS vector;

-- basic metadata (optional but handy)
CREATE TABLE IF NOT EXISTS embedding_meta (
  key   TEXT PRIMARY KEY,
  value TEXT NOT NULL
);

INSERT INTO embedding_meta(key, value) VALUES
  ('model', 'text-embedding-3-small'),
  ('dim', '1536')
ON CONFLICT (key) DO UPDATE SET value = EXCLUDED.value;

-- main chunk store (adjust dim to your embedding model)
CREATE TABLE IF NOT EXISTS documents (
  id          UUID PRIMARY KEY,
  collection  TEXT DEFAULT 'default',
  source_url  TEXT NOT NULL,
  source_path TEXT,
  title       TEXT,
  chunk_idx   INT NOT NULL,
  content     TEXT NOT NULL,
  metadata    JSONB DEFAULT '{}'::jsonb,
  embedding   VECTOR(1536) NOT NULL,
  hash        TEXT NOT NULL,
  created_at  TIMESTAMPTZ DEFAULT now()
);

-- unique on content hash to make upserts idempotent (optional)
CREATE UNIQUE INDEX IF NOT EXISTS ux_documents_hash
  ON documents(hash);

-- Choose ONE ANN index:
-- 1) IVF (good general default; tune lists as corpus grows)
CREATE INDEX IF NOT EXISTS idx_documents_embedding_ivf
  ON documents USING ivfflat (embedding vector_cosine_ops) WITH (lists = 100);

-- 2) HNSW (great recall/latency on pgvector >= 0.7)
-- CREATE INDEX IF NOT EXISTS idx_documents_embedding_hnsw
--   ON documents USING hnsw (embedding vector_cosine_ops) WITH (m = 16, ef_construction = 128);

ANALYZE documents;
