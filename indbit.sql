
define tab=&1
set recsep off

column column_name      format a30 newline
column linhas_total     format 999,999,999,999,999
column linhas_distintas format 999,999,999,999,999

select decode(rownum, 1, 'select ', ', ')
    || '''' || column_name || ''' as column_name'
    || chr(10) || ', count( ' || column_name || ' ) as linhas_total'
    || chr(10) || ', count( distinct ' || column_name || ' ) as linhas_distintas'
    as contagem_valores_distintos
  from (select distinct column_name
          from dba_ind_columns
         where index_name in (select index_name
                                from dba_indexes
                               where table_name = upper('&tab.') ) )
union all
select 'from ' || upper('&tab.') || ';' from dual;

column column_name clear
column column_name format a30 
undefine 1 tab
