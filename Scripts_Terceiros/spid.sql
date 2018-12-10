/* --------------------------------------------------------------------- */
/* Contraints e Colunas - parâmetro: 'USER'					                 */
/* --------------------------------------------------------------------- */

spool c:\spid.txt

set linesize 190

undefine os_spid
accept os_spid prompt "Forneça o processo do Sistema Operacional:" 

select a.osuser,a.sid,a.serial#,a.schemaname,a.status,a.program,
       to_char(a.logon_time,'ddmmyy-hh:mi:ss') logon,b.spid 
from v$session a,v$process b
where a.paddr=b.addr
and a.osuser is not null
and a.osuser <> 'oracle'
and a.osuser <> 'oracle7'
and a.osuser <> 'sys'
and a.osuser <> 'SYSTEM'
and a.osuser <> 'UNKNOWN'
and a.osuser <> 'NONE'
and b.spid    = &os_spid
order by 2,4,1,3

/
spool off
