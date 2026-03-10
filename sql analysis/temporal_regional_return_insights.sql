-- Temporal Trends
-- Q1. What are the monthly sales trends over the past year?
select year(orderdate) as `Year`,
		month(orderdate) as `month`,
        sum(od.quantity*p.price) as Revenue
from orders o
join orderdetails od on od.OrderID=o.OrderID
join products p on p.ProductID=od.ProductID
where OrderDate >= current_date()- interval 12 month
group by `Year`,`month`
order by `Year`,`month`;

-- Q2. How does the average order value (AOV) change by month or week?

select date_format(orderdate, "%Y-%m")as period, round(sum(od.quantity*p.price)/ count(distinct o.orderid),2) as AOV
from orders o
join orderdetails od on od.OrderID=o.OrderID
join products p on p.ProductID=od.ProductID
group by period
order by period ;

-- Regional Insights
-- Q3. Which regions have the highest order volume and which have the lowest?
select regionname, count(orderid) as order_volume
from orders o 
join customers c on c.CustomerID=o.CustomerID
join regions r on r.RegionID=c.RegionID
group by RegionName
order by order_volume desc;


-- Q4. What is the revenue per region and how does it compare across different regions?
select regionname, sum(od.quantity*p.price) as revenue
from orders o 
join orderdetails od on od.OrderID=o.OrderID
join products p on p.ProductID=od.ProductID
join customers c on c.CustomerID=o.CustomerID
join regions r on r.RegionID=c.RegionID
group by RegionName
order by revenue;

-- Return & Refund Insights
-- Q5. What is the overall return rate by product category?
SELECT 
    p.category,
    ROUND(SUM(CASE WHEN o.isreturned = 1 THEN od.quantity ELSE 0 END)/SUM(od.quantity),2) AS return_rate
FROM orders o
JOIN orderdetails od ON od.orderid = o.orderid
JOIN products p ON p.productid = od.productid
GROUP BY p.Category
ORDER BY return_rate DESC;

-- Q6. What is the overall return rate by region?
select regionname, 
		ROUND(SUM(CASE WHEN o.isreturned = 1 THEN od.quantity ELSE 0 END)/SUM(od.quantity),2) AS return_rate
FROM orders o
join customers c on c.CustomerID=o.CustomerID
JOIN orderdetails od ON od.orderid = o.orderid
JOIN products p ON p.productid = od.productid
join regions r on r.RegionID=c.RegionID
GROUP BY regionname
ORDER BY return_rate DESC;	


-- Q7. Which customers are making frequent returns?
select c.customerid, c.customername, count(distinct o.orderid) as returncount
from orders o
join customers c on c.CustomerID=o.CustomerID
where o.IsReturned=1
group by c.CustomerID, c.CustomerName
order by returncount desc
limit 10;
