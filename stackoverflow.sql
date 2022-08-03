CREATE OR REPLACE FUNCTION testeEquivalenciaPorConflito()
RETURNS integer AS $$
	BEGIN
		IF EXISTS (
			WITH RECURSIVE search_graph(parentid, path, cycle) AS ( -- relevant columns
				-- check ahead, makes 1 step less
				SELECT g.parentid, ARRAY[g.id, g.parentid], (g.id = g.parentid)
				FROM   node g
				WHERE  g.id = NEW.id  -- only test starting from new row
				
				UNION ALL
				SELECT g.parentid, sg.path || g.parentid, g.parentid = ANY(sg.path)
				FROM   search_graph sg
				JOIN   node g ON g.id = sg.parentid
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

-- calling function
SELECT testeEquivalenciaPorConflito() AS resp;