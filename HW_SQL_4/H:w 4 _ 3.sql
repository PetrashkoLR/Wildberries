/* 3. Назовем “успешными” (’rich’) селлерами тех:
    - кто продает более одной категории товаров
    - и чья суммарная выручка превышает 50 000
    Остальные селлеры (продают более одной категории, но чья суммарная выручка менее 50 000) будут обозначаться как ‘poor’.
    Выведите для каждого продавца количество категорий, средний рейтинг его категорий, суммарную выручку, а также метку ‘poor’ или ‘rich’.
    Назовите поля: `seller_id`, `total_categ`, `avg_rating`, `total_revenue`, `seller_type`.Выведите ответ по возрастанию id селлера.
    *Примечание*: Категория “Bedding” не должна учитываться в расчетах.*/

select 
  seller_id, 
  COUNT(category) AS total_categ, 
  ROUND(AVG(rating)::numeric,2) AS avg_rating, 
  TO_CHAR(SUM(revenue), '99G999G990') AS total_revenue,
  case 
    when sum(revenue) <= 50000 THEN 'poor' -- при таком определении poor вылетают данные о тех продавцах, у которых меньше 2 категорий
    else 'rich'
    end AS seller_type
from sellers
WHERE category != 'Bedding'
GROup by seller_id
HAVING COUNT(category) > 1
Order by seller_id;

