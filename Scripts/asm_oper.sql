select o.*
     , decode(EST_WORK, 0, 0, round(100*SOFAR/EST_WORK)) as pct
  from v$asm_operation o
/
