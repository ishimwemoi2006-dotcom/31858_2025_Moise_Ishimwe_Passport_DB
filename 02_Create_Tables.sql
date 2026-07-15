-- Passport Appointment Booking System
-- Student: Moise Ishimwe 31858/2025
-- Oracle Database 19c
-- Phase V: Table Implementation

CREATE TABLE Applicant (
    applicant_id NUMBER PRIMARY KEY,
    national_id VARCHAR2(16) NOT NULL UNIQUE,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    gender VARCHAR2(10) NOT NULL,
    date_of_birth DATE NOT NULL,
    phone VARCHAR2(15) UNIQUE,
    email VARCHAR2(100) UNIQUE,
    address VARCHAR2(150) NOT NULL,
    created_at DATE DEFAULT SYSDATE,
    CONSTRAINT chk_gender CHECK (gender IN ('Male','Female'))
);

CREATE TABLE Passport_Type (
    passport_type_id NUMBER PRIMARY KEY,
    type_name VARCHAR2(30) NOT NULL UNIQUE,
    validity_years NUMBER NOT NULL,
    description VARCHAR2(100)
);

CREATE TABLE Passport_Office (
    office_id NUMBER PRIMARY KEY,
    office_name VARCHAR2(100) NOT NULL UNIQUE,
    location VARCHAR2(150) NOT NULL,
    phone VARCHAR2(15) UNIQUE,
    email VARCHAR2(100) UNIQUE,
    created_at DATE DEFAULT SYSDATE
);

CREATE TABLE Officer (
    officer_id NUMBER PRIMARY KEY,
    office_id NUMBER NOT NULL,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    position VARCHAR2(50) NOT NULL,
    phone VARCHAR2(15) UNIQUE,
    email VARCHAR2(100) UNIQUE,
    created_at DATE DEFAULT SYSDATE,

    CONSTRAINT fk_officer_office
    FOREIGN KEY (office_id)
    REFERENCES Passport_Office(office_id)
);

CREATE TABLE Passport_Application (
    application_id NUMBER PRIMARY KEY,
    applicant_id NUMBER NOT NULL,
    passport_type_id NUMBER NOT NULL,
    officer_id NUMBER NOT NULL,
    application_date DATE DEFAULT SYSDATE,
    status VARCHAR2(20) NOT NULL,
    passport_number VARCHAR2(20) UNIQUE,

    CONSTRAINT fk_application_applicant
    FOREIGN KEY (applicant_id)
    REFERENCES Applicant(applicant_id),

    CONSTRAINT fk_application_type
    FOREIGN KEY (passport_type_id)
    REFERENCES Passport_Type(passport_type_id),

    CONSTRAINT fk_application_officer
    FOREIGN KEY (officer_id)
    REFERENCES Officer(officer_id),

    CONSTRAINT chk_application_status
    CHECK (status IN ('Pending','Approved','Rejected'))
);

CREATE TABLE Appointment_Slot (
    slot_id NUMBER PRIMARY KEY,
    office_id NUMBER NOT NULL,
    slot_date DATE NOT NULL,
    start_time VARCHAR2(10) NOT NULL,
    end_time VARCHAR2(10) NOT NULL,
    availability VARCHAR2(20) DEFAULT 'Available',

    CONSTRAINT fk_slot_office
    FOREIGN KEY (office_id)
    REFERENCES Passport_Office(office_id),

    CONSTRAINT chk_slot_status
    CHECK (availability IN ('Available','Booked'))
);

CREATE TABLE Payment (
    payment_id NUMBER PRIMARY KEY,
    application_id NUMBER NOT NULL,
    amount NUMBER(10,2) NOT NULL,
    payment_date DATE DEFAULT SYSDATE,
    payment_method VARCHAR2(30) NOT NULL,
    payment_status VARCHAR2(20) NOT NULL,

    CONSTRAINT fk_payment_application
    FOREIGN KEY (application_id)
    REFERENCES Passport_Application(application_id),

    CONSTRAINT chk_payment_status
    CHECK (payment_status IN ('Paid','Pending','Failed'))
);

CREATE TABLE Appointment (
    appointment_id NUMBER PRIMARY KEY,
    application_id NUMBER NOT NULL,
    slot_id NUMBER NOT NULL,
    appointment_date DATE DEFAULT SYSDATE,
    appointment_status VARCHAR2(20) NOT NULL,

    CONSTRAINT fk_appointment_application
    FOREIGN KEY (application_id)
    REFERENCES Passport_Application(application_id),

    CONSTRAINT fk_appointment_slot
    FOREIGN KEY (slot_id)
    REFERENCES Appointment_Slot(slot_id),

    CONSTRAINT chk_appointment_status
    CHECK (appointment_status IN ('Scheduled','Completed','Cancelled'))
);

CREATE TABLE User_Account (
    user_id NUMBER PRIMARY KEY,
    username VARCHAR2(50) NOT NULL UNIQUE,
    password VARCHAR2(100) NOT NULL,
    role VARCHAR2(20) NOT NULL,
    applicant_id NUMBER,
    officer_id NUMBER,

    CONSTRAINT fk_user_applicant
    FOREIGN KEY (applicant_id)
    REFERENCES Applicant(applicant_id),

    CONSTRAINT fk_user_officer
    FOREIGN KEY (officer_id)
    REFERENCES Officer(officer_id),

    CONSTRAINT chk_user_role
    CHECK (role IN ('Citizen','Officer','Admin'))
);

CREATE TABLE Holiday (
    holiday_id NUMBER PRIMARY KEY,
    holiday_name VARCHAR2(100) NOT NULL,
    holiday_date DATE NOT NULL UNIQUE
);

CREATE TABLE Audit_Log (
    audit_id NUMBER PRIMARY KEY,
    username VARCHAR2(50),
    action_type VARCHAR2(20),
    table_name VARCHAR2(50),
    action_date DATE DEFAULT SYSDATE,
    old_value VARCHAR2(4000),
    new_value VARCHAR2(4000)
);
