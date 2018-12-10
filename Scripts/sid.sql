rem
rem ARQUIVO
rem    sess.sql
rem
rem FINALIDADE
rem    Exibe informacoes de um sessao (SID) especifica
rem

set feedback off

select lpad(s.sid || ', ' || s.serial#, 12) || '@'|| s.inst_id as session_id
     , p.spid
     , s.server
     , s.username
     , s.osuser
     , to_char(s.logon_time, 'dd-mon/hh24:mi') as logon_time
     , round(s.last_call_et/60, 1) as minutos
     , s.status
     , s.machine
  from gv$process p
     , gv$session s
 where p.inst_id = s.inst_id 
   and p.addr   = s.paddr
   and sid = &1.
/
prompt

select w.event
     , s.p1text || decode(w.p1, null, null, ': ' || s.p1) as p1value
     , s.p2text || decode(w.p2, null, null, ': ' || s.p2) as p2value
     , s.p3text || decode(w.p3, null, null, ': ' || s.p3) as p3value
     , w.seconds_in_wait as wait_secs , w.wait_time as last_wait
from gv$session_wait w, gv$session s
where w.inst_id = s.inst_id 
and s.sid = w.sid
and w.sid = &1
and w.event not in ('SQL*Net message from client', 'rdbms ipc message', 'pmon timer', 'smon timer')
order by w.seconds_in_wait desc, s.username
/
prompt

 
/*  =====> Para estatisticas detalhadas dessa sessao, executar o comando:
   select v.statistic#
     , n.name as statistic_name
     , v.value as statistic_value
   from v$session s, v$bgprocess b, v$sesstat v, v$statname n
   where s.paddr = b.paddr(+)
   and s.sid = v.sid
   and v.statistic# = n.statistic#
   and v.sid = &1
   and v.value > 0
   order by n.name, v.statistic#
*/
prompt
set feedback 6
