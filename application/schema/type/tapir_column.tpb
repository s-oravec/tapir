CREATE OR REPLACE TYPE BODY tapir_column AS

    --------------------------------------------------------------------------------
    CONSTRUCTOR FUNCTION tapir_column
    (
        column_name          IN VARCHAR2 DEFAULT NULL,
        data_type            IN VARCHAR2 DEFAULT NULL,
        data_type_mod        IN VARCHAR2 DEFAULT NULL,
        data_type_owner      IN VARCHAR2 DEFAULT NULL,
        data_length          IN NUMBER DEFAULT NULL,
        data_precision       IN NUMBER DEFAULT NULL,
        data_scale           IN NUMBER DEFAULT NULL,
        nullable             IN VARCHAR2 DEFAULT NULL,
        character_set_name   IN VARCHAR2 DEFAULT NULL,
        char_col_decl_length IN NUMBER DEFAULT NULL,
        char_length          IN NUMBER DEFAULT NULL,
        char_used            IN VARCHAR2 DEFAULT NULL,
        comments             IN VARCHAR2 DEFAULT NULL
    ) RETURN SELF AS RESULT IS
    BEGIN
        --
        self.column_name          := column_name;
        self.data_type            := data_type;
        self.data_type_mod        := data_type_mod;
        self.data_type_owner      := data_type_owner;
        self.data_length          := data_length;
        self.data_precision       := data_precision;
        self.data_scale           := data_scale;
        self.nullable             := nullable;
        self.character_set_name   := character_set_name;
        self.char_col_decl_length := char_col_decl_length;
        self.char_length          := char_length;
        self.char_used            := char_used;
        self.comments             := comments;
        --
        RETURN;
        --
    END;

    --------------------------------------------------------------------------------
    MEMBER FUNCTION get_type RETURN VARCHAR2 IS
        l_result VARCHAR2(255);
    BEGIN
        --
        l_result := lower(CASE
                              WHEN self.data_type IN ('TIMESTAMP(6)') THEN
                               'TIMESTAMP'
                              ELSE
                               self.data_type
                          END);
        --
        RETURN l_result;
        --
    END;

    --------------------------------------------------------------------------------
    MEMBER FUNCTION get_type_length RETURN VARCHAR2 IS
        l_result VARCHAR2(255);
    BEGIN
        --
        l_result := lower(CASE
                              WHEN self.data_type IN ('NUMBER', 'INTEGER') THEN
                               CASE
                                   WHEN self.data_precision IS NOT NULL THEN
                                    '(' || self.data_precision || CASE
                                        WHEN self.data_scale IS NOT NULL
                                             AND self.data_scale != 0 THEN
                                         ',' || self.data_scale
                                        ELSE
                                         NULL
                                    END || ')'
                                   ELSE
                                    CASE
                                        WHEN self.data_scale IS NOT NULL
                                             AND self.data_scale != 0 THEN
                                         '(38,' || self.data_scale || ')'
                                        WHEN self.data_scale IS NOT NULL
                                             AND self.data_scale = 0 THEN
                                         '(38)'
                                        ELSE
                                         NULL
                                    END
                               END
                              WHEN self.data_Type IN
                                   ('VARCHAR2', 'RAW', 'CHAR', 'VARCHAR') THEN
                               '(' || self.char_length || CASE char_used
                                   WHEN 'C' THEN
                                    ' CHAR'
                               END || ')'
                          END);
        --
        RETURN l_result;
        --
    END;

    --------------------------------------------------------------------------------  
    MEMBER FUNCTION get_type_decl RETURN VARCHAR2 IS
        l_result VARCHAR2(255);
    BEGIN
        --
        l_result := lower(self.column_name || ' ' || get_type ||
                          get_type_length);
        --
        RETURN l_result;
        --
    END;

    --------------------------------------------------------------------------------
    MEMBER FUNCTION get_ctor_arg_decl RETURN VARCHAR2 IS
        l_result VARCHAR2(255);
    BEGIN
        --
        l_result := lower(self.column_name || ' in ' || get_type ||
                          ' default null');
        --
        RETURN l_result;
        --
    END;

    --------------------------------------------------------------------------------
    MEMBER FUNCTION get_ctor_attr_asgn RETURN VARCHAR2 IS
        l_result VARCHAR2(255);
    BEGIN
        --
        l_result := lower('self.' || self.column_name || ' := ' ||
                          self.column_name || ';');
        --
        RETURN l_result;
        --
    END;

    --------------------------------------------------------------------------------
    MEMBER FUNCTION get_selection_arg(a_arg_inout_suffix_in IN VARCHAR2 DEFAULT NULL)
        RETURN VARCHAR2 IS
        l_result VARCHAR2(255);
    BEGIN
        --
        l_result := lower(self.column_name) || ' = ' ||
                    REPLACE(tapir_config.get_scalar_arg_tmpl,
                            '{columnName}',
                            lower(self.column_name)) || a_arg_inout_suffix_in;
        --
        RETURN l_result;
        --
    END;

    --------------------------------------------------------------------------------
    MEMBER FUNCTION get_selection_record
    (
        a_arg_inout_suffix_in       IN VARCHAR2 DEFAULT NULL,
        a_arg_name_base_override_in IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2 IS
        l_result VARCHAR2(255);
    BEGIN
        --
        l_result := lower(self.column_name) || ' = ' ||
                    nvl(a_arg_name_base_override_in,
                        tapir_config.get_record_arg_tmpl) ||
                    a_arg_inout_suffix_in || '.' || lower(self.column_name);
        --
        RETURN l_result;
        --
    END;

    --------------------------------------------------------------------------------
    MEMBER FUNCTION get_selection_object
    (
        a_arg_inout_suffix_in       IN VARCHAR2 DEFAULT NULL,
        a_arg_name_base_override_in IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2 IS
        l_result VARCHAR2(255);
    BEGIN
        --
        l_result := lower(self.column_name) || ' = ' ||
                    nvl(a_arg_name_base_override_in,
                        tapir_config.get_object_arg_tmpl) ||
                    a_arg_inout_suffix_in || '.' || lower(self.column_name);
        --
        RETURN l_result;
        --
    END;

    --------------------------------------------------------------------------------
    MEMBER FUNCTION get_selection_rectab
    (
        a_iterator_name_in    IN VARCHAR2,
        a_arg_inout_suffix_in IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2 IS
        l_result VARCHAR2(255);
    BEGIN
        --
        l_result := lower(self.column_name) || ' = ' ||
                    tapir_config.get_record_table_arg_tmpl ||
                    a_arg_inout_suffix_in || '(' || a_iterator_name_in || ')' || '.' ||
                    lower(self.column_name);
        --
        RETURN l_result;
        --
    END;

    --------------------------------------------------------------------------------
    MEMBER FUNCTION get_selection_objtab
    (
        a_iterator_name_in    IN VARCHAR2,
        a_arg_inout_suffix_in IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2 IS
        l_result VARCHAR2(255);
    BEGIN
        --
        l_result := lower(self.column_name) || ' = ' ||
                    tapir_config.get_object_table_arg_tmpl ||
                    a_arg_inout_suffix_in || '(' || a_iterator_name_in || ')' || '.' ||
                    lower(self.column_name);
        --
        RETURN l_result;
        --
    END;

END;
/
