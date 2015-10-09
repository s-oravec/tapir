rem Tapir 1.0.0
define g_tapir_dev_schema       = "TAPIR_010000_DEV"
define g_tapir_dev_other_schema = "TAPIR_010000_OTH"

rem Tapir Development Schema
prompt create new &&g_tapir_dev_schema user
create user &&g_tapir_dev_schema identified by &&g_tapir_dev_schema
  default tablespace users temporary tablespace temp
  quota unlimited on users;

grant connect to &&g_tapir_dev_schema;
grant create table to &&g_tapir_dev_schema;
grant create procedure to &&g_tapir_dev_schema;
grant create type to &&g_tapir_dev_schema;
grant create synonym to &&g_tapir_dev_schema;
grant create sequence to &&g_tapir_dev_schema;

--testing only
grant debug connect session to &&g_tapir_dev_schema;

rem Tapir Development Other Schema - for Multischema Dev/Test
prompt create new &&g_tapir_dev_other_schema user
create user &&g_tapir_dev_other_schema identified by &&g_tapir_dev_other_schema
  default tablespace users temporary tablespace temp
  quota unlimited on users;

grant connect to &&g_tapir_dev_other_schema;
grant create table to &&g_tapir_dev_other_schema;
grant create procedure to &&g_tapir_dev_other_schema;
grant create type to &&g_tapir_dev_other_schema;
grant create synonym to &&g_tapir_dev_other_schema;
grant create sequence to &&g_tapir_dev_other_schema;

--testing only
grant debug connect session to &&g_tapir_dev_other_schema;


