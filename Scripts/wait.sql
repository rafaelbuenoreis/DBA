set linesize 200
set pagesize 100
col event format a40

break on username skip 1

select count(*), event, sum(SECONDS_IN_WAIT)
from v$session_wait
where wait_time=0and event not in ('SQL*Net message from client', 'rdbms ipc message', 'pipe get', 'pmon timer', 'wakeup time
manager')
group by event
order by 1 desc
/

select username, count(*), osuser
from v$session
where username is not null and status='ACTIVE'
group by username, osuser
order by 1
/

