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
        self.object_type     := 'TABLE';
        self.comments        := comments;
        self.column_list     := column_list;
        self.constraint_list := constraint_list;
        self.index_list      := index_list;
        --
        RETURN;
        --
    END;

    --------------------------------------------------------------------------------
    MEMBER FUNCTION get_surrogate_key_seq_name RETURN VARCHAR2 IS
    BEGIN
        RETURN lower(REPLACE(tapir_config.get_surrogate_key_seq_tmpl,
                             '{objectName}',
                             self.name));
    END;

    --------------------------------------------------------------------------------
    MEMBER FUNCTION get_obj_type_name RETURN VARCHAR2 IS
    BEGIN
        RETURN lower(REPLACE(tapir_config.get_object_type_tmpl,
                             '{objectName}',
                             self.name));
    END;

    --------------------------------------------------------------------------------
    MEMBER FUNCTION get_coll_type_name RETURN VARCHAR2 IS
    BEGIN
        RETURN lower(REPLACE(tapir_config.get_collection_type_tmpl,
                             '{objectName}',
                             self.name));
    END;

    --------------------------------------------------------------------------------
    MEMBER FUNCTION get_obj_type_attr_decl RETURN VARCHAR2 IS
        l_result VARCHAR2(32767);
    BEGIN
        FOR i IN 1 .. self.column_list.count
        LOOP
            l_result := l_result || self.column_list(i).get_type_decl || ',' ||
                        chr(10);
        END LOOP;
        --
        RETURN l_result;
        --
    END;

    --------------------------------------------------------------------------------
    MEMBER FUNCTION get_obj_type_ctor_args_decl RETURN VARCHAR2 IS
        l_result VARCHAR2(32767);
    BEGIN
        FOR i IN 1 .. self.column_list.count
        LOOP
            if i != self.column_list.count then
            l_result := l_result || self.column_list(i).get_ctor_arg_decl || ',' || chr(10);
            else
            l_result := l_result || self.column_list(i).get_ctor_arg_decl || chr(10);
            end if;
        END LOOP;
        --
        RETURN l_result;
        --
    END;

    --------------------------------------------------------------------------------
    MEMBER FUNCTION get_obj_type_ctor_attr_asgn RETURN VARCHAR2 IS
        l_result VARCHAR2(32767);
    BEGIN
        FOR i IN 1 .. self.column_list.count
        LOOP
            l_result := l_result || self.column_list(i).get_ctor_attr_asgn ||
                        chr(10);
        END LOOP;
        --
        RETURN l_result;
        --
    END;

END;
/
