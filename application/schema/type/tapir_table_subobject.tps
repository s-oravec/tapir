CREATE OR REPLACE TYPE tapir_table_subobject AS OBJECT
(
    NAME           VARCHAR2(128),
    subobject_type VARCHAR2(128), -- constraint | index
    column_list    tapir_column_list, --ordered by position

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
