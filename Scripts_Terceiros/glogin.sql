--
-- Copyright (c) 1988, 2005, Oracle.  All Rights Reserved.
--
-- NAME
--   glogin.sql
--
-- DESCRIPTION
--   SQL*Plus global login "site profile" file
--
--   Add any SQL*Plus commands here that are to be executed when a
--   user starts SQL*Plus, or uses the SQL*Plus CONNECT command.
--
-- USAGE
--   This script is automatically run
--

@login.sql

 set long 999999;
 set linesize 1000;
 set pagesize 5000;
 alter session set nls_date_format = 'dd/mm/yyyy hh24:mi:ss';
 set termout off
 col prom new_value prom

 select lower(sys_context('USERENV','SESSION_USER'))||
   '@'||
   sys_context('USERENV','INSTANCE_NAME') || 
   '.'||
   lower(UTL_INADDR.get_host_name) prom
 FROM dual;

 set sqlprompt "&prom> "
 set termout on

prompt conn / as sysdba
prompt conn sys/oracle@orcl as sysdba
prompt conn hr/hr@orclpdb
prompt conn sys/oracle@orclpdb as sysdba
prompt conn sys/oracle@rmanctl as sysdba
prompt conn rman/rman@rmanctl
prompt ALTER PLUGGABLE DATABASE orclpdb OPEN ;
prompt ALTER PLUGGABLE DATABASE orclpdb OPEN READ ONLY;
prompt ALTER PLUGGABLE DATABASE orclpdb OPEN RESTRICTED;
prompt ALTER PLUGGABLE DATABASE orclpdb CLOSE IMMEDIATE;
prompt alter session set container = orclpdb;

set timi on;
set time on;
set serveroutput on size unlimited;


show con_name
col name for a20
select a.con_id,  a.name,    a.dbid,   b.status,  a.open_mode,   a.total_size/1024/1024 "SIZE(MB)"  
from     v$pdbs a, 
dba_pdbs b   
where a.con_id=b.pdb_id;


