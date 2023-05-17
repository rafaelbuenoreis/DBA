set echo off
set linesize 190
set ver off
set pages 24

spool c:\log_history.txt

SELECT * FROM 
    (   
        SELECT * FROM (   
                    SELECT   TO_CHAR(FIRST_TIME, 'DD/MM') AS "DAY",
                    TO_NUMBER(SUM(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '01', 1, 0)), '99999') "01:00",
                    TO_NUMBER(SUM(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '02', 1, 0)), '99999') "02:00",
                    TO_NUMBER(SUM(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '03', 1, 0)), '99999') "03:00",
                    TO_NUMBER(SUM(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '04', 1, 0)), '99999') "04:00",
                    TO_NUMBER(SUM(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '05', 1, 0)), '99999') "05:00",
                    TO_NUMBER(SUM(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '06', 1, 0)), '99999') "06:00",
                    TO_NUMBER(SUM(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '07', 1, 0)), '99999') "07:00",
                    TO_NUMBER(SUM(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '08', 1, 0)), '99999') "08:00"
        FROM V$LOG_HISTORY
        WHERE extract(year FROM FIRST_TIME) = extract(year FROM sysdate)
        GROUP BY TO_CHAR(FIRST_TIME, 'DD/MM')   )
        ORDER BY TO_DATE(extract(year FROM sysdate) || DAY, 'YYYY DD/MM') DESC  ) WHERE ROWNUM < 22
/


SELECT * FROM 
    (   
        SELECT * FROM (   
                    SELECT   TO_CHAR(FIRST_TIME, 'DD/MM') AS "DAY",
                    TO_NUMBER(SUM(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '09', 1, 0)), '99999') "09:00",
                    TO_NUMBER(SUM(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '10', 1, 0)), '99999') "10:00",
                    TO_NUMBER(SUM(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '11', 1, 0)), '99999') "11:00",
                    TO_NUMBER(SUM(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '12', 1, 0)), '99999') "12:00",
                    TO_NUMBER(SUM(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '13', 1, 0)), '99999') "13:00",
                    TO_NUMBER(SUM(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '14', 1, 0)), '99999') "14:00",
                    TO_NUMBER(SUM(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '15', 1, 0)), '99999') "15:00",
                    TO_NUMBER(SUM(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '16', 1, 0)), '99999') "16:00"
        FROM V$LOG_HISTORY
        WHERE extract(year FROM FIRST_TIME) = extract(year FROM sysdate)
        GROUP BY TO_CHAR(FIRST_TIME, 'DD/MM')   )
        ORDER BY TO_DATE(extract(year FROM sysdate) || DAY, 'YYYY DD/MM') DESC  ) WHERE ROWNUM < 22
/


SELECT * FROM 
    (   
        SELECT * FROM (   
                    SELECT   TO_CHAR(FIRST_TIME, 'DD/MM') AS "DAY",
                    TO_NUMBER(SUM(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '17', 1, 0)), '99999') "17:00",
                    TO_NUMBER(SUM(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '18', 1, 0)), '99999') "18:00",
                    TO_NUMBER(SUM(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '19', 1, 0)), '99999') "19:00",
                    TO_NUMBER(SUM(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '20', 1, 0)), '99999') "20:00",
                    TO_NUMBER(SUM(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '21', 1, 0)), '99999') "21:00",
                    TO_NUMBER(SUM(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '22', 1, 0)), '99999') "22:00",
                    TO_NUMBER(SUM(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '23', 1, 0)), '99999') "23:00",
                    TO_NUMBER(SUM(DECODE(TO_CHAR(FIRST_TIME, 'HH24'), '00', 1, 0)), '99999') "00:00"
        FROM V$LOG_HISTORY
        WHERE extract(year FROM FIRST_TIME) = extract(year FROM sysdate)
        GROUP BY TO_CHAR(FIRST_TIME, 'DD/MM')   )
        ORDER BY TO_DATE(extract(year FROM sysdate) || DAY, 'YYYY DD/MM') DESC  ) WHERE ROWNUM < 22
/



set pages 24
set pause off
set ver on
spool off


