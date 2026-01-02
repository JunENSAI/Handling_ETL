### 1.The "Delete" Myth:

You run DELETE FROM my_table and remove 50% of the rows (10GB of data). You check the hard drive space, but free space has not increased. Why ?

=> Bloat concept : relates the space unnecessarily occupied by lines or indexes that are no longer used (like when we run DELETE ...)

### 2. Staging Strategy:

You are designing a pipeline  You download a CSV to a local folder, then load it into a Staging Table in Postgres, then transform it to a Fact Table. Why is it safe to make the Staging Table UNLOGGED, but dangerous to make the Fact Table UNLOGGED? 

=> It's dangerous to make the FACT Table UNLOGGED because if the server crashes, the FACT table is wiped empty.

### 3. Performance Debugging:

Your dashboard query used to take 1 second. After a week of heavy updates to the user table, the query now takes 10 seconds. You run EXPLAIN and see it is scanning thousands of pages that contain no useful data. What maintenance command did the database likely fail to run? 

=> The VACUUM command

### 4. Autovacuum Tuning:

Why might the default Autovacuum settings be insufficient for a Data Warehouse compared to a standard App Database? 

=> Due to the generation of massive bloat faster than the default Autovacuum can clean it up

### 5. WAL Trade-off:

What is the primary "cost" or "risk" of disabling the WAL (using UNLOGGED tables) to gain performance?

=> If the server crashes, the table is wiped empty.