--1

DROP FUNCTION IF EXISTS countpawnmoves(integer);

CREATE OR REPLACE FUNCTION countPawnMoves(id integer) RETURNS integer AS $$
DECLARE
count integer; pX text; pY integer; color text; count2 integer;
BEGIN
        SELECT x INTO pX FROM board JOIN figures ON board.fid = figures.fid 
		WHERE board.fid = id;
	SELECT y INTO pY FROM board JOIN figures ON board.fid = figures.fid 
		WHERE board.fid = id;
	SELECT fcolor INTO color FROM board JOIN figures ON board.fid = figures.fid 
		WHERE board.fid = id;
	IF color = 'White' THEN
		SELECT COUNT(*) INTO count FROM board JOIN figures ON board.fid = figures.fid WHERE
			(board.y - pY = 1 OR board.y - pY = 2);
		SELECT COUNT(*) INTO count2 FROM board JOIN figures ON board.fid = figures.fid WHERE
			(board.y - pY = 1 AND ABS(ASCII(board.x) - ASCII(pX)) = 1 AND figures.fcolor = 'Black');
	ELSE
		SELECT COUNT(*) INTO count FROM board JOIN figures ON board.fid = figures.fid 
			WHERE (pY - board.y = 1 OR pY - board.y = 2);
		SELECT COUNT(*) INTO count2 FROM board JOIN figures ON board.fid = figures.fid 
			WHERE (pY - board.y = 1 AND ABS(ASCII(board.x) - ASCII(pX)) = 1 AND figures.fcolor = 'White');
	END IF;
	RETURN 2 - count + count2;	
END;
$$ LANGUAGE plpgsql;


--2

DROP FUNCTION IF EXISTS tableFunction(integer);

CREATE OR REPLACE FUNCTION tableFunction(id integer)
RETURNS TABLE(figtype text, figid integer, figcolor text) AS $$
DECLARE 
kX text; kY integer; color text;
BEGIN
	SELECT x, y, fcolor INTO kX, kY, color 
	FROM board JOIN figures ON 
	board.fid = figures.fid WHERE board.fid = id;
	RETURN QUERY
	SELECT ftype, board.fid, fcolor FROM board JOIN figures ON board.fid = figures.fid
	WHERE (color = 'White'AND fcolor = 'Black' 
		AND (ASCII(board.x) - ASCII(kX)) ^ 2 + (board.y - kY) ^ 2 = 5)
		OR (color = 'Black' AND fcolor = 'White' 
		AND (ASCII(board.x) - ASCII(kX)) ^ 2 + (board.y - kY) ^ 2 = 5);
END;
$$ LANGUAGE plpgsql;

--3

DROP TABLE IF EXISTS deletedFigures;

CREATE TABLE deletedFigures(
	fid int PRIMARY KEY,
	x char,
	y int
);

DROP FUNCTION IF EXISTS makeKnightMove(id integer, pX char, pY integer);

CREATE OR REPLACE FUNCTION makeKnightMove(id integer, pX text, pY integer) RETURNS integer AS $$
DECLARE kX char; kY integer; color text; figColor text;
BEGIN
	SELECT board.x, board.y, figures.fcolor INTO kX, kY, color 
	FROM board JOIN figures ON
	board.fid = figures.fid WHERE board.fid = id AND figures.ftype = 'Knight'; 
	IF NOT FOUND OR ASCII(pX) < ASCII('A') OR ASCII(pX) > ASCII('H') OR pY > 8 OR pY < 1 OR
		(ASCII(pX) - ASCII(kX)) ^ 2 + (pY - kY) ^ 2 <> 5 THEN 
			RETURN 0;
	ELSE
		SELECT fcolor INTO figColor FROM board JOIN figures 
		ON board.fid = figures.fid
			WHERE board.x = pX AND board.y = pY;	
		IF NOT FOUND THEN
			UPDATE board SET x = pX, y = pY WHERE fid = id;
			RETURN 1;
		ELSIF figColor = 'Black' THEN
			IF color = 'White' THEN
				INSERT INTO deletedFigures SELECT fid, x, y FROM board WHERE x = pX AND y = pY LIMIT 1;
				DELETE FROM board WHERE x = pX AND y = pY;
				UPDATE board SET x = pX, y = pY WHERE fid = id;
				RETURN 2;
			ELSE 
				RETURN 0;
			END IF;
		ELSIF figColor = 'White' THEN
			IF color = 'Black' THEN
				INSERT INTO deletedFigures SELECT fid, x, y FROM board WHERE board.x = pX AND board.y = pY LIMIT 1;
				DELETE FROM board WHERE x = pX AND y = pY;
				UPDATE board SET x = pX, y = pY WHERE fid = id;
				RETURN 2;
			ELSE 
				RETURN 0;
			END IF;
		END IF;
	END IF;
	RETURN state;
END;
$$ LANGUAGE plpgsql;

--trigger
DROP TABLE IF EXISTS changes;

CREATE TABLE changes (
	fid int,
	state text,
	x char,
	CHECK (x IN ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H')),
	y int,
	etime timestamp,
	CHECK (y IN (1, 2, 3, 4, 5, 6, 7, 8))
);


CREATE OR REPLACE FUNCTION movesLog() RETURNS trigger AS $$
BEGIN
	IF (SELECT COUNT(*) FROM deletedFigures) != 0 THEN
		IF (NOT EXISTS(SELECT * FROM board WHERE fid = (SELECT fid FROM deletedFigures))) THEN
			INSERT INTO changes(fid, state, x, y, etime) VALUES
			((SELECT fid FROM deletedFigures), 'eaten at' 
			, (SELECT x FROM deletedFigures)
			, (SELECT y FROM deletedFigures), now());
			DELETE FROM deletedFigures;
		END IF;
	END IF;
	IF NEW.x != OLD.x AND NEW.y != OLD.y THEN
		INSERT INTO changes(fid, state, x, y, etime) VALUES
			(NEW.fid, 'moved to' , NEW.x, NEW.y, now());
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS moveLogs ON board;

CREATE TRIGGER moveLogs
	AFTER UPDATE
	ON board
	FOR EACH ROW
	EXECUTE PROCEDURE movesLog();
--tests
DELETE FROM changes;
CREATE TABLE kngs AS SELECT board.fid FROM board JOIN figures ON 
board.fid = figures.fid WHERE ftype = 'Knight';
SELECT tableFunction(fid), fid FROM kngs;
SELECT * FROM countPawnMoves(9);
SELECT * FROM tableFunction(7);
SELECT * FROM makeKnightMove(7, 'C', 3);
SELECT * FROM makeKnightMove(7, 'D', 5);
SELECT * FROM makeKnightMove(7, 'E', 7);
SELECT * FROM board;
SELECT * FROM changes;
