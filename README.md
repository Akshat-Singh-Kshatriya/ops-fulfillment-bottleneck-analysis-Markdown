# E-Commerce Fulfillment Bottleneck Analyzer

### Project Overview
This project focuses on optimizing supply chain operations by identifying latencies within the order fulfillment lifecycle. Using SQL-based data engineering, I analyzed real-world delivery timestamps to pinpoint where internal processes slow down service delivery.

### Data & Methodology
* **Dataset:** [Olist Brazilian E-Commerce Public Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).
* **Stack:** PostgreSQL, Common Table Expressions (CTEs).
* **KPIs:** Internal Warehouse Handoff Time vs. External Transit Time.

### Key Results
* **Total Volume:** Successfully processed 96,455 unique orders.
* **Approval Latency:** 10.28 hours average for payment confirmation.
* **Internal Bottleneck:** Identified a **67.18-hour delay** in warehouse picking and packing.
* **External Transit:** 223.93 hours for final-mile delivery.

### Operational Insight
The analysis revealed that internal warehouse processing (controllable) accounts for nearly 23% of total fulfillment time. By optimizing picking routes or batching orders by region, we could theoretically reduce handoff latency by 15-20%.
