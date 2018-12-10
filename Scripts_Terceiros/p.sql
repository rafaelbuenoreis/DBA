 set long 999999;
 set linesize 1000;
 set pagesize 5000;
 alter session set nls_date_format = 'dd/mm/yyyy hh24:mi:ss';
 set termout off

 select * from table(dbms_xplan.display);

 set sqlprompt "&prom> "
 set termout on
/