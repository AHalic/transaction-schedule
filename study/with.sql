WITH RECURSIVE search_graph(parentid, path, cycle) AS (
				
				SELECT g.origin, ARRAY[g.destiny, g.origin], (g.destiny = g.origin)
				FROM   "Graph" g
				
				UNION ALL
				SELECT g.origin, sg.path || g.origin, g.origin = ANY(sg.path)
				FROM   search_graph sg
				JOIN   "Graph" g ON g.destiny = sg.parentid
				WHERE  NOT sg.cycle
				)
SELECT * FROM search_graph