# Scenario:

You are building a Data Warehouse for a streaming service (like Netflix). You need to track "Video Plays".

Data available from the app:

- User ID (e.g., u_555)

- User Name (e.g., "Alice")

- Video ID (e.g., v_909)

- Video Title (e.g., "Inception")

- Genre (e.g., "Sci-Fi")

- Start Time (e.g., 2023-10-01 20:00:00)

- End Time (e.g., 2023-10-01 22:00:00)

- Device Type (e.g., "Smart TV")

- Resolution (e.g., "4K")

## Task 1: 

Draft the schema by answering the 4 steps.

- Process: What is the process ?.

- Grain: What does one row in your Fact table represent?

- Dimensions: List 3 separate Dimension tables you would create and the columns inside them.

- Facts: List 2 numeric metrics you can calculate from the data above to store in the Fact table.

## Responses 1

- Process : User watches/plays videos.

- Grain : One row represents one single time a user pressed play.

- Dimensions :

    - User (user_id, username)

    - Video (video_id, title, genre, tart_time, end_time)
    
    - Device (dim_device, type, resolution)

- Facts : 

    - `duration_seconds` (end_time - start_time).

    - `count`

## Task 2 :

### 1. Grain Definition:

If you choose a "coarse" grain (e.g., one row per day per user) instead of a "fine" grain (one row per video play), what analysis do you lose the ability to perform?

### 2. Surrogate Keys:

Why shouldn't we just use the User ID (u_555) from the app as the Primary Key in our dim_user table?

### 3. Fact vs Dimension:

Is zip_code a Fact or a Dimension attribute? Why?

### 4. Schema Change:

A "Slowly Changing Dimension" (SCD) happens when Alice changes her email address. In a Star Schema, do we update the Fact table or the Dimension table?

### 5. Nulls in Dimensions:

In a Star Schema, a Fact table connects to Dimensions via Foreign Keys. What happens if a User watches a video, but the system doesn't know which Device they used (Device is NULL)? How should we handle this in the Dimension table (e.g., dim_device) to avoid breaking the join?

## Responses 2

1. We lose the ability to perform real AGGREGATION on user because you don't saw the number of videos that the user have played.

2. If the source (u_555) changes, we only need to update our mapping; we don't break our history.

3. `zip_code`is a Dimension

4. Need to change the dimension table

5. We create a specific row in the Dimension table with ID = -1 (or 0) and name it "Unknown Device." If the source data is null, we point the Fact table to ID -1. This ensures we never have NULL foreign keys, keeping our joins clean.



