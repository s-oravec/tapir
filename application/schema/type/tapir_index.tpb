CREATE OR REPLACE TYPE BODY tapir_index AS

    --------------------------------------------------------------------------------
    CONSTRUCTOR FUNCTION tapir_index
    (
        NAME        IN VARCHAR2 DEFAULT NULL,
        index_type  IN VARCHAR2 DEFAULT NULL,
        uniqueness  IN VARCHAR2 DEFAULT NULL,
        column_list IN tapir_column_list DEFAULT NULL
    ) RETURN SELF AS RESULT IS
    BEGIN
        --
        self.name           := NAME;
        self.object_type    := 'INDEX';
        self.index_type     := index_type;
        self.uniqueness     := uniqueness;
        self.column_list    := column_list;
        --
        RETURN;
        --
    END;

END;
/
