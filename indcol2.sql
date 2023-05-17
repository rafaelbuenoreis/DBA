rem
rem ARQUIVO
rem    indcol2.sql
rem
rem FINALIDADE
rem    Lista as colunas de todos indices de um determinada tabela
rem
rem PARAMETROS
rem    1 = Owner do tabela
rem    1 = Nome do tabela
rem
rem MODIFICACOES
rem

col TABLE_NAME for a30
set feedback off
define tabown=&OWNER_
define tabname=&TABLE_
column index_tablespace format a50 heading 'INDEX (TABLESPACE)'

break on table_name skip 1 on ctype on index_tablespace

select ic.table_name
     , decode(dc.constraint_type, 'P', 'PK', 'U', 'UK',  'R', 'FK', 'N/A')
    as ctype
     , lpad( ' (' || ix.tablespace_name || ')' , 50, rpad(ic.index_name, 50) )
    as index_tablespace
     , ix.status
     , ic.column_position
     , decode(tc.nullable, 'N', 'NN', null) as not_null
     , ic.column_name
  from dba_ind_columns ic
     , dba_tab_columns tc
     , dba_indexes ix
     , dba_constraints dc
 where ---Join da IC com a TC
       ic.index_owner = tc.owner
   and ic.table_name  = tc.table_name
   and ic.column_name = tc.column_name
   and ic.index_owner  = UPPER('&tabown')
   and ic.table_name  = UPPER('&tabname')
       ---Join da IC com a IX
   and ic.index_owner = ix.owner
   and ic.table_name  = ix.table_name
   and ic.index_name  = ix.index_name
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
