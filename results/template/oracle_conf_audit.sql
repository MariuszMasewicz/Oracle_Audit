WHENEVER SQLERROR EXIT SQL.SQLCODE -20001

declare 
v_instance_name v$instance.instance_name%type;
v_host_name v$instance.HOST_name%type;
begin
select instance_name, host_name into  v_instance_name, v_host_name  from v$instance;
if ((v_instance_name <> 'instance_name') or (v_host_name<>'host'))
then
  raise_application_error(-20001,'invalid database');
end if;
end;
/

--select * from v$instance;

@../../skrypty/run_all.sql
@custom.sql

exit
