set verify off
set feedback off

col MACHINE form a20 trunc
col SPID form 9999999
col "User/Prog/Osuser" form a25 trunc
col ACTION form a32
col PROGRAM form a30
col "Executavel" form a32
col SubProgram form a32

select
	  s.username
	, decode(	s.username
		, NULL, substr( s.program
		, instr(upper(s.program), '(') )
		, s.username )
          		|| decode(substr( s.osuser, 1+instr( s.osuser, '\') ), null, null, '/')
          		|| substr( s.osuser, 1+instr( s.osuser, '\') ) as "User/Prog/Osuser"
	, s.EVENT
	, s.BLOCKING_SESSION_STATUS
	, s.BLOCKING_INSTANCE
	, s.BLOCKING_SESSION
	, s.FINAL_BLOCKING_SESSION_STATUS
	, s.FINAL_BLOCKING_INSTANCE
	, s.FINAL_BLOCKING_SESSION
	, s.SQL_ID
	, s.machine
	, s.inst_id
	, s.sid
	, s.serial#
	, p.spid
	, round(s.last_call_et/60, 1) as "SID/Serial#"
	, s.status
	, s.module
	, to_char(s.logon_time, 'dd-mon/hh24:mi')
	, s.client_info
	, s.program
	, s.LockWait
	, s.osuser
	, s.sid
	, rawtohex(s.saddr)
	, s.process
	, s.action 
	, o.object_name as "Executavel"
   	, o3.object_name as "SubProgram"
	, s.SQL_TRACE
from gv$process p
	, gv$session s
   	, dba_objects o
   	, dba_objects o3
	where p.addr = s.paddr
	and s.inst_id = p.inst_id
	and s.status = 'ACTIVE'
	and s.type = 'USER'
	and o.object_id(+) = s.PLSQL_ENTRY_OBJECT_ID
	and o3.object_id(+) = s.PLSQL_OBJECT_ID
order by 1, decode(s.SQL_ID, null, 1, 2), s.last_call_et, s.username, s.SQL_ID	
/





set verify on
set feedback on



