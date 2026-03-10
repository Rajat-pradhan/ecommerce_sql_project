-- Customer Insights

-- Q1. Who are the top 10 customers by total revenue spent?
select c.customerid, c.customername, sum(OD.quantity*P.price) as Total_revenue
from customers c
join orders o on o.CustomerID=c.CustomerID
join orderdetails od on od.OrderID=o.OrderID
join products p on p.ProductID=od.ProductID
group by c.CustomerID, c.CustomerName
order by total_revenue desc
limit 10;

-- Q2. What is the repeat customer rate?
select round(count(distinct case when ordercount> 1 then customerid end)/ count(distinct customerid), 2) as repeat_customer_rate
from
(select customerid, count(orderid) as ordercount
from orders
group by CustomerID) t;



-- Q3. What is the average time between two consecutive orders for the same customer Region-wise?
with rankedorders as (
	select o.customerid, o.orderdate, c.regionid,
			row_number() over (partition by o.customerid order by o.orderdate) as rn
	from orders o
	join customers c on c.CustomerID=o.CustomerID
),
orderspair as (
	select curr.customerid, curr.regionid, datediff(curr.orderdate, `prev`.orderdate) as daysbetween
    from rankedorders curr
    join rankedorders `prev` on curr.customerid=`prev`.customerid and curr.rn=`prev`.rn+1
),
region as (
	select customerid, regionname, daysbetween
    from orderspair op
	join regions r on r.RegionID=op.RegionID
)
select regionname, round(avg(daysbetween),2) as avgdays_between_orders
from region
group by regionname
order by avgdays_between_orders;


-- Q4. Customer Segment (based on total spend)
       -- Platinum: Total Spend > 1500
       -- Gold: 1000–1500
       -- Silver: 500–999
       -- Bronze: < 500
with customerspend as (
		select o.customerid, sum(od.quantity*p.price) as totalspend
        from orders o
        join orderdetails od on od.OrderID=o.OrderID
        join products p on p.ProductID=od.ProductID
        group by o.CustomerID
)       
select customername,
		case 
			when totalspend>1500 then "Platinum"
			when totalspend between 1000 and 1500 then "Gold"
            when totalspend between 500 and 1000 then "Silver"
            when totalspend < 500 then "Bronze"
       end as Customer_segment
  from customerspend cs
  join customers c on cs.customerid=c.CustomerID;
       
       
-- Q5. What is the customer lifetime value (CLV)?
select c.customerid, c.customername , sum(od.quantity*p.price) as CLV
from customers c
join orders o on o.CustomerID=c.CustomerID
join orderdetails od on od.OrderID=o.OrderID
join products p on p.ProductID=od.ProductID
group by c.customerid, c.customername
order by clv desc;