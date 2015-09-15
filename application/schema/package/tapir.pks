CREATE OR REPLACE PACKAGE tapir AS

    --
    -- TAPIR main package
    --

    --------------------------------------------------------------------------------
    --
    -- create surrogate key sequence
    --
    -- %argument a_table_name_in table name
    --
    PROCEDURE create_surrogate_key_seq(a_table_name_in IN VARCHAR2);

    --
    -- drop surrogate key sequence
    --
    -- %argument a_table_name_in table name
    --
    PROCEDURE drop_surrogate_key_seq(a_table_name_in IN VARCHAR2);

    --
    -- create object type
    --
    -- %argument a_table_name_in table name
    --
    PROCEDURE create_tapi_object_type(a_table_name_in IN VARCHAR2);

    --
    -- drop object type
    --
    -- %argument a_table_name_in table name
    --
    PROCEDURE drop_tapi_object_type(a_table_name_in IN VARCHAR2);

    --
    -- create collection type
    --
    -- %argument a_table_name_in table name
    --
    PROCEDURE create_tapi_coll_type(a_table_name_in IN VARCHAR2);

    --
    -- drop collection type
    --
    -- %argument a_table_name_in table name
    --
    PROCEDURE drop_tapi_coll_type(a_table_name_in IN VARCHAR2);

    --
    -- create package specification
    --
    -- %argument a_table_name_in table name
    --
    PROCEDURE create_tapi_package(a_table_name_in IN VARCHAR2);

    --
    -- drop package specification
    --
    -- %argument a_table_name_in table name
    --
    PROCEDURE drop_tapi_package(a_table_name_in IN VARCHAR2);

    --------------------------------------------------------------------------------
    --
    -- drop surrogate key sequence
    --
    -- %argument a_table_name_in table name
    --
    PROCEDURE create_all_for_table(a_table_name_in IN VARCHAR2);

    --
    -- drop surrogate key sequence
    --
    -- %argument a_table_name_in table name
    --
    PROCEDURE drop_all_for_table(a_table_name_in IN VARCHAR2);

END tapir;
/
