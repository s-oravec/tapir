CREATE OR REPLACE TYPE tapir_table UNDER tapir_object_with_columns
(
--tables
    owner VARCHAR2(30),
--tab_comments
    comments VARCHAR2(4000),
--lists
    constraint_list tapir_constraint_list,
    index_list      tapir_index_list,

    CONSTRUCTOR FUNCTION tapir_table
    (
        owner           VARCHAR2 DEFAULT NULL,
        NAME            VARCHAR2 DEFAULT NULL,
        comments        VARCHAR2 DEFAULT NULL,
        column_list     tapir_column_list DEFAULT NULL,
        constraint_list tapir_constraint_list DEFAULT NULL,
        index_list      tapir_index_list DEFAULT NULL
    ) RETURN SELF AS RESULT,

    MEMBER FUNCTION get_surrogate_key_seq_name RETURN VARCHAR2
)
/
