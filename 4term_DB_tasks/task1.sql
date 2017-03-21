drop table if exists task1;

create table task1 (
	gender char(1) check(gender in ('F', 'M')),
	tall int,
	id int primary key
);

delete from task1;


insert into task1 (gender, tall, id) values
	('M', 185, 1);
insert into task1 (gender, tall, id) values
	('F', 163, 2);	
insert into task1 (gender, tall, id) values
	('F', 186, 3);
insert into task1 (gender, tall, id) values
	('M', 175, 4);
insert into task1 (gender, tall, id) values
	('M', 195, 5);
insert into task1 (gender, tall, id) values
	('F', 161, 6);


select * from task1 as a join task1 as b on
	((a.gender = 'M') and (b.gender = 'F') and (a.tall > b.tall));