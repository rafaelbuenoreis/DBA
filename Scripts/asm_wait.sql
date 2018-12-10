set echo off
rem ==========================================================================
rem ARQUIVO.....: asm_wait.sql
rem FINALIDADE..: Lista sessoes em estado de wait, modificado para ASM
rem ==========================================================================
rem PARAMETROS
rem   nenhum
rem Prof. Augusto Marques Cordeiro
rem ==========================================================================

rem Gera subquery com lista de IDLE EVENTS conforme a versao do database.
set termout off
set timing off heading off feedback off
column idle_event_query new_value idle_event_query noprint
select case
       when instr(banner,'Release 8.1')
            + instr(banner,'Release 9') > 0
       then 'select EVENT from PERFSTAT.STATS$IDLE_EVENT'
       when instr(banner,'Release 10.') > 0
       then 'select distinct EVENT_NAME from DBA_HIST_SYSTEM_EVENT where WAIT_CLASS = ''Idle'''
       end as idle_event_query
from v$version where banner like 'Oracle%Release%'
/
set heading on termout on

break on inst_id skip 1 on event skip 1
select s.inst_id
     , w.event
     , s.session_id
     , s.computer as machine
     , s.username || '/' || s.osuser as username_osuser
     , w.p1text || decode(w.p1text, null, null, ': ' || w.p1) || '/'
    || w.p2text || decode(w.p2text, null, null, ': ' || w.p2) || '/'
    || w.p3text || decode(w.p3text, null, null, ': ' || w.p3)
    as p1p2p3_values
  from v$session_wait w
     , ( select inst_id, sid, logon_time, status, server, type
              , program, terminal, paddr, taddr, sql_id, event
              , lpad(sid,5) || ',' || lpad(serial#, 5)  as session_id
              , decode(module, null, '---', module)     as module
              , to_char(logon_time, 'dd-mon/hh24:mi')   as logon_date
              , round(last_call_et/60, 1)               as minutos
              , decode( instr(machine, '\') + instr(machine, '/')
                      , 0, machine
                      , substr( machine, instr(machine, '\')  + instr(machine, '/') + 1 ) )
             as computer
              , decode( username
                      , NULL, substr( program, instr(upper(program), '(') )
                      , username )
             as username
              , decode( osuser
                      , 'oracle', machine
                      , substr( osuser, 1+instr( osuser, '\') ) )
             as osuser
           from gv$session
          where audsid != sys_context('USERENV','SESSIONID') ) s
 where s.sid = w.sid
   and type = 'USER'
   and w.wait_time = 0 -- wait_time=0 significa "estar esperando agora"
   and s.event not in (&idle_event_query)
 order by w.event, w.p1, w.p2
/
prompt
set feedback 6
