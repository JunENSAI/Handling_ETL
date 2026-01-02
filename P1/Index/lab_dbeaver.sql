/*
   Indexing Strategy
   
   Goal: Optimize the tables for read performance.
*/

-- 1. B-Tree Indexes (Standard)
-- We query by 'start_time' frequently for reports.
CREATE INDEX idx_fact_time ON fact_video_plays USING btree (start_time);

-- We join on 'user_key' constantly. Foreign keys usually need indexes.
CREATE INDEX idx_fact_user ON fact_video_plays USING btree (user_key);


-- 2. GIN Index (For JSON)
ALTER TABLE fact_video_plays ADD COLUMN metadata JSONB;

-- Example Data: {"wifi_strength": "strong", "app_version": "1.0.4"}
-- We want to search inside this JSON.
CREATE INDEX idx_fact_metadata ON fact_video_plays USING GIN (metadata);


-- 3. BRIN Index (For Big Data)
-- If fact_video_plays had 1 Billion rows and was sorted by insertion,
-- BRIN would be the choice for the date column to save space.
-- (We won't run this now as our table is small, but here is the syntax)
-- CREATE INDEX idx_fact_brin_date ON fact_video_plays USING BRIN (start_time);


-- 4. Check Index Usage
EXPLAIN ANALYZE
SELECT * FROM fact_video_plays
WHERE start_time > '2023-01-01 00:00:00+00';
-- Look for "Index Scan" (Good) vs "Seq Scan" (Bad/Slow for large data).