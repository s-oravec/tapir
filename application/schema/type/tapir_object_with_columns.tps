CREATE OR REPLACE TYPE tapir_object_with_columns FORCE AS OBJECT
(
    NAME        VARCHAR2(128),
    object_type VARCHAR2(128), -- constraint | index | table
    column_list tapir_column_list, --ordered by position

--
--record type declaration column list
--<column_name> <table_name>.<column_name>%type
    MEMBER FUNCTION get_record_type_decl_col_list RETURN VARCHAR2,

--
-- selection expression list for scalar columns in arguments
-- <column_name> = <scalar_arg_prefix><column_name> and
    MEMBER FUNCTION get_selection_arg_cols_list RETURN VARCHAR2,

--
-- selection expression list for columns of record argument
-- <column_name> = <record_arg_prefix><object_name>.<column_name> and
    MEMBER FUNCTION get_selection_record_cols_list RETURN VARCHAR2,

--
-- selection expression list for columns of object argument
-- <column_name> = <object_arg_prefix><object_name>.<column_name> and
    MEMBER FUNCTION get_selection_object_cols_list RETURN VARCHAR2,

--
-- selection expression list for columns of table of records argument
-- <column_name> = <record_table_arg_prefix><object_name>(iterator).<column_name> and
    MEMBER FUNCTION get_selection_rectab_cols_list RETURN VARCHAR2,

--
-- selection expression list for columns of table of objects argument
-- <column_name> = <object_table_arg_prefix><object_name>(iterator).<column_name> and
    MEMBER FUNCTION get_selection_objtab_cols_list RETURN VARCHAR2

)
NOT FINAL NOT INSTANTIABLE
/
