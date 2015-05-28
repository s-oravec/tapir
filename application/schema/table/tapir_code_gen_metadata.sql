create table TAPIR_CODE_GEN_METADATA
(
  object_name VARCHAR2(30) not null,
  object_type VARCHAR2(30) not null,
  object_flag VARCHAR2(1) default '-' not null,
  tapi_flag   VARCHAR2(1) default '-' not null,
  hist_flag   VARCHAR2(1) default '-' not null
)
;

alter table TAPIR_CODE_GEN_METADATA
  add constraint TAPIR_CODE_GEN_METADATA_PK primary key (OBJECT_NAME, OBJECT_TYPE);
alter table TAPIR_CODE_GEN_METADATA
  add check (object_flag in ('-', 'N', 'Y'));
alter table TAPIR_CODE_GEN_METADATA
  add check (tapi_flag in ('-', 'N', 'Y'));
alter table TAPIR_CODE_GEN_METADATA
  add check (hist_flag in ('-', 'N', 'Y'));

