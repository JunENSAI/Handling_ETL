## Indexes

We have built the table structure. Now we need to make it fast.

However, there is a catch: 

- Indexes speed up Reads (`Select`), but slow down Writes (`Insert/Update`).  

- Every time you add a row to a table, the database has to update the table and every single index attached to it. For an ETL pipeline writing millions of rows, this can be fatal.

### B-Tree (The Default / The Workhorse)

* Best for: `Unique values, Primary Keys, Foreign Keys` (e.g., user_id, email).

* How it works: It's like the index at the back of a book. It helps you jump to "Page 50" without reading pages 1-49.

* Usage: You almost always want a B-Tree on your filtering columns. 

### GIN (Generalized Inverted Index)

* Best for: `JSONB and Arrays`.

* Scenario: You store a raw API response in a column called raw_data (JSONB). You want to find all rows where raw_data->'status' equals "success".

* A normal B-Tree cannot look inside the JSON blob. A GIN index can. 

### BRIN (Block Range INdex)

* Best for: Massive tables that are naturally sorted by time (e.g., logs, transaction_history).

* The Magic: A B-Tree for 1 billion rows is huge (many GBs of RAM). A BRIN index is tiny (Kilobytes).

* How it works: It doesn't index every row. It just writes down: "In Disk Block #1, the dates range from Jan 1 to Jan 2."

* Trade-off: It is slightly less precise but orders of magnitude smaller and faster to update than B-Tree. 

---

## The ETL Indexing Strategy

If you need to load 100 million rows of history:

* Drop all indexes on the target table.

* Load the data (It writes lightning fast because there is no index overhead).

* Recreate the indexes at the end.

* **Why?** Building an index from scratch once is faster than updating it incrementally 100 million times.