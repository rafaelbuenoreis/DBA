set echo off
rem ==========================================================================
rem ARQUIVO.....: indcols.sql
rem FINALIDADE..: Lista as colunas de todos indices de um determinada tabela
rem ==========================================================================
rem PARAMETROS
rem    1 = Owner do tabela || '.' || Nome do tabela
rem ==========================================================================
rem MODIFICACOES
rem ==========================================================================

set echo off
set feedback off termout on
col COLUMN_NAME for a30
set sqlcase upper
set ver off
set lines 300

variable own varchar2(30)
variable tab varchar2(30)

undefine tab
accept tab prompt "Entre com a OWNER.TABELA:" 

declare
  vStr varchar2(64) := upper( '&tab.');
begin
  :own := substr( vStr, 1, instr(vStr, '.')-1 );
  :tab := substr( vStr,    instr(vStr, '.')+1 );
end;
/
set termout on
column index_tablespace format a50 heading 'INDEX (TABLESPACE)'

break on table_name skip 1 on ctype on index_tablespace on status on column_position

select decode(dc.constraint_type, 'P', 'PK', 'U', 'UK',  'R', 'FK', 'N/A')
    as ctype
     , lpad( ' (' || ix.tablespace_name || ')' , 50, rpad(ix.owner || '.' || ix.index_name, 50) )
    as index_tablespace
     , ix.status
     , ic.column_position
     , decode(tc.nullable, 'N', 'NN', null) as not_null
     , ic.column_name
  from dba_indexes ix
     , ( select TABLE_OWNER, TABLE_NAME
              , INDEX_OWNER, INDEX_NAME
              , COLUMN_POSITION, COLUMN_NAME
           from dba_ind_columns
          where table_owner = :own and table_name = :tab
         union all
         select TABLE_OWNER, TABLE_NAME
              , INDEX_OWNER, INDEX_NAME
              , COLUMN_POSITION, '---funcao---'
           from dba_ind_expressions
          where table_owner = :own and table_name = :tab
       ) ic
     , dba_tab_columns tc
     , dba_constraints dc
 where ---Restringe a 1 owner, 1 tabela
       ix.table_owner = :own and ix.table_name = :tab
       ---Join da IC com a IX
   and ic.index_owner = ix.owner
   and ic.table_name  = ix.table_name
   and ic.index_name  = ix.index_name
       ---Join da IC com a TC
   and ic.table_owner = tc.owner(+)
   and ic.table_name  = tc.table_name(+)
   and ic.column_name = tc.column_name(+)
       ---Join da IX com a DC
   and ix.owner       = dc.index_owner (+)
   and ix.index_name  = dc.index_name (+)
 order by ic.index_owner, ic.table_name
     , decode(dc.constraint_type, 'P', 1, 'U', 2, 3)
     , ic.index_name, ic.column_position
/
prompt
clear breaks

set feedback 6
