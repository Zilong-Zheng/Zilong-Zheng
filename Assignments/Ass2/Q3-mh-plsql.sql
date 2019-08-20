/* FIT9132 2019 S1 Assignment 2 Q3 ANSWERS
   Student Name: Zilong Zheng
    Student ID: 29499496

   Comments to your marker:
   
*/

/* (i)*/
CREATE OR REPLACE TRIGGER trigger1 BEFORE
    UPDATE OF item_code ON item
    FOR EACH ROW
BEGIN
    UPDATE item_treatment
    SET
        item_code = :new.item_code
    WHERE
        item_code = :old.item_code;

    dbms_output.put_line('successful');
END;
/

SET SERVEROUTPUT ON;

SET ECHO ON

SELECT
    *
FROM
    item_treatment;

SELECT
    *
FROM
    item;

UPDATE item
SET
    item_code = 'KNR56'
WHERE
    item_code = 'KN056';

SELECT
    *
FROM
    item_treatment;

SELECT
    *
FROM
    item;
rollback;
/* (ii)*/

CREATE OR REPLACE TRIGGER trigger2 BEFORE
    INSERT OR UPDATE ON patient
    FOR EACH ROW
BEGIN
    IF :new.patient_lname IS NULL AND :new.patient_fname IS NULL THEN
        raise_application_error(-20000, 'last name and both name can not both be null'
        );
    END IF;
END;
/

/*-test---*/

SELECT
    *
FROM
    patient;

INSERT INTO patient VALUES (
    1000,
    NULL,
    NULL,
    '14 foster street',
    TO_DATE('19-Feb-1995', 'DD-MON-YYYY'),
    1234567890
);

UPDATE patient
SET
    patient_lname = '',
    patient_fname = ''
WHERE
    patient_id = 83728;

SELECT
    *
FROM
    patient;
rollback;
/* (iii)*/

CREATE OR REPLACE TRIGGER trigger3 AFTER
    INSERT ON item_treatment
    FOR EACH ROW
BEGIN
    UPDATE item
    SET
        item_stock = item_stock - :new.it_qty_used
    WHERE
        item_code = :new.item_code;

END;
/

/*-test---*/

SELECT
    *
FROM
    item;

INSERT INTO item_treatment VALUES (
    112765,
    'NE001',
    1,
    10
);

SELECT
    *
FROM
    item;


rollback;