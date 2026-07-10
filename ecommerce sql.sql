create database ecommerce;
use ecommerce;
select * from data;
select count(*) from data;
select Order_ID,Customer_ID,Revenue from data;
select distinct Region from data;
select distinct Category from data;
select Order_ID,Customer_ID,Payment_Method
from data
where Payment_Method='Card';

select Order_ID,Customer_ID,Region
from data
where Region='North';

select Order_ID,Customer_ID,Revenue
from data
where Revenue>1000;

select Order_ID,Customer_ID,Discount
from data 
where Discount>0.20;

select Order_ID,Customer_ID, Order_Date
from data
where Order_Date>'2023-01-01';

select Order_ID,Customer_ID,Quantity
from data
where Quantity>5;

select Revenue 
from data
order by revenue desc;

select Order_Date 
from data
order by Order_Date asc;

select * from data limit 10;

select * from data 
order by Revenue desc limit 5;

select * 
from data
where Category='Electronics';

select sum(Revenue) as total_revenue from data;
select sum(Quantity) as quantity_sold from data;
select count(distinct Customer_ID)as unique_customers from data;
select avg(Revenue) as avg_revenue from data;
select avg(Discount) as avg_discount from data;
select max(Revenue) as max_revenue from data;

select max(Quantity) as highest_quantity from data;
select min(Quantity) as lowest_quantity from data;

select Region,sum(Revenue) as total_revenue
from data
group by Region
order by total_revenue;

select category,sum(Revenue) as total_revenue
from data
group by Category
order by total_revenue;

select Region,count(Order_ID) as orders
from data
group by Region;

select Payment_Method,count(Order_ID) as orders
from data
group by Payment_Method;

select Payment_Method,sum(Revenue)
from data
group by Payment_Method;

select Region,count(distinct(Customer_ID))
from data 
group by Region;

select Category,sum(Revenue) as revenue
from data
group by Category 
having revenue>50000;

select Customer_ID,sum(Price) as spent
from data
group by Customer_ID
having spent>10000;

select Region,count(Order_ID) as total_order
from data
group by Region
having total_order>100;

select Category,sum(Quantity) as items
from data 
group by Category
having items>500;

select month(Order_Date) as month,
sum(Revenue) as total_revenue
from data
group by month(Order_Date)
order by month(Order_Date);

select year(Order_Date) as year,
sum(Revenue) as total_revenue
from data
group by year(Order_Date)
order by year(Order_Date);

select month(Order_Date),
count(Order_ID) as total_order
from data
group by month(Order_Date)
order by month(Order_Date);

select month(Order_Date) as month,
count(Order_ID) as orders
from data
group by month(Order_Date)
order by orders desc
limit 1;

select day(Order_Date) as day,
count(Order_ID) as orders
from data
group by day(Order_Date) 
order by orders desc
limit 1;

select min(Order_Date) as first_order
from data;

select max(Order_Date) as latest_order
from data;

select Order_ID,Revenue,
CASE 
	WHEN Revenue>1000 then 'High'
    WHEN Revenue>500 then 'Medium'
    else 'Low'
end as revenue_status
from data;

select * from data;

select Order_ID,Discount,
case
	when Discount>0.20 then 'High'
    when Discount>0.10 then'Medium'
    else 'low'
end as discount_status
from data;

select Order_ID,Payment_Method,
case
	when Payment_Method='Card' then 'Offline'
    when Payment_Method='COD' then 'Offline'
    when Payment_Method='Net Banking' then 'Online'
    else 'Online'
end as Payment_Status
from data;

select Order_ID,Revenue from data where Revenue>(
select  avg(Revenue) as avg_revenue from data);

select Category,max(Revenue) as highest_Revenue
from data
group by Category
order by highest_Revenue desc
limit 1;

select Region,min(Revenue) as lowest_revenue
from data
group by Region
order by lowest_revenue 
limit 1;

select * from data;

with total_spending as
(
	select Customer_ID,sum(Revenue) as total
	from data 
	group by Customer_ID
    order by total desc
    limit 10
)
select *
from total_spending;

with highest_revenue as
(
	select Category,max(Revenue) as highest
    from data
    group by Category
    order by highest desc
    limit 1
)
select * 
from highest_revenue;

with monthly_revenue as
(
select month(Order_Date),Revenue
from data)
select * 
from monthly_revenue;

select Order_ID,Revenue,rank() 
over(order by Revenue desc)as revenue_Rank from data;

select Customer_ID,Revenue,dense_rank()
over(order by Revenue desc)as revenue_drnk from data;

select Order_ID,Revenue,row_number()
over(order by Revenue desc) as rn
from data;

select Order_ID,Revenue,lag(Revenue) 
over (order by Revenue) as previous_revenue from data;

select Order_ID,Revenue,lead(Revenue)
over (order by Revenue) as next_revenue from data;

select Order_Date,Revenue,sum(Revenue)
over(order by Order_Date desc) as running_total from data;