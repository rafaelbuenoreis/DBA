rem
rem ARQUIVO
rem    indcol.sql
rem
rem FINALIDADE
rem    Lista as colunas de um determinado indice
rem
rem PARAMETROS
rem    1 = Nome do indice
rem
rem MODIFICACOES
rem

set feedback off
break on index_owner on index_name skip 1
define indname=&1

select ic.index_owner
     , ic.index_name
     , ic.column_position
     , decode(tc.nullable, 'N', 'NN', null) as not_null
     , ic.column_name
  from dba_ind_columns ic
     , dba_tab_columns tc
 where ic.index_owner || '.' || ic.index_name like upper('&indname')
   and ic.index_owner = tc.owner
   and ic.table_name  = tc.table_name
   and ic.column_name = tc.column_name
 order by ic.index_owner, ic.index_name, ic.column_position
/

clear breaks
set feedback 6
