CREATE OR REPLACE PACKAGE BODY TAPIR_CONFIG AS

    g_object_type_tmpl        VARCHAR2(128);
    OBJECT_TYPE_TMPL          VARCHAR2(128) := 'OBJECT_TYPE_TMPL';
    g_collection_type_tmpl    VARCHAR2(128);
    COLLECTION_TYPE_TMPL      VARCHAR2(128) := 'COLLECTION_TYPE_TMPL';
    g_tapir_package_tmpl       VARCHAR2(128);
    tapir_PACKAGE_TMPL         VARCHAR2(128) := 'tapir_PACKAGE_TMPL';
    g_surrogate_key_seq_tmpl  VARCHAR2(128);
    SURROGATE_KEY_SEQ_TMPL    VARCHAR2(128) := 'SURROGATE_KEY_SEQ_TMPL';
    g_history_table_tmpl      VARCHAR2(128);
    HISTORY_TABLE_TMPL        VARCHAR2(128) := 'HISTORY_TABLE_TMPL';
    g_history_trigger_tmpl    VARCHAR2(128);
    HISTORY_TRIGGER_TMPL      VARCHAR2(128) := 'HISTORY_TRIGGER_TMPL';
    g_in_arg_suffix           VARCHAR2(128);
    IN_ARG_SUFFIX             VARCHAR2(128) := 'IN_ARG_SUFFIX';
    g_out_arg_suffix          VARCHAR2(128);
    OUT_ARG_SUFFIX            VARCHAR2(128) := 'OUT_ARG_SUFFIX';
    g_inout_arg_suffix        VARCHAR2(128);
    INOUT_ARG_SUFFIX          VARCHAR2(128) := 'INOUT_ARG_SUFFIX';
    g_scalar_arg_tmpl         VARCHAR2(128);
    SCALAR_ARG_TMPL           VARCHAR2(128) := 'SCALAR_ARG_TMPL';
    g_record_arg_tmpl         VARCHAR2(128);
    RECORD_ARG_TMPL           VARCHAR2(128) := 'RECORD_ARG_TMPL';
    g_object_arg_tmpl         VARCHAR2(128);
    OBJECT_ARG_TMPL           VARCHAR2(128) := 'OBJECT_ARG_TMPL';
    g_object_table_arg_tmpl   VARCHAR2(128);
    OBJECT_TABLE_ARG_TMPL     VARCHAR2(128) := 'OBJECT_TABLE_ARG_TMPL';
    g_rectable_arg_tmpl       VARCHAR2(128);
    RECTABLE_ARG_TMPL         VARCHAR2(128) := 'RECTABLE_ARG_TMPL';
    g_scalar_local_tmpl       VARCHAR2(128);
    SCALAR_LOCAL_TMPL         VARCHAR2(128) := 'SCALAR_LOCAL_TMPL';
    g_record_local_tmpl       VARCHAR2(128);
    RECORD_LOCAL_TMPL         VARCHAR2(128) := 'RECORD_LOCAL_TMPL';
    g_object_local_tmpl       VARCHAR2(128);
    OBJECT_LOCAL_TMPL         VARCHAR2(128) := 'OBJECT_LOCAL_TMPL';
    g_object_table_local_tmpl VARCHAR2(128);
    OBJECT_TABLE_LOCAL_TMPL   VARCHAR2(128) := 'OBJECT_TABLE_LOCAL_TMPL';
    g_rectable_local_tmpl     VARCHAR2(128);
    RECTABLE_LOCAL_TMPL       VARCHAR2(128) := 'RECTABLE_LOCAL_TMPL';

    C_TRUE  VARCHAR2(10) := 'TRUE';
    C_FALSE VARCHAR2(10) := 'FALSE';

    -- reads value from config table
    --------------------------------------------------------------------------------
    FUNCTION get_param
    (
        a_key_in           IN pete_configuration.key%TYPE,
        a_default_value_in IN pete_configuration.value%TYPE DEFAULT NULL
    ) RETURN pete_configuration.value%TYPE IS
    BEGIN
        FOR config IN (SELECT VALUE
                         FROM pete_configuration c
                        WHERE key = a_key_in)
        LOOP
            RETURN config.value;
        END LOOP;
        --
        RETURN a_default_value_in;
        --
    END get_param;

    --------------------------------------------------------------------------------
    FUNCTION get_boolean_param
    (
        a_key_in           IN pete_configuration.key%TYPE,
        a_default_value_in IN BOOLEAN
    ) RETURN BOOLEAN IS
        l_value pete_configuration.value%TYPE;
    BEGIN
        l_value := get_param(a_key_in);
    
        IF (l_value = C_TRUE)
        THEN
            RETURN TRUE;
        ELSIF (l_value = C_FALSE)
        THEN
            RETURN FALSE;
        ELSE
            RETURN a_default_value_in;
        END IF;
    
    END;

    -- writes a value into the config table
    --------------------------------------------------------------------------------
    PROCEDURE set_param
    (
        a_key_in   IN pete_configuration.key%TYPE,
        a_value_in IN pete_configuration.value%TYPE
    ) IS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        MERGE INTO pete_configuration c
        USING (SELECT a_key_in key2, a_value_in value2 FROM dual) d
        ON (c.key = d.key2)
        WHEN MATCHED THEN
            UPDATE SET c.value = d.value2
        WHEN NOT MATCHED THEN
            INSERT (key, VALUE) VALUES (d.key2, d.value2);
        COMMIT;
    END set_param;

    -- wrapper for boolean params
    --------------------------------------------------------------------------------
    PROCEDURE set_boolean_param
    (
        a_key_in   IN pete_configuration.key%TYPE,
        a_value_in IN BOOLEAN
    ) IS
        l_table_value VARCHAR2(10);
    BEGIN
        IF (a_value_in)
        THEN
            l_table_value := C_TRUE;
        ELSE
            l_table_value := C_FALSE;
        END IF;
        set_param(a_key_in, l_table_value);
    END;

    --------------------------------------------------------------------------------
    PROCEDURE set_object_type_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_OBJECT_TYPE_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    ) IS
    BEGIN
        g_object_type_tmpl := a_value_in;
        IF a_set_as_default
        THEN
            set_param(OBJECT_TYPE_TMPL, a_value_in);
        END IF;
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_object_type_tmpl RETURN VARCHAR2 IS
    BEGIN
        RETURN g_object_type_tmpl;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE set_collection_type_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_COLLECTION_TYPE_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    ) IS
    BEGIN
        g_collection_type_tmpl := a_value_in;
        IF a_set_as_default
        THEN
            set_param(COLLECTION_TYPE_TMPL, a_value_in);
        END IF;
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_collection_type_tmpl RETURN VARCHAR2 IS
    BEGIN
        RETURN g_collection_type_tmpl;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE set_tapir_package_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_tapir_PACKAGE_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    ) IS
    BEGIN
        g_tapir_package_tmpl := a_value_in;
        IF a_set_as_default
        THEN
            set_param(tapir_PACKAGE_TMPL, a_value_in);
        END IF;
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_tapir_package_tmpl RETURN VARCHAR2 IS
    BEGIN
        RETURN g_tapir_package_tmpl;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE set_surrogate_key_seq_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_SURROGATE_KEY_SEQ_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    ) IS
    BEGIN
        g_surrogate_key_seq_tmpl := a_value_in;
        IF a_set_as_default
        THEN
            set_param(SURROGATE_KEY_SEQ_TMPL, a_value_in);
        END IF;
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_surrogate_key_seq_tmpl RETURN VARCHAR2 IS
    BEGIN
        RETURN g_surrogate_key_seq_tmpl;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE set_history_table_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_HISTORY_TABLE_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    ) IS
    BEGIN
        g_history_table_tmpl := a_value_in;
        IF a_set_as_default
        THEN
            set_param(HISTORY_TABLE_TMPL, a_value_in);
        END IF;
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_history_table_tmpl RETURN VARCHAR2 IS
    BEGIN
        RETURN g_history_table_tmpl;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE set_history_trigger_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_HISTORY_TRIGGER_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    ) IS
    BEGIN
        g_history_trigger_tmpl := a_value_in;
        IF a_set_as_default
        THEN
            set_param(HISTORY_TRIGGER_TMPL, a_value_in);
        END IF;
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_history_trigger_tmpl RETURN VARCHAR2 IS
    BEGIN
        RETURN g_history_trigger_tmpl;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE set_in_arg_suffix
    (
        a_value_in       IN VARCHAR2 DEFAULT g_IN_ARG_SUFFIX_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    ) IS
    BEGIN
        g_in_arg_suffix := a_value_in;
        IF a_set_as_default
        THEN
            set_param(IN_ARG_SUFFIX, a_value_in);
        END IF;
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_in_arg_suffix RETURN VARCHAR2 IS
    BEGIN
        RETURN g_in_arg_suffix;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE set_out_arg_suffix
    (
        a_value_in       IN VARCHAR2 DEFAULT g_OUT_ARG_SUFFIX_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    ) IS
    BEGIN
        g_out_arg_suffix := a_value_in;
        IF a_set_as_default
        THEN
            set_param(OUT_ARG_SUFFIX, a_value_in);
        END IF;
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_out_arg_suffix RETURN VARCHAR2 IS
    BEGIN
        RETURN g_out_arg_suffix;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE set_inout_arg_suffix
    (
        a_value_in       IN VARCHAR2 DEFAULT g_INOUT_ARG_SUFFIX_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    ) IS
    BEGIN
        g_inout_arg_suffix := a_value_in;
        IF a_set_as_default
        THEN
            set_param(INOUT_ARG_SUFFIX, a_value_in);
        END IF;
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_inout_arg_suffix RETURN VARCHAR2 IS
    BEGIN
        RETURN g_inout_arg_suffix;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE set_scalar_arg_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_SCALAR_ARG_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    ) IS
    BEGIN
        g_scalar_arg_tmpl := a_value_in;
        IF a_set_as_default
        THEN
            set_param(SCALAR_ARG_TMPL, a_value_in);
        END IF;
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_scalar_arg_tmpl RETURN VARCHAR2 IS
    BEGIN
        RETURN g_scalar_arg_tmpl;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE set_record_arg_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_RECORD_ARG_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    ) IS
    BEGIN
        g_record_arg_tmpl := a_value_in;
        IF a_set_as_default
        THEN
            set_param(RECORD_ARG_TMPL, a_value_in);
        END IF;
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_record_arg_tmpl RETURN VARCHAR2 IS
    BEGIN
        RETURN g_record_arg_tmpl;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE set_object_arg_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_OBJECT_ARG_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    ) IS
    BEGIN
        g_object_arg_tmpl := a_value_in;
        IF a_set_as_default
        THEN
            set_param(OBJECT_ARG_TMPL, a_value_in);
        END IF;
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_object_arg_tmpl RETURN VARCHAR2 IS
    BEGIN
        RETURN g_object_arg_tmpl;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE set_object_table_arg_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_OBJECT_TABLE_ARG_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    ) IS
    BEGIN
        g_object_table_arg_tmpl := a_value_in;
        IF a_set_as_default
        THEN
            set_param(OBJECT_TABLE_ARG_TMPL, a_value_in);
        END IF;
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_object_table_arg_tmpl RETURN VARCHAR2 IS
    BEGIN
        RETURN g_object_table_arg_tmpl;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE set_rectable_arg_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_RECTABLE_ARG_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    ) IS
    BEGIN
        g_rectable_arg_tmpl := a_value_in;
        IF a_set_as_default
        THEN
            set_param(RECTABLE_ARG_TMPL, a_value_in);
        END IF;
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_rectable_arg_tmpl RETURN VARCHAR2 IS
    BEGIN
        RETURN g_rectable_arg_tmpl;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE set_scalar_local_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_SCALAR_LOCAL_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    ) IS
    BEGIN
        g_scalar_local_tmpl := a_value_in;
        IF a_set_as_default
        THEN
            set_param(SCALAR_LOCAL_TMPL, a_value_in);
        END IF;
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_scalar_local_tmpl RETURN VARCHAR2 IS
    BEGIN
        RETURN g_scalar_local_tmpl;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE set_record_local_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_RECORD_LOCAL_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    ) IS
    BEGIN
        g_record_local_tmpl := a_value_in;
        IF a_set_as_default
        THEN
            set_param(RECORD_LOCAL_TMPL, a_value_in);
        END IF;
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_record_local_tmpl RETURN VARCHAR2 IS
    BEGIN
        RETURN g_record_local_tmpl;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE set_object_local_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_OBJECT_LOCAL_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    ) IS
    BEGIN
        g_object_local_tmpl := a_value_in;
        IF a_set_as_default
        THEN
            set_param(OBJECT_LOCAL_TMPL, a_value_in);
        END IF;
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_object_local_tmpl RETURN VARCHAR2 IS
    BEGIN
        RETURN g_object_local_tmpl;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE set_object_table_local_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_OBJECT_TABLE_LOCAL_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    ) IS
    BEGIN
        g_object_table_local_tmpl := a_value_in;
        IF a_set_as_default
        THEN
            set_param(OBJECT_TABLE_LOCAL_TMPL, a_value_in);
        END IF;
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_object_table_local_tmpl RETURN VARCHAR2 IS
    BEGIN
        RETURN g_object_table_local_tmpl;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE set_rectable_local_tmpl
    (
        a_value_in       IN VARCHAR2 DEFAULT g_RECTABLE_LOCAL_TMPL_DFLT,
        a_set_as_default IN BOOLEAN DEFAULT FALSE
    ) IS
    BEGIN
        g_rectable_local_tmpl := a_value_in;
        IF a_set_as_default
        THEN
            set_param(RECTABLE_LOCAL_TMPL, a_value_in);
        END IF;
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_rectable_local_tmpl RETURN VARCHAR2 IS
    BEGIN
        RETURN g_rectable_local_tmpl;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE init IS
    BEGIN
        g_object_type_tmpl        := get_param(a_key_in           => OBJECT_TYPE_TMPL,
                                               a_default_value_in => g_OBJECT_TYPE_TMPL_DFLT);
        g_collection_type_tmpl    := get_param(a_key_in           => COLLECTION_TYPE_TMPL,
                                               a_default_value_in => g_COLLECTION_TYPE_TMPL_DFLT);
        g_tapir_package_tmpl       := get_param(a_key_in           => tapir_PACKAGE_TMPL,
                                               a_default_value_in => g_tapir_PACKAGE_TMPL_DFLT);
        g_surrogate_key_seq_tmpl  := get_param(a_key_in           => SURROGATE_KEY_SEQ_TMPL,
                                               a_default_value_in => g_SURROGATE_KEY_SEQ_TMPL_DFLT);
        g_history_table_tmpl      := get_param(a_key_in           => HISTORY_TABLE_TMPL,
                                               a_default_value_in => g_HISTORY_TABLE_TMPL_DFLT);
        g_history_trigger_tmpl    := get_param(a_key_in           => HISTORY_TRIGGER_TMPL,
                                               a_default_value_in => g_HISTORY_TRIGGER_TMPL_DFLT);
        g_in_arg_suffix           := get_param(a_key_in           => IN_ARG_SUFFIX,
                                               a_default_value_in => g_IN_ARG_SUFFIX_DFLT);
        g_out_arg_suffix          := get_param(a_key_in           => OUT_ARG_SUFFIX,
                                               a_default_value_in => g_OUT_ARG_SUFFIX_DFLT);
        g_inout_arg_suffix        := get_param(a_key_in           => INOUT_ARG_SUFFIX,
                                               a_default_value_in => g_INOUT_ARG_SUFFIX_DFLT);
        g_scalar_arg_tmpl         := get_param(a_key_in           => SCALAR_ARG_TMPL,
                                               a_default_value_in => g_SCALAR_ARG_TMPL_DFLT);
        g_record_arg_tmpl         := get_param(a_key_in           => RECORD_ARG_TMPL,
                                               a_default_value_in => g_RECORD_ARG_TMPL_DFLT);
        g_object_arg_tmpl         := get_param(a_key_in           => OBJECT_ARG_TMPL,
                                               a_default_value_in => g_OBJECT_ARG_TMPL_DFLT);
        g_object_table_arg_tmpl   := get_param(a_key_in           => OBJECT_TABLE_ARG_TMPL,
                                               a_default_value_in => g_OBJECT_TABLE_ARG_TMPL_DFLT);
        g_rectable_arg_tmpl       := get_param(a_key_in           => RECTABLE_ARG_TMPL,
                                               a_default_value_in => g_RECTABLE_ARG_TMPL_DFLT);
        g_scalar_local_tmpl       := get_param(a_key_in           => SCALAR_LOCAL_TMPL,
                                               a_default_value_in => g_SCALAR_LOCAL_TMPL_DFLT);
        g_record_local_tmpl       := get_param(a_key_in           => RECORD_LOCAL_TMPL,
                                               a_default_value_in => g_RECORD_LOCAL_TMPL_DFLT);
        g_object_local_tmpl       := get_param(a_key_in           => OBJECT_LOCAL_TMPL,
                                               a_default_value_in => g_OBJECT_LOCAL_TMPL_DFLT);
        g_object_table_local_tmpl := get_param(a_key_in           => OBJECT_TABLE_LOCAL_TMPL,
                                               a_default_value_in => g_OBJECT_TABLE_LOCAL_TMPL_DFLT);
        g_rectable_local_tmpl     := get_param(a_key_in           => RECTABLE_LOCAL_TMPL,
                                               a_default_value_in => g_RECTABLE_LOCAL_TMPL_DFLT);
    
    END init;

BEGIN
    init;
END;
/
