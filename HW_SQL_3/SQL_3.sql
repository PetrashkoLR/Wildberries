-- удаление таблиц, чтобы не было ошибок при повторном запуске кода --

DROP TABLE IF EXISTS users cascade;
DROP TABLE IF EXISTS items cascade;
DROP TABLE IF EXISTS ratings;


-- создание таблиц --

CREATE TABLE users(
  user_id SERIAL PRIMARY KEY, -- генерация последовательных уникальных номеров id
  user_name VARCHAR(100) NOT NULL, -- новое поле. Хорошо, когда знаешь ФИО человека. Выбрала формат строки с кол-вом символом до 100
  birth_date DATE NOT NULL, -- дата рождения
  sex VARCHAR(6) NOT NULL CHECK(sex = 'male' OR sex = 'female'), -- male/female. Поставила check, чтобы не добавлялось что-то иное в данное поле
  age SMALLINT -- на возраст требуется от 1 до 3 символов, поэтому поставила smallint. Его мы вычислим потом через день рождения
  );
  
CREATE TABLE items(
  item_id SERIAL PRIMARY KEY, -- аналогично user_id
  description VARCHAR(1000) NOT NULL, -- для описания требуются символы. 1000 хватит с лихвой
  price NUMERIC NOT NULL CHEcK(price >= 0), -- numeric для хранения дробных чисел. Разумная проверка на неотрицательность цены
  category VARCHAR(100) NOT NULL -- аналогично description
  );
   
CREATE TABLE ratings(
  item_id INTEGER REFERENCES items, -- связка внешним ключем с primary key в таблице items
  user_id INTEGER REFERENCES users, -- аналогично  
  review VARCHAR(1000), -- аналогично description
  rating SMALLINT NOT NULL CHECK(rating >= 0 AND rating <= 10), -- думаю, удобно выставлять оценку целым числом от 0 до 10
  PRIMARY KEY(user_id, item_id)-- новое поле -- считается, что на конкретный товар конкретный пользователь может оставить лишь 1 отзыв(оценку)
  );
 
--------------------------------------------------------------------------------------------------------------------------------
-- заполнение таблиц --

INSERT INTO users(user_name, birth_date, sex)
  SELECT
    CASE CEIL(random() * 4) -- генерируем случайное число в диапазоне 0 - 4, чтобы под него выбрать нужный вариант имени
    WHEN 0 THEN 'Max'
    WHEN 1 THEN 'Alex'
    WHEN 2 THEN 'Sandy'
    WHEN 3 THEN 'Cory'
    ELSE 'cat'
    END,
    -- генерируем случайную дату рождения в диапазоне последних 50 лет 
    (now() - (random() * (INTERVAL '31 days') - random()*(INTERVAL '12 months') + ABS(random())*(INTERVAL '50 years')))::DATE AS birth_date,
    -- случайный выбор пола
    CASE WHEN random()*10 > 4.5 THEN 'female' ELSE 'male' END AS sex 
  FROM generate_series(1, 20, 1); -- заполнение 20 строк


UPDATE users
  SET age = date_part('year',age(birth_date::date)); -- вычисление возраста user на основе даты его рождения


INSERT INTO items(description, price, category) -- аналогичное заполнение для items
  SELECT
    CASE CEIL(random()*4)
    WHEN 0 THEN 'отличный товар'
    WHEN 1 THEN 'топ 1 в России'
    WHEN 2 THEN 'лидер продаж в 2012 году'
    WHEN 3 THEN 'оценка британских ученых 9 из 10'
    ELSE '*купите пожалуйста кто-нибудь*'
    END,
    ROUND((random()*1000)::NUMERIC, 2) AS price, -- генерирую случайную цену товара с округлением до 2 знаков после запятой
    CASE CEIL(random()*4)
    WHEN 0 THEN 'одежда'
    WHEN 1 THEN 'бытовая химия'
    WHEN 2 THEN 'товары для детей'
    WHEN 3 THEN 'все для дома'
    ELSE 'продукты питания'
    END
  FROM generate_series(1, 20, 1);


INSERT INTO ratings(user_id, item_id, review, rating) -- аналогичное заполнение для ratings
  SELECT
    generate_series,
    generate_series,
    CASE CEIL(random()*4)
    WHEN 0 THEN 'супер'
    WHEN 1 THEN ' все отлично'
    WHEN 2 THEN 'нормальный продавец'
    WHEN 3 THEN 'не рекомендую покупать больше 1 раза'
    ELSE 'хороший товар'
    END,
    ROUND((random()*10)::NUMERIC) AS rating 
  FROM generate_series(1, 20, 1);


--------------------------------------------------------
-- вывод таблиц --

SELECT * FROM ratings; 
SELECT * FROM items;
SELECT * FROM users;

  
 