CREATE OR ALTER PROCEDURE sp_upsert_transactions AS
BEGIN
    -- Step 1: Update existing records (based on last_updated)
    UPDATE gold_fact_transactions
    SET
        store_id = src.store_id,
        customer_id = src.customer_id,
        txn_date = src.txn_date,
        product_id = src.product_id,
        quantity = src.quantity,
        unit_price = src.unit_price,
        total_amount = src.total_amount,
        last_updated = src.last_updated
    FROM staging_transactions_stage AS src
    WHERE gold_fact_transactions.txn_id = src.txn_id
      AND gold_fact_transactions.last_updated < src.last_updated;

    -- Step 2: Insert new records (no JOIN used)
    INSERT INTO gold_fact_transactions (
        txn_id, store_id, customer_id, txn_date,
        product_id, quantity, unit_price,
        total_amount, last_updated
    )
    SELECT
        txn_id, store_id, customer_id, txn_date,
        product_id, quantity, unit_price,
        total_amount, last_updated
    FROM staging_transactions_stage AS src
    WHERE NOT EXISTS (
        SELECT 1
        FROM gold_fact_transactions
        WHERE txn_id = src.txn_id
    );
END;
