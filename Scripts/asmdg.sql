select name, (TOTAL_MB/1024) TOTAL_GB,FREE_MB/1024 FREE_GB from v$asm_diskgroup
/
