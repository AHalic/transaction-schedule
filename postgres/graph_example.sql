-- Schedule (PostgreSQL 10)
CREATE TABLE "Edges" (
	"from_node" integer NOT NULL,
    "to_node" integer NOT NULL,
    UNIQUE ("from_node", "to_node")
);

INSERT INTO "Edges" ("from_node", "to_node") VALUES
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(4, 1),
(3, 5),
(5, 6);

INSERT INTO "Edges" ("from_node", "to_node") VALUES
(1, 2),
(2, 3),
(3, 4),
(1, 4);
-- (5, 4),
-- (4, 5);



nodes_visited = []

for tupla in edges:

    temp3 = tupla

    if not tupla in nodes_visited:
        nodes_visited.append(tupla)
    
        while True:
            temp1 = temp3
            temp_filtro = (SELECT * FROM temp1 e1, Edges e2 where e1.to_node = e2.from_node)
        
            if temp_filtro == None:
                break

            temp2 = (SELECT e1.from_node, e2.to_node from temp1 e1 join temp_filtro e2 on e1.to_node = e2.from_node)
            temp3 = temp2 - nodes_visited

            if temp3 == None or temp3.from_node = temp3.to_node:
                return 1
                
            nodes_visited = unique(nodes_visited + temp2 + temp_filtro)
       
return 0
        
# ITER 1
temp1:
from_node,to_node
(1,2)

temp_filtro = (SELECT * FROM temp1 e1, Edges e2 where e1.to_node = e2.from_node)
from_node,to_node
(2, 3)

temp2 = (SELECT e1.from_node, e2.to_node from temp1 e1 join temp_filtro e2 on e1.to_node = e2.from_node)
(1, 3)

temp3 = temp2 - temp1
from_node,to_node
(1, 3)


# ITER 2
temp1 = temp3
temp1:
from_node,to_node
(1, 3)

temp_filtro = (SELECT * FROM temp1 e1, Edges e2 where e1.to_node = e2.from_node)
from_node,to_node
(3, 4)
(3, 5)

temp2 = (SELECT e1.from_node, e2.to_node from temp1 e1 join temp_filtro e2 on e1.to_node = e2.from_node)
(1, 4)
(1, 5)

temp3 = temp2 - temp1
(1, 4)
(1, 5)

# ITER 3
temp1 = temp3
temp1:
(1, 4)
(1, 5)

temp_filtro = (SELECT * FROM temp1 e1, Edges e2 where e1.to_node = e2.from_node)
(4, 5)
(4, 1)
(5, 6)

temp2 = (SELECT e1.from_node, e2.to_node from temp1 e1 join temp_filtro e2 on e1.to_node = e2.from_node)
(1, 5)
(1, 6)
(1, 1)

temp3 = temp2 - temp1
(1, 6)
(1, 1) -> has_cycle = 1, break

# ITER 4
temp1 = temp3
temp1:
(1, 6)

temp_filtro = (SELECT * FROM temp1 e1, Edges e2 where e1.to_node = e2.from_node)
[empty] -> has_cycle = 0, continue