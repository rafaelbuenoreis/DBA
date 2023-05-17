
set feedback off
break on username skip 1
compute sum of elapsed_seconds on username

column HORA_INICIO heading 'HORA|INICIO'
column OPSEQ for 999

select s.username
     , s.sql_id
     , row_number() over(partition by s.sid order by l.start_time) as opseq
     , to_char(l.start_time, 'hh24:mi:ss') as hora_inicio
     , decode(totalwork, 0, 0, 100*sofar/totalwork) as pct
     , elapsed_seconds
     , time_remaining
     , l.opname
     , l.target as object_name
---  , q.sql_text
  from v$session_longops l
  join v$session s on (s.sid = l.sid and s.sql_id = l.sql_id)
--  join v$sql q on (s.sql_hash_value = q.hash_value and q.open_versions > 0)
/
prompt
clear breaks
