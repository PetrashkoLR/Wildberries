/*ALTER TABLE orders DROP COLUMN discount; 
ALTER TABLE orders DROP COLUMN new_price;*/

ALTER TABLE orders ADD COLUMN discount INTEGER DEFAULT 0;
ALTER TABLE orders ADD COLUMN new_price REAL DEFAULT 0;
UPDATE orders
	   SET new_price = price;
UPDATE orders
	   SET new_price = price*0.9, discount = 10
       WHERE price = (SELECT MAX(price) FROM orders);
       
SELECT * FROM orders
ORDER BY price DESC;