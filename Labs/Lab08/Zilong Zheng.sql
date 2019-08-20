SET ECHO ON

SPOOL sql_basic_parta.txt

SELECT
    *
FROM
    uni.student
ORDER BY
    studid;

SELECT
    *
FROM
    uni.unit
ORDER BY
    unitcode;

SELECT
    *
FROM
    uni.student
WHERE
    studlname = 'Smith'
ORDER BY
    studid;

SELECT
    studid,
    studfname   AS firstname,
    studlname   AS lastname,
    studdob,
    studaddress,
    studphone,
    studemail
FROM
    uni.student
WHERE
    studlname LIKE 'S%';

SELECT
    unitcode,
    semester
FROM
    uni.offering
WHERE
    TO_CHAR(ofyear, 'yyyy') = '2014';

SELECT
    unitcode,
    semester
FROM
    uni.offering
WHERE
    EXTRACT(YEAR FROM ofyear) = 2014
ORDER BY
    unitcode,
    semester;

SELECT
    unitcode,
    semester
FROM
    uni.offering
WHERE
    TO_CHAR(ofyear, 'yyyy') = '2014'
    AND semester = '1'
ORDER BY
    unitcode;

SELECT
    *
FROM
    uni.unit
WHERE
    unitcode LIKE 'FIT1%'
ORDER BY
    unitcode;

SELECT
    unitcode,
    semester
FROM
    uni.offering
WHERE
    semester IN (
        1,
        3
    )
    AND TO_CHAR(ofyear, 'yyyy') = '2013'
ORDER BY
    unitcode,
    semester;

SELECT
    studid,
    mark,
    unitcode,
    semester
FROM
    uni.enrolment
WHERE
    mark > 49
    AND semester = 1
    AND TO_CHAR(ofyear, 'yyyy') = '2013';

SELECT
    studlname,
    studfname,
    mark
FROM
    uni.student     s
    JOIN uni.enrolment   e
    ON s.studid = e.studid
WHERE
    mark BETWEEN 60 AND 70
ORDER BY
    studlname,
    studfname,
    mark;

SELECT
    o.unitcode,
    semester,
    stafffname,
    stafflname
FROM
    uni.offering   o
    JOIN uni.staff      s
    ON o.chiefexam = s.staffid
WHERE
    TO_CHAR(o.ofyear, 'yyyy') = '2014';

SELECT
    studfname,
    studlname,
    unitname,
    TO_CHAR(e.ofyear, 'yyyy') AS enrolyr,
    e.semester
FROM
    uni.student     s
    JOIN uni.enrolment   e
    ON s.studid = e.studid
    JOIN uni.offering    o
    ON ( e.unitcode = o.unitcode
         AND e.semester = o.semester
         AND e.ofyear = o.ofyear )
    JOIN uni.unit        u
    ON o.unitcode = u.unitcode;

SELECT
    o.unitcode,
    unitname,
    semester,
    TO_CHAR(ofyear, 'yyyy') AS enrolyr
FROM
    uni.unit       u
    JOIN uni.offering   o
    ON u.unitcode = o.unitcode;

SELECT
    o.unitcode,
    o.semester,
    cltype,
    clday,
    TO_CHAR(cltime, 'HHAM') AS time
FROM
    uni.offering     o
    JOIN uni.schedclass   s
    ON ( o.unitcode = s.unitcode
         AND o.semester = s.semester );

SELECT
    unitcode,
    semester,
    cltype,
    clday,
    TO_CHAR(cltime, 'HHAM') AS time
FROM
    uni.schedclass   s
    JOIN uni.staff        staff
    ON s.staffid = staff.staffid
WHERE
    TO_CHAR(ofyear, 'yyyy') = '2013'
    AND stafffname = 'Albus'
    AND stafflname = 'Dumbledore';

SELECT
    e.unitcode,
    unitname,
    semester,
    TO_CHAR(ofyear, 'yyyy') AS "year of enrolment",
    mark,
    grade
FROM
    uni.student     s
    JOIN uni.enrolment   e
    ON s.studid = e.studid
    JOIN uni.unit        u
    ON e.unitcode = u.unitcode
WHERE
    studfname = 'Mary'
    AND studlname = 'Smith';

SELECT
    u1.unitcode,
    u1.unitname,
    has_prereq_of   AS prereq_unitcode,
    u2.unitname     AS prereq_unitname
FROM
    uni.unit     u1
    JOIN uni.prereq   p
    ON u1.unitcode = p.unitcode
    JOIN uni.unit     u2
    ON u2.unitcode = p.has_prereq_of;

SELECT
    has_prereq_of   AS prereq_unitcode,
    u2.unitname     AS prereq_unitname
FROM
    uni.unit u1
    JOIN uni.prereq p ON u1.unitcode = p.unitcode
    JOIN uni.unit u2 ON u2.unitcode = p.has_prereq_of
WHERE
    u1.unitname = 'Advanced Data Management'
ORDER BY
    prereq_unitcode;

SELECT DISTINCT
    s.studid,
    studlname,
    studfname
FROM
    uni.student s
    JOIN uni.enrolment e ON s.studid = e.studid
WHERE
    mark < 50
    AND TO_CHAR(ofyear,'yyyy') = '2013'
ORDER BY
    s.studid;

SELECT
    s.studid,
    studfname,
    studlname,
    TO_CHAR(ofyear,'yyyy') AS "YEAR OF ENROLMENT",
    semester,
    e.unitcode
FROM
    uni.student s
    JOIN uni.enrolment e ON s.studid = e.studid
WHERE
    mark IS NULL;

SPOOL OFF

SET ECHO OFF