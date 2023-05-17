rem
rem ARQUIVO
rem    slongops.sql
rem
rem FINALIDADE
rem    Exibe as operacoes longas de uma sessao
rem

set feedback off
set heading off

select /*+ ordered */
       rpad('-', 96, '-')
    as title
     , 'SESSSION: ' || l.sid || ',' || l.serial#
    || ' / USER: ' || u.username
    || ' / SERVER: ' || u.server
    || ' / ELAPSED: ' || l.elapsed_seconds || 's'
    || ' / REMAINING: ' || l.time_remaining || 's'
    as title
     , l.message || ' (' || trunc(100*sofar/totalwork) || '%)'
    as message
     , rpad('-', 96, '-') as separator
     , s.sql_text
from v$session u, v$session_longops l, v$sql s
where u.sid = l.sid
and l.sql_hash_value = s.hash_value
and l.sofar != l.totalwork
and s.open_versions > 0
/
prompt
set heading on
set feedback 6
