prompt init sqlsn
@sqlsnrc

--we need sqlsn run module to traverse directory tree during install
prompt require sqlsn-run module
@&&sqlsn_require sqlsn-run

prompt define action and script
define g_run_action = install
define g_run_script = install

prompt install dependencies
@&&run_script install_dependencies

prompt install application
@&&run_dir application

column line format 99999
column name format a30
column type format a15
column text format a50

prompt errors
select line, name, type, text from user_errors;

exit
