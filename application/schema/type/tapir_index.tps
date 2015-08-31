CREATE OR REPLACE TYPE tapir_index FORCE UNDER tapir_object_with_columns
(
--index
    index_type VARCHAR2(27),
    uniqueness VARCHAR2(9),

    CONSTRUCTOR FUNCTION tapir_index
    (
        NAME        IN VARCHAR2 DEFAULT NULL,
        index_type  IN VARCHAR2 DEFAULT NULL,
        uniqueness  VARCHAR2 DEFAULT NULL,
        column_list IN tapir_column_list DEFAULT NULL
    ) RETURN SELF AS RESULT
)
/
