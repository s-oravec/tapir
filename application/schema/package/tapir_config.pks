CREATE OR REPLACE PACKAGE TAPIR_CONFIG AS

    --
    -- Tapir config API package
    --

    --
    -- Object type template
    --------------------------------------------------------------------------------
    --
    g_OBJECT_TYPE_TMPL_DFLT CONSTANT VARCHAR2(128) := 'tx_{objectName}';

    --
    -- Sets prefix for test packages
    --
    -- %argument a_value_in
    -- %argument a_set_as_default if true then the a_value_in is stored in config table TAPIR_CONFIG and becomes sesssion default
    --
    PROCEDURE set_object_type_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_OBJECT_TYPE_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    );

    --
    -- returns current settings of show_hook_methods system parameter
    --
    FUNCTION get_object_type_tmpl RETURN VARCHAR2;

    --
    -- Collection type (CREATE TYPE <CollectionType> AS TABLE OF <ObjecTypeName>) template
    --------------------------------------------------------------------------------
    --
    g_COLLECTION_TYPE_TMPL_DFLT CONSTANT VARCHAR2(128) := 'cx_{objectName}';

    --
    -- Sets prefix for test packages
    --
    -- %argument a_value_in
    -- %argument a_set_as_default if true then the a_value_in is stored in config table TAPIR_CONFIG and becomes sesssion default
    --
    PROCEDURE set_collection_type_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_COLLECTION_TYPE_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    );

    --
    -- returns current settings of show_hook_methods system parameter
    --
    FUNCTION get_collection_type_tmpl RETURN VARCHAR2;

    --
    -- TAPI package name template
    --------------------------------------------------------------------------------
    --
    g_tapir_PACKAGE_TMPL_DFLT CONSTANT VARCHAR2(128) := 'px_{objectName}';

    --
    -- Sets prefix for test packages
    --
    -- %argument a_value_in
    -- %argument a_set_as_default if true then the a_value_in is stored in config table TAPIR_CONFIG and becomes sesssion default
    --
    PROCEDURE set_tapir_package_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_tapir_PACKAGE_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    );

    --
    -- returns current settings of show_hook_methods system parameter
    --
    FUNCTION get_tapir_package_tmpl RETURN VARCHAR2;

    --
    -- Surrogate key sequence name template
    --------------------------------------------------------------------------------
    --
    g_SURROGATE_KEY_SEQ_TMPL_DFLT CONSTANT VARCHAR2(128) := 'sx_{objectName}';

    --
    -- Sets prefix for test packages
    --
    -- %argument a_value_in
    -- %argument a_set_as_default if true then the a_value_in is stored in config table TAPIR_CONFIG and becomes sesssion default
    --
    PROCEDURE set_surrogate_key_seq_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_SURROGATE_KEY_SEQ_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    );

    --
    -- returns current settings of show_hook_methods system parameter
    --
    FUNCTION get_surrogate_key_seq_tmpl RETURN VARCHAR2;

    --
    -- History table name template
    --------------------------------------------------------------------------------
    --
    g_HISTORY_TABLE_TMPL_DFLT CONSTANT VARCHAR2(128) := 'hx_{objectName}';

    --
    -- Sets prefix for test packages
    --
    -- %argument a_value_in
    -- %argument a_set_as_default if true then the a_value_in is stored in config table TAPIR_CONFIG and becomes sesssion default
    --
    PROCEDURE set_history_table_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_HISTORY_TABLE_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    );

    --
    -- returns current settings of show_hook_methods system parameter
    --
    FUNCTION get_history_table_tmpl RETURN VARCHAR2;

    --
    -- History trigger template name
    --------------------------------------------------------------------------------
    --
    g_HISTORY_TRIGGER_TMPL_DFLT CONSTANT VARCHAR2(128) := 'gx_{objectName}';

    --
    -- Sets prefix for test packages
    --
    -- %argument a_value_in
    -- %argument a_set_as_default if true then the a_value_in is stored in config table TAPIR_CONFIG and becomes sesssion default
    --
    PROCEDURE set_history_trigger_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_HISTORY_TRIGGER_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    );

    --
    -- returns current settings of show_hook_methods system parameter
    --
    FUNCTION get_history_trigger_tmpl RETURN VARCHAR2;

    --
    -- Input argument suffix
    --------------------------------------------------------------------------------
    --
    g_IN_ARG_SUFFIX_DFLT CONSTANT VARCHAR2(128) := '_in';

    --
    -- Sets prefix for test packages
    --
    -- %argument a_value_in
    -- %argument a_set_as_default if true then the a_value_in is stored in config table TAPIR_CONFIG and becomes sesssion default
    --
    PROCEDURE set_in_arg_suffix
    (
        a_value_in       IN VARCHAR2 DEFAULT g_IN_ARG_SUFFIX_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    );

    --
    -- returns current settings of show_hook_methods system parameter
    --
    FUNCTION get_in_arg_suffix RETURN VARCHAR2;

    --
    -- Output argument sufix
    --------------------------------------------------------------------------------
    --
    g_OUT_ARG_SUFFIX_DFLT CONSTANT VARCHAR2(128) := '_out';

    --
    -- Sets prefix for test packages
    --
    -- %argument a_value_in
    -- %argument a_set_as_default if true then the a_value_in is stored in config table TAPIR_CONFIG and becomes sesssion default
    --
    PROCEDURE set_out_arg_suffix
    (
        a_value_in       IN VARCHAR2 DEFAULT g_OUT_ARG_SUFFIX_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    );

    --
    -- returns current settings of show_hook_methods system parameter
    --
    FUNCTION get_out_arg_suffix RETURN VARCHAR2;

    --
    -- In out argument suffix
    --------------------------------------------------------------------------------
    --
    g_INOUT_ARG_SUFFIX_DFLT CONSTANT VARCHAR2(128) := '_io';

    --
    -- Sets prefix for test packages
    --
    -- %argument a_value_in
    -- %argument a_set_as_default if true then the a_value_in is stored in config table TAPIR_CONFIG and becomes sesssion default
    --
    PROCEDURE set_inout_arg_suffix
    (
        a_value_in       IN VARCHAR2 DEFAULT g_INOUT_ARG_SUFFIX_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    );

    --
    -- returns current settings of show_hook_methods system parameter
    --
    FUNCTION get_inout_arg_suffix RETURN VARCHAR2;

    --
    -- Scalar argument name template
    --------------------------------------------------------------------------------
    --
    g_SCALAR_ARG_TMPL_DFLT CONSTANT VARCHAR2(128) := 'a_{columnName}';

    --
    -- Sets prefix for test packages
    --
    -- %argument a_value_in
    -- %argument a_set_as_default if true then the a_value_in is stored in config table TAPIR_CONFIG and becomes sesssion default
    --
    PROCEDURE set_scalar_arg_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_SCALAR_ARG_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    );

    --
    -- returns current settings of show_hook_methods system parameter
    --
    FUNCTION get_scalar_arg_tmpl RETURN VARCHAR2;

    --
    -- Record argument name template
    --------------------------------------------------------------------------------
    --
    g_RECORD_ARG_TMPL_DFLT CONSTANT VARCHAR2(128) := 'a_rec';

    --
    -- Sets prefix for test packages
    --
    -- %argument a_value_in
    -- %argument a_set_as_default if true then the a_value_in is stored in config table TAPIR_CONFIG and becomes sesssion default
    --
    PROCEDURE set_record_arg_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_RECORD_ARG_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    );

    --
    -- returns current settings of show_hook_methods system parameter
    --
    FUNCTION get_record_arg_tmpl RETURN VARCHAR2;

    --
    -- Object argument name template
    --------------------------------------------------------------------------------
    --
    g_OBJECT_ARG_TMPL_DFLT CONSTANT VARCHAR2(128) := 'a_obj';

    --
    -- Sets prefix for test packages
    --
    -- %argument a_value_in
    -- %argument a_set_as_default if true then the a_value_in is stored in config table TAPIR_CONFIG and becomes sesssion default
    --
    PROCEDURE set_object_arg_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_OBJECT_ARG_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    );

    --
    -- returns current settings of show_hook_methods system parameter
    --
    FUNCTION get_object_arg_tmpl RETURN VARCHAR2;
    --
    -- Object table argument name template
    --------------------------------------------------------------------------------
    --
    g_OBJECT_TABLE_ARG_TMPL_DFLT CONSTANT VARCHAR2(128) := 'a_col';

    --
    -- Sets prefix for test packages
    --
    -- %argument a_value_in
    -- %argument a_set_as_default if true then the a_value_in is stored in config table TAPIR_CONFIG and becomes sesssion default
    --
    PROCEDURE set_object_table_arg_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_OBJECT_TABLE_ARG_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    );

    --
    -- returns current settings of show_hook_methods system parameter
    --
    FUNCTION get_object_table_arg_tmpl RETURN VARCHAR2;

    --
    -- PL/SQL table of records argument name template
    --------------------------------------------------------------------------------
    --
    g_RECORD_TABLE_ARG_TMPL_DFLT CONSTANT VARCHAR2(128) := 'a_tab';

    --
    -- Sets prefix for test packages
    --
    -- %argument a_value_in
    -- %argument a_set_as_default if true then the a_value_in is stored in config table TAPIR_CONFIG and becomes sesssion default
    --
    PROCEDURE set_record_table_arg_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_RECORD_TABLE_ARG_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    );

    --
    -- returns current settings of show_hook_methods system parameter
    --
    FUNCTION get_record_table_arg_tmpl RETURN VARCHAR2;

    --
    -- Scalar local variable name template
    --------------------------------------------------------------------------------
    --
    g_SCALAR_LOCAL_TMPL_DFLT CONSTANT VARCHAR2(128) := 'l_{columnName}';

    --
    -- Sets prefix for test packages
    --
    -- %argument a_value_in
    -- %argument a_set_as_default if true then the a_value_in is stored in config table TAPIR_CONFIG and becomes sesssion default
    --
    PROCEDURE set_scalar_local_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_SCALAR_LOCAL_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    );

    --
    -- returns current settings of show_hook_methods system parameter
    --
    FUNCTION get_scalar_local_tmpl RETURN VARCHAR2;

    --
    -- Local record variable name template
    --------------------------------------------------------------------------------
    --
    g_RECORD_LOCAL_TMPL_DFLT CONSTANT VARCHAR2(128) := 'l_rec';

    --
    -- Sets prefix for test packages
    --
    -- %argument a_value_in
    -- %argument a_set_as_default if true then the a_value_in is stored in config table TAPIR_CONFIG and becomes sesssion default
    --
    PROCEDURE set_record_local_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_RECORD_LOCAL_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    );

    --
    -- returns current settings of show_hook_methods system parameter
    --
    FUNCTION get_record_local_tmpl RETURN VARCHAR2;

    --
    -- Local object variable name template
    --------------------------------------------------------------------------------
    --
    g_OBJECT_LOCAL_TMPL_DFLT CONSTANT VARCHAR2(128) := 'l_obj';

    --
    -- Sets prefix for test packages
    --
    -- %argument a_value_in
    -- %argument a_set_as_default if true then the a_value_in is stored in config table TAPIR_CONFIG and becomes sesssion default
    --
    PROCEDURE set_object_local_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_OBJECT_LOCAL_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    );

    --
    -- returns current settings of show_hook_methods system parameter
    --
    FUNCTION get_object_local_tmpl RETURN VARCHAR2;

    --
    -- Local object table name variable
    --------------------------------------------------------------------------------
    --
    g_OBJECT_TABLE_LOCAL_TMPL_DFLT CONSTANT VARCHAR2(128) := 'l_col';

    --
    -- Sets prefix for test packages
    --
    -- %argument a_value_in
    -- %argument a_set_as_default if true then the a_value_in is stored in config table TAPIR_CONFIG and becomes sesssion default
    --
    PROCEDURE set_object_table_local_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_OBJECT_TABLE_LOCAL_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    );

    --
    -- returns current settings of show_hook_methods system parameter
    --
    FUNCTION get_object_table_local_tmpl RETURN VARCHAR2;

    --
    -- Local table of record variable name template
    --------------------------------------------------------------------------------
    --
    g_RECORD_TABLE_LOCAL_TMPL_DFLT CONSTANT VARCHAR2(128) := 'l_tab';

    --
    -- Sets prefix for test packages
    --
    -- %argument a_value_in
    -- %argument a_set_as_default if true then the a_value_in is stored in config table TAPIR_CONFIG and becomes sesssion default
    --
    PROCEDURE set_record_table_local_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_RECORD_TABLE_LOCAL_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    );

    --
    -- returns current settings of show_hook_methods system parameter
    --
    FUNCTION get_record_table_local_tmpl RETURN VARCHAR2;

    --
    -- <table_name>%rowtype alias name template
    --------------------------------------------------------------------------------
    --
    g_ROWTYPE_TP_ALIAS_TMPL_DFLT CONSTANT VARCHAR2(128) := 'typ_rec';

    --
    -- Sets prefix for test packages
    --
    -- %argument a_value_in
    -- %argument a_set_as_default if true then the a_value_in is stored in config table TAPIR_CONFIG and becomes sesssion default
    --
    PROCEDURE set_rowtype_tp_alias_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_ROWTYPE_TP_ALIAS_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    );

    --
    -- returns current settings of show_hook_methods system parameter
    --
    FUNCTION get_rowtype_tp_alias_tmpl RETURN VARCHAR2;

    --
    -- PLSQL table of <table_name>%rowtype name template
    --------------------------------------------------------------------------------
    --
    g_ROWTYPETAB_TP_TMPL_DFLT CONSTANT VARCHAR2(128) := 'typ_tab';

    --
    -- Sets prefix for test packages
    --
    -- %argument a_value_in
    -- %argument a_set_as_default if true then the a_value_in is stored in config table TAPIR_CONFIG and becomes sesssion default
    --
    PROCEDURE set_rowtypetab_tp_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_ROWTYPETAB_TP_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    );

    --
    -- returns current settings of show_hook_methods system parameter
    --
    FUNCTION get_rowtypetab_tp_tmpl RETURN VARCHAR2;

    --
    -- primary key record type name template
    --------------------------------------------------------------------------------
    --
    g_PKEY_REC_TYPE_TMPL_DFLT CONSTANT VARCHAR2(128) := 'typ_pkey_rec';

    --
    -- Sets prefix for test packages
    --
    -- %argument a_value_in
    -- %argument a_set_as_default if true then the a_value_in is stored in config table TAPIR_CONFIG and becomes sesssion default
    --
    PROCEDURE set_pkey_rec_type_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_PKEY_REC_TYPE_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    );

    --
    -- returns current settings of show_hook_methods system parameter
    --
    FUNCTION get_pkey_rec_type_tmpl RETURN VARCHAR2;

    --
    -- update indicator record type name template
    --------------------------------------------------------------------------------
    --
    g_UPD_IND_RECTP_TMPL_DFLT CONSTANT VARCHAR2(128) := 'typ_upd_indicator_rec';

    --
    -- Sets prefix for test packages
    --
    -- %argument a_value_in
    -- %argument a_set_as_default if true then the a_value_in is stored in config table TAPIR_CONFIG and becomes sesssion default
    --
    PROCEDURE set_upd_ind_rectp_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_UPD_IND_RECTP_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    );

    --
    -- returns current settings of show_hook_methods system parameter
    --
    FUNCTION get_upd_ind_rectp_tmpl RETURN VARCHAR2;

    --
    -- PLSQL table of update indicator record type name template
    --------------------------------------------------------------------------------
    --
    g_UPD_IND_TAB_RECTP_TMPL_DFLT CONSTANT VARCHAR2(128) := 'typ_upd_indicator_tab';

    --
    -- Sets prefix for test packages
    --
    -- %argument a_value_in
    -- %argument a_set_as_default if true then the a_value_in is stored in config table TAPIR_CONFIG and becomes sesssion default
    --
    PROCEDURE set_upd_ind_tab_rectp_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_UPD_IND_TAB_RECTP_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    );

    --
    -- returns current settings of show_hook_methods system parameter
    --
    FUNCTION get_upd_ind_tab_rectp_tmpl RETURN VARCHAR2;

END;
/
