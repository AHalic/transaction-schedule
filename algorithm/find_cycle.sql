--******************** Function declaration ***************************
CREATE OR REPLACE FUNCTION testeEquivalenciaPorConflito()
RETURNS integer AS $$
	BEGIN
		IF EXISTS (
			WITH RECURSIVE search_graph(parentid, path, cycle) AS ( -- relevant columns
				-- check ahead, makes 1 step less
				SELECT g.origin, ARRAY[g.destiny, g.origin], (g.destiny = g.origin)
				FROM   "Graph" g
				
				UNION ALL
				SELECT g.origin, sg.path || g.origin, g.origin = ANY(sg.path)
				FROM   search_graph sg
				JOIN   "Graph" g ON g.destiny = sg.parentid
				WHERE  NOT sg.cycle
				)
			SELECT FROM search_graph
			WHERE  cycle
			LIMIT  1  -- stop evaluation at first find
			)
		THEN
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	END
$$ LANGUAGE plpgsql;

--******************** Execute algorithm ***************************
-- Creates graph table
DROP TABLE IF EXISTS "Graph";

CREATE TABLE "Graph" (
	"origin" integer NOT NULL,
	"destiny" integer NOT NULL,
	CONSTRAINT unique_edge UNIQUE ("origin", "destiny")
);

-- Inserts edges into graph table
INSERT INTO "Graph"  (
	SELECT DISTINCT s1."#t", s2."#t" FROM "Schedule" AS s1 JOIN "Schedule" AS s2 ON s1."time" < s2."time"
	WHERE  (s1.op = 'R' AND s2.op = 'W' AND s1.attr = s2.attr AND s1."#t" <> s2."#t") 
		OR (s1.op = 'W' AND s2.op = 'W' AND s1.attr = s2.attr AND s1."#t" <> s2."#t")
		OR (s1.op = 'W' AND s2.op = 'R' AND s1.attr = s2.attr AND s1."#t" <> s2."#t")
);

-- Shows graph table
-- SELECT * from "Graph";

-- calling function
SELECT testeEquivalenciaPorConflito() AS resp;