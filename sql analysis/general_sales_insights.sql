#General Sales Insights

# Q1. What is the total revenue generated over the entire period?
select sum(OD.quantity* P.price) as Total_revenue
from orderdetails OD
join products p on OD.productid=P.productid;


# Q2. Revenue Excluding Returned Orders
select sum(OD.quantity* P.price) as Revenue_excluding_return
from orders O
join orderdetails OD on OD.OrderID=O.OrderID
join products p on OD.productid=P.productid
where o.isreturned=false;

# Q3. Total Revenue per Year / Month
select year(OrderDate) as `Year`,
	   month(OrderDate) as `Month`,
       sum(OD.quantity* P.price) as Monthly_revenue
from orders O
join orderdetails OD on O.OrderID=OD.OrderID
join products P on P.ProductID=OD.ProductID
group by `Year`, `Month`
order by `Year`, `Month`;

# Q4. Revenue by Product / Category
select ProductName , Category, sum(Od.quantity*P.Price) as Revenue_by_products
from orderdetails OD 
join products P on P.ProductID=OD.ProductID
group by ProductName, Category
order by Category, Revenue_by_products desc;


# Q5. What is the average order value (AOV) across all orders?
select avg(Total_order_value) as average_order_value
from
     (select o.OrderId, sum(OD.quantity*P.Price) as Total_order_value
      from orders  o
      join orderdetails OD on o.OrderID=OD.OrderID
	  join products p on p.ProductID=OD.ProductID
      group by o.OrderID) t;

# Q6. AOV per Year / Month
select year(orderdate) as `year`,
       month(orderdate) as `month`,
       avg(Total_order_value) as average_order_value
from
     (select o.OrderId,o.OrderDate, sum(OD.quantity*P.Price) as Total_order_value
      from orders  o
      join orderdetails OD on o.OrderID=OD.OrderID
	  join products p on p.ProductID=OD.ProductID
      group by o.OrderID) t
      group by `year`, `month`
      order by `year`, `month`;

# Q7. What is the average order size by region?
select regionname, avg(total_order_size) as average_order_size
from
(select o.orderid, c.regionid, sum(od.quantity) as total_order_size
from orders o
join customers c on c.CustomerID=o.CustomerID
join orderdetails od on od.OrderID=o.OrderID
group by o.orderid, c.RegionID) t
join regions r on r.RegionID=t.regionid
group by RegionName
order by average_order_size desc;
