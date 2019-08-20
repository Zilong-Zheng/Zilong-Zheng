/* FIT9132 2019 S1 Assignment 2 Q2 ANSWERS
   Student Name: Zilong Zheng
    Student ID: 29499496

   Comments to your marker:
   
*/

/* (i)*/
SELECT
    doctor_title   AS "doctor title",
    doctor_fname   AS "first name",
    doctor_lname   AS "last name",
    doctor_phone   AS "phone number"
FROM
    doctor
WHERE
    doctor_id IN (
        SELECT
            doctor_id
        FROM
            doctor_speciality
        WHERE
            spec_code = (
                SELECT
                    spec_code
                FROM
                    speciality
                WHERE
                    upper(spec_description) = upper('ORTHOPEDIC SURGERY')
            )
    )
ORDER BY
    doctor_lname,
    doctor_fname;

/* (ii)*/

SELECT
    item_code          AS "item code",
    item_description   AS "item description",
    item_stock         AS "item stock",
    cc_title           AS "cost centertitle"
FROM
    ( item         i
    JOIN costcentre   c
    ON i.cc_code = c.cc_code )
WHERE
    item_stock > 50
    AND upper(item_description) LIKE upper('%disposable%')
ORDER BY
    item_code;






    
/* (iii)*/

SELECT
    p.patient_id,
    patient_fname
    || ' '
    || patient_lname AS "Patient Name",
    TO_CHAR(adm_date_time, 'DD-Mon-YYYY HH24:MI') AS "ADMDATETIME",
    doctor_title
    || ' '
    || doctor_fname
    || ' '
    || doctor_lname AS "Doctor Name"
FROM
    patient     p
    JOIN admission   a
    ON p.patient_id = a.patient_id
    JOIN doctor      d
    ON a.doctor_id = d.doctor_id
WHERE
    TO_CHAR(adm_date_time, 'DD-Mon-YYYY') = '14-Mar-2019'
ORDER BY
    adm_date_time;







/* (iv)*/

SELECT
    proc_code          AS "procedure code",
    proc_name          AS "name",
    proc_description   AS "description",
    TO_CHAR(proc_std_cost, '$990.99') AS "standard cost"
FROM
    procedure
WHERE
    proc_std_cost < (
        SELECT
            AVG(proc_std_cost)
        FROM
            procedure
    )
ORDER BY
    proc_std_cost DESC;





 
/* (v)*/

SELECT
    a.patient_id,
    patient_lname,
    patient_fname,
    patient_dob AS "DOB",
    COUNT(a.patient_id) AS "NUMBERDMISSIONS"
FROM
    patient     p
    JOIN admission   a
    ON p.patient_id = a.patient_id
GROUP BY
    a.patient_id,
    patient_lname,
    patient_fname,
    patient_dob
HAVING
    COUNT(a.patient_id) > 2
ORDER BY
    COUNT(a.patient_id) DESC,
    p.patient_dob;




    
/* (vi)*/

SELECT
    adm_no,
    p.patient_id,
    patient_fname,
    patient_lname,
    TO_CHAR(floor(adm_discharge - adm_date_time), '99')
    || ' days'
    || TO_CHAR(mod(adm_discharge - adm_date_time, 1) * 24, '90.9')
    || ' hrs' AS "STAYLENGTH"
FROM
    patient     p
    JOIN admission   a
    ON p.patient_id = a.patient_id
WHERE
    adm_discharge - adm_date_time > (
        SELECT
            AVG(adm_discharge - adm_date_time)
        FROM
            admission
    );







    
/* (vii)*/

SELECT
    proc_code,
    proc_name,
    proc_description,
    proc_time,
    TO_CHAR(proc_std_cost -(
        SELECT
            AVG(adprc_pat_cost)
        FROM
            adm_prc ad
        WHERE
            ad.proc_code = p.proc_code
    ), '990.99') AS "Price Differential"
FROM
    procedure p
WHERE
    proc_code IN (
        SELECT
            proc_code
        FROM
            adm_prc
    )
ORDER BY
    p.proc_code;


/* (viii)*/

SELECT
    p.proc_code,
    proc_name,
    nvl(it.item_code, '---') AS item_code,
    nvl(item_description, '---') AS item_description,
    nvl(TO_CHAR(MAX(it_qty_used)), '---') AS "max"
FROM
    adm_prc          a
    JOIN item_treatment   it
    ON a.adprc_no = it.adprc_no
    JOIN item             i
    ON it.item_code = i.item_code
    RIGHT JOIN procedure        p
    ON p.proc_code = a.proc_code
GROUP BY
    p.proc_code,
    proc_name,
    it.item_code,
    item_description
ORDER BY
    p.proc_code;

COMMIT;