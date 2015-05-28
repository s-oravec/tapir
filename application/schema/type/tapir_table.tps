CREATE OR REPLACE TYPE tapir_table AS OBJECT
(
--tables
    owner VARCHAR2(30),
    NAME  VARCHAR2(128),
--tab_comments
    comments VARCHAR2(4000),
--lists
    table_columns     tapir_column_list, --ordered by column_id
    table_constraints tapir_constraint_list,
    table_indexes     tapir_index_list
)
/

