CREATE OR REPLACE PACKAGE px_tapir_reference AS

    --types
    --------------------------------------------------------------------------------
    SUBTYPE typ_rec IS tapir_reference%ROWTYPE;
    TYPE typ_tab IS TABLE OF typ_rec;

    TYPE typ_pkey_rec IS RECORD(
        id tapir_reference.id%TYPE);

    SUBTYPE typ_boolean IS CHAR;
    gc_true  CONSTANT typ_boolean := 'Y';
    gc_false CONSTANT typ_boolean := 'N';
    TYPE typ_upd_indicator_rec IS RECORD(
        id  typ_boolean := gc_false,
        id1 typ_boolean := gc_false,
        id2 typ_boolean := gc_false,
        in1 typ_boolean := gc_false,
        v1  typ_boolean := gc_false);
    TYPE typ_upd_indicator_tab IS TABLE OF typ_upd_indicator_rec;

    --get
    --------------------------------------------------------------------------------
    FUNCTION getRecByPKey(a_pkey_in IN typ_pkey_rec) RETURN typ_rec;

    FUNCTION getObjByPKey(a_pkey_in IN typ_pkey_rec) RETURN tx_tapir_reference;

    --create
    --------------------------------------------------------------------------------
    PROCEDURE ins(a_rec_io IN OUT typ_rec);
    PROCEDURE ins(a_obj_io IN OUT tx_tapir_reference);
    PROCEDURE ins(a_tab_io IN OUT NOCOPY typ_tab);
    PROCEDURE ins(a_col_io IN OUT NOCOPY cx_tapir_reference);

    --update
    --by default updates all columns
    --------------------------------------------------------------------------------
    PROCEDURE upd
    (
        a_rec_io               IN OUT typ_rec,
        a_rec_upd_indicator_in IN typ_upd_indicator_rec DEFAULT NULL
    );
    PROCEDURE upd
    (
        a_obj_io               IN OUT tx_tapir_reference,
        a_rec_upd_indicator_in IN typ_upd_indicator_rec DEFAULT NULL
    );
    PROCEDURE upd
    (
        a_tab_io               IN OUT NOCOPY typ_tab,
        a_tab_upd_indicator_in IN typ_upd_indicator_tab DEFAULT NULL
    );
    PROCEDURE upd
    (
        a_col_io               IN OUT NOCOPY cx_tapir_reference,
        a_tab_upd_indicator_in IN typ_upd_indicator_tab DEFAULT NULL
    );

    --delete
    --------------------------------------------------------------------------------
    PROCEDURE del(a_rec_in IN typ_rec);
    PROCEDURE del(a_obj_in IN tx_tapir_reference);
    PROCEDURE del(a_tab_in IN typ_tab);
    PROCEDURE del(a_col_in IN cx_tapir_reference);

    --convert functions
    --------------------------------------------------------------------------------
    FUNCTION convert(a_rec_in IN typ_rec) RETURN tx_tapir_reference;
    FUNCTION convert(a_obj_in IN tx_tapir_reference) RETURN typ_rec;
    FUNCTION convert(a_tab_in IN typ_tab) RETURN cx_tapir_reference;
    FUNCTION convert(a_col_in IN cx_tapir_reference) RETURN typ_tab;

END;
/
