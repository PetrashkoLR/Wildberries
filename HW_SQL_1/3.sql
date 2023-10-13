SELECT users.id, first_name, last_name FROM users
JOIN orders ON orders.user_id = users.id 
WHERE TO_DATE(orders._order_date, 'DD/MM/YYYY') >= '2022-09-01' 
AND TO_DATE(orders._order_date, 'DD/MM/YYYY') <= '2022-11-30' 
AND orders.status = 'create_order'