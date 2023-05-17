col name for a30
select	i.index_name
,	i.tablespace_name
,	ceil(s.bytes / 1048576) "Size MB"
from 	dba_indexes i
,	dba_segments s
where 	i.index_name = s.segment_name
and 	table_name like '&table'
order 	by 2, 1
/
