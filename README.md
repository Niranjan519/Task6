# Task6
SQL data Analysis
# Task 6: Sales Trend Analysis Using Aggregations (Adapted)

This repository contains the solution for Task 6, which requires sales trend analysis using aggregations.

## ⚠️ Important Note on Dataset

The provided `syntehtic_online_retail_data` file **does not contain the necessary `order_date` or `order_id` columns** to perform the requested monthly trend analysis or calculate distinct order volume (as per the PDF's hints: `EXTRACT(MONTH FROM order_date)` and `COUNT(DISTINCT order_id)`).

## Adapted Objective

To fulfill the spirit of the task (using aggregations for trend analysis), the objective was adapted to perform a **Product Performance Analysis** by grouping sales data by `Product_Type`.

### Aggregation Mappings:

| Original Task Hint | CSV Column Used | MySQL Function | Purpose |
| :--- | :--- | :--- | :--- |
| Group by Month/Year | `Product_Type` | `GROUP BY` | Segment the data for analysis |
| SUM() for Revenue | `Total_Net_Sales` | `SUM()` | Calculate total revenue per segment |
| COUNT(DISTINCT order_id) for Volume | `Net_Quantity` | `SUM()` | Calculate total units sold (volume proxy) |

## MySQL Execution Guide

### 1. Database Setup

The script first creates a database named `retail_db` and uses the `retail_sales` table.

```sql
CREATE DATABASE IF NOT EXISTS retail_db;
USE retail_db;
