-- Product & Order Insights
-- Q1. What are the top 10 most sold products (by quantity)?
select od.productid,p.productname ,sum(od.quantity) as total_quantity
from orderdetails od
join products p on p.productid=od.ProductID
group by od.ProductID
order by total_quantity desc
limit 10;


-- Q2. What are the top 10 most sold products (by revenue)?
select od.productid,p.productname ,sum(od.quantity*p.price) as total_revenue
from orderdetails od
join products p on p.productid=od.ProductID
group by od.ProductID
order by total_revenue desc
limit 10;


-- Q3. Which products have the highest return rate?
SELECT 
    p.productname,
    ROUND(SUM(CASE WHEN o.isreturned = 1 THEN od.quantity ELSE 0 END)/UM(od.quantity),2) AS return_rate
FROM orders o
JOIN orderdetails od ON od.orderid = o.orderid
JOIN products p ON p.productid = od.productid
GROUP BY p.productname
ORDER BY return_rate DESC
LIMIT 10;


-- Q4. Return Rate by Category
with sold as (
	select Category,sum(quantity) as total_quantity
    from orderdetails od
    join products p on p.ProductID=od.ProductID
    group by Category
),
returned as (
	select Category,sum(quantity) as returned_quantity
    from orderdetails od
    join orders o on od.OrderID=o.OrderID
	join products p on p.ProductID=od.ProductID
    where IsReturned=1
    group by Category
)
select s.Category, round((returned_quantity/total_quantity),2) as return_rate
from sold s 
join returned r on r.category=s.category
order by return_rate desc;


-- Q5. What is the average price of products per region?

select regionname, round(sum(od.quantity*p.price)/sum(od.quantity),2) as avg_price
from orders o
join customers c on c.CustomerID=o.CustomerID
join regions r on r.RegionID=c.RegionID
join orderdetails od on od.OrderID=o.OrderID
join products p on od.ProductID=p.ProductID
group by RegionName
order by avg_price desc;

-- Q6. What is the sales trend for each product category?

select date_format(orderdate, "%Y-%m") as period, category, sum(od.quantity*p.price) as revenue
from orders o
join orderdetails od on od.OrderID=o.OrderID
join products p on p.ProductID=od.ProductID
group by period, Category
order by period, Category;
