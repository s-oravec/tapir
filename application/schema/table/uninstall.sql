@&&run_dir_begin

prompt Dropping table TAPIR_CODE_GEN_METADATA
drop table tapir_code_gen_metadata cascade constraints purge;

prompt Dropping table TAPIR_CONFIGURATION
drop table tapir_configuration cascade constraints purge;

@&&run_dir_end

