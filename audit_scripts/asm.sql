SET SQLFORMAT CSV

set termout on
prompt asm.sql
set termout off

set termout on
prompt --audit_results/gv_asm_diskgroup.csv
set termout off
spool audit_results/gv_asm_diskgroup.csv
select * from gv$ASM_diskgroup order by name;
spool off

set termout on
prompt --audit_results/gv_asm_disk.csv
set termout off
spool audit_results/gv_asm_disk.csv
select * from gv$ASM_disk order by name;
spool off

set termout on
prompt --audit_results/gv_asm_file.csv
set termout off
spool audit_results/gv_asm_file.csv
select * from gv$ASM_file order by group_number, file_number;
spool off

set termout on
prompt --audit_results/gv_asm_disk_iostat.csv
set termout off
spool audit_results/gv_asm_disk_iostat.csv
select * from gv$ASM_disk_iostat order by inst_id, instname, group_number, disk_number;
spool off

set termout on
prompt --audit_results/gv_asm_disk_stat.csv
set termout off
spool audit_results/gv_asm_disk_stat.csv
select * from gv$ASM_disk_stat order by group_number, disk_number;
spool off

set termout on
prompt --audit_results/gv_asm_diskgroup_stat.csv
set termout off
spool audit_results/gv_asm_diskgroup_stat.csv
select * from gv$ASM_diskgroup_stat order by name;
spool off

set termout on
prompt --audit_results/gv_asm_alias.csv
set termout off
spool audit_results/gv_asm_alias.csv
select * from gv$ASM_alias order by name;
spool off

set termout on
prompt --audit_results/asm_disk_group_mapping.csv
set termout off
spool audit_results/asm_disk_group_mapping.csv
select g.group_number, g.name group_name, d.name disk_name, path from v$ASM_diskgroup g join v$ASM_disk d on g.group_number=d.group_number order by 1,2,3;
spool off

set termout on
prompt --audit_results/asm_group_connections.csv
set termout off
spool audit_results/asm_group_connections.csv
select a.instance_name, b.name diskgroup_name,a.db_name,a.status from v$asm_client a, v$asm_diskgroup b where a.group_number=b.group_number;
spool off

set termout on
prompt --audit_results/asm_file_aliases.csv
set termout off
spool audit_results/asm_file_aliases.csv
select * 
from gv$asm_alias a join gv$asm_file f on a.file_number=f.file_number and a.inst_id=f.inst_id and a.group_number=f.group_number
order by a.group_number, a.file_number, a.name, a.inst_id;
spool off