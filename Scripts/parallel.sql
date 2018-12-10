COL username FOR A12 
COL "QC SID" FOR A6 
COL "SID" FOR A6 
COL "QC/Slave" FOR A8 
COL "Req. DOP" FOR 9999 
COL "Actual DOP" FOR 9999 
COL "Slaveset" FOR A8 
COL "Slave INST" FOR A9 
COL "QC INST" FOR A6 
SET pages 300 lines 300 
COL wait_event FOR a30
col sndr for a10
SELECT DECODE(px.qcinst_id,NULL,username,' - '||LOWER(SUBSTR(pp.SERVER_NAME,LENGTH(pp.SERVER_NAME)-4,4) ) )"Username", 
 DECODE(px.qcinst_id,NULL, 'QC', '(Slave)') "QC/Slave" ,TO_CHAR( px.server_set) "SlaveSet",TO_CHAR(s.sid) "SID", 
 TO_CHAR(px.inst_id) "Slave INST",DECODE(sw.state,'WAITING', 'WAIT', 'NO WAIT' ) as STATE,      
 CASE sw.state WHEN 'WAITING' THEN SUBSTR(sw.event,1,30) ELSE NULL end as wait_event , 
 DECODE(px.qcinst_id, NULL ,TO_CHAR(s.sid) ,px.qcsid) "QC SID",TO_CHAR(px.qcinst_id) "QC INST", 
 px.req_degree "Req. DOP", px.degree "Actual DOP" 
FROM gv$px_session px, 
 gv$session s , 
 gv$px_process pp, 
 gv$session_wait sw 
WHERE px.sid=s.sid (+) 
 AND px.serial#=s.serial#(+) 
 AND px.inst_id = s.inst_id(+) 
 AND px.sid = pp.sid (+) 
 AND px.serial#=pp.serial#(+) 
 AND sw.sid = s.sid   
 AND sw.inst_id = s.inst_id    
ORDER BY 
 DECODE(px.QCINST_ID,  NULL, px.INST_ID,  px.QCINST_ID), 
 px.QCSID, 
 DECODE(px.SERVER_GROUP, NULL, 0, px.SERVER_GROUP),  
 px.SERVER_SET,  
 px.INST_ID 
/ 

SET pages 300 lines 300 
COL wait_event FOR a30 
SELECT sw.SID as RCVSID, 
 DECODE(pp.server_name,NULL, 'A QC',pp.server_name) as RCVR, 
 sw.inst_id as RCVRINST,CASE sw.state WHEN 'WAITING' THEN SUBSTR(sw.event,1,30) ELSE NULL end as wait_event , 
 DECODE(bitand(p1, 65535),65535, 'QC','P'||TO_CHAR(bitand(p1, 65535),'fm000')) as SNDR, 
 bitand(p1, 16711680) - 65535 as SNDRINST, 
 DECODE(bitand(p1, 65535),65535, ps.qcsid,
       (SELECT sid  
        FROM gv$px_process  
        WHERE server_name = 'P'||TO_CHAR(bitand(sw.p1, 65535),'fm000') AND 
        inst_id = bitand(sw.p1, 16711680) - 65535)) as SNDRSID, 
 DECODE(sw.state,'WAITING', 'WAIT', 'NO WAIT' ) as STATE      
FROM  
 gv$session_wait sw, 
 gv$px_process pp, 
 gv$px_session ps 
WHERE 
 sw.sid = pp.sid (+) AND 
 sw.inst_id = pp.inst_id (+) AND  
 sw.sid = ps.sid (+) AND 
 sw.inst_id = ps.inst_id (+) AND  
 p1text  = 'sleeptime/senderid' AND 
 bitand(p1, 268435456) = 268435456 
ORDER BY
 DECODE(ps.QCINST_ID,  NULL, ps.INST_ID,  ps.QCINST_ID), 
 ps.QCSID, 
 DECODE(ps.SERVER_GROUP, NULL, 0, ps.SERVER_GROUP),  
 ps.SERVER_SET,  
 ps.INST_ID 
/ 



SET pages 300 lines 300 
COL "Username" FOR a12 
COL "QC/Slave" FOR A8 
COL "Slaveset" FOR A8 
COL "Slave INST" FOR A9 
COL "QC SID" FOR A6 
COL "QC INST" FOR A6 
COL "operation_name" FOR A30 
COL "target" FOR A30 
COL units FOR A20

SELECT DECODE(px.qcinst_id,NULL,username,' - '||lower(SUBSTR(pp.SERVER_NAME,LENGTH(pp.SERVER_NAME)-4,4) ) )"Username", 
 DECODE(px.qcinst_id,NULL, 'QC', '(Slave)') "QC/Slave" ,TO_CHAR( px.server_set) "SlaveSet",TO_CHAR(px.inst_id) "Slave INST", 
 SUBSTR(opname,1,30)  operation_name,SUBSTR(target,1,30) target,sofar,totalwork,units,TO_CHAR(start_time,'hh24:mi dd-mon-yy') "Start", 
 timestamp,DECODE(px.qcinst_id, NULL ,TO_CHAR(s.sid) ,px.qcsid) "QC SID", TO_CHAR(px.qcinst_id) "QC INST" 
FROM gv$px_session px, 
 gv$px_process pp, 
 gv$session_longops s  
WHERE px.sid=s.sid  
 AND px.serial#=s.serial# 
 AND px.inst_id = s.inst_id 
 AND px.sid = pp.sid (+) 
 AND px.serial#=pp.serial#(+) 
ORDER BY 
 DECODE(px.QCINST_ID,  NULL, px.INST_ID,  px.QCINST_ID), 
 px.QCSID, 
 DECODE(px.SERVER_GROUP, NULL, 0, px.SERVER_GROUP),  
 px.SERVER_SET,  
 px.INST_ID 
/