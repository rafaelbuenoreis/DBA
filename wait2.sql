set verify off;
 set line 1000;
 set pagesize 100;
 
 col Usuario format a10;
 col Os.User format a15;
 col Programa format a30;
 col Evento format a29;
 col Sid format 999999
 col Serial format 999999


select    a.inst_id,
 a.username "Usuario",
a.osuser as "Os.User",
a.sid as "Sid",
a.serial# as "Serial",
a.program as "Programa",
a.logon_time,
 a.status as "Status",
b.seconds_in_wait/60 as "Segs.",
b.wait_time as "Tempo de Espera",
b.event as "Evento",
b.state as "Estado"
from gv$session a,
 gv$session_wait b
 where a.sid = b.sid
 and b.event not like 'SQL*Net%'
and a.inst_id=b.inst_id
 group by a.username,
 a.osuser,
 a.sid,
 b.sid,
 a.serial#,
 a.program,
 a.status,
 b.seconds_in_wait,
 b.wait_time,
 b.event,
 b.state,
 a.inst_id,
 a.logon_time
 order by a.status;
