## 1. The "Silent Failure" of duplicates:

In an ETL pipeline, why is `DISTINCT` often insufficient for removing duplicates compared to the `ROW_NUMBER()` window function strategy?

- **Example:** If you have two rows that are identical except for an upload_timestamp (e.g., Row A came in at 10:00, Row B at 10:05), `DISTINCT` sees them as two different rows and keeps both.

- `ROW_NUMBER()` allows you to group by the ID (the business key) and ignore the timestamp, letting you smartly pick the latest one and discard the res

## 2. CTEs vs Subqueries:

You are reviewing a code. They have written a query with three nested subqueries (a query inside a query inside a query). It runs correctly, but you reject it during code review. Why? What is the main engineering benefit of refactoring this into CTEs (WITH clauses)?

=> Using CTE make the query more readable and more simple to correct if it contains problem.

## 3. Window Function Syntax:

Explain the difference between `PARTITION BY` and `ORDER BY` inside a window function clause. If you remove PARTITION BY but keep ORDER BY, what happens to the calculation?

=> `PARTITION BY` is like a `GROUP BY` but applied locally so you tell SQL how to perform the aggregation (ROW_NUMBER() e.g). `ORDER BY` make order on variable that need to be ordered like date, total_spend,...

If you remove `PARTITION BY`, the "Window" becomes the entire table.

- Result: `ROW_NUMBER()` would number your rows from 1 to 500,000,000 continuously, effectively ranking the whole dataset, rather than restarting the count at "1" for every new customer.

## 4. Performance Instincts:

You need to perform a deduplication on a table with 500 million rows. Would you prefer to do this transformation in Python (Pandas) or in the Database (SQL)? Why?

- To do this in Python, you have to: `1. Read 500M rows from Disk -> 2. Send over Network -> 3. Load into Python RAM -> 4. Process -> 5. Send back to DB.`

- Doing it in SQL **skips steps 2, 3, and 5**. The data never leaves the database server. Always bring the compute to the data, not the data to the compu

## 5. Debugging Logic:

You run the deduplication query from the practice file, but it keeps the oldest version of the record instead of the newest. Which specific part of the SQL command ROW_NUMBER() OVER (...) do you need to change?

=> The `ORDER BY` part : change ASC (ascending) to DESC (descending)