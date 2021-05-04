 /*******************************************************************************
   NAME:       LDMS_List_of_Employees.sql
   PURPOSE:    creates a HTML output list of employees by department
               using department id as a parameter.

   REVISIONS:
   Ver        Date         Author           Description
   ---------  -----------  ---------------  -----------------------------------
   1.0        01-May-2021  Moffat B         Initial creation
******************************************************************************/
SET HEAD ON
SET SERVEROUTPUT ON SIZE 100000
SET LINESIZE 200
SET LONG 200
SET PAGESIZE 50
SET NEWPAGE 0
SET ECHO OFF
SET FEEDBACK OFF
SET VERIFY OFF

PROMPT 'Enter a Department Name ' 
ACCEPT Dept_Name 


TTITLE LEFT 'List of Employees for the ' &Dept_Name ' Department '  skip 2
COL employee_id format 99999 heading 'Employee ID'
COL employee_name format a50 heading 'Employee Name'
COL date_hired format a12 heading 'Date Hired'

PROMPT
PROMPT 'Enter the dirve\directory and file name with a HTML extension i.e. list_emps.html to store the output:'
ACCEPT Dir_Name

SET MARKUP HTML on
SET TERM OFF
SPOOL &dir_name
CLEAR BREAKS
BREAK ON employee_id skip 1

SELECT e.employee_id
       ,e.employee_name
	   ,TO_CHAR(e.date_hired,'DD/MM/YY') date_hired
FROM   Employees e,
       departments d
WHERE  e.department_id = d.department_id
AND    Upper(d.department_name) = upper('&Dept_Name');

SPOOL OFF
SET MARKUP HTML off
SET TERM ON
PROMPT 'Report production completed please view the output file';



