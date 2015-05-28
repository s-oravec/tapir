CREATE OR REPLACE TYPE tapir_index AS OBJECT
(
--index
    NAME       VARCHAR2(128),
    index_type VARCHAR2(27),
    uniqueness VARCHAR2(9),
--ind_columns
    index_columns tapir_column_list --ordered by position
)
/

