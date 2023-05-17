set echo OFF
rem ==========================================================================
rem ARQUIVO.....: login.sql
rem FINALIDADE..: Comandos para formatacao de colunas no SQL*Plus
rem Prof. Augusto Marques Cordeiro
rem ==========================================================================
rem PARAMETROS
rem   Nenhum
rem ==========================================================================
rem Parametros de controle de ambiente do SQL*Plus
rem @@login1.sql

ALTER SESSION SET nls_date_format = 'HH:MI:SS';

-- SET the SQLPROMPT to include the _USER, _CONNECT_IDENTIFIER
-- and _DATE variables.
SET SQLPROMPT "_USER'@'_CONNECT_IDENTIFIER _DATE> "

-- To set the number of lines to display in a report page to 24.
SET PAGESIZE 24

-- To set the number of characters to display on each report line to 78.
SET LINESIZE 200

-- To set the number format used in a report to $99,999.
SET NUMFORMAT $99,999

SET TIMI ON

SET TIME ON

rem Colunas para bytes, quantidade, etc
column QTDE                           format 999g999g999
column LINHAS                         format 99g999g999g999
column TX_LINHAS                      format 99g999g999g999
column PCT                            format 999
column PCT_WAITED                     format 990d0           heading 'PCT|WAITED'
column RANK                           format 999
column BYTES                          format 99g999g999g999
column KBYTES                         format 999g999g999
column MBYTES                         format 999g990
column GBYTES                         format 9g990
column BLOCK_SIZE                     format 99999           heading 'BLOCK|SIZE'
column NEXT_EXTENT                    format 999g999g999g999
column NEXT_KBYTES                    format 999g999g999     heading 'NEXT|KBYTES'
column NEXT_MBYTES                    format 999g999g999     heading 'NEXT|MBYTES'
column INITIAL_EXTENT                 format 999g999g999g999
column INITIAL_KBYTES                 format 999g999g999     heading 'INITIAL|KBYTES'
column INITIAL_MBYTES                 format 999g999g999     heading 'INITIAL|MBYTES'
column MAX_MBYTES                     format 999g990         heading 'MAX|MBYTES'
column TOTAL_BYTES                    format 99g999g999g999  heading 'TOTAL|BYTES'
column USADOS                         format 99g999g999g999
column LIVRES                         format 99g999g999g999
column TOTAL_MBYTES                   format 999g990d0       heading 'TOTAL|MBYTES'
column USED_MBYTES                    format 999g990d0       heading 'USED|MBYTES'
column FREE_MBYTES                    format 99g990d0        heading 'FREE|MBYTES'
column MENOR_FREE                     format 9g999g999g999   heading 'MENOR_FREE|BYTES'
column MENOR_FREE_KBYTES              format 99g999g999      heading 'MENOR_FREE|KBYTES'
column MENOR_FREE_MBYTES              format 999g990         heading 'MENOR_FREE|MBYTES'
column MAIOR_FREE                     format 9g999g999g999   heading 'MAIOR_FREE|BYTES'
column MAIOR_FREE_KBYTES              format 9g999g999       heading 'MAIOR_FREE|KBYTES'
column MAIOR_FREE_MBYTES              format 999g990         heading 'MAIOR_FREE|MBYTES'
column BYTES_IN_CACHE                 format 999g999g999g999
column SIZE_MBYTES                    format 999g990         heading 'SIZE|MBYTES'
column MAX_SIZE_MBYTES                format 999g990         heading 'MAX_SIZE|MBYTES'

rem Colunas para owner, username, etc
column USERNAME                       format a22
column OWNER                          format a22
column INDEX_OWNER                    format a22
column R_OWNER                        format a22
column GRANTEE                        format a22
column GRANTOR                        format a22
column SNAME                          format a22
column EXTERNAL_NAME                  format a14
column OSUSER                         format a22
column USERNAME_OSUSER                format a26             heading 'USERNAME/OSUSER' truncate

rem Colunas para nomes de tabelas, segmentos, objetos, etc
column TNAME                          format a25
column TABLE_NAME                     format a25
column R_TABLE_NAME                   format a25
column OBJECT_NAME                    format a30
column REFERENCED_NAME                format a25
column SUBOBJECT_NAME                 format a35
column COLUMN_NAME                    format a30
column CONSTRAINT_NAME                format a30
column R_CONSTRAINT_NAME              format a25
column CONSTRAINT_TYPE                format a4              heading 'CONS|TYPE'
column R_CONSTRAINT_TYPE              format a4              heading 'R_CO|TYPE'
column DELETE_RULE                                           heading 'DELETE|RULE'
column TS#                            format 99999
column TABLESPACE_NAME                format a16
column FILE_NAME                      format a55

rem Colunas para nomes de indices
column INDEX_NAME                     format a30
column INDEX_TYPE                     format a23
column UNIQUENESS                     format a3              heading 'UNI|QUE'
column COMPRESSION                    format a4              heading 'COMP|PRES'
column PARTITIONED                    format a3              heading 'PAR|TIT'
column BITMAP_INDEX                   format a3              heading 'BIT|MAP'
column CLUSTER_INDEX                  format a4              heading 'CLUS|TER'
column FUNCTION_INDEX                 format a4              heading 'FUNC|TION'
column IOT_INDEX                      format a3              heading 'IOT|TOP'
column REVERSE_INDEX                  format a4              heading 'REVE|RSE'
column LOB_INDEX                      format a3              heading 'LOB'
column ROWS_PER_KEY                   format 999,999         heading 'ROWS|PER KEY'
column LF_ROWS                        format 999g999g999
column DEL_LF_ROWS                    format 999g999g999
column POSITION                       format 99g999
column COLUMN_POSITION                format 99g999          heading 'COLUMN|POSITION'
column POS                            format 999

rem Defaults for SET AUTOTRACE EXPLAIN report
column ID_PLUS_EXP                    format 990             heading i
column PARENT_ID_PLUS_EXP             format 990             heading p
column PLAN_PLUS_EXP                  format a92             truncate
column OBJECT_NODE_PLUS_EXP           format a8
column OTHER_TAG_PLUS_EXP             format a29
column OTHER_PLUS_EXP                 format a44
column NAME_COL_PLUS_SHOW_PARAM       format a38
column VALUE_COL_PLUS_SHOW_PARAM      format a38

rem Colunas comuns a mais de uma view/tabela
column CREATED                        format a20
column ROW_ID                         format a18

rem Colunas relativas a TABLES
column NUM_ROWS                       format 999g999g999     heading 'LINHAS|QUANTIDADE'
column ROW_MBYTES                     format 99g990          heading 'LINHAS|MBYTES'
column AVG_ROW_LEN                    format 99g999          heading 'LINHAS|AVG LEN'
column SAMPLE_SIZE                    format 999g999g999     heading 'SAMPLE|SIZE'
column DISTINCT_KEYS                  format 999g999g999     heading 'DISTINCT|KEYS'
column EMPTY_BLOCKS                   format 99g990          heading 'EMPTY|BLOCKS'
column AVG_SPACE                      format 99g999          heading 'AVG|SPACE'
column CHAIN_CNT                      format 99g999
column COMMENTS                       format a39             word_wrap
column SEARCH_CONDITION               format a30             word_wrap
column LAST_ANALYZED                                         heading 'LAST|ANALYZED'

rem Colunas relativas a OBJECTS
column object_type                    format a18

rem Colunas relativas a USERS
column DEFAULT_TABLESPACE             format a14             heading 'DEFAULT|TABLESPACE'
column TEMPORARY_TABLESPACE           format a14             heading 'TEMPORARY|TABLESPACE'
column PROFILE                        format a20
column ACCOUNT_STATUS                 format a13             heading 'ACCOUNT|STATUS' truncate
column USER_CREATED                   format a17             heading 'CREATED'
column LOCK_DATE                      format a17
column EXPIRY_DATE                    format a17

rem Colunas relativas a SESSIONS
column SID                            format 99g999
column SERIAL#                        format 99g999
column SESSION_ID                     format a12
column USER_ID                        format 999g999
column SERVER                         format a3              truncate
column SPID                           format a8
column P1VALUE                        format a32
column P2VALUE                        format a32
column P3VALUE                        format a32
column P1P2_VALUES                    format a32             heading 'P1/P2 VALUES'
column P1P2P3_VALUES                  format a50             heading 'P1/P2/P3 VALUES'
column EVENT                          format a26             truncate
column SECONDS_IN_WAIT                format 9999            heading 'WAIT|SECS'
column WAIT_TIME                      format 9999            heading 'LAST|WAIT'
column SID                            format 99999
column SERIAL#                        format 99999
column SQL_TEXT                       format a64 word_wrap
column SQL_FULLTEXT                   format a120 word_wrap
column SQL_PROFILE                    format a30
column RESOURCE_CONSUMER_GROUP        format a16             heading 'RSRC_GRP'
column PARAMETER                      format a32
column TERMINAL                       format a16             truncate
column MACHINE                        format a16             truncate
column DOMAIN                         format a16             truncate
column PROGRAM                        format a24             truncate
column LAST_CALL_ET                   format a14
column MODULE                         format a16             truncate
column SMODULE                        format a10             truncate
column BLOCKING_SESSION               format 99g999          heading 'BLOCKING|SID'
column BLOCKING_USER                  format a16
column BLOCKING_MODULE                format a10             heading 'BLOCKING|MODULE'
column WAITING_SESSION                format 99g999          heading 'WAITING|SID'
column WAITING_USER                   format a16
column WAITING_MODULE                 format a10             heading 'WAITING|MODULE'
column MINUTOS                        format 9999            heading 'MIN'
column CLIENT_INFO                    format a42
column OPNAME                         format a36
column CURRENT_TIMESTAMP              FORMAT a38

rem Colunas relativas a REAL APPLICATION CLUSTERS (RAC)
column FAILOVER_TYPE                                         heading 'FAILOVER|TYPE'
column FAILOVER_METHOD                                       heading 'FAILOVER|METHOD'
column FAILED_OVER                                           heading 'FAILED|OVER'

rem Colunas relativas a ASM
column HEADER_STATUS                                         heading 'HEADER|STATUS'

rem Colunas relativas a TABLESPACES, SEGMENTS e EXTENTS
column SEGMENT_NAME                   format a25
column SEGMENT_TYPE                   format a18
column BLOCKS                         format 99g999g999
column EXTENTS                        format 99g999g999
column INITIAL_EXTENT                 format 999g999g999
column NEXT_EXTENT                    format 999g999g999
column PCT_INCREASE                   format 999             heading 'PCT|INC'
column MIN_EXTENTS                    format 999g999         heading 'MIN|EXTENTS'
column MAX_EXTENTS                    format 9G999g999g999   heading 'MAX|EXTENTS' justify right
column EXTENT_MANAGEMENT              format a10             heading 'EXTENT|MANAGEMENT'
column ALLOCATION_TYPE                format a10             heading 'ALLOCATION|TYPE'
column SEG_MBYTES                     format 999g990         heading 'SEGMENT|MBYTES'

rem Colunas relativas a ROLLBACK SEGMENTS
column USN                            format 999
column RBSNAME                        format a7              heading RBSNAME truncate
column OPTSIZE                        format 9G990D0
column WRAPS                          format 999g999
column EXTENDS                        format 999g999
column SHRINKS                        format 999g999
column CUREXT                         format 9G999
column CURBLK                         format 99g999
column RBS_STATUS                     format a7              truncate
column XACTS                          format 999
column WRITES                         format 999g999g999

rem Colunas relativas a FILES
column FILE_ID                        format 99g999
column FILE#                          format 99g999
column INCREMENT_BY                   format 999g999g999     heading 'INCR.BY|(BLOCKS)'
column INCREMENT_BYTES                format 99g999g999g999  heading 'INCREMENT_BY|(BYTES)'
column INCREMENT_KBYTES               format 999g999g999     heading 'INCREMENT_BY|(KBYTES)'
column INCREMENT_MBYTES               format 999g990         heading 'INCR.BY|MBYTES'
column INCREMENT_GBYTES               format 9g990           heading 'INCR BY|GBYTES'
column PHYRDS                         format 9g999g999g999
column PHYBLKRD                       format 99g999g999g999
column READTIM                        format 999g999g999
column BLK_PER_READ                   format 999             heading 'BLK/|READ'
column PHYWRTS                        format 9g999g999g999
column PHYBLKWRT                      format 999g999g999
column WRITETIM                       format 999g999g999
column AVGIOTIM                       format 9g999
column IOPCT                          format 990d00
column READPCT                        format 990d00
column WRITEPCT                       format 990d00
column DIRECTORY_PATH                 format a60
column CORRUPTION_CHANGE#             format 99999999999999  heading 'CORRUPTION|CHANGE#'
column MARKED_CORRUPT                                        heading 'MARKED|CORRPUT'
column CORRUPTION_TYPE                                       heading 'CORRUPTION|TYPE'

rem Colunas relativas a JOBS
column JOB                            format 99999999
column NEXT_DATE                      format a11             word_wrap
column LAST_DATE                      format a11             word_wrap
column INTERVAL                       format a20             word_wrap
column WHAT                           format a60             word_wrap
column JOB_VALUE                      format a60             word_wrap
column JOB_PARAMETER                  format a20
column FAILURES                       format 9999
column BROKEN                         format a6

rem Colunas relativas a PRIVILEGIOS
column GRANTED_ROLE                   format a25
column ROLE                           format a25
column PRIVILEGE                      format a28
column GRANTABLE                      format a3

rem Colunas relativas a ESTATISTICAS DE PERFORMANCE
column STATISTIC_NAME                 format a30             truncate
column STATISTIC_VALUE                format 999g999g999g990 heading 'STATISTIC|VALUE'
column LATCH_NAME                     format a40
column GETS                           format 999g999g999g999
column MISSES                         format 999g999g999g999
column SLEEPS                         format 999g999g999
column IMMEDIATE_GETS                 format 999g999g999g999 heading IGETS
column IMMEDIATE_MISSES               format 999g999g999g999 heading IMISS
column GETHITRATIO                    format 990D00
column IGETHITRATIO                   format 990D00
column MISSPCT                        format 990D00
column IMISSPCT                       format 990D00
column TOTAL_WAITS                    format 99g999g999      heading 'TOTAL|WAITS'
column TOTAL_TIMEOUTS                 format 999g999         heading 'TOTAL|TIMEOUTS'
column TIME_WAITED                    format a12             heading 'TIME|WAITED' justify right
column TIME_CONNECTED                                        heading 'TIME|CONNECTED' justify right
column AVERAGE_WAIT                   format 990d000         heading 'AVERAGE|WAIT'
column MAX_WAIT                       format 9g999           heading 'MAX|WAIT'
column DLM_REQUESTS                                          heading 'DLM|REQUESTS'
column DLM_CONFLICTS                                         heading 'DLM|CONFLICTS'
column DLM_RELEASES                                          heading 'DLM|RELEASES'
column DLM_PIN_REQUESTS                                      heading 'DLM PIN|REQUESTS'
column DLM_PIN_RELEASES                                      heading 'DLM PIN|RELEASES'
column DLM_INVALIDATION_REQUESTS                             heading 'DLM INVALID|REQUESTS'
column DLM_INVALIDATIONS                                     heading 'DLM|INVALIDATIONS'

rem Colunas relativas a SHARED SERVER
column MESSAGES                       format 99g999g999
column BREAKS                         format 9G999
column BUSY                           format 99g999g999g999
column IDLE                           format 99g999g999g999
column PROTOCOL                       format a4
column DISPATCHER                     format a4
column SHARED_SERVER                  format a4              heading 'SH|SRV'
column BUSY_PCT                       format 990d0           heading 'BUSY %'

rem Colunas relativas a REDO LOG
column MEMBER                         format a50
column GROUP#                         format 999g999
column THREAD#                        format 999             heading THR
column SEQUENCE#                      format 999g999
column SWITCH_INTERVAL                format a20
column ARCHIVE_VALUE                  format 99g999g999g999

rem Colunas relativas ao DICIONARIO DE DADOS
column VIEW_DEFINITION                format a48             word_wrap

rem Colunas relativas a INSTANCE/DATABASE
column DB_NAME                        format a12
column DB_UNIQUE_NAME                 format a12             heading 'DB UNIQUE|NAME'
column INSTANCE_NAME                  format a9              heading 'INSTANCE'
column HOST_NAME                      format a16             word_wrap
column CONTROLFILE_TYPE                                      heading 'CONTROLFILE|TYPE'
column INSTANCE_MACHINE               format a25             heading 'INSTANCE (SERVIDOR)' truncate
column STARTUP_TIME                   format a20
column VERSION                        format a12
column PARAMETER_NAME                 format a32             word_wrap
column PARAMETER_VALUE                format a40             word_wrap
column PARAMETER_DESC                 format a32             word_wrap
column ISSYS_MODIFIABLE               format a5              truncate
column ISSES_MODIFIABLE               format a5              truncate
column ISDEFAULT                      format a5
column ISMODIFIED                     format a5              truncate
column ISADJUSTED                     format a5              truncate
column GLOBAL_NAME                    format a26             truncate
column SERVICE_NAME                   format a26             truncate
column BANNER                         format a70
column STATUS                         format a12             truncate
column OPTION_NAME                    format a64
column OPTION_VALUE                   format a12
column POOL                           format a12
column SGA_POOL                       format a20
column PROPERTY_VALUE                 format a30
column COMP_NAME                      format a36

rem Colunas relativas a PROCESSOS
column PROCESS_NAME                   format a4              heading 'NAME'
column PROCESS_DESCRIPTION            format a36             heading 'DESCRIPTION'
column PROCESS_ERROR                                         heading 'ERROR'

rem Colunas relativas a REPLICACAO
column ONAME                          format a24
column SCHEMANAME                     format a12
column USERID                         format a12
column LOG_USER                       format a12
column PRIV_USER                      format a12
column SCHEMA_USER                    format a12
column GNAME                          format a12
column GROUP_OWNER                    format a12
column HOST                           format a22
column SNAPSHOT_SITE                  format a22             word_wrap
column DB_LINK                        format a22
column DBLINK                         format a22
column SOURCE                         format a22
column MASTER                         format a22
column MASTERDEF                      format a9
column CALLNO                         format 99999
column DEFERRED_TRAN_ID               format a16
column PACKAGENAME                    format a16
column PROCNAME                       format a16
column ARGCOUNT                       format 99999
column ORIGIN_TRAN_DB                 format a22
column DESTINATION                    format a22
column ERROR_MSG                      format a30
column SCHEMA_COMMENT                 format a20             word_wrap
column MASTER_COMMENT                 format a20             word_wrap
column FNAME                          format a20             word_wrap
column CLIENTE                        format a12
column NOME_OBJETO                    format a30
column TIPO_OBJETO                    format a14
column RESOL_CONFLITO                 format a24
column REPPARM_VALUE                  format a12             heading 'REPPARM|VALUE'
column METHOD_NAME                    format a40

rem Colunas relativas a GLOBALIZATION
column NLS_PARAMETER                  format a35
column NLS_VALUE                      format a40

rem Colunas relativas a PL/SQL
column SOURCE_TEXT                    format a100            heading TEXT
column SOURCE_LINE                    format 99g999          heading LINE justify right
column TRIGGER_NAME                   format a25
column TRIGGERING_EVENT               format a40             word_wrap
column WHEN_CLAUSE                    format a40             word_wrap
column PLSQL_CODE_TYPE                format a20

rem Colunas relativas ao ORACLE SPATIAL
column SDO_UNIT                       format a16
column UNIT_NAME                      format a32
column NAME                           format a50             truncate

rem Colunas relativas aos EXAMPLE SCHEMAS
column LAST_NAME                      format a25
column FIRST_NAME                     format a25
column EMAIL                          format a12             truncate
column SALARY                         format 99g999
column DEPARTMENT_NAME                format a20
column POSTAL_CODE                    format a12
column CITY                           format a20
column STREET_ADDRESS                 format a40
column STATE_PROVINCE                 format a18
column JOB_ID                         format a10
column JOB_TITLE                      format a32
column MAX_SALARY                     format 99g999
column MIN_SALARY                     format 99g999
column REGION_NAME                    format a22
column COUNTRY_NAME                   format a25

rem Colunas relativas a TRANSACOES
column UNDO_NAME                      format a12
column USED_UBLK                      format 999g999         heading 'UNDO|BLOCKS'
column START_TIME                     format a20
column BLOCK_GETS                     format 999g999g999g990
column CONSISTENT_GETS                format 999g999g999g990
column PHYSICAL_READS                 format 999g999g999g990
column DB_BLOCK_GETS                  format 999g999g999g990
column PHY_IO                         format 999g999g999
column LOG_IO                         format 999g999g999
column BLOCK_CHANGES                  format 99g999g990      heading 'BLOCK|CHANGES'
column CONSISTENT_CHANGES             format 99g999g990      heading 'CONSISTENT|CHANGES'
column EXECUTIONS                     format 999g999g999
column FETCHES                        format 9g999g999
column DISK_READS                     format 9g999g999
column BUFFER_GETS                    format 999g999g999g999
column CPU_TIME                       format 999g999g999g999
column ELAPSED_TIME                   format 999g999g999g999
column ROWS_PROCESSED                 format 999g999g999g999 heading 'ROWS|PROCESSED'
column USERS_EXECUTING                format 9g999           heading 'USERS|EXECUT'
column OPTIMIZER_MODE                                        heading 'OPTIMIZER|MODE'

rem Colunas para v$recovery_instance
column RECOVERY_ESTIMATED_IOS         format 999g999g999 heading 'RECOVERY|ESTIM.IOS'
column ACTUAL_REDO_BLKS               format 999g999g999 heading 'REDO BLOCKS|REAL'
column TARGET_REDO_BLKS               format 999g999g999 heading 'REDO BLOCKS|TARGET'
column LOG_FILE_SIZE_REDO_BLKS        format 999g999g999 heading 'REDO BLOCKS|LOGFILE'
column LOG_CHKPT_TIMEOUT_REDO_BLKS    format 999g999g999  -
                                         heading 'REDO BLOCKS|LOG CKPT|TIMEOUT'
column LOG_CHKPT_INTERVAL_REDO_BLKS   format 999g999g999g999  -
                                         heading 'REDO BLOCKS|LOG CKPT|INTERVAL'
column FAST_START_IO_TARGET_REDO_BLKS format 999g999g999  -
                                         heading 'REDO BLOCKS|FAST START|IO TARGET'
