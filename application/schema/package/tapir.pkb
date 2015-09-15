CREATE OR REPLACE PACKAGE BODY tapir IS

    --------------------------------------------------------------------------------
    PROCEDURE execute_statement
    (
        a_sql_in         IN VARCHAR2,
        a_raise_error_in IN BOOLEAN DEFAULT TRUE
    ) IS
    BEGIN
        EXECUTE IMMEDIATE a_sql_in;
    EXCEPTION
        WHEN OTHERS THEN
            IF a_raise_error_in
            THEN
                RAISE;
            ELSE
                --TODO log?
                NULL;
            END IF;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE create_surrogate_key_seq_impl(a_tapir_table_in IN tapir_table) IS
    BEGIN
        execute_statement(a_sql_in => tapir_util.get_surrogate_key_seq_create(a_tapir_table_in => a_tapir_table_in));
    END;

    --------------------------------------------------------------------------------
    PROCEDURE create_surrogate_key_seq(a_table_name_in IN VARCHAR2) IS
    BEGIN
        create_surrogate_key_seq_impl(a_tapir_table_in => tapir_util.get_tapir_table(a_table_name_in => a_table_name_in));
    END;

    --------------------------------------------------------------------------------
    PROCEDURE drop_surrogate_key_seq_impl(a_tapir_table_in IN tapir_table) IS
    BEGIN
        execute_statement(a_sql_in         => tapir_util.get_surrogate_key_seq_drop(a_tapir_table_in => a_tapir_table_in),
                          a_raise_error_in => FALSE);
    END;

    --------------------------------------------------------------------------------
    PROCEDURE drop_surrogate_key_seq(a_table_name_in IN VARCHAR2) IS
    BEGIN
        drop_surrogate_key_seq_impl(a_tapir_table_in => tapir_util.get_tapir_table(a_table_name_in => a_table_name_in));
    END;

    --------------------------------------------------------------------------------
    PROCEDURE create_tapi_object_type_impl(a_tapir_table_in IN tapir_table) IS
    BEGIN
        execute_statement(a_sql_in => tapir_util.get_tapi_obj_type_spc_create(a_tapir_table_in => a_tapir_table_in));
        execute_statement(a_sql_in => tapir_util.get_tapi_obj_type_bdy_create(a_tapir_table_in => a_tapir_table_in));
    END;

    --------------------------------------------------------------------------------
    PROCEDURE create_tapi_object_type(a_table_name_in IN VARCHAR2) IS
    BEGIN
        create_tapi_object_type_impl(a_tapir_table_in => tapir_util.get_tapir_table(a_table_name_in => a_table_name_in));
    END;

    --------------------------------------------------------------------------------
    PROCEDURE drop_tapi_object_type_impl(a_tapir_table_in IN tapir_table) IS
    BEGIN
        execute_statement(a_sql_in         => tapir_util.get_tapi_obj_type_drop(a_tapir_table_in => a_tapir_table_in),
                          a_raise_error_in => FALSE);
    END;

    --------------------------------------------------------------------------------
    PROCEDURE drop_tapi_object_type(a_table_name_in IN VARCHAR2) IS
    BEGIN
        drop_tapi_object_type_impl(a_tapir_table_in => tapir_util.get_tapir_table(a_table_name_in => a_table_name_in));
    END;

    --------------------------------------------------------------------------------
    PROCEDURE create_tapi_coll_type_impl(a_tapir_table_in IN tapir_table) IS
    BEGIN
        execute_statement(a_sql_in => tapir_util.get_tapi_coll_type_create(a_tapir_table_in => a_tapir_table_in));
    END;

    --------------------------------------------------------------------------------
    PROCEDURE create_tapi_coll_type(a_table_name_in IN VARCHAR2) IS
    BEGIN
        create_tapi_coll_type_impl(a_tapir_table_in => tapir_util.get_tapir_table(a_table_name_in => a_table_name_in));
    END;

    --------------------------------------------------------------------------------
    PROCEDURE drop_tapi_coll_type_impl(a_tapir_table_in IN tapir_table) IS
    BEGIN
        execute_statement(a_sql_in         => tapir_util.get_tapi_coll_type_drop(a_tapir_table_in => a_tapir_table_in),
                          a_raise_error_in => FALSE);
    END;

    --------------------------------------------------------------------------------
    PROCEDURE drop_tapi_coll_type(a_table_name_in IN VARCHAR2) IS
    BEGIN
        drop_tapi_coll_type_impl(a_tapir_table_in => tapir_util.get_tapir_table(a_table_name_in => a_table_name_in));
    END;

    --------------------------------------------------------------------------------
    PROCEDURE create_tapi_package_impl(a_tapir_table_in IN tapir_table) IS
    BEGIN
        execute_statement(a_sql_in => tapir_util.get_tapi_package_spc_create(a_tapir_table_in => a_tapir_table_in));
        execute_statement(a_sql_in => tapir_util.get_tapi_package_bdy_create(a_tapir_table_in => a_tapir_table_in));
    END;

    --------------------------------------------------------------------------------
    PROCEDURE create_tapi_package(a_table_name_in IN VARCHAR2) IS
    BEGIN
        create_tapi_package_impl(a_tapir_table_in => tapir_util.get_tapir_table(a_table_name_in => a_table_name_in));
    END;

    --------------------------------------------------------------------------------
    PROCEDURE drop_tapi_package_impl(a_tapir_table_in IN tapir_table) IS
    BEGIN
        execute_statement(a_sql_in         => tapir_util.get_tapi_package_drop(a_tapir_table_in => a_tapir_table_in),
                          a_raise_error_in => FALSE);
    END;

    --------------------------------------------------------------------------------
    PROCEDURE drop_tapi_package(a_table_name_in IN VARCHAR2) IS
    BEGIN
        drop_tapi_package_impl(a_tapir_table_in => tapir_util.get_tapir_table(a_table_name_in => a_table_name_in));
    END;

    --------------------------------------------------------------------------------
    PROCEDURE create_all_for_table(a_table_name_in IN VARCHAR2) IS
        l_tapir_table tapir_table;
    BEGIN
        --
        l_tapir_table := tapir_util.get_tapir_table(a_table_name_in => a_table_name_in);
        --
        create_surrogate_key_seq_impl(a_tapir_table_in => l_tapir_table);
        create_tapi_object_type_impl(a_tapir_table_in => l_tapir_table);
        create_tapi_coll_type_impl(a_tapir_table_in => l_tapir_table);
        create_tapi_package_impl(a_tapir_table_in => l_tapir_table);
        --
    END;

    --------------------------------------------------------------------------------
    PROCEDURE drop_all_for_table(a_table_name_in IN VARCHAR2) IS
        l_tapir_table tapir_table;
    BEGIN
        --
        l_tapir_table := tapir_util.get_tapir_table(a_table_name_in => a_table_name_in);
        --
        drop_surrogate_key_seq_impl(a_tapir_table_in => l_tapir_table);
        drop_tapi_object_type_impl(a_tapir_table_in => l_tapir_table);
        drop_tapi_coll_type_impl(a_tapir_table_in => l_tapir_table);
        drop_tapi_package_impl(a_tapir_table_in => l_tapir_table);
        --
    END;

END tapir;
/
