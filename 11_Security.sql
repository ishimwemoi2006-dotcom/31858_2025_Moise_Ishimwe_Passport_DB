CREATE ROLE passport_admin;
CREATE ROLE passport_officer;
CREATE ROLE passport_viewer;

GRANT SELECT, INSERT, UPDATE, DELETE ON Applicant TO passport_admin;

GRANT SELECT, INSERT, UPDATE, DELETE ON Passport_Application TO passport_admin;

GRANT SELECT, INSERT, UPDATE, DELETE ON Appointment TO passport_admin;

GRANT SELECT, UPDATE ON Passport_Application TO passport_officer;

GRANT SELECT ON Applicant TO passport_officer;

GRANT SELECT ON Appointment TO passport_officer;

GRANT SELECT ON Applicant TO passport_viewer;

GRANT SELECT ON Passport_Application TO passport_viewer;

GRANT SELECT ON Appointment TO passport_viewer;

GRANT SELECT, INSERT, UPDATE, DELETE ON Applicant TO passport_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Passport_Application TO passport_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Appointment TO passport_admin;

GRANT SELECT, UPDATE ON Passport_Application TO passport_officer;
GRANT SELECT ON Applicant TO passport_officer;
GRANT SELECT ON Appointment TO passport_officer;

GRANT SELECT ON Applicant TO passport_viewer;
GRANT SELECT ON Passport_Application TO passport_viewer;
GRANT SELECT ON Appointment TO passport_viewer;