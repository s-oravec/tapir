rem Tapir 1.0.0
define g_tapir_dev_schema       = "TAPIR_010000_DEV"
define g_tapir_dev_other_schema = "TAPIR_010000_OTH"

rem Tapir Development Schema
prompt drop &&g_tapir_dev_schema user
drop user &&g_tapir_dev_schema cascade;

rem Tapir Development Other Schema - for Multischema Dev/Test
prompt drop &&g_tapir_dev_other_schema user
drop user &&g_tapir_dev_other_schema cascade;
