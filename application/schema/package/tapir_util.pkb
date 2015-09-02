CREATE OR REPLACE PACKAGE BODY tapir_util AS

    gc_index_type_normal CONSTANT VARCHAR2(30) := 'NORMAL';

    gc_cstr_type_primary_key CONSTANT VARCHAR2(1) := 'P';
    gc_cstr_type_foreign_key CONSTANT VARCHAR2(1) := 'R';
    gc_cstr_type_unique      CONSTANT VARCHAR2(1) := 'U';

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
        l_stmt_tmpl VARCHAR2(32767) --
        := 'CREATE OR REPLACE PACKAGE #tapirPackageName# AS' || chr(10) --
           || '' || chr(10) --
           || '    --types' || chr(10) --
           ||
           '    --------------------------------------------------------------------------------' ||
           chr(10) --
           || '    SUBTYPE typ_rec IS #tableName#%ROWTYPE;' || chr(10) --
           || '    TYPE typ_tab IS TABLE OF typ_rec;' || chr(10) --
           || '' || chr(10) --
           || '    TYPE typ_pkey_rec IS RECORD(' || chr(10) --
           || '        id #tableName#.id%TYPE);' || chr(10) --fixme: get real primary key columns using a_tapir_table_in
           || '' || chr(10) --
           || '    SUBTYPE typ_boolean IS CHAR;' || chr(10) --
           || '    gc_true  CONSTANT typ_boolean := ''Y'';' || chr(10) --
           || '    gc_false CONSTANT typ_boolean := ''N'';' || chr(10) --
           || '' || chr(10) --
           || '    TYPE typ_upd_indicator_rec IS RECORD(' || chr(10) --
           || '         #updIndRecordTypeDeclarationColumnList#);' || chr(10) --
           ||
           '    TYPE typ_upd_indicator_tab IS TABLE OF typ_upd_indicator_rec;' ||
           chr(10) --
           || '' || chr(10) --
           || '    --get' || chr(10) --
           ||
           '    --------------------------------------------------------------------------------' ||
           chr(10) --
           ||
           '    FUNCTION getRecByPKey(a_pkey_in IN typ_pkey_rec) RETURN typ_rec;' ||
           chr(10) --
           || '' || chr(10) --
           ||
           '    FUNCTION getObjByPKey(a_pkey_in IN typ_pkey_rec) RETURN #objTypeName#;' ||
           chr(10) --
           || '' || chr(10) --
           || '    --create' || chr(10) --
           ||
           '    --------------------------------------------------------------------------------' ||
           chr(10) --
           || '    PROCEDURE ins(#aRecIO# IN OUT typ_rec);' || chr(10) --
           || '    PROCEDURE ins(#aObjIO# IN OUT #objTypeName#);' || chr(10) --
           || '    PROCEDURE ins(#aTabIO# IN OUT NOCOPY typ_tab);' || chr(10) --
           || '    PROCEDURE ins(#aColIO# IN OUT NOCOPY #collTypeName#);' ||
           chr(10) --
           || '' || chr(10) --
           || '    --update' || chr(10) --
           || '    --by default updates all columns' || chr(10) --
           ||
           '    --------------------------------------------------------------------------------' ||
           chr(10) --
           || '    PROCEDURE upd' || chr(10) --
           || '    (' || chr(10) --
           || '        #aRecIO#               IN OUT typ_rec,' || chr(10) --
           ||
           '        a_rec_upd_indicator_in IN typ_upd_indicator_rec DEFAULT NULL' ||
           chr(10) --
           || '    );' || chr(10) --
           || '    PROCEDURE upd' || chr(10) --
           || '    (' || chr(10) --
           || '        #aObjIO#               IN OUT #objTypeName#,' || chr(10) --
           ||
           '        a_rec_upd_indicator_in IN typ_upd_indicator_rec DEFAULT NULL' ||
           chr(10) --
           || '    );' || chr(10) --
           || '    PROCEDURE upd' || chr(10) --
           || '    (' || chr(10) --
           || '        #aTabIO#               IN OUT NOCOPY typ_tab,' ||
           chr(10) --
           ||
           '        a_tab_upd_indicator_in IN typ_upd_indicator_tab DEFAULT NULL' ||
           chr(10) --
           || '    );' || chr(10) --
           || '    PROCEDURE upd' || chr(10) --
           || '    (' || chr(10) --
           || '        #aColIO#               IN OUT NOCOPY #collTypeName#,' ||
           chr(10) --
           ||
           '        a_tab_upd_indicator_in IN typ_upd_indicator_tab DEFAULT NULL' ||
           chr(10) --
           || '    );' || chr(10) --
           || '' || chr(10) --
           || '    --delete' || chr(10) --
           ||
           '    --------------------------------------------------------------------------------' ||
           chr(10) --
           || '    PROCEDURE del(#aRecIn# IN typ_rec);' || chr(10) --
           || '    PROCEDURE del(#aObjIn# IN #objTypeName#);' || chr(10) --
           || '    PROCEDURE del(#aTabIn# IN typ_tab);' || chr(10) --
           || '    PROCEDURE del(#aColIn# IN #collTypeName#);' || chr(10) --
           || '' || chr(10) --
           || '    --convert functions' || chr(10) --
           ||
           '    --------------------------------------------------------------------------------' ||
           chr(10) --
           || '    FUNCTION convert(#aRecIn# IN typ_rec) RETURN #objTypeName#;' ||
           chr(10) --
           || '    FUNCTION convert(#aObjIn# IN #objTypeName#) RETURN typ_rec;' ||
           chr(10) --
           ||
           '    FUNCTION convert(#aTabIn# IN typ_tab) RETURN #collTypeName#;' ||
           chr(10) --
           ||
           '    FUNCTION convert(#aColIn# IN #collTypeName#) RETURN typ_tab;' ||
           chr(10) --
           || '' || chr(10) --
           || 'END;';
           --
           l_result varchar2(32767);
           --
    BEGIN
        --package name and table name
        l_result := replace(replace(l_stmt_tmpl,
                                    '#tapirPackageName#',
                                    a_tapir_table_in.get_tapir_package_name),
                                '#tableName#',
                                lower(a_tapir_table_in.name));
        --type names
        l_result := replace(replace(l_result,
                                    '#objTypeName#',
                                    a_tapir_table_in.get_obj_type_name),
                                '#collTypeName#',
                                a_tapir_table_in.get_coll_type_name);
        --update indicator record type declaration
        l_result := replace(l_result,
                            '#updIndRecordTypeDeclarationColumnList#',
                            a_tapir_table_in.get_updind_rectp_decl_col_list);
        --arguments - in
        l_result := replace(replace(replace(replace(l_result,
                                                    '#aRecIn#',
                                                    tapir_config.get_record_arg_tmpl || tapir_config.get_in_arg_suffix),
                                                '#aObjIn#',
                                                tapir_config.get_object_arg_tmpl || tapir_config.get_in_arg_suffix),
                                            '#aTabIn#',
                                            tapir_config.get_record_table_arg_tmpl || tapir_config.get_in_arg_suffix),
                                        '#aColIn#',
                                        tapir_config.get_object_table_arg_tmpl || tapir_config.get_in_arg_suffix);
        --arguments - in out
        l_result := replace(replace(replace(replace(l_result,
                                                    '#aRecIO#',
                                                    tapir_config.get_record_arg_tmpl || tapir_config.get_inout_arg_suffix),
                                                '#aObjIO#',
                                                tapir_config.get_object_arg_tmpl || tapir_config.get_inout_arg_suffix),
                                            '#aTabIO#',
                                            tapir_config.get_record_table_arg_tmpl || tapir_config.get_inout_arg_suffix),
                                        '#aColIO#',
                                        tapir_config.get_object_table_arg_tmpl || tapir_config.get_inout_arg_suffix);
        --
        return l_result;
        --
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_tapi_package_bdy_create(a_tapir_table_in IN tapir_table)
        RETURN VARCHAR2 IS
        l_stmt_tmpl VARCHAR2(255) --
        := '';
    BEGIN
        RETURN '';
    END;

END;
/
