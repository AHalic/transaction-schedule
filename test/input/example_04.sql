-- example_04 (PostgreSQL 10)
-- Conflicts:
-- 1 -> 2
INSERT INTO "Schedule" ("time", "#t", "op", "attr") VALUES
(1, 1,  'R',  'X'),
(2, 1,  'W',  'X'),
(3, 2,  'R',  'X'),
(4, 2,  'W',  'X'),
(5, 2,  'R',  'Y'),
(6, 2,  'W',  'Y'),
(7, 1,  'C',  '-'),
(8, 2,  'C',  '-');