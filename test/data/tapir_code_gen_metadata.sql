
--insert into tapir_code_gen_metadata (OBJECT_NAME, OBJECT_TYPE, OBJECT_FLAG, TAPI_FLAG, HIST_FLAG)
--values ('PETEV_OUTPUT_RUN_LOG', 'VIEW', 'N', 'N', 'N');
--
--insert into tapir_code_gen_metadata (OBJECT_NAME, OBJECT_TYPE, OBJECT_FLAG, TAPI_FLAG, HIST_FLAG)
--values ('PETE_CONFIGURATION', 'TABLE', 'Y', 'Y', 'N');
--
--insert into tapir_code_gen_metadata (OBJECT_NAME, OBJECT_TYPE, OBJECT_FLAG, TAPI_FLAG, HIST_FLAG)
--values ('PETE_EXPECTED_RESULT', 'TABLE', 'Y', 'Y', 'Y');
--
--insert into tapir_code_gen_metadata (OBJECT_NAME, OBJECT_TYPE, OBJECT_FLAG, TAPI_FLAG, HIST_FLAG)
--values ('PETE_INPUT_ARGUMENT', 'TABLE', 'Y', 'Y', 'Y');
--
--insert into tapir_code_gen_metadata (OBJECT_NAME, OBJECT_TYPE, OBJECT_FLAG, TAPI_FLAG, HIST_FLAG)
--values ('PETE_PLSQL_BLOCK', 'TABLE', 'Y', 'Y', 'Y');
--
--insert into tapir_code_gen_metadata (OBJECT_NAME, OBJECT_TYPE, OBJECT_FLAG, TAPI_FLAG, HIST_FLAG)
--values ('PETE_PLSQL_BLOCK_IN_CASE', 'TABLE', 'Y', 'Y', 'Y');
--
--insert into tapir_code_gen_metadata (OBJECT_NAME, OBJECT_TYPE, OBJECT_FLAG, TAPI_FLAG, HIST_FLAG)
--values ('PETE_RUN_LOG', 'TABLE', 'Y', 'Y', 'N');
--
--insert into tapir_code_gen_metadata (OBJECT_NAME, OBJECT_TYPE, OBJECT_FLAG, TAPI_FLAG, HIST_FLAG)
--values ('PETE_RUN_LOG_DETAIL', 'TABLE', 'Y', 'Y', 'N');
--
--insert into tapir_code_gen_metadata (OBJECT_NAME, OBJECT_TYPE, OBJECT_FLAG, TAPI_FLAG, HIST_FLAG)
--values ('PETE_TEST_CASE', 'TABLE', 'Y', 'Y', 'Y');
--
--insert into tapir_code_gen_metadata (OBJECT_NAME, OBJECT_TYPE, OBJECT_FLAG, TAPI_FLAG, HIST_FLAG)
--values ('PETE_TEST_CASE_IN_SCRIPT', 'TABLE', 'Y', 'Y', 'Y');
--
--insert into tapir_code_gen_metadata (OBJECT_NAME, OBJECT_TYPE, OBJECT_FLAG, TAPI_FLAG, HIST_FLAG)
--values ('PETE_TEST_SCRIPT', 'TABLE', 'Y', 'Y', 'Y');

--insert into tapir_code_gen_metadata (OBJECT_NAME, OBJECT_TYPE, OBJECT_FLAG, TAPI_FLAG, HIST_FLAG)
--values ('TAPIR_REFERENCE', 'TABLE', 'Y', 'Y', 'Y');

MERGE INTO tapir_code_gen_metadata t
USING (SELECT 'TAPIR_REFERENCE' AS object_name,
              'TABLE' AS object_type,
              'Y' AS object_flag,
              'Y' AS tapi_flag,
              'Y' AS hist_flag
         FROM dual) s
ON (s.object_name = t.object_name AND s.object_type = t.object_type)
WHEN MATCHED THEN
    UPDATE
       SET t.OBJECT_FLAG = s.OBJECT_FLAG,
           t.TAPI_FLAG   = s.TAPI_FLAG,
           t.HIST_FLAG   = s.HIST_FLAG
WHEN NOT MATCHED THEN
    INSERT
        (OBJECT_NAME, OBJECT_TYPE, OBJECT_FLAG, TAPI_FLAG, HIST_FLAG)
    VALUES
        (s.OBJECT_NAME, s.OBJECT_TYPE, s.OBJECT_FLAG, s.TAPI_FLAG, s.HIST_FLAG);

commit;

