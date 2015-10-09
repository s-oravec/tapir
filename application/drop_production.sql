rem Tapir 1.0.0
define g_tapir_production_schema = "TAPIR_010000"

rem Tapir Development Schema
prompt drop &&g_tapir_production_schema user
drop user &&g_tapir_production_schema cascade;
