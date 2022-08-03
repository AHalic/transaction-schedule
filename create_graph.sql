-- Schedule (PostgreSQL 10)
DROP TABLE IF EXISTS "Graph";

CREATE TABLE "Graph" (
	"origin" integer NOT NULL,
	"destiny" integer NOT NULL,
	UNIQUE ("origin", "destiny")
);


