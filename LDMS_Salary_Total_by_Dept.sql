 /*******************************************************************************
   NAME:       LDMS_List_of_Total_Salaries.sql
   PURPOSE:    creates a HTML output list of total salaries by department
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


TTITLE LEFT 'Total Salaries for the ' &Dept_Name ' Department '  skip 2
COL department_id format 99999 heading 'Department ID'
COL department_name format a50 heading 'Department Name'
COL salary format 999,999.99 heading 'Salary Total'

PROMPT
PROMPT 'Enter the dirve\directory and file name with a HTML extension i.e. department_salary.html to store the output:'
ACCEPT Dir_Name

SET MARKUP HTML on
SET TERM OFF
SPOOL &dir_name
CLEAR BREAKS

SELECT e.department_id
       ,d.department_name
	   ,SUM(e.salary ) Salary
FROM   Employees e,
       departments d
WHERE  e.department_id = d.department_id
AND    Upper(d.department_name) = upper('&Dept_Name')
GROUP BY e.department_id,d.department_name;

SPOOL OFF
SET MARKUP HTML off
SET TERM ON
PROMPT 'Report production completed please view the output file';




