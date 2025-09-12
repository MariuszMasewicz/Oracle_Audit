SET SQLFORMAT CSV

set termout on
prompt cdb.sql
set termout off

set termout on
prompt --
set termout off
spool audit_results/v_containers.csv
select * 
from GV$CONTAINERS
order by 1,2;
spool off

set termout on
prompt --
set termout off
spool audit_results/cdb_pdbs.csv
select * 
from cdb_pdbs
order by 1,2;
spool off

set termout on
prompt --
set termout off
spool audit_results/cdb_properties.csv
select * 
from CDB_PROPERTIES
ORDER BY property_name, con_id;
spool off

set termout on
prompt --audit_results/cdb_services.csv
set termout off
spool audit_results/cdb_services.csv
select * 
from CDB_SERVICES
ORDER BY service_id, con_id;
spool off

set termout on
prompt --audit_results/cdb_pdb_history.csv
set termout off
spool audit_results/cdb_pdb_history.csv
select * 
from CDB_PDB_HISTORY 
order by pdb_name,con_id, pdb_id, op_timestamp desc;
spool off

set termout on
prompt --audit_results/cdb_container_data.csv
set termout off
spool audit_results/cdb_container_data.csv
select * 
from CDB_CONTAINER_DATA
order by username, object_name, con_id;
spool off

set termout on
prompt --audit_results/cdb_pdb_saved_states.csv
set termout off
spool audit_results/cdb_pdb_saved_states.csv
select * 
from CDB_PDB_SAVED_STATES;
spool off