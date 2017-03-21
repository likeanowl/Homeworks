DROP TABLE IF EXISTS descr_and_type, used_and_descr;

CREATE TABLE descr_and_type AS 
	SELECT mark, model, power, complectation, price_of_new,
		year_of_release, a_type, cars_descr.id
		FROM cars_descr JOIN auto_type ON
		cars_descr.id = auto_type.id;

CREATE TABLE used_and_descr AS
	SELECT count_of_owners, price_of_used, state, mark, model,
		power, complectation, price_of_new, year_of_release, used_cars.id 
		FROM used_cars JOIN cars_descr ON
		cars_descr.id = used_cars.id;

--1

SELECT mark, model FROM descr_and_type WHERE
	a_type = 'Sport car';

--2
SELECT * FROM used_and_descr WHERE
	year_of_release = 2008;

--3
SELECT mark FROM cars_descr WHERE year_of_release = 2007;

--4
DROP TABLE IF EXISTS luxury, off_roaders;
CREATE TABLE luxury AS
	SELECT mark FROM descr_and_type 
		WHERE a_type = 'Luxory';
CREATE TABLE off_roaders AS
	SELECT mark FROM descr_and_type 
		WHERE a_type = 'Off Roader';
SELECT luxury.mark FROM luxury JOIN off_roaders ON
	luxury.mark = off_roaders.mark;

--5
SELECT cs_name, COUNT(*) FROM cars_descr JOIN car_showroom ON
	cars_descr.id = car_showroom.id
	GROUP BY cs_name HAVING
	COUNT(DISTINCT mark) >= 3;

--6
SELECT mark, model FROM cars_descr used_cars 
WHERE  NOT EXISTS (
   SELECT * FROM cars_descr, used_cars
   WHERE cars_descr.id = used_cars.id
   );

--7
SELECT mark, price_of_new, price_of_used FROM
	cars_descr JOIN used_cars ON 
		cars_descr.id = used_cars.id
	WHERE CAST (price_of_used AS FLOAT) / price_of_new < 0.8;

--8
CREATE TABLE cheaper_than_30 AS
SELECT price, cs_name, cars_descr.id FROM car_showroom JOIN cars_descr ON
	car_showroom.id = cars_descr.id WHERE
	price < 30000;

SELECT price, cs_name FROM cheaper_than_30 JOIN auto_type ON
	auto_type.id = cheaper_than_30.id WHERE
	a_type = 'Off Roader' ORDER BY price LIMIT 1;

--9
(SELECT a_type, COUNT(model), AVG(price_of_new) FROM descr_and_type WHERE
	a_type = 'Off Roader'
	GROUP BY a_type LIMIT 1)
UNION
(SELECT a_type, COUNT(model), AVG(price_of_new) FROM descr_and_type WHERE
	a_type = 'Sport Car' 
	GROUP BY a_type LIMIT 1)
UNION
(SELECT a_type, COUNT(model), AVG(price_of_new) FROM descr_and_type WHERE
	a_type = 'Luxory' 
	GROUP BY a_type LIMIT 1)
ORDER BY 3;

--10
DROP TABLE IF EXISTS max_price, min_price;

CREATE TABLE max_price AS
SELECT price_of_new, model FROM cars_descr WHERE
	complectation = 'Max';
	
CREATE TABLE min_price AS
SELECT price_of_new, model FROM cars_descr WHERE
	complectation = 'Min';

SELECT max_price.model FROM max_price JOIN min_price ON
	max_price.model = min_price.model WHERE
		CAST (max_price.price_of_new AS FLOAT) / min_price.price_of_new >= 2;
--11
DROP TABLE IF EXISTS off_roaders;
CREATE TABLE off_roaders AS
	SELECT mark FROM descr_and_type 
		WHERE a_type = 'Off Roader';
SELECT DISTINCT off_roaders.mark FROM off_roaders JOIN descr_and_type ON
	descr_and_type.mark = off_roaders.mark WHERE
	a_type != 'Sport Car';

--12
DROP TABLE IF EXISTS toyota;
CREATE TABLE toyota AS
	SELECT CAST(COUNT(*) AS FLOAT) / (SELECT COUNT(*) FROM used_and_descr) 
	FROM used_and_descr WHERE
	mark = 'Toyota';
	

--13
(SELECT mark, model, a_type FROM descr_and_type JOIN used_cars ON
	descr_and_type.id = used_cars.id WHERE
	a_type = 'Off Roader' 
	GROUP BY mark, model, a_type
	ORDER BY COUNT(*) LIMIT 1)
UNION
(SELECT mark, model, a_type FROM descr_and_type JOIN used_cars ON
	descr_and_type.id = used_cars.id WHERE
	a_type = 'Sport Car' 
	GROUP BY mark, model, a_type
	ORDER BY COUNT(*) LIMIT 1)
UNION
(SELECT mark, model, a_type FROM descr_and_type JOIN used_cars ON
	descr_and_type.id = used_cars.id WHERE
	a_type = 'Luxory' 
	GROUP BY mark, model, a_type
	ORDER BY COUNT(*) LIMIT 1);