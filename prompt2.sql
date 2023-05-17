 set long 999999;
 set linesize 1000;
 set pagesize 5000;
 alter session set nls_date_format = 'dd/mm/yyyy hh24:mi:ss';
 set termout off
 col prom new_value prom

 select lower(sys_context('USERENV','SESSION_USER'))||
   '@'||
   upper(sys_context('USERENV','DB_NAME'))||
   '.'||
   lower(UTL_INADDR.get_host_name) prom
 FROM dual;

 set sqlprompt "&prom> "
 set termout on
/