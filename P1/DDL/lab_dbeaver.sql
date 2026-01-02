/*
   Implementing the Star Schema

   Context: Streaming Service Analytics
*/

-- 1. Create Dimension Tables (The "Context")

CREATE TABLE dim_user (
    user_key SERIAL PRIMARY KEY,        -- Surrogate Key (Internal)
    user_id_original VARCHAR(50),       -- Natural Key (From App)
    username TEXT,
    email TEXT,
    registration_date TIMESTAMPTZ
);

CREATE TABLE dim_video (
    video_key SERIAL PRIMARY KEY,
    video_id_original VARCHAR(50),
    title TEXT,
    genre VARCHAR(100),
    release_year INT
);

CREATE TABLE dim_device (
    device_key SERIAL PRIMARY KEY,
    device_type VARCHAR(50),
    os_version VARCHAR(50)
);

-- 2. Handle the "Unknown" Member
INSERT INTO dim_device (device_key, device_type, os_version)
VALUES (-1, 'Unknown', 'N/A');


-- 3. Create Fact Table (The "Metrics")
-- This table connects the dimensions together.

CREATE TABLE fact_video_plays (
    play_id SERIAL PRIMARY KEY,
    
    -- Foreign Keys linking to Dimensions
    user_key INT REFERENCES dim_user(user_key),
    video_key INT REFERENCES dim_video(video_key),
    device_key INT REFERENCES dim_device(device_key),
    
    -- The Date/Time Context
    start_time TIMESTAMPTZ NOT NULL,
    
    -- The Facts (Measurements)
    duration_seconds INT,               -- How long they watched
    is_completed BOOLEAN DEFAULT FALSE, -- Did they finish it?
    
    -- Constraint: Ensure duration is logical
    CONSTRAINT check_positive_duration CHECK (duration_seconds >= 0)
);

-- 4. Verification
-- Visualize the table structure
SELECT * FROM information_schema.tables WHERE table_name = 'fact_video_plays';