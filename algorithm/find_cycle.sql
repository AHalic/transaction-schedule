--******************** Function declaration ***************************
CREATE OR REPLACE FUNCTION testeEquivalenciaPorConflito()
RETURNS integer AS $$
	BEGIN
		-- If search_graph has rows, then a cycle was found and returns 1
		IF EXISTS (
			-- https://www.postgresql.org/docs/9.1/queries-with.html
			-- search graph has initial node, and boolean value if a cycle was found
			WITH RECURSIVE search_graph(parentid, path, cycle) AS (
				-- g is the graph table, sg is the search graph table that's created
				
				-- gets node (origin) and adds to the end of path, then checks if the initial
				-- node is the same as the final node, if so, a cycle was found
				SELECT g.origin, ARRAY[g.destiny, g.origin], (g.destiny = g.origin)
				FROM   "Graph" g

				-- combines all results in one table 
				UNION ALL
				-- concats paths and checks if the initial node is in the path
				SELECT g.origin, sg.path || g.origin, g.origin = ANY(sg.path)
				FROM   search_graph sg
				JOIN   "Graph" g ON g.destiny = sg.parentid
				WHERE  NOT sg.cycle
				)
			SELECT FROM search_graph
			WHERE  cycle
			LIMIT  1  
			)
		THEN
			RETURN 1; -- Cycle detected
		ELSE
			RETURN 0; -- No cycle detected
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