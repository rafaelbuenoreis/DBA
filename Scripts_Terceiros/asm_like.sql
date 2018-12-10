
column full_alias_path format a85
column file_type format a15
 
break on report
compute sum of mbytes on report

select mtime
     , file_type
     , mbytes
     , system_created
     , directory
--     , redundancy, striped
     , full_alias_path
  FROM (
select to_char( mtime, 'dd-mm-yyyy hh24:mi' ) as mtime
     , file_type
     , mbytes
     , decode( system_created, 'Y', 'YES', 'N', 'NO', '??' )  as system_created
     , decode( alias_directory, 'Y', 'YES', 'N', 'NO', '??' ) as directory
--     , redundancy, striped
     , concat('+'||gname, sys_connect_by_path(aname, '/')) full_alias_path
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
       )
 start with (mod(pindex, power(2, 24))) = 0
             and rindex in
                ( select a.reference_index
                    from v$asm_alias a, v$asm_diskgroup b
                   where a.group_number = b.group_number
                     and (mod(a.parent_index, power(2, 24))) = 0
                )
connect by prior rindex = pindex
) where full_alias_path like upper('%&1%')
    and directory != 'YES'
/

clear breaks
