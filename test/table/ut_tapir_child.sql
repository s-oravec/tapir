create table ut_tapir_child (
  id integer primary key,
  master_key1 integer,
  master_key2 integer
);

alter table ut_tapir_child
  add constraint ut_tapir_child_fk1
  foreign key (master_key1, master_key2) references ut_tapir_master(key1, key2)
;
