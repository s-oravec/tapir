CREATE OR REPLACE TYPE tx_tapir_reference AS OBJECT
(

    id  NUMBER(38, 0),
    id1 NUMBER(38, 0),
    id2 NUMBER(38, 0),
    in1 NUMBER(38, 0),
    v1  VARCHAR2(20),

    CONSTRUCTOR FUNCTION tx_tapir_reference
    (
        id1 IN NUMBER DEFAULT NULL,
        id2 IN NUMBER DEFAULT NULL,
        in1 IN NUMBER DEFAULT NULL,
        v1  IN VARCHAR2 DEFAULT NULL
    ) RETURN SELF AS RESULT

)
;
/
