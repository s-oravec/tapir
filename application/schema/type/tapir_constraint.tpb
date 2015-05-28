CREATE OR REPLACE TYPE BODY tapir_constraint AS

    --------------------------------------------------------------------------------  
    CONSTRUCTOR FUNCTION tapir_constraint
    (
        NAME              VARCHAR2 DEFAULT NULL,
        constraint_type   VARCHAR2 DEFAULT NULL,
        r_owner           VARCHAR2 DEFAULT NULL,
        r_constraint_name VARCHAR2 DEFAULT NULL,
        RELY              VARCHAR2 DEFAULT NULL
    ) RETURN SELF AS RESULT IS
    BEGIN
        --
        self.NAME              := NAME;
        self.constraint_type   := constraint_type;
        self.r_owner           := r_owner;
        self.r_constraint_name := r_constraint_name;
        self.RELY              := RELY;
        --
        RETURN;
        --
    END;

    --------------------------------------------------------------------------------  
    MEMBER FUNCTION get_cons_column_list RETURN VARCHAR2 IS
    BEGIN
        RETURN NULL;
    END;

END;
/
