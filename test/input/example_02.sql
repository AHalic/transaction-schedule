-- example_02 (PostgreSQL 10)
-- No conflicts
INSERT INTO "Schedule" ("time", "#t", "op", "attr") VALUES
(7, 3,  'R',  'X'),
(8, 3,  'R',  'Y'),
(9, 4,  'R',  'X'),
(10,  3,  'W',  'Y'),
(11,  4,  'C',  '-'),
(12,  3,  'C',  '-');