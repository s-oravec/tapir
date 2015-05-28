@&&run_dir_begin

BEGIN
    FOR obj IN (SELECT object_name
                  FROM user_objects
                 WHERE object_name LIKE 'UT_TAPIR%'
                   AND object_type = 'PACKAGE')
    LOOP
        EXECUTE IMMEDIATE 'drop package ' || obj.object_name;
    END LOOP;
END;
/

delete
  from tapir_code_gen_metadata
 where object_name like 'PETE%'
;

commit;

@&&run_dir data
@&&run_dir table
@&&run_dir package
@&&run_dir type

set serveroutput on size unlimited
exec pete.run_test_suite;

@&&run_dir_end
