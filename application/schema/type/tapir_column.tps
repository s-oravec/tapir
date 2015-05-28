CREATE OR REPLACE TYPE tapir_column AS OBJECT
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

    --get column type declaration
    MEMBER FUNCTION get_type_decl RETURN VARCHAR2,

    --get function column argument declaration
    MEMBER FUNCTION get_fnc_argument_decl RETURN VARCHAR2
)
/
