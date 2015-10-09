rem Tapir 1.0.0
define g_tapir_production_schema = "TAPIR_010000"

--TODO: configurable tablespaces
prompt Create tapir schema [&&g_tapir_production_schema]
create user &&g_tapir_production_schema identified by &&g_tapir_production_schema
  default tablespace users temporary tablespace temp
  quota unlimited on users;

prompt Grant privileges to Tapir schema
grant connect to &&g_tapir_production_schema;
grant create table to &&g_tapir_production_schema;
grant create procedure to &&g_tapir_production_schema;
grant create type to &&g_tapir_production_schema;

--TODO: do we need it for production?
grant create sequence to &&g_tapir_production_schema;
