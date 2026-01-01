## How to organize your data

Before writing code, we must choose how to organize our data. Here are the outlines of three major schools of thought :

### 1. The Inmon Approach (The Corporate Information Factory)

- **What is it?** 

A top-down, normalized approach where data is stored in Third Normal Form (3NF).


- **How it works** ? 

You create a "Single Source of Truth" where every piece of data (e.g., a customer address) exists in exactly one place.

- **Pros:** Excellent data integrity; minimizes redundancy.

- **Cons**: Extremely complex for reporting. Business Intelligence (BI) queries require massive, slow joins across hundreds of tables.


- **Limits:** The ETL process is front-loaded and heavy; data must be perfect before loading.

---

### 2. The Kimball Approach (Dimensional Modeling)

* **What is it?** 

A bottom-up approach focused on query performance and ease of use for analysts.


* **How it works** ? 

It uses the Star Schema, consisting of Fact Tables (metrics like sales) and Dimension Tables (context like date, customer).

* **Pros:** Optimized for reading and reporting (fast Star Joins). This is the industry standard for general analytics.

* **Cons:** Requires the ETL pipeline to handle "denormalization" complexity, such as Slowly Changing Dimensions (SCDs).


* **Our Choice:** We will use Kimball for this program because it balances complexity and utility perfectly for our Python/PostgreSQL stack.

---

### 3. The Data Vault

* **What is it?** 

A hybrid approach designed for high-volume, rapidly changing data, splitting data into Hubs (keys), Links (relationships), and Satellites (attributes).

* **Pros:** Highly resilient to source system changes; allows raw loading with minimal transformation.

* **Cons:** Requires complex query logic to reconstruct data for actual use.

---

## Environment Configuration (PostgreSQL & DBeaver)

### 1. PostgreSQL: `shared_buffers`

* **Why?** 

Determines how much data PostgreSQL caches in RAM.

* **Recommendation:** Set to 25-40% of your system RAM.

* **Impact:** If too low, the database constantly reads from the slow hard disk instead of fast RAM.

---

### 2. PostgreSQL: `work_mem`

- **Why?** 

Controls memory used for internal sort operations and hash tables.

- **Recommendation:** Needs to be increased for ETL.


- **Impact:** A low value causes sorting to "spill to disk," which drastically slows down transformations.

---

## 3. DBeaver: Connection Keep-Alive

- **Why?** 

Long-running ETL queries might look "idle" to the network, causing firewalls to drop the connection.

- **How:** Enable "Keep-Alive" in connection settings to send dummy packets periodically.