CREATE OR REPLACE PACKAGE BODY tapir IS

    --------------------------------------------------------------------------------
    PROCEDURE execute_statement(l_sql_in IN VARCHAR2) IS
        l_sql VARCHAR2(32767);
    BEGIN
        EXECUTE IMMEDIATE l_sql;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE create_surrogate_key_seq_impl(a_tapir_table_in IN tapir_table) IS
    BEGIN
        execute_statement(l_sql_in => tapir_util.get_surrogate_key_seq_create(a_tapir_table_in => a_tapir_table_in));
    END;

    --------------------------------------------------------------------------------
    PROCEDURE create_surrogate_key_seq(a_table_name_in IN VARCHAR2) IS
    BEGIN
        create_surrogate_key_seq_impl(a_tapir_table_in => tapir_util.get_tapir_table(a_table_name_in => a_table_name_in));
    END;

    --------------------------------------------------------------------------------
    PROCEDURE drop_surrogate_key_seq_impl(a_tapir_table_in IN tapir_table) IS
    BEGIN
        execute_statement(l_sql_in => tapir_util.get_surrogate_key_seq_drop(a_tapir_table_in => a_tapir_table_in));
    END;

    --------------------------------------------------------------------------------
    PROCEDURE drop_surrogate_key_seq(a_table_name_in IN VARCHAR2) IS
    BEGIN
        drop_surrogate_key_seq_impl(a_tapir_table_in => tapir_util.get_tapir_table(a_table_name_in => a_table_name_in));
    END;

END tapir;
/
