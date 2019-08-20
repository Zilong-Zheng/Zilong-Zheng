/* FIT9132 2019 S1 Assignment 2 Q4 ANSWERS
   Student Name:Zilong Zheng
    Student ID: 29499496

   Comments to your marker:
   
*/
/* (i)*/
ALTER TABLE item ADD reorder_level NUMBER(3, 0);

UPDATE item
SET
    reorder_level = item_stock / 2;

CREATE OR REPLACE TRIGGER trigger4 BEFORE
    INSERT ON item
    FOR EACH ROW
BEGIN
    :new.reorder_level := :new.item_stock / 2;
END;
/

/*-test---*/

SELECT
    *
FROM
    item;

INSERT INTO item VALUES (
    1900,
    'QQQQ',
    25,
    3,
    'CC001',
    0
);

SELECT
    *
FROM
    item;

/* (ii)*/

DROP TABLE adm_doctor CASCADE CONSTRAINTS;

CREATE TABLE adm_doctor (
    adprc_no      NUMBER(6) NOT NULL,
    doctor_id     NUMBER(4) NOT NULL,
    doctor_type   VARCHAR2(50) NOT NULL
);

ALTER TABLE adm_doctor ADD CONSTRAINT adm_doctor_pk PRIMARY KEY ( adprc_no,
                                                                  doctor_id );

ALTER TABLE adm_doctor
    ADD CONSTRAINT adm_doctor_fk_1 FOREIGN KEY ( adprc_no )
        REFERENCES adm_prc ( adprc_no );

ALTER TABLE adm_doctor
    ADD CONSTRAINT adm_doctor_fk_2 FOREIGN KEY ( doctor_id )
        REFERENCES doctor ( doctor_id );

ALTER TABLE adm_doctor
    ADD CONSTRAINT adm_doctor_type CHECK ( doctor_type = 'leader'
                                           OR doctor_type = 'ancillary' );

INSERT INTO adm_doctor
    ( SELECT
        adprc_no,
        perform_dr_id AS "Doctor ID",
        'leader' AS "Doctor Type"
    FROM
        adm_prc
    WHERE
        perform_dr_id IS NOT NULL
    );

ALTER TABLE adm_prc DROP COLUMN perform_dr_id;

CREATE OR REPLACE TRIGGER trigger5 BEFORE
    INSERT ON adm_doctor
    FOR EACH ROW
DECLARE
    adprc_no_std NUMBER(7, 0);
BEGIN
    IF :new.doctor_type = 'leader' THEN
        SELECT
            adprc_no
        INTO adprc_no_std
        FROM
            adm_doctor
        WHERE
            adprc_no = :new.adprc_no
            AND doctor_type = 'leader';

        IF adprc_no_std = :new.adprc_no THEN
            raise_application_error(-20000, 'can have only one leader');
        END IF;

    END IF;
END;
/

/*test--*/

SELECT
    *
FROM
    adm_doctor;

INSERT INTO adm_doctor VALUES (
    11471,
    1028,
    'leader'
);

INSERT INTO adm_doctor VALUES (
    11471,
    1028,
    'ancillary'
);

SELECT
    *
FROM
    adm_doctor;

COMMIT;