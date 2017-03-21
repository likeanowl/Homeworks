DROP TABLE IF EXISTS answ;

CREATE TABLE answ(
	atype text,
	highest_price int,
	m1 text,
	mo1 text,
	lowest_price int,
	m2 text,
	mo2 text
);

DROP FUNCTION max_min();

CREATE OR REPLACE FUNCTION max_min() RETURNS 
	TABLE(atype text, highest_price int, m1 text, mo1 text,
		lowest_price int, m2 text, mo2 text) AS $$
	DECLARE p int; m text; mo text; lp int; lm text; lmo text;
	BEGIN	
		p := 0; lp := 0;
		SELECT MAX(price_of_new) INTO p FROM descr_and_type WHERE
			a_type = 'Sport Car';
			
		SELECT mark, model into m, mo FROM
			descr_and_type WHERE
				a_type = 'Sport Car' AND price_of_new = p
			GROUP BY 1, 2;
				
		IF EXISTS (SELECT price_of_used FROM descr_and_type JOIN used_cars ON
			descr_and_type.id = used_cars.id WHERE
				a_type = 'Sport Car') THEN
					SELECT MIN(price_of_used) INTO lp FROM descr_and_type JOIN used_cars ON
						descr_and_type.id = used_cars.id WHERE
							a_type = 'Sport Car';
							
					SELECT mark, model INTO lm, lmo FROM
						descr_and_type JOIN used_cars ON 
						descr_and_type.id = used_cars.id WHERE 
							a_type = 'Sport Car' AND price_of_used = lp
						GROUP BY 1, 2;

		ELSE
			SELECT MIN(price_of_new) INTO lp FROM descr_and_type WHERE
				a_type = 'Sport Car';
				
			SELECT mark, model INTO lm, lmo FROM
				descr_and_type WHERE 
					a_type = 'Sport Car' AND price_of_new = lp;	
		END IF;
		
		INSERT INTO answ (atype, highest_price, m1, mo1,
				  lowest_price, m2, mo2) VALUES
		('Sport Car', p, m, mo, lp, lm, lmo);


		p := 0; lp := 0;
		SELECT MAX(price_of_new) INTO p FROM descr_and_type WHERE
			a_type = 'Luxory';
			
		SELECT mark, model into m, mo FROM
			descr_and_type WHERE
				a_type = 'Luxory' AND price_of_new = p
			GROUP BY 1, 2;
				
		IF EXISTS (SELECT price_of_used FROM descr_and_type JOIN used_cars ON
			descr_and_type.id = used_cars.id WHERE
				a_type = 'Luxory') THEN
					SELECT MIN(price_of_used) INTO lp FROM descr_and_type JOIN used_cars ON
						descr_and_type.id = used_cars.id WHERE
							a_type = 'Luxory';
							
					SELECT mark, model INTO lm, lmo FROM
						descr_and_type JOIN used_cars ON 
						descr_and_type.id = used_cars.id WHERE 
							a_type = 'Luxory' AND price_of_used = lp
						GROUP BY 1, 2;

		ELSE
			SELECT MIN(price_of_new) INTO lp FROM descr_and_type WHERE
				a_type = 'Luxory';
				
			SELECT mark, model INTO lm, lmo FROM
				descr_and_type WHERE 
					a_type = 'Luxory' AND price_of_new = lp;	
		END IF;
		
		INSERT INTO answ (atype, highest_price, m1, mo1,
				  lowest_price, m2, mo2) VALUES
		('Luxory', p, m, mo, lp, lm, lmo);

		p := 0; lp := 0;
		SELECT MAX(price_of_new) INTO p FROM descr_and_type WHERE
			a_type = 'Off Roader';
			
		SELECT mark, model into m, mo FROM
			descr_and_type WHERE
				a_type = 'Off Roader' AND price_of_new = p
			GROUP BY 1, 2;
				
		IF EXISTS (SELECT price_of_used FROM descr_and_type JOIN used_cars ON
			descr_and_type.id = used_cars.id WHERE
				a_type = 'Off Roader') THEN
					SELECT MIN(price_of_used) INTO lp FROM descr_and_type JOIN used_cars ON
						descr_and_type.id = used_cars.id WHERE
							a_type = 'Off Roader';
							
					SELECT mark, model INTO lm, lmo FROM
						descr_and_type JOIN used_cars ON 
						descr_and_type.id = used_cars.id WHERE 
							a_type = 'Off Roader' AND price_of_used = lp
						GROUP BY 1, 2;

		ELSE
			SELECT MIN(price_of_new) INTO lp FROM descr_and_type WHERE
				a_type = 'Off Roader';
				
			SELECT mark, model INTO lm, lmo FROM
				descr_and_type WHERE 
					a_type = 'Off Roader' AND price_of_new = lp;	
		END IF;
		
		INSERT INTO answ (atype, highest_price, m1, mo1,
				  lowest_price, m2, mo2) VALUES
		('Off Roader', p, m, mo, lp, lm, lmo);
		
		RETURN QUERY 
			SELECT * FROM answ;
	END;
$$LANGUAGE plpgsql;

DROP FUNCTION dynamics(text);

CREATE OR REPLACE FUNCTION dynamics(c_mark text) RETURNS 
	TABLE(u_model text, metric float) AS $$
DECLARE _mark text;
	BEGIN
		DROP TABLE IF EXISTS used_m;
		
		CREATE TABLE used_m AS
			SELECT DISTINCT cars_descr.model FROM used_cars JOIN cars_descr ON
				used_cars.id = cars_descr.id WHERE
				mark = c_mark;

		RETURN QUERY
			SELECT DISTINCT used_m.model, helper(used_m.model) FROM used_m;
	END;
$$LANGUAGE plpgsql;

DROP FUNCTION helper(text);

CREATE OR REPLACE FUNCTION helper(_model text) RETURNS
	float AS $$
DECLARE new_price integer; used_price integer; year_new integer; year_old integer; years integer;
	BEGIN
		SELECT price_of_used, year_of_release INTO
		used_price, year_old FROM used_cars 
		JOIN cars_descr ON
			used_cars.id = cars_descr.id WHERE
				model = _model
			ORDER BY price_of_used LIMIT 1;
			
		SELECT price_of_new, year_of_release INTO
		new_price, year_new FROM cars_descr
		WHERE model = _model ORDER BY price_of_new LIMIT 1;
		IF year_new - year_old = 0 THEN
			years = 1;
		ELSE
			years = year_new - year_old;
		END IF;
		RETURN CAST (1 - (CAST ((new_price - used_price) AS FLOAT) / (years)) / new_price AS numeric(37, 2));
	END;
$$LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION priceChange() RETURNS trigger AS $$
DECLARE mod text; new_id int;
BEGIN
	SELECT id INTO new_id FROM NEW WHERE
		id NOT IN (SELECT id FROM OLD);

	SELECT model INTO mod FROM NEW WHERE
		id = new_id;

	DROP TABLE IF EXISTS ids;
	
	CREATE TABLE ids AS
	SELECT used_cars.id FROM cars_descr JOIN used_cars ON
		cars_descr.id = used_cars.id 
		WHERE model = mod;

	UPDATE used_cars SET price_of_used = price_of_used / 100 * 95
		WHERE used_cars.id IN (SELECT id FROM ids);
		
	RETURN NEW;	
END;
$$ LANGUAGE plpgsql; 

DROP TRIGGER priceChange ON cars_descr;

CREATE TRIGGER priceChange
	AFTER UPDATE
	ON cars_descr
	FOR EACH ROW
	EXECUTE PROCEDURE priceChange();
--test

SELECT DISTINCT * FROM max_min();

DELETE FROM answ;

SELECT * FROM helper('RAV4');

DROP TABLE IF EXISTS marks;

CREATE TABLE marks AS 
	SELECT DISTINCT mark FROM used_cars JOIN cars_descr ON
		used_cars.id = cars_descr.id WHERE
			used_cars.id = cars_descr.id;

SELECT mark, dynamics(mark) FROM marks;

SELECT * FROM dynamics('Toyota');

SELECT * FROM used_cars;

SELECT * FROM cars_descr;

INSERT INTO cars_descr VALUES
	('Toyota', 'RAV4', 200, 'Max', 35000, 2013, 10);

SELECT * FROM cars_descr;

SELECT * FROM used_cars;