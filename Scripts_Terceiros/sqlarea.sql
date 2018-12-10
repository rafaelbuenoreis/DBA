-- _______________________________________________
--
-- SQL´s sem BIND		--     	 
-- ______________________________________________ 

set echo off
set linesize 500
set ver off
set sqlcase upper
set long 20000
set serverout on
set feedback off
set head on


undefine grantor
accept colunas prompt "Colunas :" 

column SQL format a200

select count(1) as QTDE, substr(sql_text,1,&colunas) as SQL
from v$sqlarea
group by substr(sql_text,1,&COLUNAS)
having count(1) > 100
order by QTDE desc;


set pages 24
set pause off
set sqlcase mixed
set long 80
set ver on
set serverout off
set feedback on
spool off


