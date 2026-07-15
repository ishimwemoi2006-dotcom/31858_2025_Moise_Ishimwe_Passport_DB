CREATE OR REPLACE VIEW vw_application_details AS
SELECT
    pa.application_id,
    a.first_name,
    a.last_name,
    pt.type_name,
    o.first_name || ' ' || o.last_name AS officer_name,
    pa.application_date,
    pa.status
FROM Passport_Application pa
JOIN Applicant a
ON pa.applicant_id = a.applicant_id
JOIN Passport_Type pt
ON pa.passport_type_id = pt.passport_type_id
JOIN Officer o
ON pa.officer_id = o.officer_id;

SELECT * FROM vw_application_details;

CREATE OR REPLACE VIEW vw_payments AS
SELECT
    p.payment_id,
    a.first_name,
    a.last_name,
    p.amount,
    p.payment_method,
    p.payment_status
FROM Payment p
JOIN Passport_Application pa
ON p.application_id = pa.application_id
JOIN Applicant a
ON pa.applicant_id = a.applicant_id;

SELECT * FROM vw_payments;

