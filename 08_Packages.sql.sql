CREATE OR REPLACE PACKAGE PKG_PASSPORT
AS

    PROCEDURE Create_Application (
        p_application_id NUMBER,
        p_applicant_id NUMBER,
        p_passport_type_id NUMBER,
        p_officer_id NUMBER
    );


    PROCEDURE Update_Application_Status (
        p_application_id NUMBER,
        p_status VARCHAR2
    );


    FUNCTION Get_Application_Status (
        p_application_id NUMBER
    )
    RETURN VARCHAR2;


END PKG_PASSPORT;
/

CREATE OR REPLACE PACKAGE BODY PKG_PASSPORT
AS


    PROCEDURE Create_Application (
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

    END Create_Application;



    PROCEDURE Update_Application_Status (
        p_application_id NUMBER,
        p_status VARCHAR2
    )
    AS
    BEGIN

        UPDATE Passport_Application
        SET status = p_status
        WHERE application_id = p_application_id;


        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(
                -20001,
                'Application does not exist'
            );
        END IF;


        COMMIT;


    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;

    END Update_Application_Status;



    FUNCTION Get_Application_Status (
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

    END Get_Application_Status;


END PKG_PASSPORT;
/

BEGIN

    PKG_PASSPORT.Create_Application(
        4,
        1,
        1,
        1
    );

END;
/

SELECT * FROM Passport_Application;
SELECT PKG_PASSPORT.Get_Application_Status(4)
FROM dual;

BEGIN

    PKG_PASSPORT.Update_Application_Status(
        4,
        'Approved'
    );

END;
/

SELECT application_id,status FROM Passport_Application;
