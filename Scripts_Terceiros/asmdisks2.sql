
SET LINESIZE  333
SET PAGESIZE  9999
SET VERIFY    off

COLUMN disk_group_name        FORMAT a20           HEAD 'Disk Group Name'
COLUMN disk_file_path         FORMAT a60           HEAD 'Path'
COLUMN disk_file_name         FORMAT a25           HEAD 'File Name'
COLUMN disk_file_fail_group   FORMAT a25           HEAD 'Fail Group'
COLUMN total_mb               FORMAT 999,999,999   HEAD 'File Size (MB)'
COLUMN used_mb                FORMAT 999,999,999   HEAD 'Used Size (MB)'
COLUMN pct_used               FORMAT 999.99        HEAD 'Pct. Used'

break on report on disk_group_name skip 1

compute sum label ""              of total_mb used_mb on disk_group_name
compute sum label "Grand Total: " of total_mb used_mb on report
/*
-- Essa query não tava mostrando os discos candidatos
SELECT
    NVL(a.name, '[CANDIDATE]')                       disk_group_name
  , b.path                                           disk_file_path
  , b.name                                           disk_file_name
  , b.failgroup                                      disk_file_fail_group
  , b.total_mb                                       total_mb
--  , (b.total_mb - b.free_mb)                         used_mb
--  , ROUND((1- (b.free_mb / b.total_mb))*100, 2)      pct_used
FROM
    v$asm_disk b RIGHT OUTER JOIN v$asm_diskgroup a USING (group_number)
ORDER BY
    a.name;
*/
	
SELECT
    NVL(a.name, '[CANDIDATE]')                       disk_group_name
  , b.path                                           disk_file_path
  , b.name                                           disk_file_name
  , b.failgroup                                      disk_file_fail_group
  , b.total_mb                                       total_mb
--  , (b.total_mb - b.free_mb)                         used_mb
--  , ROUND((1- (b.free_mb / b.total_mb))*100, 2)      pct_used
FROM
    v$asm_diskgroup a RIGHT OUTER JOIN v$asm_disk b USING (group_number)
ORDER BY
    a.name;

/*
set pages 100 lines 300
col name for a30
col path for a70
select dg.name, d.path
from v$asm_disk d, v$asm_diskgroup dg
where d.group_number = dg.group_number
order by 1,2;
*/