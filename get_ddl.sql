set linesize 2000;
set pagesize 1000;
set long 9999999;
set ECHO off;
set FEED off;
set HEAD off;
set time off;
COLUMN DDL FORMAT a9999;
	exec dbms_metadata.set_transform_param(dbms_metadata.session_transform,'SQLTERMINATOR',true);
	select dbms_metadata.get_ddl('&object_type','&object_name','&owner') "DDL" from dual;
set FEED on;
set HEAD on;
set time on;