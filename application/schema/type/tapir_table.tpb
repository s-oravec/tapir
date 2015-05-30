CREATE OR REPLACE TYPE BODY tapir_table AS

    --------------------------------------------------------------------------------
    CONSTRUCTOR FUNCTION tapir_table
    (
        owner           VARCHAR2 DEFAULT NULL,
        NAME            VARCHAR2 DEFAULT NULL,
        comments        VARCHAR2 DEFAULT NULL,
        column_list     tapir_column_list DEFAULT NULL,
        constraint_list tapir_constraint_list DEFAULT NULL,
        index_list      tapir_index_list DEFAULT NULL
    ) RETURN SELF AS RESULT IS
    BEGIN
        --
        self.owner           := owner;
        self.name            := NAME;
        self.comments        := comments;
        self.column_list     := column_list;
        self.constraint_list := constraint_list;
        self.index_list      := index_list;
        --
        RETURN;
        --
    END;

END;
/
