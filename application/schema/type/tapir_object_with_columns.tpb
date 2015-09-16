CREATE OR REPLACE TYPE BODY tapir_object_with_columns AS

    --------------------------------------------------------------------------------
    MEMBER FUNCTION get_cols_list RETURN VARCHAR2 IS
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
    MEMBER FUNCTION get_object_cols_list(a_object_name_in IN VARCHAR2)
        RETURN VARCHAR2 IS
        l_result VARCHAR2(32767);
    BEGIN
        --
        FOR columnIdx IN self.column_list.first .. self.column_list.last
        LOOP
            --
            l_result := l_result || a_object_name_in || '.' ||
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
    MEMBER FUNCTION get_assignment_col_list
    (
        a_src_object_name_in IN VARCHAR2 DEFAULT NULL,
        a_tgt_object_name_in IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2 IS
        l_result VARCHAR2(32767);
    BEGIN
        --
        FOR columnIdx IN self.column_list.first .. self.column_list.last
        LOOP
            --
            l_result := l_result || self.column_list(columnIdx)
                       .get_assignment(a_src_object_name_in => a_src_object_name_in,
                                       a_tgt_object_name_in => a_tgt_object_name_in);
            --
        END LOOP;
        --
        RETURN l_result;
        --
    END;

    --------------------------------------------------------------------------------
    MEMBER FUNCTION get_rec_upd_set_wind_col_list RETURN VARCHAR2 IS
        l_result VARCHAR2(32767);
    BEGIN
        --
        FOR columnIdx IN self.column_list.first .. self.column_list.last
        LOOP
            --
            l_result := l_result ||
                        lower(self.column_list(columnIdx)
                              .column_name ||
                               ' = decode(nvl(a_rec_upd_indicator_in.' || self.column_list(columnIdx)
                              .column_name || ', gc_true), gc_true, ' ||
                               tapir_config.get_record_arg_tmpl ||
                               tapir_config.get_inout_arg_suffix || '.' || self.column_list(columnIdx)
                              .column_name || ', ' || self.column_list(columnIdx)
                              .column_name || ')');
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
    MEMBER FUNCTION get_obj_upd_set_wind_col_list RETURN VARCHAR2 IS
        l_result VARCHAR2(32767);
    BEGIN
        --
        FOR columnIdx IN self.column_list.first .. self.column_list.last
        LOOP
            --
            l_result := l_result ||
                        lower(self.column_list(columnIdx)
                              .column_name ||
                               ' = decode(nvl(a_rec_upd_indicator_in.' || self.column_list(columnIdx)
                              .column_name || ', gc_true), gc_true, ' ||
                               tapir_config.get_object_arg_tmpl ||
                               tapir_config.get_inout_arg_suffix || '.' || self.column_list(columnIdx)
                              .column_name || ', ' || self.column_list(columnIdx)
                              .column_name || ')');
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
    MEMBER FUNCTION get_tab_upd_set_wind_col_list RETURN VARCHAR2 IS
        l_result VARCHAR2(32767);
        --TODO: refactor all like this one
        l_a_tab_io VARCHAR2(255) := tapir_config.get_record_table_arg_tmpl ||
                                    tapir_config.get_inout_arg_suffix;
    BEGIN
        --
        FOR columnIdx IN self.column_list.first .. self.column_list.last
        LOOP
            -- NoFormat Start
            l_result := l_result ||
                        lower(self.column_list(columnIdx).column_name ||
                               ' = decode(nvl(a_tab_upd_indicator_in(l_iterator).' ||
                               self.column_list(columnIdx).column_name || ', gc_true), gc_true, ' ||
                               l_a_tab_io || '(l_iterator).' || self.column_list(columnIdx).column_name || ', ' ||
                               self.column_list(columnIdx).column_name || ')');
            -- NoFormat End
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
    MEMBER FUNCTION get_tab_upd_set_woind_col_list RETURN VARCHAR2 IS
        l_result VARCHAR2(32767);
    BEGIN
        --
        FOR columnIdx IN self.column_list.first .. self.column_list.last
        LOOP
            -- NoFormat Start
            l_result := l_result ||
                        lower(self.column_list(columnIdx).column_name || ' = '  ||
                        tapir_config.get_record_table_arg_tmpl || tapir_config.get_inout_arg_suffix || '(l_iterator).' ||
                        self.column_list(columnIdx).column_name);
            -- NoFormat End
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
    MEMBER FUNCTION get_col_upd_set_wind_col_list RETURN VARCHAR2 IS
        l_result VARCHAR2(32767);
        --TODO: refactor all like this one
        l_a_col_io VARCHAR2(255) := tapir_config.get_object_table_arg_tmpl ||
                                    tapir_config.get_inout_arg_suffix;
    BEGIN
        --
        FOR columnIdx IN self.column_list.first .. self.column_list.last
        LOOP
            -- NoFormat Start
            l_result := l_result ||
                        lower(self.column_list(columnIdx).column_name ||
                               ' = decode(nvl(a_tab_upd_indicator_in(l_iterator).' ||
                               self.column_list(columnIdx).column_name || ', gc_true), gc_true, ' || --TODO: gc_true to config
                               l_a_col_io || '(l_iterator).' || self.column_list(columnIdx).column_name || ', ' ||
                               self.column_list(columnIdx).column_name || ')');
            -- NoFormat End
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
    MEMBER FUNCTION get_col_upd_set_woind_col_list RETURN VARCHAR2 IS
        l_result VARCHAR2(32767);
    BEGIN
        --
        FOR columnIdx IN self.column_list.first .. self.column_list.last
        LOOP
            -- NoFormat Start
            l_result := l_result ||
                        lower(self.column_list(columnIdx).column_name || ' = '  ||
                        tapir_config.get_object_table_arg_tmpl || tapir_config.get_inout_arg_suffix || '(l_iterator).' ||
                        self.column_list(columnIdx).column_name);
            -- NoFormat End
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
