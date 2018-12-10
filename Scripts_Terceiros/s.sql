-- -----------------------------------------------------------------------------------
-- Author       : Augusto
-- Description  : Exibe os SQL´s das sessões correntes.
-- -----------------------------------------------------------------------------------
SET VERIFY OFF
SET LINESIZE 2000
COL SID FORMAT 999999
COL SERIAL FOR 999999
COL STATUS   FORMAT A1
COL username FORMAT A8
COL PROGRAM  FORMAT A16
COL OSUSER  FORMAT A8
COL SQL_TEXT FORMAT A120 HEADING 'SQL QUERY'
COL SPID FOR a8
COL ACTION FOR A25

select 
s.sql_fulltext,
decode(a.status,'ACTIVE','A','INACTIVE','I') S,
substr(a.inst_id,1,1) I,
substr(a.username,1,8) "Usuario",
substr(a.osuser,1,8) as "Os.User",
substr(a.program,1,16) as "Programa",
a.logon_time,
a.status as "Status",
b.seconds_in_wait/60 as "Segs.",
b.wait_time as "Tempo de Espera",
b.event as "Evento",
b.state as "Estado",
substr(a.action,1,25) ACTION,
to_char(a.logon_time,'ddmmyy-hh24:mi:ss') LOGON,
p.spid,
s.sql_id
-- s.sql_fulltext
from gv$session a,
     gv$session_wait b,
     gv$sql s,
     gv$process p
where   
        a.inst_id        = s.inst_id
and     a.inst_id        = b.inst_id
and     s.inst_id        = b.inst_id
and     a.inst_id        = p.inst_id
and     a.sid            = b.sid
and     a.paddr          = p.addr
and     a.SQL_HASH_VALUE = s.HASH_VALUE
and     a.SQL_ADDRESS    = s.ADDRESS
and     a.SQL_ID         = S.SQL_ID
AND     a.status = 'ACTIVE'
and     a.sid            = &sid_ and     a.serial#        = &serial_
-- and     b.event not like 'SQL*Net%'
-- and     machine in ('amlsp1945','amlsp1963','amlsp1946','amlsp1964','amlsp2340','amlsp2343','GRUPOAMIL\AMLSP1945','GRUPOAMIL\AMLSP1963','GRUPOAMIL\AMLSP1964','GRUPOAMIL\AMLSP2340','GRUPOAMIL\AMLSP2343')
;


SET VERIFY ON
SET LINESIZE 255