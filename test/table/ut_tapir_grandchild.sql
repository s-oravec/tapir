create table ut_tapir_grandchild (
  id integer primary key,
  child_id integer
);

alter table ut_tapir_grandchild
  add constraint ut_tapir_grandchild_fk1
  foreign key (id) references ut_tapir_child(id)
;

