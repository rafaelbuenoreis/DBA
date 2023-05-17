set heading off
set ver off

col name                 newline
col height               newline
col lf_blk_rows          newline  
col del_lf_rows          newline
col branch_util          newline
col leaf_util          newline 
col can_reduce_level   newline 
col ibadness newline     
col space_util newline     
col percent	newline
col col1 newline

ACCEPT own PROMPT 'Enter value for owner > '
ACCEPT ind PROMPT 'Enter value for INDEX name > '     
ACCEPT avgrow PROMPT 'Enter value for average row > '

validate index &own..&ind;    

rem height > 3 consider rebuilding
rem ibadness > 15-20% lots of deletes consider rebuilding
rem blevel > 4 consider rebuilding

spool indstat_temp.sql

select 'define db_block_size = '    || value
  from v$parameter
 where name = 'db_block_size';

select 'define num_rows = '|| num_rows
  from dba_tables 
  where table_name = (Select table_name from dba_indexes
			where index_name = UPPER('&ind')
			and owner = UPPER('&own') );

select 'define leaf_blocks = ' || leaf_blocks col1
	,'define init_trans = '|| ini_trans col1 
	,'define blevel = '|| blevel col1 
	,'define pctfree = '|| pct_free col1 
  from dba_indexes
  where index_name = UPPER('&ind')
  and owner = UPPER('&own') ; 
	
spool off
@indstat_temp

select 'index name        : '||name
     ,'height            : '||height
     ,'blevel		 : ' || &blevel col1
     ,'space util        : '||to_char (
		( &num_rows*&avgrow ) * 100 / 
	(&leaf_blocks * 
       	    (
		&db_block_size 
		- (113 + 2*&init_trans) 
		- (&db_block_size - (113 + 2*&init_trans))*&pctfree/100 
	    )
         )
				,'99.9')||'%' space_util
     ,'branch util       : '||to_char( 
		(br_rows_len*100)/(br_blk_len*br_blks)
					,'99.9')||'%' branch_util 
     ,'leaf util         : '||to_char( 
		(lf_rows_len - del_lf_rows_len)*100 / (lf_blk_len*lf_blks)   
					,'99.9')||'%'  leaf_util 
     ,'can_reduce_level  : '|| DECODE(SIGN(CEIL( 
		LOG(br_blk_len/(br_rows_len/br_rows) 
		, lf_blk_len/((lf_rows_len - del_lf_rows_len)
			/(lf_rows - del_lf_rows)))) + 1 - height)
					, -1, 'YES','NO') can_reduce_level
     ,'leaf rows deleted : '||to_char(del_lf_rows,'999,999,990')  del_lf_rows
     ,'leaf rows in use  : '||to_char(lf_rows-del_lf_rows,'999,999,990')  lf_blk_rows
     ,'index badness     : '||to_char((del_lf_rows*100)/(lf_rows) 
						,'99.9')||'%' ibadness  
     ,'leaf to branches  : '||to_char(
		(lf_blk_len*100)/(lf_blk_len+br_blk_len),'99.9')||'%' percent
from    index_stats  
/  

set heading on

