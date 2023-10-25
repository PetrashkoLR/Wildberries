/* 1. Для каждого города выведите число покупателей из соответствующей таблицы,
      сгруппированных по возрастным категориям и отсортированных по убыванию количества покупателей в каждой категории.
      
      Примечание: под возрастной категорией подразумевается возраст человека в полных годах (например, 21, 35, 65 и т.д.).
      Можете дополнительно написать запрос именно для “категорий”: от 0 до 20 (категория young), от 21 до 49 (категория adult),
      от 50 и выше (категория old) */


SELECT 
  city, 
  age AS age_group, 
  COUNT(*) AS number_in_age_group 
FROM users
GROUP BY city, age
Order by city, age_group DESC;

SELECT 
  city,
  SUM(CASE WHEN age >= 0 AND age < 21 THEN 1 ELSE 0 END) AS young,
  SUM(CASE WHEN age >= 21 AND age < 50 THEN 1 ELSE 0 END) AS adult,
  SUM(CASE WHEN age >= 50 THEN 1 ELSE 0 END) AS old_
FROM users
GROUP BY city
ORDER by city;

