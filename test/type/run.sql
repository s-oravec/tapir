@&&run_dir_begin

prompt Install test package UT_TAPIR_COLUMN
@@ut_tapir_column.pkg
grant execute on ut_tapir_column to pete_010000;


prompt Install test package UT_TAPIR_TABLE
@@ut_tapir_table.pkg
grant execute on ut_tapir_table to pete_010000;


@&&run_dir_end
