/*
   Internals and Optimization
   
   Goal: Manage Bloat and bypass WAL for speed.
*/

-- 1. Create an UNLOGGED Staging Table
-- Use this for raw data imports (Day 33). It is fragile (not crash-safe) but FAST.
CREATE UNLOGGED TABLE stg_raw_json (
    id SERIAL PRIMARY KEY,
    raw_payload JSONB
);
-- Benefit: Bypasses the Write-Ahead Log (WAL) overhead. 


-- 2. Simulate Bloat (The "Delete" Trap)
-- Create a dummy table
CREATE TABLE test_bloat (id INT, val TEXT);
INSERT INTO test_bloat SELECT generate_series(1, 10000), 'original';

-- Update all rows (This creates 10,000 DEAD tuples)
UPDATE test_bloat SET val = 'updated';

-- Check the "Dead Tuples" count
-- n_dead_tup = Number of dead rows waiting to be cleaned.
SELECT relname, n_live_tup, n_dead_tup, last_autovacuum
FROM pg_stat_user_tables
WHERE relname = 'test_bloat';


-- 3. The Fix: VACUUM
-- Manually trigger the garbage collector.
VACUUM VERBOSE test_bloat;

-- Check again (n_dead_tup should be 0)
SELECT relname, n_live_tup, n_dead_tup 
FROM pg_stat_user_tables
WHERE relname = 'test_bloat';