set echo off
rem ==========================================================================
rem ARQUIVO.....: 
rem FINALIDADE..: 
rem ==========================================================================
rem PARAMETROS
rem   nenhum
rem Prof. Augusto Marques Cordeiro
rem ==========================================================================

column full_alias_path format a85
column file_type format a15
 

select concat('+'||gname, sys_connect_by_path(aname, '/')) full_alias_path
     , system_created
     , alias_directory
     , file_type
--     , redundancy, striped
     , mbytes
     , to_char(mtime, 'dd-mm-yyyy hh24:mi') as mtime
  from ( select b.name as gname
              , a.parent_index as pindex
              , a.name as aname
              , a.reference_index as rindex
              , a.system_created
              , a.alias_directory
              , c.type file_type
              , c.redundancy
              , c.striped
              , c.bytes/1024/1024 as mbytes
              , c.incarnation
              , c.modification_date as mtime
           from v$asm_alias a
              , v$asm_diskgroup b
              , v$asm_file c
          where a.group_number = b.group_number
            and a.group_number = c.group_number(+)
            and a.file_number = c.file_number(+)
            and a.file_incarnation = c.incarnation(+)
            and a.alias_directory = 'N'
       )
 start with (mod(pindex, power(2, 24))) = 0
             and rindex in
                ( select a.reference_index
                    from v$asm_alias a, v$asm_diskgroup b
                   where a.group_number = b.group_number
                     and (mod(a.parent_index, power(2, 24))) = 0
                     and a.name like upper('%&1%')
                )
connect by prior rindex = pindex
/
