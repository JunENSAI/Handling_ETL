While analysts use SQL to answer questions, engineers use SQL to transform and clean data. Two features are indispensable for this: Window Functions and CTEs.

## 1. Window Functions (OVER, PARTITION BY)

* **What are they?** 

    They allow you to look across a "window" of rows related to the current row without collapsing them into a single summary (unlike GROUP BY).

* The Key Use Case: `Deduplication`.

    * **Scenario:** Your extraction script accidentally ran twice, or the source system sent duplicate records. You have two rows for "Order #1001", but one has a slightly later timestamp.

    * **The Engineer's Fix**: Use ROW_NUMBER() partitioned by the ID and ordered by time. The row with rank 1 is the latest; rank 2 is the duplicate to be discarded.

* **Other Functions:**

    * `LEAD() / LAG()`: Look at the next or previous row. Crucial for calculating "Day-over-Day" growth in a single query.

---

## 2. Common Table Expressions (CTEs)

* **What are they?**

    The WITH clause. They create a temporary result set that exists only for the duration of the query.

* **Why use them?** (Readability): 

    * They allow you to break a massive, monolithic "Spaghetti SQL" query into logical, sequential steps (e.g., "Step 1: Clean Data", "Step 2: Join Data", "Step 3: Filter").

    * `PostgreSQL Note`: In older versions, CTEs acted as an "optimization fence" (preventing the planner from optimizing across the boundary). In modern Postgres, they are generally optimization-friendly.