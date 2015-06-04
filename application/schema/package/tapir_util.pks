CREATE OR REPLACE PACKAGE tapir_util AS

    FUNCTION get_tapir_table(a_table_name_in IN user_tables.table_name%TYPE)
        RETURN tapir_table;

END;
/
