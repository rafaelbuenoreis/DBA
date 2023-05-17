 set long 999999
 set linesize 1000
 set pages 5000
 set sqlcase upper
 col prom new_value prom 
 
 undefine usuario
 accept usuario prompt "Usuário: "  

 set termout off

 alter session set nls_date_format = 'dd/mm/yyyy hh24:mi:ss';
 alter session set current_schema= &usuario;

  select substr(lower(sys_context('USERENV','SESSION_USER')),1,13)|| 
   '('|| 
   substr(upper(sys_context('USERENV','CURRENT_SCHEMA')),1,12)||
   ')'||
   '@'||
   substr(upper(sys_context('USERENV','DB_NAME')),1,10)|| 
   substr(upper(sys_context('USERENV','INSTANCE')),1,1) || 
   '.'||
   substr(lower(UTL_INADDR.get_host_name),1,14) prom
 FROM dual;

 set sqlprompt "&prom> "
 set termout on
 set sqlcase mixed



