CREATE OR REPLACE PROCEDURE Create_Application (
    p_application_id NUMBER,
    p_applicant_id NUMBER,
    p_passport_type_id NUMBER,
    p_officer_id NUMBER
)
AS
BEGIN

    INSERT INTO Passport_Application
    (
        application_id,
        applicant_id,
        passport_type_id,
        officer_id,
        status
    )
    VALUES
    (
        p_application_id,
        p_applicant_id,
        p_passport_type_id,
        p_officer_id,
        'Pending'
    );

    COMMIT;

END;
/

BEGIN
    Create_Application(3,1,1,1);
END;
/

SELECT * FROM Passport_Application;

CREATE OR REPLACE PROCEDURE Update_Application_Status (
    p_application_id NUMBER,
    p_status VARCHAR2
)
AS
BEGIN

    UPDATE Passport_Application
    SET status = p_status
    WHERE application_id = p_application_id;

    COMMIT;

END;
/

BEGIN
    Update_Application_Status(3,'Approved');
END;
/

SELECT application_id, status FROM Passport_Application;

CREATE OR REPLACE PROCEDURE Update_Application_Status (
    p_application_id NUMBER,
    p_status VARCHAR2
)
AS
BEGIN

    UPDATE Passport_Application
    SET status = p_status
    WHERE application_id = p_application_id;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20001,
        'Application ID does not exist');
    END IF;

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;

END;
/

BEGIN
    Update_Application_Status(99,'Approved');
END;
/

CREATE OR REPLACE PROCEDURE List_Pending_Applications
AS
    CURSOR c_pending IS
        SELECT application_id,status
        FROM Passport_Application
        WHERE status='Pending';

    v_id Passport_Application.application_id%TYPE;
    v_status Passport_Application.status%TYPE;

BEGIN

    OPEN c_pending;

    LOOP

        FETCH c_pending
        INTO v_id,v_status;

        EXIT WHEN c_pending%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            'Application: '
            ||v_id||
            ' Status: '||
            v_status
        );

    END LOOP;

    CLOSE c_pending;

END;
/
 
SET SERVEROUTPUT ON;
BEGIN
    List_Pending_Applications;
END;
/
