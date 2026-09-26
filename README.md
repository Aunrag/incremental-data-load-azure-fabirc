
# Incremental Load Project – Microsoft Azure / Fabric

## Overview

This project implements an incremental data load for transaction data using a staging table, a gold table, and a stored procedure.

The process:

1. Load new or changed records into the staging table.
2. Update existing records when the incoming `last_updated` is newer.
3. Insert new transactions that do not exist in the target table.

## Flow

```text
Source
  ↓
Azure / Fabric Pipeline
  ↓
Staging Table
  ↓
Stored Procedure
  ↓
Gold Fact Table
````

 ## Tables

 ### Staging

 `staging_transactions_stage`

 Stores the incoming incremental transaction data.

 ### Gold

 `gold_fact_transactions`

 Stores the final transaction data.

 ## Incremental Logic

 The stored procedure `sp_upsert_transactions` performs:

 - **UPDATE**: If `txn_id` exists and the staging `last_updated` is newer.
- **INSERT**: If `txn_id` does not exist in the gold table.
- **IGNORE**: If the incoming record is older or has the same timestamp.

```
                 Staging
                    │
              Check txn_id
               /          \
            New            Exists
             │               │
          INSERT      Compare last_updated
                            │
                    ┌───────┴───────┐
                  Newer          Older/Same
                    │                │
                 UPDATE            Ignore
```

 ## Technologies

 - Microsoft Azure / Microsoft Fabric
- SQL
- Data Pipeline
- Incremental Load
- Stored Procedure

 ## Project Structure

```
incremental-load/
│
├── README.md
├── create_tables.sql
└── sp_upsert_transactions.sql
```

 ## Key Concept

 The project uses `txn_id` as the transaction key and `last_updated` as the change-detection column to avoid unnecessary full-table loads.
