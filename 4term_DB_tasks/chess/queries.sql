--1
SELECT COUNT(*) FROM board;

--2
SELECT fid FROM figures WHERE ftype LIKE 'K%';

--3
SELECT COUNT(*) FROM figures GROUP BY ftype;

--4
SELECT ftype, fcolor, board.fid FROM board 
	JOIN figures ON figures.fid = board.fid WHERE 
	ftype = 'Pawn'AND fcolor = 'White';

--5
SELECT ftype, fcolor FROM board JOIN figures ON figures.fid = board.fid 
	WHERE (x,y) = ('A', 8) OR (x,y) = ('B', 7) OR (x,y) = ('C', 6)
	OR (x,y) = ('D', 5) OR (x,y) = ('E', 4) OR (x,y) = ('F', 3)
	OR (x,y) = ('G', 2) OR (x,y) = ('H', 1);

--6	
SELECT COUNT(*), fcolor FROM figures JOIN board ON figures.fid = board.fid
	GROUP BY fcolor;

--7
SELECT ftype, fcolor FROM figures JOIN board ON figures.fid = board.fid
	WHERE fcolor = 'Black';

--8
SELECT COUNT(*), ftype, fcolor FROM figures JOIN board ON figures.fid = board.fid
	WHERE fcolor = 'Black' GROUP BY ftype, fcolor;

--9
SELECT COUNT(*), ftype FROM figures JOIN board ON figures.fid = board.fid 
	GROUP BY ftype HAVING COUNT(*) >= 2;

--10
SELECT fcolor FROM figures JOIN board ON figures.fid = board.fid
	GROUP BY fcolor ORDER BY COUNT(*) LIMIT 1;

--11
DROP TABLE IF EXISTS rockCoords;

CREATE TABLE rockCoords AS
	SELECT x, y FROM figures JOIN board ON
	figures.fid = board.fid
	WHERE ftype = 'Rock' 
	GROUP BY ftype, x, y;

SELECT ftype, fcolor FROM rockCoords, figures JOIN board ON figures.fid = board.fid
	WHERE board.x = rockCoords.x OR board.y = rockCoords.y
	GROUP BY ftype, fcolor;

--12
SELECT fcolor FROM figures JOIN board ON figures.fid = board.fid
	GROUP BY fcolor HAVING COUNT('Pawn') = 8;

--13
DROP TABLE IF EXISTS board1, board2;

CREATE TABLE board1 AS TABLE board;

CREATE TABLE board2 AS 
SELECT fid, x, y FROM board LIMIT 31;

SELECT board1.fid FROM board1 FULL OUTER JOIN board2 USING (fid, x, y)
	WHERE board2.x IS NULL OR board2.y IS NULL
	OR board2.x != board1.x OR board2.y != board1.y;

--14
DROP TABLE IF EXISTS bKing_coords;

CREATE TABLE bKing_coords AS
	SELECT x, y FROM board JOIN figures ON 
	figures.fid = board.fid WHERE
		ftype = 'King' AND fcolor = 'Black'
	GROUP BY x, y;
	
SELECT board.fid FROM bKing_coords, board JOIN figures ON
	figures.fid = board.fid
	WHERE ABS(ASCII(bKing_coords.x) - ASCII(board.x)) < 2 
	AND ABS(bKing_coords.y - board.y) < 2 AND fcolor = 'White'
	GROUP BY board.fid;

--15
DROP TABLE IF EXISTS wKing_coords, bufferTable; 

CREATE TABLE wKing_coords AS
	SELECT x, y FROM board JOIN figures ON 
	figures.fid = board.fid WHERE
		ftype = 'King' AND fcolor = 'White'
	GROUP BY x, y;

CREATE TABLE bufferTable AS 
	SELECT ftype, fcolor FROM wKing_coords, board JOIN figures ON
	figures.fid = board.fid
	GROUP BY ftype, fcolor, board.x, board.y, 
		wKing_coords.x, wKing_coords.y ORDER BY 
	ABS(ASCII(wKing_coords.x) - ASCII(board.x)) 
	+ ABS(wKing_coords.y - board.y) 
	LIMIT 2;

SELECT * FROM bufferTable 
	WHERE ftype != 'King'
	GROUP BY ftype, fcolor;