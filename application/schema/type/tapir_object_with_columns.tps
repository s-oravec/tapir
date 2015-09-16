CREATE OR REPLACE TYPE tapir_object_with_columns FORCE AS OBJECT
(
    NAME        VARCHAR2(128),
    object_type VARCHAR2(128), -- constraint | index | table
    column_list tapir_column_list, --ordered by position

--
--get plain column list
--<column_name>
    MEMBER FUNCTION get_cols_list RETURN VARCHAR2,

--
--get plain column list
--<object_name>.<column_name>
    MEMBER FUNCTION get_object_cols_list(a_object_name_in IN VARCHAR2)
        RETURN VARCHAR2,

--
--get plain column list
--[<tgt_object_name>.]<column_name> := [<src_object_name>.]<column_name>
    MEMBER FUNCTION get_assignment_col_list
    (
        a_src_object_name_in IN VARCHAR2 DEFAULT NULL,
        a_tgt_object_name_in IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2,

--
--get record update column list
--<column_name> = decode(nvl(a_rec_upd_indicator_in.<column_name>, gc_true), gc_true, a_rec_io.<column_name>, <column_name>),
    MEMBER FUNCTION get_rec_upd_set_wind_col_list RETURN VARCHAR2,

--
--get object update column list
--<column_name> = decode(nvl(a_rec_upd_indicator_in.<column_name>, gc_true), gc_true, a_obj_io.<column_name>, <column_name>),
    MEMBER FUNCTION get_obj_upd_set_wind_col_list RETURN VARCHAR2,

--
--get table update column list - with update indicator
--<column_name> = decode(nvl(a_tab_upd_indicator_in(l_iterator).<column_name>, gc_true), gc_true, a_tab_io(l_iterator).<column_name>, <column_name>),
    MEMBER FUNCTION get_tab_upd_set_wind_col_list RETURN VARCHAR2,

--
--get table update column list - without update indicator
--<column_name> = `a_tab_io(l_iterator).<column_name>
    MEMBER FUNCTION get_tab_upd_set_woind_col_list RETURN VARCHAR2,

--
--get table of objects update column list - with update indicator
--<column_name> = decode(nvl(a_col_upd_indicator_in(l_iterator).<column_name>, gc_true), gc_true, a_col_io(l_iterator).<column_name>, <column_name>),
    MEMBER FUNCTION get_col_upd_set_wind_col_list RETURN VARCHAR2,

--
--get table of objects update column list - without update indicator
--<column_name> = a_col_io(l_iterator).<column_name>
    MEMBER FUNCTION get_col_upd_set_woind_col_list RETURN VARCHAR2,

--
--get update indicator record type declaration column list
--<column_name> typ_boolean := gc_false
    MEMBER FUNCTION get_updind_rectp_decl_col_list RETURN VARCHAR2,

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
    MEMBER FUNCTION get_selection_record_cols_list
    (
        a_arg_inout_suffix_in       IN VARCHAR2 DEFAULT NULL,
        a_arg_name_base_override_in IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2,

--
-- selection expression list for columns of object argument
-- <column_name> = <object_arg_prefix><object_name>.<column_name> and
    MEMBER FUNCTION get_selection_object_cols_list
    (
        a_arg_inout_suffix_in       IN VARCHAR2 DEFAULT NULL,
        a_arg_name_base_override_in IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2,

--
-- selection expression list for columns of table of records argument
-- <column_name> = <record_table_arg_prefix><object_name>(iterator).<column_name> and
    MEMBER FUNCTION get_selection_rectab_cols_list
    (
        a_iterator_name_in    IN VARCHAR2,
        a_arg_inout_suffix_in IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2,

--
-- selection expression list for columns of table of objects argument
-- <column_name> = <object_table_arg_prefix><object_name>(iterator).<column_name> and
    MEMBER FUNCTION get_selection_objtab_cols_list
    (
        a_iterator_name_in    IN VARCHAR2,
        a_arg_inout_suffix_in IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2

)
NOT FINAL NOT INSTANTIABLE
/
