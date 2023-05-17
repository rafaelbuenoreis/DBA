set echo off
rem
rem ARQUIVO
rem    splan.sql
rem
rem FINALIDADE
rem    Exibe plano de execucao de comando em execucao neste instante por uma sessao
rem
rem PARAMETROS
rem    1=SID de uma sessao
rem


rem Obtem identificador do SQL a partir do SID
set feedback off termout off
---Coluna SQL_ID
column sql_id new_value sql_id 
select sql_id from v$session where sid = &1;
---Coluna SQL_ADDRESS
column sql_address new_value sql_address
select sql_address from v$session where sid = &1;
set termout on

rem Mostra o comando SQL a partir do SQL_ID

select *
  from table( dbms_xplan.display_CURSOR( (select sql_id from v$session where sid=&1) ) )
/

set feedback 6
