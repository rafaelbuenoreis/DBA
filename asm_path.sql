set echo off
rem ==========================================================================
rem ARQUIVO.....: 
rem FINALIDADE..: 
rem ==========================================================================
rem PARAMETROS
rem   nenhum
rem Prof. Augusto Marques Cordeiro
rem ==========================================================================

clear breaks
select d.path as device
     , decode(g.name, null, 'N/A', g.name) as asm_dg_name
     , d.header_status
     , d.TOTAL_MB
     , (d.TOTAL_MB - d.FREE_MB) as USED_MB
     , decode(g.name, null, to_number(null), d.FREE_MB) as FREE_MB
     , round( 100*d.FREE_MB/d.TOTAL_MB,1 ) as PCT_FREE
     , d.name as asm_disk_name
  from v$asm_disk d
  full outer join v$asm_diskgroup g using (GROUP_NUMBER)
  order by d.path
/
