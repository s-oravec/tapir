@&&run_dir_begin

drop table ut_tapir_master cascade constraints purge;
drop table ut_tapir_child cascade constraints purge;
drop table ut_tapir_grandchild cascade constraints purge;

prompt Install test table UT_TAPIR_MASTER
@@ut_tapir_master.sql

prompt Install test table UT_TAPIR_CHILD
@@ut_tapir_child.sql

prompt Install test table UT_TAPIR_GRANDCHILD
@@ut_tapir_grandchild.sql

@&&run_dir_end
