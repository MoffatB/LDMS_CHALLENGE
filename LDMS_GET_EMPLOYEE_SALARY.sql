/*******************************************************************************
   NAME:       LDMS_CREATE_EMPLOYEE.sql
   PURPOSE:    Executes the salary adjustment package procedure.

   REVISIONS:
   Ver        Date         Author           Description
   ---------  -----------  ---------------  -----------------------------------
   1.0        03-May-2021  Moffat B	    Initial creation 
******************************************************************************/
SET HEAD ON
SET SERVEROUTPUT ON SIZE 100000
SET LINESIZE 200
SET FEEDBACK OFF
SET VERIFY OFF

SELECT LDMS_TRANSFORM_PKG.GET_EMP_SALARY('&Employee_ID') "Employee Salary" FROM DUAL;