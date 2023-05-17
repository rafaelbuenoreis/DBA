rem
rem ARQUIVO
rem    ind.sql
rem
rem FINALIDADE
rem    Lista os indices de uma determinada tabela
rem
rem PARAMETROS
rem    1 = Nome da tabela
rem
rem MODIFICACOES
rem

set feedback off
define tabname=&1

select ix.index_name
     , status
     , distinct_keys
     , num_rows
     , ix.last_analyzed
     , decode ( ix.uniqueness, 'UNIQUE', 'YES', 'NO') as UNIQUENESS
     , decode ( ix.compression, 'ENABLED',  'YES', 'NO') as COMPRESSION
     , ix.partitioned
     , case when index_type like '%BITMAP%' then 'YES'
            when decode(num_rows, null, 1, 0, 1, distinct_keys/num_rows) < 1/1000 then '-1%'
            when decode(num_rows, null, 1, 0, 1, distinct_keys/num_rows) < 1/100  then ' 1%'
            else NULL end
    as bitmap_index
     , case when index_type = 'CLUSTER' then 'YES'
            else NULL end
    as cluster_index
     , case when index_type like '%FUNCTION%' then 'YES'
            else NULL end
    as function_index
     , case when index_type = 'IOT - TOP' then 'YES'
            else NULL end
    as iot_index
     , case when index_type like '%REV%' then 'YES'
            else NULL end
    as reverse_index
     , case when index_type = 'LOB' then 'YES'
            else NULL end
    as lob_index
from dba_indexes ix
where ix.table_name = upper('&tabname')
order by owner, index_name
/
prompt

set feedback 6
