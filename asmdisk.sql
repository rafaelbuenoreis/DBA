-- --------------------------------------- */
-- Lista os discos e grupos de discos ASM
-- Author: Augusto Marques
-- --------------------------------------- */

spool c:\asmdisk.txt

set pages 24
set linesize 190

column path 		format a35
column name 		format a15

select  DISK_NUMBER,
	GROUP_NUMBER,
	NAME,
        LABEL,
        PATH,
        COMPOUND_INDEX,
        INCARNATION,
        FAILGROUP
from v$asm_disk;

select  DISK_NUMBER,
        MOUNT_STATUS,
        MODE_STATUS,
        STATE,
        TOTAL_MB,
        FREE_MB,
        REDUNDANCY,
        LIBRARY
from v$asm_disk;

spool off
