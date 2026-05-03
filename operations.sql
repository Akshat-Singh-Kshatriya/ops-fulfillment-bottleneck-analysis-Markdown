CREATE TABLE olist_orders_dataset (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(30),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);
copy olist_orders_dataset FROM 'D:\akshat\Downloads\olist_orders_dataset.csv' DELIMITER ',' CSV HEADER;


WITH OrderStages AS (
    SELECT 
        order_id,
        
       
        EXTRACT(EPOCH FROM (order_approved_at::timestamp - order_purchase_timestamp::timestamp)) / 3600 AS hrs_to_approve,
        
        
        EXTRACT(EPOCH FROM (order_delivered_carrier_date::timestamp - order_approved_at::timestamp)) / 3600 AS hrs_in_warehouse,
        
        
        EXTRACT(EPOCH FROM (order_delivered_customer_date::timestamp - order_delivered_carrier_date::timestamp)) / 3600 AS hrs_in_transit,

        EXTRACT(EPOCH FROM (order_delivered_customer_date::timestamp - order_purchase_timestamp::timestamp)) / 3600 AS total_turnaround_hrs
        
    FROM 
        olist_orders_dataset
    WHERE 
        order_status = 'delivered' 
        AND order_approved_at IS NOT NULL 
        AND order_delivered_carrier_date IS NOT NULL 
        AND order_delivered_customer_date IS NOT NULL
),

AverageTimes AS (
    SELECT 
        COUNT(order_id) AS total_orders_analyzed,
        ROUND(AVG(hrs_to_approve)::numeric, 2) AS avg_hrs_to_approve,
        ROUND(AVG(hrs_in_warehouse)::numeric, 2) AS avg_hrs_in_warehouse,
        ROUND(AVG(hrs_in_transit)::numeric, 2) AS avg_hrs_in_transit,
        ROUND(AVG(total_turnaround_hrs)::numeric, 2) AS avg_total_turnaround
    FROM 
        OrderStages
)


SELECT 
    total_orders_analyzed,
    avg_hrs_to_approve,
    avg_hrs_in_warehouse AS internal_bottleneck_hrs,
    avg_hrs_in_transit AS external_bottleneck_hrs,
    avg_total_turnaround
FROM 
    AverageTimes;