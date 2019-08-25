-- Generated by Oracle SQL Developer Data Modeler 18.4.0.339.1536
--   at:        2019-04-30 21:24:18 AEST
--   site:      Oracle Database 12c
--   type:      Oracle Database 12c

spool mh_schema_output.txt
set echo on

DROP TABLE additional_item CASCADE CONSTRAINTS;

DROP TABLE admission CASCADE CONSTRAINTS;

DROP TABLE bed CASCADE CONSTRAINTS;

DROP TABLE bed_admission CASCADE CONSTRAINTS;

DROP TABLE cost_center CASCADE CONSTRAINTS;

DROP TABLE doctor_specialisation CASCADE CONSTRAINTS;

DROP TABLE dortor CASCADE CONSTRAINTS;

DROP TABLE item_details CASCADE CONSTRAINTS;

DROP TABLE nurse CASCADE CONSTRAINTS;

DROP TABLE patient CASCADE CONSTRAINTS;

DROP TABLE procedure CASCADE CONSTRAINTS;

DROP TABLE procedure_details CASCADE CONSTRAINTS;

DROP TABLE specialisations CASCADE CONSTRAINTS;

DROP TABLE ward CASCADE CONSTRAINTS;

DROP TABLE ward_assign CASCADE CONSTRAINTS;

CREATE TABLE additional_item ( 
/*  this is the quantity of item*/
    item_quan           NUMBER(5) NOT NULL, 
/*  this is the total charge of item*/
    total_item_charge   NUMBER(5, 5), 
/*  these are unique code for procedure*/
    procedure_code      NUMBER(10) NOT NULL, 
/*  this is the unique code  of item.*/
    item_code           NUMBER(10) NOT NULL
);

COMMENT ON COLUMN additional_item.item_quan IS
    'this is the quantity of item';

COMMENT ON COLUMN additional_item.total_item_charge IS
    'this is the total charge of item';

COMMENT ON COLUMN additional_item.procedure_code IS
    'these are unique codes for procedures';

COMMENT ON COLUMN additional_item.item_code IS
    'this is the unique code  of item.';

ALTER TABLE additional_item
    ADD CONSTRAINT additional_item_pk PRIMARY KEY ( item_quan,
                                                    procedure_code,
                                                    item_code );

CREATE TABLE admission ( 
/*  this is the date of admission for each patient*/
    date_of_admission   DATE NOT NULL, 
/*  this is the time pf admission.*/
    time_of_admission   CHAR(5) NOT NULL, 
/*  these are doctors'  unique id numbers.  */
    doctor_id           NUMBER(15) NOT NULL, 
/*  this is the unique id for patient*/
    patient_id          NUMBER(5) NOT NULL
);

COMMENT ON COLUMN admission.date_of_admission IS
    'this is the date of admission for each patient';

COMMENT ON COLUMN admission.time_of_admission IS
    'this is the time pf admission.';

COMMENT ON COLUMN admission.doctor_id IS
    'these are doctors''  unique id numbers.  ';

COMMENT ON COLUMN admission.patient_id IS
    'this is the unique id for patient';

ALTER TABLE admission
    ADD CONSTRAINT admission_pk PRIMARY KEY ( date_of_admission,
                                              patient_id,
                                              time_of_admission );

ALTER TABLE admission ADD CONSTRAINT patient_idv1 UNIQUE ( patient_id );

CREATE TABLE bed ( 
/*  this is the code for bed*/
    bed_code        NUMBER(2) NOT NULL, 
/*  Whether there is a patient in the hospital bed*/
    bed_available   CHAR(3) NOT NULL, 
/*  this is the telephone number of bed*/
    telephone_num   CHAR(20) NOT NULL, 
/*  this is the type of bed*/
    bed_type        CHAR(10) NOT NULL, 
/*  this is the unique code of ward*/
    ward_code       NUMBER(5) NOT NULL
);

COMMENT ON COLUMN bed.bed_code IS
    'this is the code for bed';

COMMENT ON COLUMN bed.bed_available IS
    'Whether there is a patient in the hospital bed';

COMMENT ON COLUMN bed.telephone_num IS
    'this is the telephone number of bed';

COMMENT ON COLUMN bed.bed_type IS
    'this is the type of bed';

COMMENT ON COLUMN bed.ward_code IS
    'this is the unique code of ward';

ALTER TABLE bed ADD CONSTRAINT bed_pk PRIMARY KEY ( bed_code,
                                                    ward_code );

CREATE TABLE bed_admission ( 
/*  this is the date when the patient move in*/
    date_star    DATE NOT NULL, 
/*  this is the date when the patient leave*/
    date_end     DATE NOT NULL, 
/*  this is the code for bed*/
    bed_code     NUMBER(2) NOT NULL, 
/*  this is the unique code of ward*/
    ward_code    NUMBER(5) NOT NULL, 
/*  this is the unique id for patient*/
    patient_id   NUMBER(5) NOT NULL
);

COMMENT ON COLUMN bed_admission.date_star IS
    'this is the date when the patient move in';

COMMENT ON COLUMN bed_admission.date_end IS
    'this is the date when the patient leave';

COMMENT ON COLUMN bed_admission.bed_code IS
    'this is the code for bed';

COMMENT ON COLUMN bed_admission.ward_code IS
    'this is the unique code of ward';

COMMENT ON COLUMN bed_admission.patient_id IS
    'this is the unique id for patient';

ALTER TABLE bed_admission
    ADD CONSTRAINT bed_admission_pk PRIMARY KEY ( date_star,
                                                  bed_code,
                                                  ward_code );

CREATE TABLE cost_center ( 
/*  this is the unique code  of center.*/
    center_code         CHAR(5) NOT NULL, 
/*  this is the name  of center.*/
    center_name         VARCHAR2(15) NOT NULL, 
/*  this is the title  of center.*/
    center_managename   VARCHAR2(15) NOT NULL
);

COMMENT ON COLUMN cost_center.center_code IS
    'this is the unique code  of center.';

COMMENT ON COLUMN cost_center.center_name IS
    'this is the name  of center.';

COMMENT ON COLUMN cost_center.center_managename IS
    'this is the title  of center.';

ALTER TABLE cost_center ADD CONSTRAINT cost_center_pk PRIMARY KEY ( center_code )
;

CREATE TABLE doctor_specialisation ( 
/*  these are doctors'  unique id numbers.  */
    doctor_id           NUMBER(15) NOT NULL, 
/*  these are unique number of specialisation*/
    specialisation_id   NUMBER(5) NOT NULL
);

COMMENT ON COLUMN doctor_specialisation.doctor_id IS
    'these are doctors''  unique id numbers.  ';

COMMENT ON COLUMN doctor_specialisation.specialisation_id IS
    'these are unique number of specialisation';

ALTER TABLE doctor_specialisation ADD CONSTRAINT doctor_specialisation_pk PRIMARY
KEY ( doctor_id,
                                                                                        specialisation_id
                                                                                        )
                                                                                        ;

CREATE TABLE dortor ( 
/*  these are doctors'  unique id numbers.  */
    doctor_id          NUMBER(15) NOT NULL, 
/*  these are doctor's lastname.*/
    doctor_lastname    VARCHAR2(15) NOT NULL, 
/*  these are doctor's firstname.*/
    doctor_firstname   VARCHAR2(15) NOT NULL, 
/*  these are doctor's phone number.*/
    phone_number       NUMBER(15) NOT NULL
);

COMMENT ON COLUMN dortor.doctor_id IS
    'these are doctors''  unique id numbers.  ';

COMMENT ON COLUMN dortor.doctor_lastname IS
    'these are doctor''s lastname.';

COMMENT ON COLUMN dortor.doctor_firstname IS
    'these are doctor''s firstname.';

COMMENT ON COLUMN dortor.phone_number IS
    'these are doctor''s phone number.';

ALTER TABLE dortor ADD CONSTRAINT dortor_pk PRIMARY KEY ( doctor_id );

CREATE TABLE item_details ( 
/*  this is the unique code  of item.*/
    item_code       NUMBER(10) NOT NULL, 
/*  this is the discription  of item.*/
    item_descri     VARCHAR2(500) NOT NULL, 
/*  this is the price  of item.*/
    item_price      CHAR(5) NOT NULL, 
/*  this is the current stock  of item.*/
    current_stock   NUMBER(5) NOT NULL, 
/*  this is the unique code  of center.*/
    center_code     CHAR(5) NOT NULL
);

COMMENT ON COLUMN item_details.item_code IS
    'this is the unique code  of item.';

COMMENT ON COLUMN item_details.item_descri IS
    'this is the discription  of item.';

COMMENT ON COLUMN item_details.item_price IS
    'this is the price  of item.';

COMMENT ON COLUMN item_details.current_stock IS
    'this is the current stock  of item.';

COMMENT ON COLUMN item_details.center_code IS
    'this is the unique code  of center.';

CREATE UNIQUE INDEX item_details__idx ON
    item_details (
        center_code
    ASC );

ALTER TABLE item_details ADD CONSTRAINT item_details_pk PRIMARY KEY ( item_code )
;

CREATE TABLE nurse ( 
/*  this is the unique id number of nurse.*/
    nurse_id        NUMBER(5) NOT NULL, 
/*  this is the first name of nurse*/
    first_name      VARCHAR2(15) NOT NULL, 
/*  this is the last name of nurse*/
    last_name       VARCHAR2(15) NOT NULL, 
/*  this is the phone number of nurse*/
    contact_phone   NUMBER(20) NOT NULL, 
/*  this is the certified of working with children*/
    certified       CHAR(5) NOT NULL
);

COMMENT ON COLUMN nurse.nurse_id IS
    'this is the unique id number of nurse.';

COMMENT ON COLUMN nurse.first_name IS
    'this is the first name of nurse';

COMMENT ON COLUMN nurse.last_name IS
    'this is the last name of nurse';

COMMENT ON COLUMN nurse.contact_phone IS
    'this is the phone number of nurse';

COMMENT ON COLUMN nurse.certified IS
    'this is the certified of working with children';

ALTER TABLE nurse ADD CONSTRAINT nurse_pk PRIMARY KEY ( nurse_id );

CREATE TABLE patient ( 
/*  this is the unique id for patient*/
    patient_id          NUMBER(5) NOT NULL, 
/*  this is the last name of patient*/
    patient_lastname    VARCHAR2(15) NOT NULL, 
/*  this is the first name of patient*/
    patient_firstname   VARCHAR2(15) NOT NULL, 
/*  this is the address of patient*/
    address             CHAR(30) NOT NULL,
    date_of_birth       DATE NOT NULL, 
/*  this is the contact number of patient*/
    emergency_num       NUMBER(20)
);

COMMENT ON COLUMN patient.patient_id IS
    'this is the unique id for patient';

COMMENT ON COLUMN patient.patient_lastname IS
    'this is the last name of patient';

COMMENT ON COLUMN patient.patient_firstname IS
    'this is the first name of patient';

COMMENT ON COLUMN patient.address IS
    'this is the address of patient';

COMMENT ON COLUMN patient.date_of_birth IS
    'this is the date of birth of patient';

COMMENT ON COLUMN patient.emergency_num IS
    'this is the contact number of patient';

ALTER TABLE patient ADD CONSTRAINT patient_pk PRIMARY KEY ( patient_id );

CREATE TABLE procedure ( 
/*  these are carried out date of procedure*/
    carri_date         DATE NOT NULL, 
/*  these are carried out time of procedure*/
    carri_time         CHAR(5) NOT NULL, 
/*  these is the charge of procedure*/
    procedure_charge   NUMBER(5, 5) NOT NULL,
    extra_charge       NUMBER(5, 5) NOT NULL, 
/*  these are doctors'  unique id numbers.  */
    req_doctor_id      NUMBER(15) NOT NULL, 
/*  these are doctors'  unique id numbers.  */
    doctor_id          NUMBER(15), 
/*  this is the unique id for patient*/
    patient_id         NUMBER(5) NOT NULL, 
/*  these are unique code for procedure*/
    procedure_code     NUMBER(10) NOT NULL
);

COMMENT ON COLUMN procedure.carri_date IS
    'these are carried out date of procedure';

COMMENT ON COLUMN procedure.carri_time IS
    'these are carried out time of procedure';

COMMENT ON COLUMN procedure.procedure_charge IS
    'these is the charge of procedure';

COMMENT ON COLUMN procedure.req_doctor_id IS
    'these are doctors''  unique id numbers.  ';

COMMENT ON COLUMN procedure.doctor_id IS
    'these are doctors''  unique id numbers.  ';

COMMENT ON COLUMN procedure.patient_id IS
    'this is the unique id for patient';

COMMENT ON COLUMN procedure.procedure_code IS
    'these are unique codes for procedures';

ALTER TABLE procedure ADD CONSTRAINT procedure_pk PRIMARY KEY ( carri_date,
                                                                carri_time );

CREATE TABLE procedure_details ( 
/*  these are unique code for procedure*/
    procedure_code      NUMBER(10) NOT NULL,
    procedure_name      VARCHAR2(15) NOT NULL, 
/*  this is description for procedure*/
    procedure_descrip   VARCHAR2(100) NOT NULL, 
/*  this is required time for procedure*/
    requird_time        CHAR(5) NOT NULL
);

COMMENT ON COLUMN procedure_details.procedure_code IS
    'these are unique codes for procedures';

COMMENT ON COLUMN procedure_details.procedure_name IS
    'these are names for procedure';

COMMENT ON COLUMN procedure_details.procedure_descrip IS
    'this is description for procedure';

COMMENT ON COLUMN procedure_details.requird_time IS
    'this is required time for procedure';

ALTER TABLE procedure_details ADD CONSTRAINT procedure_details_pk PRIMARY KEY ( procedure_code
);

CREATE TABLE specialisations ( 
/*  these are unique number of specialisation*/
    specialisation_id     NUMBER(5) NOT NULL, 
/*  these are name of specialisation*/
    specialisation_name   VARCHAR2(15) NOT NULL
);

COMMENT ON COLUMN specialisations.specialisation_id IS
    'these are unique number of specialisation';

COMMENT ON COLUMN specialisations.specialisation_name IS
    'these are name of specialisation';

ALTER TABLE specialisations ADD CONSTRAINT specialisations_pk PRIMARY KEY ( specialisation_id
);

CREATE TABLE ward ( 
/*  this is the unique code of ward*/
    ward_code       NUMBER(5) NOT NULL, 
/*  this is the name of ward*/
    ward_name       VARCHAR2(15) NOT NULL, 
/*  this is the total number of ward*/
    total_num_bed   NUMBER(3) NOT NULL
);

COMMENT ON COLUMN ward.ward_code IS
    'this is the unique code of ward';

COMMENT ON COLUMN ward.ward_name IS
    'this is the name of ward';

COMMENT ON COLUMN ward.total_num_bed IS
    'this is the total number of ward';

ALTER TABLE ward ADD CONSTRAINT ward_pk PRIMARY KEY ( ward_code );

CREATE TABLE ward_assign ( 
/*  this is the assigned date of nurse*/
    date_assigned   DATE NOT NULL, 
/*  this is the complete date of nurse*/
    date_complete   DATE, 
/*  this is the unique id number of nurse.*/
    nurse_id        NUMBER(5) NOT NULL, 
/*  this is the unique code of ward*/
    ward_code       NUMBER(5) NOT NULL
);

COMMENT ON COLUMN ward_assign.date_assigned IS
    'this is the assigned date of nurse';

COMMENT ON COLUMN ward_assign.date_complete IS
    'this is the complete date of nurse';

COMMENT ON COLUMN ward_assign.nurse_id IS
    'this is the unique id number of nurse.';

COMMENT ON COLUMN ward_assign.ward_code IS
    'this is the unique code of ward';

ALTER TABLE ward_assign ADD CONSTRAINT ward_assign_pk PRIMARY KEY ( nurse_id,
                                                                    ward_code );

ALTER TABLE additional_item
    ADD CONSTRAINT additional_item_details FOREIGN KEY ( item_code )
        REFERENCES item_details ( item_code );

ALTER TABLE procedure
    ADD CONSTRAINT admission_procedure FOREIGN KEY ( patient_id )
        REFERENCES admission ( patient_id );

ALTER TABLE bed_admission
    ADD CONSTRAINT bed_bed_admission FOREIGN KEY ( bed_code,
                                                   ward_code )
        REFERENCES bed ( bed_code,
                         ward_code );

ALTER TABLE procedure
    ADD CONSTRAINT carri_doctor_procedure FOREIGN KEY ( doctor_id )
        REFERENCES dortor ( doctor_id );

ALTER TABLE admission
    ADD CONSTRAINT doctor_admission FOREIGN KEY ( doctor_id )
        REFERENCES dortor ( doctor_id );

ALTER TABLE doctor_specialisation
    ADD CONSTRAINT doctor_doctor_specia FOREIGN KEY ( doctor_id )
        REFERENCES dortor ( doctor_id );

ALTER TABLE doctor_specialisation
    ADD CONSTRAINT doctor_specia_specia FOREIGN KEY ( specialisation_id )
        REFERENCES specialisations ( specialisation_id );

ALTER TABLE item_details
    ADD CONSTRAINT item_details_cost_center FOREIGN KEY ( center_code )
        REFERENCES cost_center ( center_code );

ALTER TABLE ward_assign
    ADD CONSTRAINT nurse_ward_assign FOREIGN KEY ( nurse_id )
        REFERENCES nurse ( nurse_id );

ALTER TABLE admission
    ADD CONSTRAINT patient_admission FOREIGN KEY ( patient_id )
        REFERENCES patient ( patient_id );

ALTER TABLE additional_item
    ADD CONSTRAINT procedure_detils_item FOREIGN KEY ( procedure_code )
        REFERENCES procedure_details ( procedure_code );

ALTER TABLE procedure
    ADD CONSTRAINT procedure_procedure_details FOREIGN KEY ( procedure_code )
        REFERENCES procedure_details ( procedure_code );

ALTER TABLE bed
    ADD CONSTRAINT relation_21 FOREIGN KEY ( ward_code )
        REFERENCES ward ( ward_code );

ALTER TABLE bed_admission
    ADD CONSTRAINT relation_23 FOREIGN KEY ( patient_id )
        REFERENCES admission ( patient_id );

ALTER TABLE procedure
    ADD CONSTRAINT required_procedure_doctor FOREIGN KEY ( req_doctor_id )
        REFERENCES dortor ( doctor_id );

ALTER TABLE ward_assign
    ADD CONSTRAINT ward_ward_assign FOREIGN KEY ( ward_code )
        REFERENCES ward ( ward_code );



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            15
-- CREATE INDEX                             1
-- ALTER TABLE                             32
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- TSDP POLICY                              0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
set echo off
spool off