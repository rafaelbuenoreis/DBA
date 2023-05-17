-- _______________________________________________
--
--  LISTA AS VIEWS DE UM ESQUEMA E SEU CONTEÚDO	--
--  AUTHOR: AUGUSTO MARQUES CORDEIRO				 
-- ______________________________________________ 

set echo off
set linesize 190
--set ver off
set sqlcase upper
set long 2000

spool c:\outline.txt

DECLARE
   x long;
   phash_value number;
   
BEGIN

  select HASH_VALUE INTO phash_value from GV$SQLAREA where SQL_ID = '&_SQL_ID';

  FOR c IN (select sql_text from v$sqltext where hash_value=phash_value order by piece) LOOP
     x:=x||c.sql_text;
     dbms_output.put_line(c.sql_text);
  END LOOP;

  dbms_output.put_line( length(x));
  x:= SUBSTR(x, 1, LENGTH(x)-1);
  dbms_output.put_line( length(x));
  
  -- EXECUTE IMMEDIATE 'create outline FNDRSRUN_2638173895 on ' || x;

  dbms_output.put_line( 'create outline ' || 'FNDRSRUN_' || phash_value || ' on ' || x );	

END;
/

set pages 24
set pause off
set sqlcase mixed
set long 80
set ver on
spool off


