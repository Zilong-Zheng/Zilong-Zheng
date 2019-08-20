/* FIT9132 2019 S1 Assignment 2 Q1-Part B ANSWERS
   Student Name: Zilong Zheng
    Student ID: 29499496

   Comments to your marker:
   
*/

/* (i)*/
DROP SEQUENCE patient_sequence;

DROP SEQUENCE admission_sequence;

DROP SEQUENCE adm_prc_sequence;

CREATE SEQUENCE patient_sequence START WITH 200000 INCREMENT BY 10 ORDER;

CREATE SEQUENCE admission_sequence START WITH 200000 INCREMENT BY 10 ORDER;

CREATE SEQUENCE adm_prc_sequence START WITH 200000 INCREMENT BY 10 ORDER;

/* (ii)*/

INSERT INTO patient VALUES (
    patient_sequence.NEXTVAL,
    'Peter',
    'Xiue',
    '14 Narrow Lane Caulfield',
    TO_DATE('01-Oct-1981', 'DD-MON-YYYY'),
    '0123456789'
);

INSERT INTO admission VALUES (
    admission_sequence.NEXTVAL,
    TO_DATE('16-May-2019 10:00 AM', 'DD-MON-YYYY HH:MI PM'),
    NULL,
    patient_sequence.CURRVAL,
    (
        SELECT
            doctor_id
        FROM
            doctor
        WHERE
            upper(doctor_fname) = upper('Sawyer')
            AND upper(doctor_lname) = upper('HAISELL')
    )
);




/* (iii)*/

UPDATE doctor_speciality
SET
    spec_code = (
        SELECT
            spec_code
        FROM
            speciality
        WHERE
            upper(spec_description) = upper('vascular surgery')
    )
WHERE
    doctor_id = (
        SELECT
            doctor_id
        FROM
            doctor
        WHERE
            upper(doctor_fname) = upper('Decca')
            AND upper(doctor_lname) = upper('BLANKHORN')
    )
    AND spec_code = (
        SELECT
            spec_code
        FROM
            speciality
        WHERE
            upper(spec_description) = upper('Thoracic surgery')
    );



     
/* (iv)*/

DELETE FROM doctor_speciality
WHERE
    spec_code = (
        SELECT
            spec_code
        FROM
            speciality
        WHERE
            upper(spec_description) = upper('Medical genetics')
    );

DELETE FROM speciality
WHERE
    upper(spec_description) = upper('Medical genetics');

COMMIT;