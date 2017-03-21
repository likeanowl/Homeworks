DROP TABLE IF EXISTS figures, board;

CREATE TABLE figures (
	fid int PRIMARY KEY,
	fcolor TEXT CHECK (fcolor IN ('Black', 'White')),
	ftype TEXT CHECK (ftype IN ('King', 'Queen',
		'Rock', 'Bishop', 'Knight', 'Pawn'))
);

CREATE TABLE board (
	fid int PRIMARY KEY,
	x char,
	CHECK (x IN ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H')),
	y int,
	CHECK (y IN (1, 2, 3, 4, 5, 6, 7, 8)),
	unique (x,y)
);
