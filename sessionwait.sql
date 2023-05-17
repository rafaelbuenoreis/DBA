set linesize 200
set pages 55
col sid format 99999
col name format a36
col p1 format 999999999 Head 'P1'
col program format a25
col p2 format 999999999 Head 'P2'
col p3 format 999999999 Head 'P3'
col pgm format a15 head 'What'
col state format a15
col wt format 9999999 head 'Wait|Time'
col WaitEvent format a38 head 'Wait Event'
 
col lc format 99999999999.99 head 'last call'
 
select  A.sid,
decode(A.event,'null event','CPU Exec',A.event) WaitEvent,
A.p1,A.p2,A.p3,
decode(A.state,'WAITING','WTG',
'WAITED UNKNOWN TIME','UNK',
'WAITED SHORT TIME','WST',
'WAITED KNOWN TIME','WKT') wait_type,
decode(A.state,'WAITING',A.seconds_in_wait,
'WAITED UNKNOWN TIME',-999,
'WAITED SHORT TIME',A.wait_time,
'WAITED KNOWN TIME',A.WAIT_TIME) wt,
round((last_call_et/60),2) lc,
substr(nvl(b.module,b.program),1,15) pgm
from    v$session_wait A,
        v$session B
where 1=1
and (A.event  like 'gc%'
or A.event like 'GC%'
or A.event like 'ge%')
and A.event not like '%remote message'
and A.event not like '%sleep'
and A.sid=B.sid
and B.status='ACTIVE'
order by 1
/
