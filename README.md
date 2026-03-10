# 🛒 E-Commerce Sales Analysis Project

![SQL](https://img.shields.io/badge/SQL-Analysis-blue?logo=mysql)

---

## 📌 Project Goal
Analyze the **sales performance of products, categories, customers, and regions** to identify key business insights.

The project focuses on:
- Revenue analysis
- Customer purchasing behavior
- Product performance
- Regional sales distribution
- Return and refund patterns

---

# 📑 Table of Contents
- [Database Schema](#database-schema)
- [Business Questions](#business-questions)
- [General Sales Insights](#general-sales-insights)
- [Customer Insights](#customer-insights)
- [Product & Order Insights](#product--order-insights)
- [Temporal Trends](#temporal-trends)
- [Regional Insights](#regional-insights)
- [Return & Refund Insights](#return--refund-insights)

---

# 🗄 Database Schema

The dataset consists of **5 main tables**:

| Table | Description |
|------|-------------|
| Customers | Customer details and demographic information |
| Products | Product information including category |
| Orders | Order transaction details |
| OrderDetails | Individual product items within each order |
| Regions | Geographic regions where orders are placed |

---

# 📊 Business Questions

## General Sales Insights

- What is the **total revenue generated** over the entire period?
- What is the **revenue excluding returned orders**?
- What is the **total revenue per year and per month**?
- What is the **revenue by product and category**?
- What is the **average order value (AOV)** across all orders?
- What is the **AOV per year and per month**?
- What is the **average order size by region**?

---

## Customer Insights

- Who are the **top 10 customers by total revenue spent**?
- What is the **repeat customer rate**?
- What is the **average time between two consecutive orders** for the same customer (region-wise)?
- How can customers be segmented based on **total spending**?

Customer Segmentation:

| Segment | Total Spend |
|-------|-------------|
| Platinum | > 1500 |
| Gold | 1000 – 1500 |
| Silver | 500 – 999 |
| Bronze | < 500 |

- What is the **Customer Lifetime Value (CLV)**?

---

## Product & Order Insights

- What are the **top 10 most sold products by quantity**?
- What are the **top 10 products by revenue**?
- Which products have the **highest return rate**?
- What is the **return rate by category**?
- What is the **average product price by region**?
- What are the **sales trends for each product category**?

---

## Temporal Trends

- What are the **monthly sales trends over the past year**?
- How does the **Average Order Value (AOV)** change by **month or week**?

---

## Regional Insights

- Which regions have the **highest and lowest order volumes**?
- What is the **revenue per region** and how does it compare across regions?

---

## Return & Refund Insights

- What is the **overall return rate by product category**?
- What is the **overall return rate by region**?
- Which **customers make frequent returns**?

---

## 🛠 Tools Used

- SQL
- GitHub

---

## 📁 Project Structure

```
ecommerce-sales-analysis
│
├── 01-data
│   ├── table_creation.sql
│   ├── insert_into_customers.sql
│   ├── insert_into_orderdetails.sql
│   ├── insert_into_orders.sql
│   └── insert_into_regions.sql
│   |── insert_into_products.sql
|
├── 02-sql_analysis
│   |── customer_insights.sql
|   |── general_sales_insights.sql
|   |── product_order_insights.sql 
|   |── temporal_regional_return_insights.sql
|
|──03-ecommerce_erd.mbw
|
└── README.md
```
---
# Author
- Rajat Pradhan
- email: rajat20pradhan@gmail.com
- linkedin: www.linkedin.com/in/rajat-pradhan-87b5723b6
- **Data Analyst Portfolio Project**
---

⭐ If you find this project useful, consider **starring the repository**.
