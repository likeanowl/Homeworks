DROP TABLE IF EXISTS cars_descr, used_cars, colors, auto_type, car_showroom;

CREATE TABLE cars_descr(
	mark text,
	model text,
	power int,
	complectation text,
	price_of_new int,
	year_of_release int,
	id int
);

CREATE TABLE colors(
	color text,
	id int
);

CREATE TABLE auto_type(
	a_type text,
	id int
);

CREATE TABLE used_cars(
	count_of_owners int,
	price_of_used int,
	state text,
	id int
);

CREATE TABLE car_showroom(
	id int,
	price int,
	used boolean,
	cs_name text
);