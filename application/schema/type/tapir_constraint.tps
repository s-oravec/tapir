CREATE OR REPLACE TYPE tapir_constraint UNDER tapir_object_with_columns
(
--constraint
    constraint_type   VARCHAR2(1),
    r_owner           VARCHAR2(128),
    r_constraint_name VARCHAR2(128),
    RELY              VARCHAR2(4),

    CONSTRUCTOR FUNCTION tapir_constraint
    (
        NAME              VARCHAR2 DEFAULT NULL,
        constraint_type   VARCHAR2 DEFAULT NULL,
        r_owner           VARCHAR2 DEFAULT NULL,
        r_constraint_name VARCHAR2 DEFAULT NULL,
        RELY              VARCHAR2 DEFAULT NULL,
        column_list       tapir_column_list DEFAULT NULL
    ) RETURN SELF AS RESULT

)
/
