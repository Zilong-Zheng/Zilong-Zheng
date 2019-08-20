SPOOL tables_from_scratch1_run.txt

SET ECHO ON

DROP TABLE unit CASCADE CONSTRAINTS PURGE;

CREATE TABLE unit (
    unit_code   CHAR(7) NOT NULL,
    unit_name   VARCHAR(50) NOT NULL
);

ALTER TABLE unit ADD CONSTRAINT uq_unit_name UNIQUE ( unit_name );

ALTER TABLE unit ADD CONSTRAINT unit_pk PRIMARY KEY ( unit_code );

DROP TABLE student CASCADE CONSTRAINTS PURGE;

CREATE TABLE student (
    stu_nbr     NUMERIC(8) NOT NULL,
    stu_lname   VARCHAR(50) NOT NULL,
    stu_fname   VARCHAR(50) NOT NULL,
    stu_dob     DATE
);

ALTER TABLE student ADD CONSTRAINT ck_stu_nbr CHECK ( stu_nbr > 10000000 );

ALTER TABLE student ADD CONSTRAINT student_pk PRIMARY KEY ( stu_nbr );

DROP TABLE enrolment PURGE;

CREATE TABLE enrolment (
    stu_nbr          NUMERIC(8),
    unit_code        CHAR(7),
    enrol_year       NUMERIC(4),
    enrol_semester   CHAR(1),
    enrol_mark       NUMERIC(3),
    enrol_grade      CHAR(2)
);

ALTER TABLE enrolment
    ADD CONSTRAINT enrol_sem_value CHECK ( enrol_semester IN (
        '1',
        '2',
        '3'
    ) );

ALTER TABLE enrolment
    ADD CONSTRAINT enrolment_pk PRIMARY KEY ( stu_nbr,
                                              unit_code,
                                              enrol_year,
                                              enrol_semester );

ALTER TABLE enrolment
    ADD CONSTRAINT enrolment_fk_student FOREIGN KEY ( stu_nbr )
        REFERENCES student ( stu_nbr );

ALTER TABLE enrolment
    ADD CONSTRAINT enrolment_fk_unit FOREIGN KEY ( unit_code )
        REFERENCES unit ( unit_code );

INSERT INTO student VALUES (
    11111111,
    'Bloggs',
    'Fred',
    '01-Jan-1990'
);

INSERT INTO student VALUES (
    11111112,
    'Nice',
    'Nick',
    '10-Oct-1994'
);

INSERT INTO student VALUES (
    11111113,
    'Wheat',
    'Wendy',
    '05-May-1990'
);

INSERT INTO student VALUES (
    11111114,
    'Sheen',
    'Cindy',
    '25-Dec-1996'
);

INSERT INTO unit VALUES (
    'FIT5132',
    'Introduction to Databases'
);

INSERT INTO unit VALUES (
    'FIT5016',
    'Project'
);

INSERT INTO unit VALUES (
    'FIT5111',
    'Student''s Life'
);

INSERT INTO unit VALUES (
    'FIT9999',
    'FIT Last Unit'
);

INSERT INTO enrolment VALUES (
    11111111,
    'FIT5132',
    2013,
    '1',
    35,
    'N'
);

INSERT INTO enrolment VALUES (
    11111111,
    'FIT5016',
    2013,
    '1',
    61,
    'C'
);

INSERT INTO enrolment VALUES (
    11111111,
    'FIT5132',
    2013,
    '2',
    42,
    'N'
);

INSERT INTO enrolment VALUES (
    11111111,
    'FIT5111',
    2013,
    '2',
    76,
    'D'
);

INSERT INTO enrolment VALUES (
    11111111,
    'FIT5132',
    2014,
    '2',
    NULL,
    NULL
);

INSERT INTO enrolment VALUES (
    11111112,
    'FIT5132',
    2013,
    '2',
    83,
    'HD'
);

INSERT INTO enrolment VALUES (
    11111112,
    'FIT5111',
    2013,
    '2',
    79,
    'D'
);

INSERT INTO enrolment VALUES (
    11111113,
    'FIT5132',
    2014,
    '2',
    NULL,
    NULL
);

INSERT INTO enrolment VALUES (
    11111113,
    'FIT5111',
    2014,
    '2',
    NULL,
    NULL
);

INSERT INTO enrolment VALUES (
    11111114,
    'FIT5111',
    2014,
    '2',
    NULL,
    NULL
);

COMMIT;

CREATE SEQUENCE student_seq START WITH 11111115 INCREMENT BY 1;

INSERT INTO student VALUES (
    student_seq.NEXTVAL,
    'Mouse',
    'Micky',
    '01-Feb-1980'
);

INSERT INTO enrolment VALUES (
    student_seq.CURRVAL,
    'FIT5132',
    2016,
    '2',
    NULL,
    NULL
);

INSERT INTO student VALUES (
    student_seq.NEXTVAL,
    'Zilong',
    'Zheng',
    '19-Feb-1980'
);

INSERT INTO enrolment VALUES (
    student_seq.CURRVAL,
    (
        SELECT
            unit_code
        FROM
            unit
        WHERE
            unit_name = 'Introduction to Databases'
    ),
    2016,
    '2',
    NULL,
    NULL
);

CREATE TABLE fit5132_student
    AS
        SELECT
            *
        FROM
            enrolment
        WHERE
            unit_code = 'FIT5111';

ALTER TABLE unit ADD (
    credit_points NUMBER(2, 0) DEFAULT 6
);

insert into unit values ('FIT9111', 'Unit FIT9111', 12);
commit;
SET ECHO OFF

SPOOL OFF