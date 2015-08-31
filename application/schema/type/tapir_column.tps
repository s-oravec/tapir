CREATE OR REPLACE TYPE tapir_column FORCE AS OBJECT
(
--tab_columns
    column_name          VARCHAR2(128),
    data_type            VARCHAR2(128),
    data_type_mod        VARCHAR2(3),
    data_type_owner      VARCHAR2(128),
    data_length          NUMBER,
    data_precision       NUMBER,
    data_scale           NUMBER,
    nullable             VARCHAR2(1),
    character_set_name   VARCHAR2(44),
    char_col_decl_length NUMBER,
    char_length          NUMBER,
    char_used            VARCHAR2(1),
--col_comments
    comments VARCHAR2(4000),

    CONSTRUCTOR FUNCTION tapir_column
    (
        column_name          IN VARCHAR2 DEFAULT NULL,
        data_type            IN VARCHAR2 DEFAULT NULL,
        data_type_mod        IN VARCHAR2 DEFAULT NULL,
        data_type_owner      IN VARCHAR2 DEFAULT NULL,
        data_length          IN NUMBER DEFAULT NULL,
        data_precision       IN NUMBER DEFAULT NULL,
        data_scale           IN NUMBER DEFAULT NULL,
        nullable             IN VARCHAR2 DEFAULT NULL,
        character_set_name   IN VARCHAR2 DEFAULT NULL,
        char_col_decl_length IN NUMBER DEFAULT NULL,
        char_length          IN NUMBER DEFAULT NULL,
        char_used            IN VARCHAR2 DEFAULT NULL,
        comments             IN VARCHAR2 DEFAULT NULL
    ) RETURN SELF AS RESULT,

--get column declaration in SQL type
    MEMBER FUNCTION get_type_decl RETURN VARCHAR2,

--get column argument in constructor of SQL type
    MEMBER FUNCTION get_ctor_arg_decl RETURN VARCHAR2,

--get attribute assignment in constructor of SQL type
    MEMBER FUNCTION get_ctor_attr_asgn RETURN VARCHAR2,

-- selection expression for scalar column in argument
-- <column_name> = <scalar_arg_prefix><column_name> and
    MEMBER FUNCTION get_selection_arg RETURN VARCHAR2,

-- selection expression list for columns of record argument
-- <column_name> = <record_arg_prefix><object_name>.<column_name> and
    MEMBER FUNCTION get_selection_record RETURN VARCHAR2,

--
-- selection expression list for columns of object argument
-- <column_name> = <object_arg_prefix><object_name>.<column_name> and
    MEMBER FUNCTION get_selection_object RETURN VARCHAR2,

--
-- selection expression list for columns of table of records argument
-- <column_name> = <record_table_arg_prefix><object_name>(iterator).<column_name> and
    MEMBER FUNCTION get_selection_rectab(a_iterator_name_in IN VARCHAR2)
        RETURN VARCHAR2,

--
-- selection expression list for columns of table of objects argument
-- <column_name> = <object_table_arg_prefix><object_name>(iterator).<column_name> and
    MEMBER FUNCTION get_selection_objtab(a_iterator_name_in IN VARCHAR2)
        RETURN VARCHAR2
)
/
