select 	column_name
from 	dba_ind_columns
where 	index_name = '&index'
order 	by column_position
/
