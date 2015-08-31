@&&run_dir_begin

prompt Dropping table TAPIR_REFERENCE
drop table tapir_reference purge;

prompt Dropping TAPI package
drop package px_tapir_reference;

prompt Dropping TAPI collection type
drop type cx_tapir_reference force;

prompt Dropping TAPI type
drop type tx_tapir_reference force;

prompt Dropping surrogate key sequence
drop sequence sx_tapir_reference;

@&&run_dir_end
