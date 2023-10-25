/* 2. Рассчитайте среднюю цену категорий товаров в таблице products, в названиях товаров которых присутствуют слова «hair» или «home».
      Среднюю цену округлите до двух знаков после запятой. Столбец с полученным значением назовите avg_price.*/

SELECT 
  ROUND(AVG(price)::numeric, 2) AS avg_price, 
  category 
from products
where name like ('%Home%') OR name like ('%Hair%') OR name like ('%hair%') OR name like ('%home%')
group by category;

