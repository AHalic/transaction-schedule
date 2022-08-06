-- example_05 (PostgreSQL 10)
-- Conflicts
-- 1 -> 2
INSERT INTO "Schedule" ("time", "#t", "op", "attr") VALUES
(1, 1,  'R',  'X'),
(2, 2,  'W',  'X'),
(3, 3,  'R',  'Y'),
(4, 3,  'W',  'Y'),
(5,  1,  'C',  '-'),
(6,  2,  'C',  '-'),
(7,  3,  'C',  '-');