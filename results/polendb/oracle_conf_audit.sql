WHENEVER SQLERROR EXIT SQL.SQLCODE

declare 
v_instance_name v$instance.instance_name%type;
v_host_name v$instance.HOST_name%type;
begin
select instance_name, host_name into  v_instance_name, v_host_name  from v$instance;
if ((v_instance_name <> 'polendb') or (v_host_name<>'d2-pld-o1.localdomain'))
then
  raise_application_error(-20001,'invalid database');
end if;
end;
/

--select instance_name, host_name from v$instance;

@../../../../../github/Oracle_Audit/Oracle_Audit/audit_scripts/run_all.sql
@custom.sql
@../custom_all_databases.sql

exit
