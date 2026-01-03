/*
   Handling JSONB
   
   Goal: Parse nested JSON data using SQL.
*/

-- 1. Create the Raw Landing Table
CREATE TABLE raw_crypto_data (
    id SERIAL PRIMARY KEY,
    insertion_time TIMESTAMPTZ DEFAULT NOW(),
    api_response JSONB  -- The magic column
);

-- 2. Insert Dummy Nested Data
INSERT INTO raw_crypto_data (api_response) VALUES
('{"coin": "bitcoin", "market_data": {"price": 50000, "high_24h": 51000, "tags": ["layer1", "pow"]}}'),
('{"coin": "ethereum", "market_data": {"price": 3000, "high_24h": 3100, "tags": ["layer1", "pos"]}}');

-- 3. Flattening the Data
-- We want a table looking like: | coin | price | first_tag |

SELECT
    -- Top level extraction (Text)
    api_response->>'coin' as coin_name,
    
    -- Nested extraction (Cast to Numeric to do math later)
    (api_response->'market_data'->>'price')::NUMERIC as current_price,
    
    -- Array extraction (Get the 0th element of the tags array)
    api_response->'market_data'->'tags'->>0 as primary_tag
FROM
    raw_crypto_data;
    
-- 4. Handling Missing Keys
-- Insert a row with MISSING market_data
INSERT INTO raw_crypto_data (api_response) VALUES
('{"coin": "doge", "error": "data not found"}');

-- Run the SELECT above again. 
-- Notice that Postgres handles the missing keys gracefully (returns NULL) 
-- instead of crashing the query.