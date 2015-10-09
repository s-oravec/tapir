@&&run_dir_begin

rem Drop TAPIR tests in schema
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

rem reinstall reference
@&&run_script ../reference/uninstall.sql
@&&run_script ../reference/install.sql

@&&run_dir data
@&&run_dir table
@&&run_dir package
@&&run_dir type
@&&run_dir reference

rem Run tests on reference implementation on reference table
set serveroutput on size unlimited
exec pete.run_test_suite;

rem Functional test
rem .. 1. drop reference
@&&run_script ../reference/uninstall.sql

rem .. 2. recreate reference table
@&&run_script ../reference/tapir_reference.sql

rem .. 3. create TAPI using TAPIR
BEGIN
    tapir.create_all_for_table(a_table_name_in => 'TAPIR_REFERENCE');
END;
/

BEGIN
    dbms_utility.compile_schema(user, false);
END;
/

BEGIN
    for cmd in (select 'grant execute on ' || object_name || ' to PETE_010000' as text
                  from user_objects
                 where object_name like 'UT%' and object_type = 'PACKAGE') LOOP
        BEGIN
            execute IMMEDIATE cmd.text;
        exception when OTHERS then
            dbms_output.put_line('ERROR> ' || sqlerrm);
            dbms_output.put_line('ERROR> ' || cmd.text);
        end;
    end loop;
end;
/

rem .. 4. Run tests on generated objects on reference table
BEGIN
    FOR test_package IN (SELECT object_name
                           FROM user_objects
                          WHERE object_type = 'PACKAGE'
                            AND object_name LIKE 'UT_PX_TAPIR_REF%')
    LOOP
        pete.run_test_package(a_package_name_in => user || '.' || test_package.object_name);
    END LOOP;
END;
/

rem .. 5. ????
prompt ????

rem .. 6. PROFIT!!!!
prompt PROFIT!!!!

@&&run_dir_end
