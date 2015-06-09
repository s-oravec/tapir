create table TAPIR_REFERENCE
(
  id  INTEGER not null,
  id1 INTEGER not null,
  id2 INTEGER not null,
  in1 INTEGER,
  v1  VARCHAR2(20)
)
;

-- Comments
comment on table TAPIR_REFERENCE
  is 'Tapir reference table';

comment on column TAPIR_REFERENCE.id
  is 'Surrogate primary key';
comment on column TAPIR_REFERENCE.id1
  is 'First key of alternative key';
comment on column TAPIR_REFERENCE.id2
  is 'Second key of alternative key';
comment on column TAPIR_REFERENCE.in1
  is 'Indexed key';
comment on column TAPIR_REFERENCE.v1
  is 'Some value key';

-- Primary, unique and foreign key constraints 
alter table TAPIR_REFERENCE
  add constraint TAPIR_REFERENCE_PK primary key (ID)
;

alter table TAPIR_REFERENCE
  add constraint TAPIR_REFERENCE_AK unique (ID1, ID2)
;

-- Indexes
create index TAPIR_REFERENCE_IN01 on TAPIR_REFERENCE (IN1)
;
