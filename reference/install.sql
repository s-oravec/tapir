@&&run_dir_begin

prompt Creating table TAPIR_REFERENCE
@@tapir_reference.sql

prompt Creating TAPI package
@@px_tapir_reference.pks

prompt Creating TAPI package body
@@px_tapir_reference.pkb

prompt Creating TAPI type
@@tx_tapir_reference.tps

prompt Creating TAPI type body
@@tx_tapir_reference.tpb

prompt Creating TAPI collection type
@@cx_tapir_reference.tps

prompt Creating surrogate key sequence
@@sx_tapir_reference.seq

@&&run_dir_end
