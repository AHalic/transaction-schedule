-- example_03 (PostgreSQL 10)
INSERT INTO "Schedule" ("time", "#t", "op", "attr") VALUES
(1, 1,  'R',  'X'),
(2, 1,  'W',  'X'),
(3, 2,  'R',  'X'),
(4, 3,  'R',  'X'),
(5, 2,  'W',  'X'),
(6, 3,  'W',  'X'),
(7, 2,  'R',  'Y'),
(8, 2,  'W',  'Y'),
(9, 1,  'C',  '-'),
(10, 2,  'C',  '-'),
(11, 3,  'C',  '-');