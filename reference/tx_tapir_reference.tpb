CREATE OR REPLACE TYPE BODY tx_tapir_reference AS

    --------------------------------------------------------------------------------
    CONSTRUCTOR FUNCTION tx_tapir_reference
    (
        id  IN NUMBER DEFAULT NULL,
        id1 IN NUMBER DEFAULT NULL,
        id2 IN NUMBER DEFAULT NULL,
        in1 IN NUMBER DEFAULT NULL,
        v1  IN VARCHAR2 DEFAULT NULL
    ) RETURN SELF AS RESULT IS
    BEGIN
        --
        self.id  := id;
        self.id1 := id1;
        self.id2 := id2;
        self.in1 := in1;
        self.v1  := v1;
        --
        RETURN;
        --
    END;

END;
/
