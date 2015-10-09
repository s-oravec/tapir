@&&run_dir_begin

prompt Reference TAPI package - insert method tests
@@ut_px_tapir_ref_ins.pkg
grant execute on ut_px_tapir_ref_ins to pete_010000;

prompt Reference TAPI package - update method tests
@@ut_px_tapir_ref_upd.pkg
grant execute on ut_px_tapir_ref_upd to pete_010000;

prompt Reference TAPI package - delete method tests
@@ut_px_tapir_ref_del.pkg
grant execute on ut_px_tapir_ref_del to pete_010000;

prompt Reference TAPI package - convert method tests
@@ut_px_tapir_ref_convert.pkg
grant execute on ut_px_tapir_ref_convert to pete_010000;

prompt Reference TAPI type
@@ut_tx_tapir_ref.pkg
grant execute on ut_tx_tapir_ref to pete_010000;

@&&run_dir_end
