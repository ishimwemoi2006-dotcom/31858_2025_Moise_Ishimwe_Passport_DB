SELECT * FROM Applicant;

SELECT first_name, last_name, phone FROM Applicant;

SELECT * FROM Applicant WHERE address = 'Kigali';

SELECT * FROM Passport_Application WHERE status = 'Approved';

SELECT first_name, last_name FROM Applicant ORDER BY last_name ASC;

SELECT 
    a.first_name,
    a.last_name,
    p.application_id,
    p.status,
    p.passport_number
FROM Applicant a
JOIN Passport_Application p
ON a.applicant_id = p.applicant_id;

SELECT
    a.first_name || ' ' || a.last_name AS Applicant_Name,
    pt.type_name AS Passport_Type,
    o.first_name || ' ' || o.last_name AS Officer_Name,
    p.status
FROM Passport_Application p
JOIN Applicant a
ON p.applicant_id = a.applicant_id
JOIN Passport_Type pt
ON p.passport_type_id = pt.passport_type_id
JOIN Officer o
ON p.officer_id = o.officer_id;

SELECT  status, COUNT(*) AS total_applications FROM Passport_Application GROUP BY status;

SELECT
    status,
    COUNT(*) AS total
FROM Passport_Application
GROUP BY status
HAVING COUNT(*) > 1;

SELECT first_name, last_name
FROM Applicant
WHERE applicant_id IN
(
    SELECT applicant_id
    FROM Passport_Application
);

CREATE VIEW Application_Report AS
SELECT
    a.first_name || ' ' || a.last_name AS applicant_name,
    pt.type_name,
    p.application_date,
    p.status
FROM Passport_Application p
JOIN Applicant a
ON p.applicant_id = a.applicant_id
JOIN Passport_Type pt
ON p.passport_type_id = pt.passport_type_id;

SELECT * FROM Application_Report;

CREATE SEQUENCE applicant_seq
START WITH 2
INCREMENT BY 1;

CREATE SEQUENCE application_seq
START WITH 3
INCREMENT BY 1;

SELECT applicant_seq.NEXTVAL FROM dual;

SELECT index_name, column_name
FROM user_ind_columns
WHERE table_name = 'APPLICANT';

CREATE INDEX idx_application_status
ON Passport_Application(status);

SELECT index_name FROM user_indexes;

SELECT application_id, status
FROM Passport_Application;

UPDATE Passport_Application
SET status = 'Pending'
WHERE application_id = 3;

COMMIT;