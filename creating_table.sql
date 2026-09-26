CREATE TABLE staging_transactions_stage (
  txn_id VARCHAR(20),
  store_id VARCHAR(10),
  customer_id VARCHAR(20),
  txn_date DATE,
  product_id VARCHAR(20),
  quantity INT,
  unit_price FLOAT,
  total_amount FLOAT,
  last_updated DATETIME2(0)
);

CREATE TABLE gold_fact_transactions (
  txn_id VARCHAR(20) ,
  store_id VARCHAR(10),
  customer_id VARCHAR(20),
  txn_date DATE,
  product_id VARCHAR(20),
  quantity INT,
  unit_price FLOAT,
  total_amount FLOAT,
  last_updated DATETIME2(0)
);
