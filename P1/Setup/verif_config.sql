-- Configuration Audit

-- 1. Check Shared Buffers (Memory Cache)
-- Target: Should be roughly 25-40% of your total System RAM.
-- If this is '128MB' (default), it is too low for serious ETL.
SHOW shared_buffers;

-- 2. Check Work Mem (Sort/Hash Memory)
-- Target: For ETL, 16MB-64MB is often a good start, depending on concurrency.
-- If this is '4MB' (default), complex joins will be slow.
SHOW work_mem;

-- 3. Check Data Directory
-- Useful to know where your data is physically landing on the disk.
SHOW data_directory;

-- 4. Check Max Connections
SHOW max_connections;

-- 5. Connection Keep-Alive Check (Client-side)
SHOW tcp_keepalives_idle;