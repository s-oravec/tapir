create table TAPIR_CONFIGURATION
(
  key         VARCHAR2(255) not null,
  value       VARCHAR2(4000),
  description VARCHAR2(4000)
)
;

comment on table TAPIR_CONFIGURATION is 'TAPIR configuration table';

comment on column TAPIR_CONFIGURATION.key is 'Configuration key';
comment on column TAPIR_CONFIGURATION.value is 'Value';
comment on column TAPIR_CONFIGURATION.description is 'Description';

alter table TAPIR_CONFIGURATION
  add constraint TAPIR_CONFIGURATION_PK primary key (KEY)
;
