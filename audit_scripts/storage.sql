SET SQLFORMAT CSV
spool audit_results/dba_data_files.csv
select * from dba_data_files order by file_id desc;
spool off

spool audit_results/v_datafile.csv
select * from gv$datafile order by file# desc;
spool off

spool audit_results/dba_temp_files.csv
select * from dba_temp_files order by file_id desc;
spool off

spool audit_results/v_controlfile.csv
select * from gV$CONTROLFILE order by name;
spool off

spool audit_results/dba_tablespaces.csv
select * from dba_tablespaces order by tablespace_name;
spool off

spool audit_results/v_tablespace.csv
select * from gv$tablespace order by name;
spool off

spool audit_results/tablespaces_free_space.csv
select
   fs.tablespace_name                          Tablespace_name,
   (df.totalspace - fs.freespace)              Used_MB,
   fs.freespace                                Free_MB,
   df.totalspace                               Total_MB,
   round(100 * (fs.freespace / df.totalspace)) Pct_Free
from
   (select
      tablespace_name,
      round(sum(bytes) / 1048576) TotalSpace
   from
      dba_data_files
   group by
      tablespace_name
   ) df,
   (select
      tablespace_name,
      round(sum(bytes) / 1048576) FreeSpace
   from
      dba_free_space
   group by
      tablespace_name
   ) fs
where
   df.tablespace_name = fs.tablespace_name
order by Tablespace_name;
spool off