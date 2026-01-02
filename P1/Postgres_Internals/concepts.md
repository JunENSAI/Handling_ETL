## MVCC (Multi-Version Concurrency Control)

- **The Problem:** You are reading a report (SELECT) while I am updating the data (UPDATE). If the database locks the table, your report freezes.

- **The Solution (MVCC):** PostgreSQL allows us to work simultaneously.

- **How:** When I update a row, Postgres does not overwrite the old row.

It creates a new version of the row and marks the old one as "Dead" (invisible to new transactions, but visible to your running report). 

**The Consequence:** If you update 1 million rows, you now have 1 million "Live" rows and 1 million "Dead" rows occupying space. This is called Bloat. 

---

## VACUUM and Autovacuum

- **VACUUM**: This is the garbage collector. It goes through the table, finds "Dead" rows that no one is looking at anymore, and marks that space as "Free to Reuse." 

- **Autovacuum**: A background process that runs VACUUM automatically.

- **ETL Trap**: Heavy ETL updates generate massive bloat faster than the default Autovacuum can clean it up. We often need to tune it to run more aggressively on our Fact tables. 

---

## WAL (Write-Ahead Log)

- **The Mechanism**: Before Postgres writes data to the actual table file (which is risky if power fails), it writes the change to a sequential "journal" called the WAL. 

- **Reliability**: If the server crashes, Postgres replays the WAL to recover the data.

- **Performance Hack (UNLOGGED Tables)**: Writing to WAL is slow. For Staging Tables (temporary raw data that we can just re-download if we lose it), we can turn off WAL. (`CREATE UNLOGGED TABLE ...`)

- **Result**: 2x-3x faster writes, but if the server crashes, the table is wiped empty.

---