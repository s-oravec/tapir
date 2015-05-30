CREATE OR REPLACE TYPE BODY tapir_table_subobject AS

    MEMBER FUNCTION get_selection_arg_cols_list RETURN VARCHAR2 IS
    BEGIN
        return null;
    END;

    MEMBER FUNCTION get_selection_record_cols_list RETURN VARCHAR2 IS
    BEGIN
        RETURN NULL;
    END;

    MEMBER FUNCTION get_selection_object_cols_list RETURN VARCHAR2 IS
    BEGIN
        RETURN NULL;
    END;

    MEMBER FUNCTION get_selection_rectab_cols_list RETURN VARCHAR2 IS
    BEGIN
        RETURN NULL;
    END;

    MEMBER FUNCTION get_selection_objtab_cols_list RETURN VARCHAR2 IS
    BEGIN
        RETURN NULL;
    END;

END;
/
