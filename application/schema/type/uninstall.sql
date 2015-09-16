@&&run_dir_begin

rem Templating objects

prompt Dropping type TAPIR_REPLACE
drop type TAPIR_REPLACE force;

prompt Dropping type TAPIR_REPLACES
drop type TAPIR_REPLACES force;

rem Table metadata objects

prompt Dropping type TAPIR_COLUMN
drop type tapir_column force;

prompt Dropping type TAPIR_COLUMN_LIST
drop type tapir_column_list force;

prompt Dropping type TAPIR_OBJECT_WITH_COLUMNS
drop type tapir_object_with_columns force;


prompt Dropping type TAPIR_CONSTRAINT
drop type tapir_constraint force;

prompt Dropping type TAPIR_CONSTRAINT_LIST
drop type tapir_constraint_list force;

prompt Dropping type TAPIR_INDEX
drop type tapir_index force;

prompt Dropping type TAPIR_INDEX_LIST
drop type tapir_index_list force;

prompt Dropping type TAPIR_TABLE
drop type tapir_table force;

@&&run_dir_end

