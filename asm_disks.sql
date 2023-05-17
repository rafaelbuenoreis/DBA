set echo off
rem ==========================================================================
rem ARQUIVO.....: 
rem FINALIDADE..: 
rem ==========================================================================
rem PARAMETROS
rem   nenhum
rem Prof. Augusto Marques Cordeiro
rem ==========================================================================

break on asm_dg_name skip 1 on report
compute sum of TOTAL_MB on asm_dg_name
compute sum of FREE_MB  on asm_dg_name
compute sum of USED_MB  on asm_dg_name
compute avg of PCT_FREE on asm_dg_name

column ASM_DG_NAME      format a16
column ASM_DISK_NAME    format a30
column DEVICE           format a16
column TOTAL_MB         format 99g999g999
column FREE_MB          format 99g999g999
column USED_MB          format 99g999g999
column PCT_FREE         format 990d0

select decode(g.name, null, 'N/A', g.name) as asm_dg_name
     , d.path as device
     , d.header_status
     , d.state
     , d.TOTAL_MB
     , (d.TOTAL_MB - d.FREE_MB) as USED_MB
     , decode(g.name, null, to_number(null), d.FREE_MB) as FREE_MB
     , round( 100*d.FREE_MB/d.TOTAL_MB,1 ) as PCT_FREE
     , d.name as asm_disk_name
  from v$asm_disk d
  full outer join v$asm_diskgroup g using (GROUP_NUMBER)
  order by g.name, d.path
/
