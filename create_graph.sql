-- Schedule (PostgreSQL 10)
DROP TABLE IF EXISTS "Graph";

CREATE TABLE "Graph" (
	"origin" integer NOT NULL,
	"destiny" integer NOT NULL,
	CONSTRAINT unique_edge UNIQUE ("origin", "destiny")
);

INSERT INTO "Graph"  (
	SELECT DISTINCT s1."#t", s2."#t" FROM "Schedule" AS s1 JOIN "Schedule" AS s2 ON s1."time" < s2."time"
	WHERE  (s1.op = 'R' AND s2.op = 'W' AND s1.attr = s2.attr AND s1."#t" <> s2."#t") 
		OR (s1.op = 'W' AND s2.op = 'W' AND s1.attr = s2.attr AND s1."#t" <> s2."#t")
		OR (s1.op = 'W' AND s2.op = 'R' AND s1.attr = s2.attr AND s1."#t" <> s2."#t")
);