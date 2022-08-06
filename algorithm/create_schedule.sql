-- Schedule (PostgreSQL 10)
DROP TABLE IF EXISTS "Schedule";

CREATE TABLE "Schedule" (
	"time" integer,
	"#t" integer NOT NULL,
	"op" character NOT NULL,
	"attr" character NOT NULL,
	UNIQUE ("time")
);