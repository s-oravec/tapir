CREATE OR REPLACE PACKAGE tapir AS

    --
    -- TAPIR main package
    --

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

END tapir;
/
