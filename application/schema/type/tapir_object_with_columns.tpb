CREATE OR REPLACE TYPE BODY tapir_object_with_columns AS

    --------------------------------------------------------------------------------
    MEMBER FUNCTION get_column_list RETURN VARCHAR2 IS
        l_result VARCHAR2(32767);
    BEGIN
        --
        FOR columnIdx IN self.column_list.first .. self.column_list.last
        LOOP
            --
            l_result := l_result ||
                        lower(self.column_list(columnIdx).column_name);
            --
            IF columnIdx != column_list.last
            THEN
                l_result := l_result || ',' || chr(10);
            END IF;
        END LOOP;
        --
        RETURN l_result;
        --
    END;

    --------------------------------------------------------------------------------
    MEMBER FUNCTION get_updind_rectp_decl_col_list RETURN VARCHAR2 IS
        l_result VARCHAR2(32767);
    BEGIN
        --
        FOR columnIdx IN self.column_list.first .. self.column_list.last
        LOOP
            --
            l_result := l_result ||
                        lower(self.column_list(columnIdx)
                              .column_name || ' typ_boolean := gc_false');
            --
            IF columnIdx != column_list.last
            THEN
                l_result := l_result || ',' || chr(10);
            END IF;
        END LOOP;
        --
        RETURN l_result;
        --
    END;

    --------------------------------------------------------------------------------
    MEMBER FUNCTION get_record_type_decl_col_list RETURN VARCHAR2 IS
        l_result VARCHAR2(32767);
    BEGIN
        --
        FOR columnIdx IN self.column_list.first .. self.column_list.last
        LOOP
            --
            l_result := l_result || lower(self.column_list(columnIdx)
                                          .column_name || ' ' || self.name || '.' || self.column_list(columnIdx)
                                          .column_name || '%type');
            --
            IF columnIdx != column_list.last
            THEN
                l_result := l_result || ',' || chr(10);
            END IF;
        END LOOP;
        --
        RETURN l_result;
        --
    END;

    --------------------------------------------------------------------------------
    MEMBER FUNCTION get_selection_arg_cols_list RETURN VARCHAR2 IS
        l_result VARCHAR2(32767);
    BEGIN
        --
        FOR columnIdx IN self.column_list.first .. self.column_list.last
        LOOP
            --
            l_result := l_result || self.column_list(columnIdx)
                       .get_selection_arg();
            --
            IF columnIdx != column_list.last
            THEN
                l_result := l_result || ' and ' || chr(10);
            END IF;
        END LOOP;
        --
        RETURN l_result;
        --
    END;

    --------------------------------------------------------------------------------
    MEMBER FUNCTION get_selection_record_cols_list
    (
        a_arg_inout_suffix_in       IN VARCHAR2 DEFAULT NULL,
        a_arg_name_base_override_in IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2 IS
        l_result VARCHAR2(32767);
    BEGIN
        --
        FOR columnIdx IN self.column_list.first .. self.column_list.last
        LOOP
            --
            l_result := l_result || self.column_list(columnIdx)
                       .get_selection_record(a_arg_inout_suffix_in       => a_arg_inout_suffix_in,
                                             a_arg_name_base_override_in => a_arg_name_base_override_in);
            --
            IF columnIdx != column_list.last
            THEN
                l_result := l_result || ' and ' || chr(10);
            END IF;
        END LOOP;
        --
        RETURN l_result;
        --
    END;

    --------------------------------------------------------------------------------
    MEMBER FUNCTION get_selection_object_cols_list
    (
        a_arg_inout_suffix_in       IN VARCHAR2 DEFAULT NULL,
        a_arg_name_base_override_in IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2 IS
        l_result VARCHAR2(32767);
    BEGIN
        --
        FOR columnIdx IN self.column_list.first .. self.column_list.last
        LOOP
            --
            l_result := l_result || self.column_list(columnIdx)
                       .get_selection_object(a_arg_inout_suffix_in       => a_arg_inout_suffix_in,
                                             a_arg_name_base_override_in => a_arg_name_base_override_in);
            --
            IF columnIdx != column_list.last
            THEN
                l_result := l_result || ' and ' || chr(10);
            END IF;
        END LOOP;
        --
        RETURN l_result;
        --
    END;

    --------------------------------------------------------------------------------
    MEMBER FUNCTION get_selection_rectab_cols_list
    (
        a_iterator_name_in    IN VARCHAR2,
        a_arg_inout_suffix_in IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2 IS
        l_result VARCHAR2(32767);
    BEGIN
        --
        FOR columnIdx IN self.column_list.first .. self.column_list.last
        LOOP
            --
            l_result := l_result || self.column_list(columnIdx)
                       .get_selection_rectab(a_iterator_name_in    => nvl(a_iterator_name_in,
                                                                          'iter'),
                                             a_arg_inout_suffix_in => a_arg_inout_suffix_in);
            --
            IF columnIdx != column_list.last
            THEN
                l_result := l_result || ' and ' || chr(10);
            END IF;
        END LOOP;
        --
        RETURN l_result;
        --
    END;

    --------------------------------------------------------------------------------
    MEMBER FUNCTION get_selection_objtab_cols_list
    (
        a_iterator_name_in    IN VARCHAR2,
        a_arg_inout_suffix_in IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2 IS
        l_result VARCHAR2(32767);
    BEGIN
        --
        FOR columnIdx IN self.column_list.first .. self.column_list.last
        LOOP
            --
            l_result := l_result || self.column_list(columnIdx)
                       .get_selection_objtab(a_iterator_name_in    => nvl(a_iterator_name_in,
                                                                          'iter'),
                                             a_arg_inout_suffix_in => a_arg_inout_suffix_in);
            --
            IF columnIdx != column_list.last
            THEN
                l_result := l_result || ' and ' || chr(10);
            END IF;
        END LOOP;
        --
        RETURN l_result;
        --
    END;

END;
/
