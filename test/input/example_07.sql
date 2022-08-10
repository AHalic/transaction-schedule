-- example_07 (PostgreSQL 10)
-- No conflicts
INSERT INTO "Schedule" ("time", "#t", "op", "attr") VALUES
(7, 3,  'R',  'X'),
(8, 3,  'W',  'X'),
(9, 4,  'R',  'Y'),
(10,  4,  'W',  'Y'),
(11, 4,  'R',  'X'),
(12, 3,  'R',  'X'),
(13, 4,  'W',  'X'),
(14,  4,  'C',  '-'),
(15,  3,  'C',  '-');