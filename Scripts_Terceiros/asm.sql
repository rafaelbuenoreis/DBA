-- --------------------------------------- */
-- Lista os discos e grupos de discos ASM
-- Author: Augusto Marques
-- --------------------------------------- */

spool c:\asm.txt

set pages 24
set linesize 190

column DISK_PATH	format a100
column DISK_GROUP	format a30
column utilizado 	format 9999999999
column "Util(%)"	format 999.99

select 	path as DISK_PATH, 
	group_number, 
	total_mb as SIZE_MB
from gv$asm_disk
where inst_id = 1
order by path;

select 	name as DISK_GROUP, 
	group_number, 
	type, 
	state, 
	total_mb Total, 
	free_mb Livre, 
	(total_mb-free_mb) utilizado,
	decode(total_mb,0,0,round(100-((free_mb*100)/decode(total_mb,0,1,total_mb)),2)) || '%' as "Util(%)"
from gv$asm_diskgroup
where inst_id = 1;

spool off
