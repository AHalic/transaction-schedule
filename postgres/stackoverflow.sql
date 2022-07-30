with cte as (
      select from_node, to_node, 
             convert(varchar(max), concat(',', from_node, ',', to_node, ',')) as nodes, 1 as lev, 
             (case when from_node = to_node then 1 else 0 end) as has_cycle
      from edges e
      union all
      select cte.from_node, e.to_node,
             convert(varchar(max), concat(cte.nodes, e.to_node, ',')), lev + 1,
             (case when cte.nodes like concat('%,', e.to_node, ',%') then 1 else 0 end) as has_cycle
      from cte join
           edges e
           on e.from_node = cte.to_node
      where cte.has_cycle = 0 
     )
select *
from cte
where has_cycle = 1;