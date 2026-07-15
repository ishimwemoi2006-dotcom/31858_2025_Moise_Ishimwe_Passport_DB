CREATE OR REPLACE FUNCTION Get_Application_Status (
    p_application_id NUMBER
)
RETURN VARCHAR2
AS
    v_status VARCHAR2(20);

BEGIN

    SELECT status
    INTO v_status
    FROM Passport_Application
    WHERE application_id = p_application_id;

    RETURN v_status;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Application Not Found';

END;
/

SELECT Get_Application_Status(1) FROM dual;
SELECT Get_Application_Status(2) FROM dual;
SELECT Get_Application_Status(99)FROM dual;

