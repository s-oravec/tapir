CREATE OR REPLACE PACKAGE tapir_util AS

    --
    -- TAPIR code generation utility functions
    --

    --
    -- Populates tapir_table object with table metadata
    --  - columns
    --  - unique constraints
    --  - indexes
    --
    -- %argument a_table_name_in table name
    --
    FUNCTION get_tapir_table(a_table_name_in IN user_tables.table_name%TYPE)
        RETURN tapir_table;

    --
    -- Returns surrogate key create staments
    --
    -- %argument a_tapir_table_in table metadata object
    --
    FUNCTION get_surrogate_key_seq_create(a_tapir_table_in IN tapir_table)
        RETURN VARCHAR2;

    --
    -- Returns surrogate key drop staments
    --
    -- %argument a_tapir_table_in table metadata object
    --
    FUNCTION get_surrogate_key_seq_drop(a_tapir_table_in IN tapir_table)
        RETURN VARCHAR2;

END;
/
