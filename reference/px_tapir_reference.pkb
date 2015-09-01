CREATE OR REPLACE PACKAGE BODY px_tapir_reference IS

    --get
    --------------------------------------------------------------------------------
    FUNCTION getRecByPKey(a_pkey_in IN typ_pkey_rec) RETURN typ_rec IS
        l_result px_tapir_reference.typ_rec;
    BEGIN
        SELECT * INTO l_result FROM tapir_reference WHERE id = a_pkey_in.id;
        --
        RETURN l_result;
        --
    END;

    --------------------------------------------------------------------------------
    FUNCTION getObjByPKey(a_pkey_in IN typ_pkey_rec) RETURN tx_tapir_reference IS
        l_result tx_tapir_reference;
    BEGIN
        SELECT tx_tapir_reference(id, id1, id2, in1, v1)
          INTO l_result
          FROM tapir_reference
         WHERE id = a_pkey_in.id;
        --
        RETURN l_result;
        --
    END;

    --create
    --------------------------------------------------------------------------------
    PROCEDURE ins(a_rec_in IN OUT typ_rec) IS
    BEGIN
        --TODO: assumption: no triggers with side effects on row 
        --else whole row has to be in returning clause
        INSERT INTO tapir_reference
            (id, id1, id2, in1, v1)
        VALUES
            (nvl(a_rec_in.id, sx_tapir_reference.nextval),
             a_rec_in.id1,
             a_rec_in.id2,
             a_rec_in.in1,
             a_rec_in.v1)
        RETURNING id INTO a_rec_in.id;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE ins(a_obj_in IN OUT tx_tapir_reference) IS
    BEGIN
        INSERT INTO tapir_reference
            (id, id1, id2, in1, v1)
        VALUES
            (nvl(a_obj_in.id, sx_tapir_reference.nextval),
             a_obj_in.id1,
             a_obj_in.id2,
             a_obj_in.in1,
             a_obj_in.v1)
        RETURNING id INTO a_obj_in.id;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE ins(a_tab_in IN OUT NOCOPY typ_tab) IS
        l_iterator PLS_INTEGER;
    BEGIN
        IF a_tab_in IS NOT NULL
           AND a_tab_in.count > 0
        THEN
            l_iterator := a_tab_in.first;
            WHILE l_iterator IS NOT NULL
            LOOP
                IF a_tab_in(l_iterator).id IS NULL
                THEN
                    a_tab_in(l_iterator).id := sx_tapir_reference.nextval;
                END IF;
                l_iterator := a_tab_in.next(l_iterator);
            END LOOP;
        
            FORALL l_iterator IN INDICES OF a_tab_in
                INSERT INTO tapir_reference VALUES a_tab_in (l_iterator);
        END IF;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE ins(a_col_in IN OUT NOCOPY cx_tapir_reference) IS
        l_iterator PLS_INTEGER;
    BEGIN
        IF a_col_in IS NOT NULL
           AND a_col_in.count > 0
        THEN
            l_iterator := a_col_in.first;
            WHILE l_iterator IS NOT NULL
            LOOP
                IF a_col_in(l_iterator).id IS NULL
                THEN
                    a_col_in(l_iterator).id := sx_tapir_reference.nextval;
                END IF;
                l_iterator := a_col_in.next(l_iterator);
            END LOOP;
        
            FORALL l_iterator IN INDICES OF a_col_in
                INSERT INTO tapir_reference
                VALUES
                    (a_col_in(l_iterator).id,
                     a_col_in(l_iterator).id1,
                     a_col_in(l_iterator).id2,
                     a_col_in(l_iterator).in1,
                     a_col_in(l_iterator).v1);
        END IF;
    END;

    --update
    --------------------------------------------------------------------------------
    PROCEDURE upd
    (
        a_rec_in               IN OUT typ_rec,
        a_rec_upd_indicator_in IN typ_upd_indicator_rec DEFAULT NULL
    ) IS
    BEGIN
        UPDATE tapir_reference
           SET id1 = decode(nvl(a_rec_upd_indicator_in.id1, gc_true),
                            gc_true,
                            a_rec_in.id1,
                            id1),
               id2 = decode(nvl(a_rec_upd_indicator_in.id2, gc_true),
                            gc_true,
                            a_rec_in.id2,
                            id2),
               in1 = decode(nvl(a_rec_upd_indicator_in.in1, gc_true),
                            gc_true,
                            a_rec_in.in1,
                            in1),
               v1  = decode(nvl(a_rec_upd_indicator_in.v1, gc_true),
                            gc_true,
                            a_rec_in.v1,
                            v1)
         WHERE id = a_rec_in.id;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE upd
    (
        a_obj_in               IN OUT tx_tapir_reference,
        a_rec_upd_indicator_in IN typ_upd_indicator_rec DEFAULT NULL
    ) IS
    BEGIN
        UPDATE tapir_reference
           SET id1 = decode(nvl(a_rec_upd_indicator_in.id1, gc_true),
                            gc_true,
                            a_obj_in.id1,
                            id1),
               id2 = decode(nvl(a_rec_upd_indicator_in.id2, gc_true),
                            gc_true,
                            a_obj_in.id2,
                            id2),
               in1 = decode(nvl(a_rec_upd_indicator_in.in1, gc_true),
                            gc_true,
                            a_obj_in.in1,
                            in1),
               v1  = decode(nvl(a_rec_upd_indicator_in.v1, gc_true),
                            gc_true,
                            a_obj_in.v1,
                            v1)
         WHERE id = a_obj_in.id;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE upd
    (
        a_tab_in               IN OUT NOCOPY typ_tab,
        a_tab_upd_indicator_in IN typ_upd_indicator_tab DEFAULT NULL
    ) IS
    BEGIN
        IF a_tab_upd_indicator_in IS NOT NULL
        THEN
            IF a_tab_upd_indicator_in.count = a_tab_in.count
            THEN
                FORALL l_iterator IN INDICES OF a_tab_in
                    UPDATE tapir_reference
                       SET id1 = decode(nvl(a_tab_upd_indicator_in(l_iterator).id1,
                                            gc_true),
                                        gc_true,
                                        a_tab_in(l_iterator).id1,
                                        id1),
                           id2 = decode(nvl(a_tab_upd_indicator_in(l_iterator).id2,
                                            gc_true),
                                        gc_true,
                                        a_tab_in(l_iterator).id2,
                                        id2),
                           in1 = decode(nvl(a_tab_upd_indicator_in(l_iterator).in1,
                                            gc_true),
                                        gc_true,
                                        a_tab_in(l_iterator).in1,
                                        in1),
                           v1  = decode(nvl(a_tab_upd_indicator_in(l_iterator).v1,
                                            gc_true),
                                        gc_true,
                                        a_tab_in(l_iterator).v1,
                                        v1)
                     WHERE id = a_tab_in(l_iterator).id;
            ELSE
                raise_application_error(-20001,
                                        'table and update indicator table count not same.');
            END IF;
        ELSE
            --update aLL
            FORALL l_iterator IN INDICES OF a_tab_in
                UPDATE tapir_reference
                   SET id1 = a_tab_in(l_iterator).id1,
                       id2 = a_tab_in(l_iterator).id2,
                       in1 = a_tab_in(l_iterator).in1,
                       v1  = a_tab_in(l_iterator).v1
                 WHERE id = a_tab_in(l_iterator).id;
        END IF;
    
    END;

    --------------------------------------------------------------------------------
    PROCEDURE upd
    (
        a_col_in               IN OUT NOCOPY cx_tapir_reference,
        a_tab_upd_indicator_in IN typ_upd_indicator_tab DEFAULT NULL
    ) IS
    BEGIN
        IF a_tab_upd_indicator_in IS NOT NULL
        THEN
            IF a_tab_upd_indicator_in.count = a_col_in.count
            THEN
                FORALL l_iterator IN INDICES OF a_col_in
                    UPDATE tapir_reference
                       SET id1 = decode(nvl(a_tab_upd_indicator_in(l_iterator).id1,
                                            gc_true),
                                        gc_true,
                                        a_col_in(l_iterator).id1,
                                        id1),
                           id2 = decode(nvl(a_tab_upd_indicator_in(l_iterator).id2,
                                            gc_true),
                                        gc_true,
                                        a_col_in(l_iterator).id2,
                                        id2),
                           in1 = decode(nvl(a_tab_upd_indicator_in(l_iterator).in1,
                                            gc_true),
                                        gc_true,
                                        a_col_in(l_iterator).in1,
                                        in1),
                           v1  = decode(nvl(a_tab_upd_indicator_in(l_iterator).v1,
                                            gc_true),
                                        gc_true,
                                        a_col_in(l_iterator).v1,
                                        v1)
                     WHERE id = a_col_in(l_iterator).id;
            ELSE
                raise_application_error(-20001,
                                        'collection and update indicator table count not same.');
            END IF;
        ELSE
            --update aLL
            FORALL l_iterator IN INDICES OF a_col_in
                UPDATE tapir_reference
                   SET id1 = a_col_in(l_iterator).id1,
                       id2 = a_col_in(l_iterator).id2,
                       in1 = a_col_in(l_iterator).in1,
                       v1  = a_col_in(l_iterator).v1
                 WHERE id = a_col_in(l_iterator).id;
        END IF;
    END;

    --delete
    --------------------------------------------------------------------------------
    PROCEDURE del(a_rec_in IN typ_rec) IS
    BEGIN
        DELETE FROM tapir_reference WHERE id = a_rec_in.id;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE del(a_obj_in IN tx_tapir_reference) IS
    BEGIN
        DELETE FROM tapir_reference WHERE id = a_obj_in.id;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE del(a_tab_in IN typ_tab) IS
    BEGIN
        FORALL l_iterator IN INDICES OF a_tab_in
            DELETE tapir_reference WHERE id = a_tab_in(l_iterator).id;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE del(a_col_in IN cx_tapir_reference) IS
    BEGIN
        FORALL l_iterator IN INDICES OF a_col_in
            DELETE tapir_reference WHERE id = a_col_in(l_iterator).id;
    END;

    --convert functions
    --------------------------------------------------------------------------------
    FUNCTION convert(a_rec_in IN typ_rec) RETURN tx_tapir_reference IS
    BEGIN
        RETURN tx_tapir_reference(id  => a_rec_in.id,
                                  id1 => a_rec_in.id1,
                                  id2 => a_rec_in.id2,
                                  in1 => a_rec_in.in1,
                                  v1  => a_rec_in.v1);
    END;

    --------------------------------------------------------------------------------
    FUNCTION convert(a_obj_in IN tx_tapir_reference) RETURN typ_rec IS
        l_result typ_rec;
    BEGIN
        --
        l_result.id  := a_obj_in.id;
        l_result.id1 := a_obj_in.id1;
        l_result.id2 := a_obj_in.id2;
        l_result.in1 := a_obj_in.in1;
        l_result.v1  := a_obj_in.v1;
        --
        RETURN l_result;
        --
    END;

    --------------------------------------------------------------------------------
    FUNCTION convert(a_tab_in IN typ_tab) RETURN cx_tapir_reference IS
        l_result          cx_tapir_reference;
        l_tab_iterator    PLS_INTEGER;
        l_result_iterator PLS_INTEGER;
    BEGIN
        IF a_tab_in IS NOT NULL
        THEN
            l_result := cx_tapir_reference();
            IF a_tab_in.count > 0
            THEN
                l_result.extend(a_tab_in.count);
                l_result_iterator := 0;
                l_tab_iterator    := a_tab_in.first;
                WHILE l_tab_iterator IS NOT NULL
                LOOP
                    l_result_iterator := l_result_iterator + 1;
                    l_result(l_result_iterator) := convert(a_rec_in => a_tab_in(l_tab_iterator));
                    l_tab_iterator := a_tab_in.next(l_tab_iterator);
                END LOOP;
            END IF;
        END IF;
        --
        RETURN l_result;
        --
    END;

    --------------------------------------------------------------------------------
    FUNCTION convert(a_col_in IN cx_tapir_reference) RETURN typ_tab IS
        l_result          typ_tab;
        l_col_iterator    PLS_INTEGER;
        l_result_iterator PLS_INTEGER;
    BEGIN
        IF a_col_in IS NOT NULL
        THEN
            l_result := typ_tab();
            IF a_col_in.count > 0
            THEN
                l_result.extend(a_col_in.count);
                l_result_iterator := 0;
                l_col_iterator    := a_col_in.first;
                WHILE l_col_iterator IS NOT NULL
                LOOP
                    l_result_iterator := l_result_iterator + 1;
                    l_result(l_result_iterator) := convert(a_obj_in => a_col_in(l_col_iterator));
                    l_col_iterator := a_col_in.next(l_col_iterator);
                END LOOP;
            END IF;
        END IF;
        --
        RETURN l_result;
        --
    END;

END;
/
