/* 4.Для каждого из неуспешных продавцов (из предыдущего задания) посчитайте, сколько полных месяцев прошло с даты регистрации продавца. 
    Отсчитывайте от того времени, когда вы выполняете задание. Считайте, что в месяце 30 дней. Например, для 61 дня полных месяцев будет 2. 
    Также выведите разницу между максимальным и минимальным сроком доставки среди неуспешных продавцов. 
    Это число должно быть одинаковым для всех неуспешных продавцов.
    Назовите поля: `seller_id`, `month_from_registration` ,`max_delivery_difference`.Выведите ответ по возрастанию id селлера.
    *Примечание*: Категория “Bedding” по-прежнему не должна учитываться в расчетах. */

-- нужно для подсчета разницы максимальной и минимальной длительности доставки
WITH max_days_poor_delivery AS
  (SELECT MAX(delivery_days) AS maxi FROM sellers
  WHERE category != 'Bedding'
  GROup by seller_id
  HAVING COUNT(category) > 1 AND sum(revenue)<=50000), 
min_days_poor_delivery AS
  (SELECT MIN(delivery_days) AS mini FROM sellers
  WHERE category != 'Bedding'
  GROup by seller_id
  HAVING COUNT(category) > 1 AND sum(revenue)<=50000)


select 
  seller_id,
  -- я решила, что датой регистрации продавца можно считать дату, когда он зарегистрировался в своей первой категории => min()
  -- ниже следующая конструкция: из сегодняшней даты вычитаю дату первой регистрации (приведя ее к вычисляемому типу) и делю на 30, чтобы вычислить кол-во месяцев
  (NOW()::date - MIN(to_date(date_reg, 'DD MM YYYY')))/30 AS month_from_registration,
  -- по заданию я поняла, что нужно по выборке из Всех poor sellers найти максимальное и минимальное время доставки. В таком случае всем можно присвоить разницу данных значений
  ((SELECT MAX(maxi) FROM max_days_poor_delivery) - (SELECT MIN(mini) FROM min_days_poor_delivery)) AS max_delivery_difference
from sellers
WHERE category != 'Bedding'
GROup by seller_id
HAVING COUNT(category) > 1 AND sum(revenue)<=50000
Order by seller_id;


