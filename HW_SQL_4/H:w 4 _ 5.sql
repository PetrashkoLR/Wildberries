/* 5.Отберите продавцов, продающих ровно 2 категории товаров с суммарной выручкой за 2022 год, превышающей 75 000.
     Выведите seller_id данных продавцов, а также столбец `category_pair` с наименованиями категорий, которые продают данные селлеры.
     Например, если селлер продает товары категорий “Game”, “Fitness”, то для него необходимо вывести пару категорий `category_pair` с разделителем “-” в алфавитном порядке (т.е. “Game - Fitness”).
     Поля в результирующей таблице: `seller_id`,  `category_pair`*/


SELECT 
  seller_id, 
  STRING_AGG(category,'-' ORDER BY category) AS category_pair 
FROM sellers
WHERE EXTRACT(YEAR FROM (to_date(date, 'DD MM YYYY'))) = 2022
GROUP BY seller_id
HAVING COUNT(category) = 2 AND SUM(revenue) > 75000
ORDER BY seller_id;

