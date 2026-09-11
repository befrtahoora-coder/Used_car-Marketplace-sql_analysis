# Used Car Marketplace — SQL Analysis

A structured SQL case study simulating the data environment of a used car marketplace, built to practise real-world analytical SQL skills including multi-table JOINs, GROUP BY aggregations, CASE WHEN classification, HAVING filters, and KPI calculations.

---

## Project Overview

This project builds a relational MySQL database representing a used car dealership operating across 4 branches in the UAE. The database contains 60 cars in inventory, 50 sales transactions, 8 sales representatives, and 4 branch locations — all connected through foreign key relationships.

The analysis answers 15 progressive business questions, from basic inventory filtering to multi-table JOINs, revenue aggregations, and conditional classification using CASE WHEN.

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

---

## Skills Demonstrated

- `SELECT`, `WHERE`, `ORDER BY`, `LIMIT` — basic data retrieval and filtering
- `GROUP BY` with aggregate functions — `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
- `INNER JOIN` and `LEFT JOIN` across multiple tables
- `CASE WHEN` — conditional column classification (Budget / Mid / Premium)
- `HAVING` — filtering aggregated results
- Multi-table joins combining branches, salesreps, cars, and sales
- Conditional aggregation — `SUM(CASE WHEN ... THEN ... ELSE 0 END)`

---

## Key Queries

### 1. List all cars priced above 80,000

```sql
SELECT car_id, brand, model, list_price
FROM cars
WHERE list_price > 80000
ORDER BY list_price DESC;
```

### 2. Count cars available per branch

```sql
SELECT b.branch_name, COUNT(c.car_id) AS total_cars
FROM branches b
INNER JOIN cars c ON b.branch_id = c.branch_id
GROUP BY b.branch_name;
```

### 3. Classify cars by price tier using CASE WHEN

```sql
SELECT car_id, brand, list_price,
  CASE
    WHEN list_price < 50000 THEN 'Budget'
    WHEN list_price BETWEEN 50000 AND 90000 THEN 'Mid'
    ELSE 'Premium'
  END AS price_tier
FROM cars;
```

### 4. Total revenue per sales rep using JOIN

```sql
SELECT sr.rep_name, SUM(s.sale_price) AS total_revenue
FROM salesreps sr
INNER JOIN sales s ON sr.rep_id = s.rep_id
GROUP BY sr.rep_name
ORDER BY total_revenue DESC;
```

---

## Files

| File | Description |
|---|---|
| `branches.csv` | Branch location data |
| `salesreps.csv` | Sales representative data |
| `cars.csv` | Vehicle inventory data |
| `sales.csv` | Sales transaction data |

---


## Tools Used

- MySQL 8.0
- MySQL Workbench

---

## About

Built as part of a data analytics portfolio project to practise SQL for business intelligence and strategy analysis use cases.

**Author:** Tahoora Pathan  
**LinkedIn:** [linkedin.com/in/tahoora-pathan](https://linkedin.com/in/tahoora-pathan)  
**Portfolio:** [Google Drive](https://drive.google.com)
