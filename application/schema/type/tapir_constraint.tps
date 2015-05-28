CREATE OR REPLACE TYPE tapir_constraint AS OBJECT
(
--constraint
    NAME              VARCHAR2(128),
    constraint_type   VARCHAR2(1),
    r_owner           VARCHAR2(128),
    r_constraint_name VARCHAR2(128),
    RELY              VARCHAR2(4),
--cons_columns
    constraint_columns tapir_column_list, --ordered by position

    CONSTRUCTOR FUNCTION tapir_constraint
    (
        NAME              VARCHAR2 DEFAULT NULL,
        constraint_type   VARCHAR2 DEFAULT NULL,
        r_owner           VARCHAR2 DEFAULT NULL,
        r_constraint_name VARCHAR2 DEFAULT NULL,
        RELY              VARCHAR2 DEFAULT NULL
    ) RETURN SELF AS RESULT,

    MEMBER FUNCTION get_cons_column_list RETURN VARCHAR2
)
/
