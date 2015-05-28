create table ut_tapir_master (
  key1 integer,
  key2 integer,
  n number,
  n0 number(*,0),
  n_precision number(9),
  n_precision_scale number(9,2),
  n_scale number(*,2),
  v varchar2(10),
  v_byte varchar2(10 byte),
  v_char varchar2(10 char),
  d date,
  ts timestamp,
  idts interval day to second,
  iytm interval year to month,
  ch char,
  ch1 char(1),
  xml xmltype,
  c clob
);

alter table ut_tapir_master
  add constraint ut_tapir_master_pk
  primary key (key1, key2)
;


