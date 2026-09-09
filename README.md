# Used Car Marketplace — SQL Analysis

A structured SQL case study simulating the data environment of a kavak used car marketplace, built to practise real-world analytical SQL skills including multi-table JOINs, GROUP BY aggregations, CASE WHEN classification, HAVING filters, and KPI calculations.

---

## Project Overview

This project builds a relational MySQL database representing a used car dealership operating across 4 branches in the UAE. The database contains 60 cars in inventory, 50 sales transactions, 8 sales representatives, and 4 branch locations  all connected through foreign key relationships.

The analysis answers 20 progressive business questions, from basic inventory filtering to a full executive summary query combining revenue, sell-through rate, and profit margin across all branches.

---

## Database Schema

```
branches ──< cars ──< sales
branches ──< salesreps ──< sales
```

| Table | Rows | Description |
|---|---|---|
| branches | 4 | Dealership locations across UAE (Dubai, Sharjah, Abu Dhabi, Al Ain) |
| salesreps | 8 | Sales staff, each assigned to one branch |
| cars | 60 | Vehicle inventory with cost price, list price, brand, model, year |
| sales | 50 | Completed transactions with actual sale price, rep, and date |

Not every car has a matching sale row — approximately 28% of inventory remains unsold, enabling LEFT JOIN practice for finding unsold stock.

---

## Skills Demonstrated

- `SELECT`, `WHERE`, `ORDER BY`, `LIMIT` — basic data retrieval and filtering
- `GROUP BY` with aggregate functions — `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
- `INNER JOIN` and `LEFT JOIN` across multiple tables
- `CASE WHEN` — conditional column classification (Budget / Mid / Premium)
- `HAVING` — filtering aggregated results
- Conditional aggregation — `SUM(CASE WHEN ... THEN ... ELSE 0 END)`
- KPI calculations — sell-through rate, gross margin %, profit per unit
- Multi-column `GROUP BY` — revenue by branch AND month simultaneously
- Subqueries — filtering against aggregated values
- Window functions — `RANK() OVER (PARTITION BY ...)`

---

## Key Queries

### 1. Classify cars by price tier using CASE WHEN

```sql
SELECT car_id, brand, list_price,
  CASE
    WHEN list_price < 50000 THEN 'Budget'
    WHEN list_price BETWEEN 50000 AND 90000 THEN 'Mid'
    ELSE 'Premium'
  END AS price_tier
FROM cars;
```

### 2. Revenue by branch AND month (multi-column GROUP BY)

```sql
SELECT b.branch_name, s.month, SUM(s.sale_price) AS total_revenue
FROM sales s
INNER JOIN cars c ON s.car_id = c.car_id
INNER JOIN branches b ON c.branch_id = b.branch_id
GROUP BY b.branch_name, s.month;
```

### 3. Sell-through rate per brand

```sql
SELECT c.brand,
  COUNT(DISTINCT c.car_id) AS total_inventory,
  COUNT(DISTINCT s.car_id) AS total_sold,
  ROUND(100.0 * COUNT(DISTINCT s.car_id) / COUNT(DISTINCT c.car_id), 1) AS sell_through_pct
FROM cars c
LEFT JOIN sales s ON c.car_id = s.car_id
GROUP BY c.brand;
```

### 4. Executive summary — full branch performance in one query

```sql
SELECT b.branch_name,
  COUNT(DISTINCT c.car_id) AS total_inventory,
  COUNT(DISTINCT s.car_id) AS total_sold,
  SUM(s.sale_price) AS total_revenue,
  ROUND(AVG(100.0 * (s.sale_price - c.cost_price) / s.sale_price), 1) AS avg_margin_pct
FROM cars c
LEFT JOIN sales s ON c.car_id = s.car_id
INNER JOIN branches b ON c.branch_id = b.branch_id
GROUP BY b.branch_name;
```

---

## Files

| File | Description |
|---|---|
| `setup_database.sql` | Creates the database and all 4 tables with foreign key constraints |
| `practice_questions.sql` | All 20 business questions with solutions |
| `branches.csv` | Branch location data |
| `salesreps.csv` | Sales representative data |
| `cars.csv` | Vehicle inventory data |
| `sales.csv` | Sales transaction data |

---

## How to Set Up Locally

1. Open MySQL Workbench and connect to your local server
2. Run `setup_database.sql` to create the database and tables
3. Import each CSV using the Table Data Import Wizard in this order: branches → salesreps → cars → sales
4. Open `practice_questions.sql` and run any query against the live database

---

## Tools Used

- MySQL 8.0
- MySQL Workbench

---

## About

Built as part of a data analytics portfolio project to practise SQL for business intelligence and strategy analysis use cases, with a focus on retail and marketplace datasets.

**Author:** Tahoora Pathan  
**LinkedIn:** [linkedin.com/in/tahoora-pathan](https://linkedin.com/in/tahoora-pathan)  
**Portfolio:** [Google Drive](https://drive.google.com)
