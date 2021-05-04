/*******************************************************************************
   NAME:       LDMS_CREATE_EMPLOYEE.sql
   PURPOSE:    Executes the create employee package procedure.

   REVISIONS:
   Ver        Date         Author           Description
   ---------  -----------  ---------------  -----------------------------------
   1.0        03-May-2021  Moffat B	    Initial creation 
******************************************************************************/
SET HEAD ON
SET SERVEROUTPUT ON SIZE 100000
SET LINESIZE 200
SET FEEDBACK ON

EXECUTE LDMS_TRANSFORM_PKG.CREATE_EMPLOYEE('&Employee_Name','&Job_Title','&Date_Hired',&Salary,&Department_id,&Manager_id);