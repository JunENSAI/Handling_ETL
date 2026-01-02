### 1. The Write Penalty:

You have a table with 5 different indexes (on date, user, product, store, price). You notice that your daily ETL INSERT script is running extremely slowly. Based on the concept of "Index Overhead," why is this happening? 

=> When an insert happens the index needs to be updated also and that takes time 

### 2. Space vs. Speed:

You have a massive log table (1 TB). You need to filter by log_date.

- **Option A**: B-Tree Index (Fastest search, takes up 200GB space).

- **Option B**: BRIN Index (Slightly slower search, takes up 50MB space).

Which would you choose for an archival log table that is rarely queried, and why? 

=> BRIN Index maybe because log_table is rarely queried.

### 3. JSON Searching:

You have a column raw_response containing JSON strings. You try to run SELECT * FROM table WHERE raw_response->>'status' = 'failed'. It takes 10 minutes. Which specific index type (B-Tree, GIN, or BRIN) should you add to fix this?

=> add `GIN` index

### 4. Operational Strategy:

You are about to reload your entire Fact Table (historical backfill). The table has a B-Tree index on date. To minimize the total time (Load Time + Index Time), what order of operations should you follow? 

* Drop all indexes on the Fact table.

* Load the data (It writes lightning fast because there is no index overhead).

* Recreate the indexes at the end.


### 5. Composite Indexes:

(Logic Question) If you create a single index on two columns: CREATE INDEX idx_user_date ON table (user_id, date). Will this index help a query that only filters by date (e.g., WHERE date = '2023-01-01')?

=> No, this index help a query that specified user_id = ... and date = ... **Order matters !!**