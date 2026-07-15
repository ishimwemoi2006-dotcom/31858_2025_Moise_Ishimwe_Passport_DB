CREATE OR REPLACE TRIGGER trg_prevent_double_booking
BEFORE INSERT OR UPDATE ON Appointment
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM Appointment
    WHERE slot_id = :NEW.slot_id
      AND appointment_id <> NVL(:NEW.appointment_id, -1);

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'This appointment slot has already been booked.'
        );
    END IF;
END;
/

INSERT INTO Appointment
(appointment_id, application_id, slot_id, appointment_status)
VALUES
(5, 1, 1, 'Scheduled');

CREATE OR REPLACE TRIGGER trg_prevent_double_booking
BEFORE INSERT OR UPDATE ON Appointment
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM Appointment
    WHERE slot_id = :NEW.slot_id
      AND appointment_id <> NVL(:NEW.appointment_id, -1);

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'This appointment slot has already been booked.'
        );
    END IF;
END;
/

INSERT INTO Appointment
(appointment_id, application_id, slot_id, appointment_status)
VALUES
(5, 1, 1, 'Scheduled');

DESC Audit_Log;

CREATE SEQUENCE audit_seq
START WITH 1
INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_audit_passport_application
AFTER INSERT OR UPDATE OR DELETE
ON Passport_Application
FOR EACH ROW
BEGIN

    IF INSERTING THEN

        INSERT INTO Audit_Log
        (
            audit_id,
            username,
            action_type,
            table_name,
            action_date,
            new_value
        )
        VALUES
        (
            audit_seq.NEXTVAL,
            USER,
            'INSERT',
            'PASSPORT_APPLICATION',
            SYSDATE,
            'Application ID = ' || :NEW.application_id
        );

    ELSIF UPDATING THEN

        INSERT INTO Audit_Log
        (
            audit_id,
            username,
            action_type,
            table_name,
            action_date,
            old_value,
            new_value
        )
        VALUES
        (
            audit_seq.NEXTVAL,
            USER,
            'UPDATE',
            'PASSPORT_APPLICATION',
            SYSDATE,
            :OLD.status,
            :NEW.status
        );

    ELSIF DELETING THEN

        INSERT INTO Audit_Log
        (
            audit_id,
            username,
            action_type,
            table_name,
            action_date,
            old_value
        )
        VALUES
        (
            audit_seq.NEXTVAL,
            USER,
            'DELETE',
            'PASSPORT_APPLICATION',
            SYSDATE,
            'Application ID = ' || :OLD.application_id
        );

    END IF;

END;
/

UPDATE Passport_Application
SET status = 'Approved'
WHERE application_id = 1;

COMMIT;

SELECT * FROM Audit_Log;

CREATE OR REPLACE TRIGGER trg_block_operations
BEFORE INSERT OR UPDATE OR DELETE
ON Passport_Application
DECLARE
    v_day VARCHAR2(10);
    v_count NUMBER;
BEGIN

    v_day := TO_CHAR(SYSDATE,'DAY','NLS_DATE_LANGUAGE=ENGLISH');

    SELECT COUNT(*)
    INTO v_count
    FROM Holiday
    WHERE holiday_date = TRUNC(SYSDATE);

    IF TRIM(v_day) IN
       ('MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY')
       OR v_count > 0 THEN

       RAISE_APPLICATION_ERROR(
            -20010,
            'Database modifications are not allowed today.'
       );

    END IF;

END;
/

UPDATE Passport_Application
SET status='Rejected'
WHERE application_id=2;

ALTER TRIGGER trg_block_operations DISABLE;

UPDATE Passport_Application
SET status='Rejected'
WHERE application_id=2;

ALTER TRIGGER trg_block_operations ENABLE;

CREATE OR REPLACE TRIGGER trg_application_compound
FOR INSERT OR UPDATE OR DELETE
ON Passport_Application
COMPOUND TRIGGER

    v_total_changes NUMBER := 0;

    BEFORE STATEMENT IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('=== Starting DML operation ===');
    END BEFORE STATEMENT;

    AFTER EACH ROW IS
    BEGIN
        v_total_changes := v_total_changes + 1;
    END AFTER EACH ROW;

    AFTER STATEMENT IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Rows affected: ' || v_total_changes);
        DBMS_OUTPUT.PUT_LINE('=== DML operation completed ===');
    END AFTER STATEMENT;

END;
/

SET SERVEROUTPUT ON;

UPDATE Passport_Application
SET status='Rejected'
WHERE application_id=3;

COMMIT;

DELETE FROM Applicant
WHERE applicant_id=1;

SELECT *
FROM AUDIT_LOG;

