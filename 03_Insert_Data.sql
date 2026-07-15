INSERT INTO Applicant 
(applicant_id, national_id, first_name, last_name, gender, date_of_birth, phone, email, address)
VALUES
(1, '119991234567890', 'Moise', 'Ishimwe', 'Male', TO_DATE('2006-02-05','YYYY-MM-DD'), '0790795671', 'moise@example.com', 'Kigali');
COMMIT;

INSERT INTO Passport_Type (passport_type_id, type_name, validity_years, description)
VALUES (1, 'Ordinary', 10, 'Regular passport');
INSERT INTO Passport_Type (passport_type_id, type_name, validity_years, description)
VALUES (2, 'Diplomatic', 5, 'Diplomatic passport');
INSERT INTO Passport_Type (passport_type_id, type_name, validity_years, description)
VALUES (3, 'Service', 5, 'Official service passport');

COMMIT;

INSERT INTO Passport_Office (office_id, office_name, location, phone, email)
VALUES (1, 'Kigali Passport Office', 'Kigali', '0788000001', 'kigali@passport.gov');
INSERT INTO Passport_Office (office_id, office_name, location, phone, email)
VALUES (2, 'Huye Passport Office', 'Huye', '0788000002', 'huye@passport.gov');
INSERT INTO Passport_Office (office_id, office_name, location, phone, email)
VALUES (3, 'Musanze Passport Office', 'Musanze', '0788000003', 'musanze@passport.gov');
COMMIT;

INSERT INTO Officer (officer_id, office_id, first_name, last_name, position, phone, email)
VALUES (1, 1, 'Jean', 'Uwase', 'Senior Officer', '0788111111', 'jean.uwase@passport.gov');
INSERT INTO Officer (officer_id, office_id, first_name, last_name, position, phone, email)
VALUES (2, 2, 'Eric', 'Mugisha', 'Officer', '0788222222', 'eric.mugisha@passport.gov');
COMMIT;

INSERT INTO Passport_Application 
(application_id, applicant_id, passport_type_id, officer_id, status)
VALUES 
(1, 1, 1, 1, 'Pending');
INSERT INTO Passport_Application 
(application_id, applicant_id, passport_type_id, officer_id, status, passport_number)
VALUES 
(2, 1, 1, 2, 'Approved', 'RW1234567');
COMMIT;

INSERT INTO Appointment_Slot
(slot_id, office_id, slot_date, start_time, end_time)
VALUES
(1,1,TO_DATE('2026-07-20','YYYY-MM-DD'),'09:00','09:30');
INSERT INTO Appointment_Slot
(slot_id, office_id, slot_date, start_time, end_time)
VALUES
(2,1,TO_DATE('2026-07-20','YYYY-MM-DD'),'10:00','10:30');
COMMIT;

INSERT INTO Payment
(payment_id, application_id, amount, payment_method, payment_status)
VALUES
(1, 1, 50000, 'Mobile Money', 'Paid');
INSERT INTO Payment
(payment_id, application_id, amount, payment_method, payment_status)
VALUES
(2, 2, 50000, 'Bank Card', 'Paid');
COMMIT;

INSERT INTO Appointment
(appointment_id, application_id, slot_id, appointment_status)
VALUES
(1,1,1,'Scheduled');
INSERT INTO Appointment
(appointment_id, application_id, slot_id, appointment_status)
VALUES
(2,2,2,'Completed');
COMMIT;

INSERT INTO User_Account
(user_id, username, password, role, applicant_id)
VALUES
(1,'moise','12345','Citizen',1);
INSERT INTO User_Account
(user_id, username, password, role, officer_id)
VALUES
(2,'jean_officer','12345','Officer',1);
INSERT INTO User_Account
(user_id, username, password, role)
VALUES
(3,'admin','admin123','Admin');
COMMIT;

INSERT INTO Holiday
(holiday_id, holiday_name, holiday_date)
VALUES
(1,'Independence Day',TO_DATE('2026-07-01','YYYY-MM-DD'));
INSERT INTO Holiday
(holiday_id, holiday_name, holiday_date)
VALUES
(2,'Liberation Day',TO_DATE('2026-07-04','YYYY-MM-DD'));
INSERT INTO Holiday
(holiday_id, holiday_name, holiday_date)
VALUES
(3,'Christmas Day',TO_DATE('2026-12-25','YYYY-MM-DD'));

INSERT INTO Holiday (holiday_id, holiday_name, holiday_date)
VALUES (4,'New Year',DATE '2026-01-01');

COMMIT;

SELECT * FROM Applicant;

SELECT * FROM PASSPORT_APPLICATION;

SELECT status,
       COUNT(*) AS total
FROM Passport_Application
GROUP BY status;

SELECT pt.type_name,
       COUNT(*) AS total
FROM Passport_Application pa
JOIN Passport_Type pt
ON pa.passport_type_id = pt.passport_type_id
GROUP BY pt.type_name;

SELECT SUM(amount) AS total_revenue
FROM Payment;

SELECT o.first_name,
       o.last_name,
       COUNT(*) AS applications
FROM Passport_Application pa
JOIN Officer o
ON pa.officer_id = o.officer_id
GROUP BY o.first_name, o.last_name;







