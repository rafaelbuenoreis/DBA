SET LINESIZE 500
SET PAGESIZE 1000
SET VERIFY OFF

SELECT a.sql_text
FROM   v$sqltext a,
       v$session b
WHERE  a.address = b.sql_address
AND    a.hash_value = b.sql_hash_value
AND    b.sid = &1
ORDER BY a.piece;

PROMPT
SET PAGESIZE 14