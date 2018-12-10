-- _______________________________________________
--
--  LISTA AS VIEWS DE UM ESQUEMA E SEU CONTE�DO	--
--  AUTHOR: AUGUSTO MARQUES CORDEIRO				 
-- ______________________________________________ 

set echo off
set linesize 190
set ver off
set sqlcase upper
set long 20000


column object_name format a30

undefine obj
accept obj prompt "Forne�a o(s) objeto(s) a ser(em) listado(s):" 

spool c:\obj.txt


select owner, object_name, status, object_type, to_char(last_ddl_time,'DD/MON/YY HH:MI:YY') "Alterado"
from dba_objects 
where upper(object_name) like ('%&obj%')
order by object_id;

set pause on
set pages 0

set pages 24
set pause off
set sqlcase mixed
set long 80
set ver on
spool off


