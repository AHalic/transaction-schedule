-- example_05 (PostgreSQL 10)
-- Conflicts
-- 1 -> 2
-- 2 -> 3
-- 3 -> 1
INSERT INTO "Schedule" ("time", "#t", "op", "attr") VALUES
(1, 1,  'R',  'X'),
(2, 2,  'W',  'X'),
(3, 3,  'R',  'X'),
(4, 3,  'R',  'Y'),
(5,  1,  'W',  'Y'),
(6,  1,  'C',  '-'),
(7,  2,  'C',  '-'),
(8,  3,  'C',  '-');