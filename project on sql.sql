-- 1.Retrieve the total number of order placed.

select * from orders;
select count(order_id) as total_orders from orders;

-- 2.calculate the total revenue generated from pizza sales.

select
sum(order_details.quantity * pizzas.price) as total_sales
from order_details join pizzas
on pizzas.pizza_id = order_details.pizza_id;

-- 3. identify the highest-priced pizza.

select pizza_types.name, pizzas.price
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
order by pizzas.price desc limit 1;


-- 4.Identify the most common pizza size ordered.

select pizzas.size,count(order_details.order_details_id) as order_count
from pizzas join order_details
on pizzas.pizza_id = order_details.pizza_id
group by pizzas.size order by order_count desc;





-- 5.list the top 5 most ordered pizza types along with their quantities.

select pizza_types.name,
sum(order_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id= pizzas.pizza_id
group by pizza_types.name order by quantity desc;



-- 6.Join the necessary tables to find the total quantity of each pizza category ordered.


SELECT pizza_types.category,
sum(order_details.quantity)as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id= pizzas.pizza_type_id
join order_details
on order_details.pizza_id= pizzas.pizza_id
GROUP BY pizza_types.category order by quantity desc;



-- 7.determine the distrubtion of orders by hour of the day

select hour(order_time) as hour, count(order_id) as order_count from orders 
group by hour(order_time);



-- 8. join relevant tables to find the category wise distribution of pizzas.

select category ,count(name) from pizza_types
group by category;


-- 9. group the orders by date and calculate the average number of pizzas ordered per day.

select avg(quantity) from 
(select orders.order_date, sum(order_details.quantity) as quantity
from orders join order_details
on orders.order_id = order_details.order_id
group by orders.order_date) as order_quantity;


-- 10. determine the top 3 most ordered pizza types based on revenue 


select pizza_types.name,
order_details.quantity * pizzas.price as revenue
from pizza_types join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by revenue desc limit 3;

