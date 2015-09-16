CREATE OR REPLACE PACKAGE BODY tapir_util AS

    gc_index_type_normal CONSTANT VARCHAR2(30) := 'NORMAL';

    gc_cstr_type_primary_key CONSTANT VARCHAR2(1) := 'P';
    gc_cstr_type_foreign_key CONSTANT VARCHAR2(1) := 'R';
    gc_cstr_type_unique      CONSTANT VARCHAR2(1) := 'U';

    --------------------------------------------------------------------------------
    FUNCTION process_replaces
    (
        a_template_in IN VARCHAR2,
        a_replaces_in IN tapir_replaces
    ) RETURN VARCHAR2 IS
        l_result VARCHAR2(32767) := a_template_in;
    BEGIN
        IF a_replaces_in IS NULL
           OR a_replaces_in.count = 0
        THEN
            NULL;
        ELSE
            FOR i IN 1 .. a_replaces_in.count
            LOOP
                l_result := REPLACE(l_result,
                                    a_replaces_in(i).placeholder,
                                    a_replaces_in(i).value);
            END LOOP;
        END IF;
        --
        RETURN l_result;
        --
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_tapir_table(a_table_name_in IN user_tables.table_name%TYPE)
        RETURN tapir_table IS
        l_result tapir_table;
    BEGIN
        --
        -- NoFormat Start
        WITH table_columns AS
         (SELECT wtc.column_name,
                 wtc.data_type,
                 wtc.data_type_mod,
                 wtc.data_type_owner,
                 wtc.data_length,
                 wtc.data_precision,
                 wtc.data_scale,
                 wtc.nullable,
                 wtc.character_set_name,
                 wtc.char_col_decl_length,
                 wtc.char_length,
                 wtc.char_used,
                 wcc.comments,
                 wtc.column_id
            FROM user_tab_columns wtc, user_col_comments wcc
           WHERE wtc.table_name = a_table_name_in
             AND wtc.table_name = wcc.table_name
             AND wtc.column_name = wcc.column_name)
        SELECT tapir_table(owner           => USER,
                           NAME            => t.table_name,
                           comments        => tcm.comments,
                           column_list     => (SELECT CAST(COLLECT(tapir_column(column_name          => tc.column_name,
                                                                                data_type            => tc.data_type,
                                                                                data_type_mod        => tc.data_type_mod,
                                                                                data_type_owner      => tc.data_type_owner,
                                                                                data_length          => tc.data_length,
                                                                                data_precision       => tc.data_precision,
                                                                                data_scale           => tc.data_scale,
                                                                                nullable             => tc.nullable,
                                                                                character_set_name   => tc.character_set_name,
                                                                                char_col_decl_length => tc.char_col_decl_length,
                                                                                char_length          => tc.char_length,
                                                                                char_used            => tc.char_used,
                                                                                comments             => tc.comments)) AS
                                                           tapir_column_list)
                                                 FROM (SELECT tc.*
                                                         FROM table_columns tc
                                                        ORDER BY tc.column_id) tc),
                           constraint_list => (SELECT CAST(COLLECT(tapir_constraint(NAME              => cns.CONSTRAINT_NAME,
                                                                                    constraint_type   => cns.CONSTRAINT_TYPE,
                                                                                    r_owner           => cns.R_OWNER,
                                                                                    r_constraint_name => cns.R_CONSTRAINT_NAME,
                                                                                    RELY              => cns.RELY,
                                                                                    column_list       => (SELECT CAST(COLLECT(tapir_column(column_name          => tc.column_name,
                                                                                                                                           data_type            => tc.data_type,
                                                                                                                                           data_type_mod        => tc.data_type_mod,
                                                                                                                                           data_type_owner      => tc.data_type_owner,
                                                                                                                                           data_length          => tc.data_length,
                                                                                                                                           data_precision       => tc.data_precision,
                                                                                                                                           data_scale           => tc.data_scale,
                                                                                                                                           nullable             => tc.nullable,
                                                                                                                                           character_set_name   => tc.character_set_name,
                                                                                                                                           char_col_decl_length => tc.char_col_decl_length,
                                                                                                                                           char_length          => tc.char_length,
                                                                                                                                           char_used            => tc.char_used,
                                                                                                                                           comments             => tc.comments)) AS
                                                                                                                      tapir_column_list)
                                                                                                            FROM (SELECT tc.*
                                                                                                                    FROM table_columns     tc,
                                                                                                                         user_cons_columns cnsc
                                                                                                                   WHERE cnsc.constraint_name =
                                                                                                                         cns.constraint_name
                                                                                                                     AND cnsc.COLUMN_NAME =
                                                                                                                         tc.COLUMN_NAME
                                                                                                                   ORDER BY cnsc.POSITION) tc))) AS
                                                           tapir_constraint_list)
                                                 FROM (SELECT *
                                                         FROM user_constraints
                                                        WHERE table_name =  a_table_name_in
                                                          AND constraint_type IN
                                                              ( gc_cstr_type_primary_key,
                                                               gc_cstr_type_foreign_key                                                               ,
                                                               gc_cstr_type_unique                                                               )
                                                        ORDER BY constraint_name) cns),
                           index_list      => (SELECT CAST(COLLECT(tapir_index(NAME        => ind.index_NAME,
                                                                               index_type  => ind.index_TYPE,
                                                                               uniqueness  => ind.uniqueness,
                                                                               column_list => (SELECT CAST(COLLECT(tapir_column(column_name          => tc.column_name,
                                                                                                                                           data_type            => tc.data_type,
                                                                                                                                           data_type_mod        => tc.data_type_mod,
                                                                                                                                           data_type_owner      => tc.data_type_owner,
                                                                                                                                           data_length          => tc.data_length,
                                                                                                                                           data_precision       => tc.data_precision,
                                                                                                                                           data_scale           => tc.data_scale,
                                                                                                                                           nullable             => tc.nullable,
                                                                                                                                           character_set_name   => tc.character_set_name,
                                                                                                                                           char_col_decl_length => tc.char_col_decl_length,
                                                                                                                                           char_length          => tc.char_length,
                                                                                                                                           char_used            => tc.char_used,
                                                                                                                                           comments             => tc.comments)) AS
                                                                                                           tapir_column_list)
                                                                                                 FROM (SELECT tc.*
                                                                                                         FROM table_columns    tc,
                                                                                                              user_ind_columns indc
                                                                                                        WHERE indc.index_name =
                                                                                                              ind.index_name
                                                                                                          AND indc.COLUMN_NAME =
                                                                                                              tc.COLUMN_NAME
                                                                                                        ORDER BY indc.column_position) tc))) AS
                                                           tapir_index_list)
                                                 FROM (SELECT uind.*
                                                         FROM user_indexes uind
                                                        WHERE uind.table_name = a_table_name_in
                                                          AND uind.index_type = gc_index_type_normal
                                                        ORDER BY uind.index_name) ind)) AS table_obj
        INTO l_result
          FROM user_tables t, user_tab_comments tcm
         WHERE t.table_name = a_table_name_in
           AND tcm.table_name = t.TABLE_NAME;        
        -- NoFormat End
        --
        RETURN l_result;
        --
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_surrogate_key_seq_create(a_tapir_table_in IN tapir_table)
        RETURN VARCHAR2 IS
        l_stmt_tmpl VARCHAR2(255) --
        := 'create sequence #sequenceName#';
    BEGIN
        RETURN REPLACE(l_stmt_tmpl,
                       '#sequenceName#',
                       a_tapir_table_in.get_surrogate_key_seq_name);
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_surrogate_key_seq_drop(a_tapir_table_in IN tapir_table)
        RETURN VARCHAR2 IS
        l_stmt_tmpl VARCHAR2(255) --
        := 'drop sequence #sequenceName#';
    BEGIN
        RETURN REPLACE(l_stmt_tmpl,
                       '#sequenceName#',
                       a_tapir_table_in.get_surrogate_key_seq_name);
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_tapi_obj_type_spc_create(a_tapir_table_in IN tapir_table)
        RETURN VARCHAR2 IS
        l_stmt_tmpl VARCHAR2(255) --
        := 'create or replace type #typeName# force as object' || chr(10) --
           || '(' || chr(10) --
           || '#typeAttrDeclList#' || chr(10) --
           || '  CONSTRUCTOR FUNCTION #typeName#' || chr(10) --
           || '  (' || chr(10) --
           || '#typeCtorArgDeclList#' || chr(10) --
           || '  ) RETURN SELF AS RESULT' || chr(10) --
           || ');';
    BEGIN
        RETURN REPLACE(REPLACE(REPLACE(l_stmt_tmpl,
                                       '#typeName#',
                                       a_tapir_table_in.get_obj_type_name),
                               '#typeAttrDeclList#',
                               a_tapir_table_in.get_obj_type_attr_decl),
                       '#typeCtorArgDeclList#',
                       a_tapir_table_in.get_obj_type_ctor_args_decl);
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_tapi_obj_type_bdy_create(a_tapir_table_in IN tapir_table)
        RETURN VARCHAR2 IS
        l_stmt_tmpl VARCHAR2(255) --
        := 'create or replace type body #typeName# is' || chr(10) --
           || chr(10) --
           || '  CONSTRUCTOR FUNCTION #typeName#' || chr(10) --
           || '  (' || chr(10) --
           || '#typeCtorArgDeclList#' || chr(10) --
           || '  ) RETURN SELF AS RESULT IS' || chr(10) --
           || '  begin' || chr(10) --
           || '  --' || chr(10) --
           || '#typeCtorAttrAsgnList#' || chr(10) --
           || '  --' || chr(10) --
           || '  RETURN;' || chr(10) --
           || '  --' || chr(10) --
           || '  end;' || chr(10) --
           || 'end;';
    BEGIN
        RETURN REPLACE(REPLACE(REPLACE(l_stmt_tmpl,
                                       '#typeName#',
                                       a_tapir_table_in.get_obj_type_name),
                               '#typeCtorArgDeclList#',
                               a_tapir_table_in.get_obj_type_ctor_args_decl),
                       '#typeCtorAttrAsgnList#',
                       a_tapir_table_in.get_obj_type_ctor_attr_asgn);
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_tapi_obj_type_drop(a_tapir_table_in IN tapir_table)
        RETURN VARCHAR2 IS
        l_stmt_tmpl VARCHAR2(255) --
        := 'drop type #typeName# force';
    BEGIN
        RETURN REPLACE(l_stmt_tmpl,
                       '#typeName#',
                       a_tapir_table_in.get_obj_type_name);
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_tapi_coll_type_create(a_tapir_table_in IN tapir_table)
        RETURN VARCHAR2 IS
        l_stmt_tmpl VARCHAR2(255) --
        := 'create or replace type #collTypeName# force is table of #objTypeName#;';
    BEGIN
        RETURN REPLACE(REPLACE(l_stmt_tmpl,
                               '#collTypeName#',
                               a_tapir_table_in.get_coll_type_name),
                       '#objTypeName#',
                       a_tapir_table_in.get_obj_type_name);
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_tapi_coll_type_drop(a_tapir_table_in IN tapir_table)
        RETURN VARCHAR2 IS
        l_stmt_tmpl VARCHAR2(255) --
        := 'drop type #collTypeName# force';
    BEGIN
        RETURN REPLACE(l_stmt_tmpl,
                       '#collTypeName#',
                       a_tapir_table_in.get_coll_type_name);
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_tapi_package_spc_create(a_tapir_table_in IN tapir_table)
        RETURN VARCHAR2 IS
        -- NoFormat Start
        l_stmt_tmpl VARCHAR2(32767) --
        := 'CREATE OR REPLACE PACKAGE #tapirPackageName# AS' || chr(10)
           || '' || chr(10)
           || '    --types' || chr(10)
           || '    --------------------------------------------------------------------------------' || chr(10)
           || '    SUBTYPE #typRec# IS #tableName#%ROWTYPE;' || chr(10)
           || '    TYPE #typTab# IS TABLE OF #typRec#;' || chr(10)
           || '' || chr(10)
           || '    TYPE #typPkeyRec# IS RECORD(' || chr(10)
           || '        id #tableName#.id%TYPE);' || chr(10) --fixme: get real primary key columns using a_tapir_table_in
           || '' || chr(10)
           || '    SUBTYPE typ_boolean IS CHAR;' || chr(10)
           || '    gc_true  CONSTANT typ_boolean := ''Y'';' || chr(10)
           || '    gc_false CONSTANT typ_boolean := ''N'';' || chr(10)
           || '' || chr(10)
           || '    TYPE #typUpdIndRec# IS RECORD(' || chr(10)
           || '         #updIndRecordTypeDeclarationColumnList#);' || chr(10)
           || '    TYPE #typUpdIndTab# IS TABLE OF #typUpdIndRec#;' || chr(10)
           || '' || chr(10)
           || '    --get' || chr(10)
           || '    --------------------------------------------------------------------------------' || chr(10)
           || '    FUNCTION getRecByPKey(a_pkey_in IN #typPkeyRec#) RETURN #typRec#;' || chr(10)
           || '    FUNCTION getObjByPKey(a_pkey_in IN #typPkeyRec#) RETURN #objTypeName#;' || chr(10)
           || '' || chr(10)
           || '    --create' || chr(10)
           || '    --------------------------------------------------------------------------------' || chr(10)
           || '    PROCEDURE ins(#aRecIO# IN OUT #typRec#);' || chr(10)
           || '    PROCEDURE ins(#aObjIO# IN OUT #objTypeName#);' || chr(10)
           || '    PROCEDURE ins(#aTabIO# IN OUT NOCOPY #typTab#);' || chr(10)
           || '    PROCEDURE ins(#aColIO# IN OUT NOCOPY #collTypeName#);' || chr(10)
           || '' || chr(10)
           || '    --update' || chr(10)
           || '    --by default updates all columns' || chr(10)
           || '    --------------------------------------------------------------------------------' || chr(10)
           || '    PROCEDURE upd' || chr(10)
           || '    (' || chr(10)
           || '        #aRecIO#               IN OUT #typRec#,' || chr(10)
           || '        a_rec_upd_indicator_in IN #typUpdIndRec# DEFAULT NULL' || chr(10)
           || '    );' || chr(10)
           || '    PROCEDURE upd' || chr(10)
           || '    (' || chr(10)
           || '        #aObjIO#               IN OUT #objTypeName#,' || chr(10)
           || '        a_rec_upd_indicator_in IN #typUpdIndRec# DEFAULT NULL' || chr(10)
           || '    );' || chr(10)
           || '    PROCEDURE upd' || chr(10)
           || '    (' || chr(10)
           || '        #aTabIO#               IN OUT NOCOPY #typTab#,' || chr(10)
           || '        a_tab_upd_indicator_in IN #typUpdIndTab# DEFAULT NULL' || chr(10)
           || '    );' || chr(10)
           || '    PROCEDURE upd' || chr(10)
           || '    (' || chr(10)
           || '        #aColIO#               IN OUT NOCOPY #collTypeName#,' || chr(10)
           || '        a_tab_upd_indicator_in IN #typUpdIndTab# DEFAULT NULL' || chr(10)
           || '    );' || chr(10)
           || '' || chr(10)
           || '    --delete' || chr(10)
           || '    --------------------------------------------------------------------------------' || chr(10)
           || '    PROCEDURE del(#aRecIn# IN #typRec#);' || chr(10)
           || '    PROCEDURE del(#aObjIn# IN #objTypeName#);' || chr(10)
           || '    PROCEDURE del(#aTabIn# IN #typTab#);' || chr(10)
           || '    PROCEDURE del(#aColIn# IN #collTypeName#);' || chr(10)
           || '' || chr(10)
           || '    --convert functions' || chr(10)
           || '    --------------------------------------------------------------------------------' || chr(10)
           || '    FUNCTION convert(#aRecIn# IN #typRec#) RETURN #objTypeName#;' || chr(10)
           || '    FUNCTION convert(#aObjIn# IN #objTypeName#) RETURN #typRec#;' || chr(10)
           || '    FUNCTION convert(#aTabIn# IN #typTab#) RETURN #collTypeName#;' || chr(10)
           || '    FUNCTION convert(#aColIn# IN #collTypeName#) RETURN #typTab#;' || chr(10)
           || '' || chr(10)
           || 'END;';
           -- NoFormat End
        --
    BEGIN
        -- NoFormat Start
        return process_replaces(
            a_template_in => l_stmt_tmpl,
            a_replaces_in => tapir_replaces(
                --package name and table name
                tapir_replace('#tapirPackageName#', a_tapir_table_in.get_tapir_package_name),
                tapir_replace('#tableName#', lower(a_tapir_table_in.name)),
                --type_names
                tapir_replace('#objTypeName#', a_tapir_table_in.get_obj_type_name),
                tapir_replace('#collTypeName#', a_tapir_table_in.get_coll_type_name),
                --update indicator record type declaration
                tapir_replace('#updIndRecordTypeDeclarationColumnList#', a_tapir_table_in.get_updind_rectp_decl_col_list),
                --arguments - in
                tapir_replace('#aRecIn#', tapir_config.get_record_arg_tmpl       || tapir_config.get_in_arg_suffix),
                tapir_replace('#aObjIn#', tapir_config.get_object_arg_tmpl       || tapir_config.get_in_arg_suffix),
                tapir_replace('#aTabIn#', tapir_config.get_record_table_arg_tmpl || tapir_config.get_in_arg_suffix),
                tapir_replace('#aColIn#', tapir_config.get_object_table_arg_tmpl || tapir_config.get_in_arg_suffix),
                --arguments - in out
                tapir_replace('#aRecIO#', tapir_config.get_record_arg_tmpl       || tapir_config.get_inout_arg_suffix),
                tapir_replace('#aObjIO#', tapir_config.get_object_arg_tmpl       || tapir_config.get_inout_arg_suffix),
                tapir_replace('#aTabIO#', tapir_config.get_record_table_arg_tmpl || tapir_config.get_inout_arg_suffix),
                tapir_replace('#aColIO#', tapir_config.get_object_table_arg_tmpl || tapir_config.get_inout_arg_suffix),
                --types
                tapir_replace('#typUpdIndTab#', tapir_config.get_upd_ind_tab_rectp_tmpl),
                tapir_replace('#typUpdIndRec#', tapir_config.get_upd_ind_rectp_tmpl),
                tapir_replace('#typPkeyRec#', tapir_config.get_pkey_rec_type_tmpl),
                tapir_replace('#typTab#', tapir_config.get_rowtypetab_tp_tmpl),
                tapir_replace('#typRec#', tapir_config.get_rowtype_tp_alias_tmpl)
            )
        );
        -- NoFormat End
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_tapi_package_bdy_create(a_tapir_table_in IN tapir_table)
        RETURN VARCHAR2 IS
        -- NoFormat Start
        --TODO: _in -> tapir_config.get_in_arg_suffix
        --TODO: id  -> tapir_config.get_surrogate_key_column_name
        l_stmt_tmpl VARCHAR2(32767) --
        := 'CREATE OR REPLACE PACKAGE BODY #tapirPackageName# AS' || chr(10)
           || '' || chr(10)
           || '    --------------------------------------------------------------------------------' || chr(10)
           || '    FUNCTION getRecByPKey(a_pkey_in IN #typPkeyRec#) RETURN #typRec#' || chr(10)
           || '    IS' || chr(10)
           || '        l_result #typRec#;' || chr(10)
           || '    BEGIN' || chr(10)
           || '        SELECT * INTO l_result FROM #tableName# WHERE #aPKeySelectionList#;' || chr(10)
           || '        --' || chr(10)
           || '        RETURN l_result;' || chr(10)
           || '        --' || chr(10)
           || '    END;' || chr(10)
           || '' || chr(10)
           || '    --------------------------------------------------------------------------------' || chr(10)
           || '    FUNCTION getObjByPKey(a_pkey_in IN #typPkeyRec#) RETURN #objTypeName#' || chr(10)
           || '    IS' || chr(10)
           || '        l_result #objTypeName#;' || chr(10)
           || '    BEGIN' || chr(10)
           || '        SELECT #objTypeName#(#tableColumnList#)' || chr(10)
           || '          INTO l_result' || chr(10) 
           || '          FROM #tableName#' || chr(10)
           || '         WHERE #aPKeySelectionList#;' || chr(10)
           || '        --' || chr(10)
           || '        RETURN l_result;' || chr(10)
           || '        --' || chr(10)
           || '    END;' || chr(10)
           || '' || chr(10)
           || '    --------------------------------------------------------------------------------' || chr(10)
           || '    PROCEDURE ins(#aRecIO# IN OUT #typRec#)' || chr(10)
           || '    IS' || chr(10)
           || '    BEGIN' || chr(10)
           || '        --' || chr(10)
           || '        #aRecIO#.id := nvl(#aRecIO#.id, #surrogateKeySeqName#.nextval);' || chr(10)
           || '        --' || chr(10)
           || '        INSERT INTO #tableName# VALUES #aRecIO#;' || chr(10)
           || '        --' || chr(10)
           || '    END;' || chr(10)
           || '' || chr(10)
           || '    --------------------------------------------------------------------------------' || chr(10)
           || '    PROCEDURE ins(#aObjIO# IN OUT #objTypeName#)' || chr(10)
           || '    IS' || chr(10)
           || '    BEGIN' || chr(10)
           || '        --' || chr(10)
           || '        #aObjIO#.id := nvl(#aObjIO#.id, #surrogateKeySeqName#.nextval);' || chr(10)
           || '        --' || chr(10)
           || '        INSERT INTO #tableName#' || chr(10)
           || '        VALUES (#aObjIOCols#);' || chr(10)
           || '        --' || chr(10)
           || '    END;' || chr(10)
           || '' || chr(10)
           || '    --------------------------------------------------------------------------------' || chr(10)
           || '    PROCEDURE ins(#aTabIO# IN OUT NOCOPY #typTab#)' || chr(10)
           || '    IS' || chr(10)
           || '        l_iterator PLS_INTEGER;' || chr(10)
           || '    BEGIN' || chr(10)
           || '        IF #aTabIO# IS NOT NULL' || chr(10)
           || '           AND #aTabIO#.count > 0' || chr(10)
           || '        THEN' || chr(10)
           || '            l_iterator := #aTabIO#.first;' || chr(10)
           || '            WHILE l_iterator IS NOT NULL' || chr(10)
           || '            LOOP' || chr(10)
           || '                IF #aTabIO#(l_iterator).id IS NULL' || chr(10)
           || '                THEN' || chr(10)
           || '                    #aTabIO#(l_iterator).id := #surrogateKeySeqName#.nextval;' || chr(10)
           || '                END IF;' || chr(10)
           || '                l_iterator := #aTabIO#.next(l_iterator);' || chr(10)
           || '            END LOOP;' || chr(10)
           || '            --' || chr(10)
           || '            FORALL l_iterator IN INDICES OF #aTabIO#' || chr(10)
           || '                INSERT INTO #tableName# VALUES #aTabIO# (l_iterator);' || chr(10)
           || '        END IF;' || chr(10)
           || '    END;' || chr(10)
           || '' || chr(10)
           || '    --------------------------------------------------------------------------------' || chr(10)
           || '    PROCEDURE ins(#aColIO# IN OUT NOCOPY #collTypeName#) IS' || chr(10)
           || '        l_iterator PLS_INTEGER;' || chr(10)
           || '    BEGIN' || chr(10)
           || '        IF #aColIO# IS NOT NULL' || chr(10)
           || '           AND #aColIO#.count > 0' || chr(10)
           || '        THEN' || chr(10)
           || '            l_iterator := #aColIO#.first;' || chr(10)
           || '            WHILE l_iterator IS NOT NULL' || chr(10)
           || '            LOOP' || chr(10)
           || '                IF #aColIO#(l_iterator).id IS NULL' || chr(10)
           || '                THEN' || chr(10)
           || '                    #aColIO#(l_iterator).id := #surrogateKeySeqName#.nextval;' || chr(10)
           || '                END IF;' || chr(10)
           || '                l_iterator := #aColIO#.next(l_iterator);' || chr(10)
           || '            END LOOP;' || chr(10)
           || '        ' || chr(10)
           || '            FORALL l_iterator IN INDICES OF #aColIO#' || chr(10)
           || '                INSERT INTO #tableName#' || chr(10)
           || '                VALUES (#aColIOCols#);' || chr(10)
           || '        END IF;' || chr(10)
           || '    END;' || chr(10)
           || '' || chr(10)
           || '    --------------------------------------------------------------------------------' || chr(10)
           || '    PROCEDURE upd' || chr(10)
           || '    (' || chr(10)
           || '        #aRecIO#               IN OUT #typRec#,' || chr(10)
           || '        a_rec_upd_indicator_in IN #typUpdIndRec# DEFAULT NULL' || chr(10)
           || '    )' || chr(10)
           || '    IS' || chr(10)
           || '    BEGIN' || chr(10)
           || '        UPDATE #tableName#' || chr(10)
           || '           SET #aRecIOUpdateSetColumnList#' || chr(10)
           || '         WHERE id = #aRecIO#.id;' || chr(10)
           || '    END;' || chr(10)
           || '' || chr(10)
           || '    --------------------------------------------------------------------------------' || chr(10)
           || '    PROCEDURE upd' || chr(10)
           || '    (' || chr(10)
           || '        #aObjIO#               IN OUT #objTypeName#,' || chr(10)
           || '        a_rec_upd_indicator_in IN #typUpdIndRec# DEFAULT NULL' || chr(10)
           || '    )' || chr(10)
           || '    IS' || chr(10)
           || '    BEGIN' || chr(10)
           || '        UPDATE #tableName#' || chr(10)
           || '           SET #aObjIOUpdateSetColumnList#' || chr(10)
           || '         WHERE id = #aObjIO#.id;' || chr(10)
           || '    END;' || chr(10)
           || '' || chr(10)
           || '    --------------------------------------------------------------------------------' || chr(10)
           || '    PROCEDURE upd' || chr(10)
           || '    (' || chr(10)
           || '        #aTabIO#               IN OUT NOCOPY #typTab#,' || chr(10)
           || '        a_tab_upd_indicator_in IN #typUpdIndTab# DEFAULT NULL' || chr(10)
           || '    )' || chr(10)
           || '    IS' || chr(10)
           || '    BEGIN' || chr(10)
           || '        IF a_tab_upd_indicator_in IS NOT NULL' || chr(10)
           || '        THEN' || chr(10)
           || '            IF a_tab_upd_indicator_in.count = #aTabIO#.count' || chr(10)
           || '            THEN' || chr(10)
           || '                FORALL l_iterator IN INDICES OF #aTabIO#' || chr(10)
           || '                    UPDATE #tableName#' || chr(10)
           || '                       SET #aTabIOUpdateSetWithIndicatorColumnList#' || chr(10)
           || '                     WHERE id = #aTabIO#(l_iterator).id;' || chr(10)
           || '            ELSE' || chr(10)
           || '                raise_application_error(-20001,' || chr(10)
           || '                                        ''table and update indicator table count not same.'');' || chr(10)
           || '            END IF;' || chr(10)
           || '        ELSE' || chr(10)
           || '            --update all' || chr(10)
           || '            FORALL l_iterator IN INDICES OF #aTabIO#' || chr(10)
           || '                UPDATE #tableName#' || chr(10)
           || '                   SET #aTabIOUpdateSetWithoutIndicatorColumnList#' || chr(10)
           || '                 WHERE id = #aTabIO#(l_iterator).id;' || chr(10)
           || '        END IF;' || chr(10)
           || '    END;' || chr(10)
           || '' || chr(10)
           || '    --------------------------------------------------------------------------------' || chr(10)
           || '    PROCEDURE upd' || chr(10)
           || '    (' || chr(10)
           || '        #aColIO#               IN OUT NOCOPY #collTypeName#,' || chr(10)
           || '        a_tab_upd_indicator_in IN #typUpdIndTab# DEFAULT NULL' || chr(10)
           || '    )' || chr(10)
           || '    IS' || chr(10)
           || '    BEGIN' || chr(10)
           || '        IF a_tab_upd_indicator_in IS NOT NULL' || chr(10)
           || '        THEN' || chr(10)
           || '            IF a_tab_upd_indicator_in.count = #aColIO#.count' || chr(10)
           || '            THEN' || chr(10)
           || '                FORALL l_iterator IN INDICES OF #aColIO#' || chr(10)
           || '                    UPDATE #tableName#' || chr(10)
           || '                       SET #aColIOUpdateSetWithIndicatorColumnList#' || chr(10)
           || '                     WHERE id = #aColIO#(l_iterator).id;' || chr(10)
           || '            ELSE' || chr(10)
           || '                raise_application_error(-20001,' || chr(10)
           || '                                        ''collection and update indicator table count not same.'');' || chr(10)
           || '            END IF;' || chr(10)
           || '        ELSE' || chr(10)
           || '            --update all' || chr(10)
           || '            FORALL l_iterator IN INDICES OF #aColIO#' || chr(10)
           || '                UPDATE #tableName#' || chr(10)
           || '                   SET #aColIOUpdateSetWithoutIndicatorColumnList#' || chr(10)
           || '                 WHERE id = #aColIO#(l_iterator).id;' || chr(10)
           || '        END IF;' || chr(10)
           || '    END;' || chr(10)
           || '' || chr(10)
           || '    --------------------------------------------------------------------------------' || chr(10)
           || '    PROCEDURE del(#aRecIn# IN #typRec#)' || chr(10)
           || '    IS' || chr(10)
           || '    BEGIN' || chr(10)
           || '        DELETE FROM #tableName# WHERE id = #aRecIn#.id;' || chr(10)
           || '    END;' || chr(10)
           || '' || chr(10)
           || '    --------------------------------------------------------------------------------' || chr(10)
           || '    PROCEDURE del(#aObjIn# IN #objTypeName#)' || chr(10)
           || '    IS' || chr(10)
           || '    BEGIN' || chr(10)
           || '        DELETE FROM #tableName# WHERE id = #aObjIn#.id;' || chr(10)
           || '    END;' || chr(10)
           || '' || chr(10)
           || '    --------------------------------------------------------------------------------' || chr(10)
           || '    PROCEDURE del(#aTabIn# IN #typTab#)' || chr(10)
           || '    IS' || chr(10)
           || '    BEGIN' || chr(10)
           || '        FORALL l_iterator IN INDICES OF #aTabIn#' || chr(10)
           || '            DELETE #tableName# WHERE id = #aTabIn#(l_iterator).id;' || chr(10)
           || '    END;' || chr(10)
           || '' || chr(10)
           || '    --------------------------------------------------------------------------------' || chr(10)
           || '    PROCEDURE del(#aColIn# IN #collTypeName#)' || chr(10)
           || '    IS' || chr(10)
           || '    BEGIN' || chr(10)
           || '        FORALL l_iterator IN INDICES OF #aColIn#' || chr(10)
           || '            DELETE #tableName# WHERE id = #aColIn#(l_iterator).id;' || chr(10)
           || '    END;' || chr(10)
           || '' || chr(10)
           || '    --------------------------------------------------------------------------------' || chr(10)
           || '    FUNCTION convert(#aRecIn# IN #typRec#) RETURN #objTypeName#' || chr(10)
           || '    IS' || chr(10)
           || '    BEGIN' || chr(10)
           || '        RETURN #objTypeName#(#aRecInCols#);' || chr(10)
           || '    END;' || chr(10)
           || '' || chr(10)
           || '    --------------------------------------------------------------------------------' || chr(10)
           || '    FUNCTION convert(#aObjIn# IN #objTypeName#) RETURN #typRec# IS' || chr(10)
           || '        l_result #typRec#;' || chr(10)
           || '    BEGIN' || chr(10)
           || '        --' || chr(10)
           || '        #aObjAttrsToResultAttrsAssignment#' || chr(10)
           || '        --' || chr(10)
           || '        RETURN l_result;' || chr(10)
           || '        --' || chr(10)
           || '    END;' || chr(10)
           || '' || chr(10)
           || '    --------------------------------------------------------------------------------' || chr(10)
           || '    FUNCTION convert(#aTabIn# IN #typTab#) RETURN #collTypeName# IS' || chr(10)
           || '        l_result          #collTypeName#;' || chr(10)
           || '        l_tab_iterator    PLS_INTEGER;' || chr(10)
           || '        l_result_iterator PLS_INTEGER;' || chr(10)
           || '    BEGIN' || chr(10)
           || '        IF #aTabIn# IS NOT NULL' || chr(10)
           || '        THEN' || chr(10)
           || '            l_result := #collTypeName#();' || chr(10)
           || '            IF #aTabIn#.count > 0' || chr(10)
           || '            THEN' || chr(10)
           || '                l_result.extend(#aTabIn#.count);' || chr(10)
           || '                l_result_iterator := 0;' || chr(10)
           || '                l_tab_iterator    := #aTabIn#.first;' || chr(10)
           || '                WHILE l_tab_iterator IS NOT NULL' || chr(10)
           || '                LOOP' || chr(10)
           || '                    l_result_iterator := l_result_iterator + 1;' || chr(10)
           || '                    l_result(l_result_iterator) := convert(#aRecIn# => #aTabIn#(l_tab_iterator));' || chr(10)
           || '                    l_tab_iterator := #aTabIn#.next(l_tab_iterator);' || chr(10)
           || '                END LOOP;' || chr(10)
           || '            END IF;' || chr(10)
           || '        END IF;' || chr(10)
           || '        --' || chr(10)
           || '        RETURN l_result;' || chr(10)
           || '        --' || chr(10)
           || '    END;' || chr(10)
           || '' || chr(10)
           || '    --------------------------------------------------------------------------------' || chr(10)
           || '    FUNCTION convert(#aColIn# IN #collTypeName#) RETURN #typTab# IS' || chr(10)
           || '        l_result          #typTab#;' || chr(10)
           || '        l_col_iterator    PLS_INTEGER;' || chr(10)
           || '        l_result_iterator PLS_INTEGER;' || chr(10)
           || '    BEGIN' || chr(10)
           || '        IF #aColIn# IS NOT NULL' || chr(10)
           || '        THEN' || chr(10)
           || '            l_result := #typTab#();' || chr(10)
           || '            IF #aColIn#.count > 0' || chr(10)
           || '            THEN' || chr(10)
           || '                l_result.extend(#aColIn#.count);' || chr(10)
           || '                l_result_iterator := 0;' || chr(10)
           || '                l_col_iterator    := #aColIn#.first;' || chr(10)
           || '                WHILE l_col_iterator IS NOT NULL' || chr(10)
           || '                LOOP' || chr(10)
           || '                    l_result_iterator := l_result_iterator + 1;' || chr(10)
           || '                    l_result(l_result_iterator) := convert(#aObjIn# => #aColIn#(l_col_iterator));' || chr(10)
           || '                    l_col_iterator := #aColIn#.next(l_col_iterator);' || chr(10)
           || '                END LOOP;' || chr(10)
           || '            END IF;' || chr(10)
           || '        END IF;' || chr(10)
           || '        --' || chr(10)
           || '        RETURN l_result;' || chr(10)
           || '        --' || chr(10)
           || '    END;' || chr(10)
           || '' || chr(10)
           || 'END;';
           -- NoFormat End
        --
        l_pkey   tapir_constraint;
        --
    BEGIN
        --
        l_pkey := a_tapir_table_in.get_primary_key_constraint;
        -- NoFormat Start
        return process_replaces(
            a_template_in => l_stmt_tmpl,
            a_replaces_in => tapir_replaces(
                --package name and table name
                tapir_replace('#tapirPackageName#', a_tapir_table_in.get_tapir_package_name),
                tapir_replace('#tableName#', lower(a_tapir_table_in.name)),
                --type_names
                tapir_replace('#objTypeName#', a_tapir_table_in.get_obj_type_name),
                tapir_replace('#collTypeName#', a_tapir_table_in.get_coll_type_name),
                --update indicator record type declaration
                tapir_replace('#updIndRecordTypeDeclarationColumnList#', a_tapir_table_in.get_updind_rectp_decl_col_list),
                --arguments - in
                tapir_replace('#aRecIn#', tapir_config.get_record_arg_tmpl       || tapir_config.get_in_arg_suffix),
                tapir_replace('#aObjIn#', tapir_config.get_object_arg_tmpl       || tapir_config.get_in_arg_suffix),
                tapir_replace('#aTabIn#', tapir_config.get_record_table_arg_tmpl || tapir_config.get_in_arg_suffix),
                tapir_replace('#aColIn#', tapir_config.get_object_table_arg_tmpl || tapir_config.get_in_arg_suffix),
                --arguments - in out
                tapir_replace('#aRecIO#', tapir_config.get_record_arg_tmpl       || tapir_config.get_inout_arg_suffix),
                tapir_replace('#aObjIO#', tapir_config.get_object_arg_tmpl       || tapir_config.get_inout_arg_suffix),
                tapir_replace('#aTabIO#', tapir_config.get_record_table_arg_tmpl || tapir_config.get_inout_arg_suffix),
                tapir_replace('#aColIO#', tapir_config.get_object_table_arg_tmpl || tapir_config.get_inout_arg_suffix),
                --types
                tapir_replace('#typUpdIndTab#', tapir_config.get_upd_ind_tab_rectp_tmpl),
                tapir_replace('#typUpdIndRec#', tapir_config.get_upd_ind_rectp_tmpl),
                tapir_replace('#typPkeyRec#', tapir_config.get_pkey_rec_type_tmpl),
                tapir_replace('#typTab#', tapir_config.get_rowtypetab_tp_tmpl),
                tapir_replace('#typRec#', tapir_config.get_rowtype_tp_alias_tmpl),
                --pkey
                tapir_replace('#aPKeySelectionList#',
                              l_pkey.get_selection_record_cols_list(a_arg_inout_suffix_in       => tapir_config.get_in_arg_suffix,
                                                                    a_arg_name_base_override_in => 'a_pkey')),
                --sequence
                tapir_replace('#surrogateKeySeqName#', a_tapir_table_in.get_surrogate_key_seq_name),
                --assignments
                tapir_replace('#aObjAttrsToResultAttrsAssignment#',
                              a_tapir_table_in.get_assignment_col_list(a_src_object_name_in => tapir_config.get_object_arg_tmpl || tapir_config.get_in_arg_suffix,
                                                                       a_tgt_object_name_in => 'l_result')),
                --table column list
                tapir_replace('#tableColumnList#', a_tapir_table_in.get_cols_list),
                tapir_replace('#aRecInCols#',
                              a_tapir_table_in.get_object_cols_list(a_object_name_in => tapir_config.get_record_arg_tmpl ||
                                                                                        tapir_config.get_in_arg_suffix)),
                tapir_replace('#aObjIOCols#',
                              a_tapir_table_in.get_object_cols_list(a_object_name_in => tapir_config.get_object_arg_tmpl ||
                                                                                        tapir_config.get_inout_arg_suffix)),
                --TODO: refactor that '(l_iterator)'
                tapir_replace('#aColIOCols#',
                              a_tapir_table_in.get_object_cols_list(a_object_name_in => tapir_config.get_object_table_arg_tmpl ||
                                                                                        tapir_config.get_inout_arg_suffix ||
                                                                                        '(l_iterator)')),
                --update
                tapir_replace('#aRecIOUpdateSetColumnList#', a_tapir_table_in.get_rec_upd_set_wind_col_list),
                tapir_replace('#aObjIOUpdateSetColumnList#', a_tapir_table_in.get_obj_upd_set_wind_col_list),
                tapir_replace('#aTabIOUpdateSetWithIndicatorColumnList#', a_tapir_table_in.get_tab_upd_set_wind_col_list),
                tapir_replace('#aTabIOUpdateSetWithoutIndicatorColumnList#', a_tapir_table_in.get_tab_upd_set_woind_col_list),
                tapir_replace('#aColIOUpdateSetWithIndicatorColumnList#', a_tapir_table_in.get_col_upd_set_wind_col_list),
                tapir_replace('#aColIOUpdateSetWithoutIndicatorColumnList#', a_tapir_table_in.get_col_upd_set_woind_col_list)
            )
        );
        -- NoFormat End
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_tapi_package_drop(a_tapir_table_in IN tapir_table) RETURN VARCHAR2 IS
        l_stmt_tmpl VARCHAR2(255) --
        := 'drop package #tapirPackageName#';
    BEGIN
        RETURN REPLACE(l_stmt_tmpl,
                       '#tapirPackageName#',
                       a_tapir_table_in.get_tapir_package_name);
    END;

END;
/
