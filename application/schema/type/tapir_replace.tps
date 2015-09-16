CREATE OR REPLACE TYPE tapir_replace FORCE AS OBJECT
(
    placeholder varchar2(255),
    value       varchar2(32767)
)
/
