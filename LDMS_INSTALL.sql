/*******************************************************************************
   NAME:       LDMS_INSTALL.sql
   PURPOSE:    Install script for the all the reqired objects.

   REVISIONS:
   Ver        Date         Author           Description
   ---------  -----------  ---------------  -----------------------------------
   1.0        03-May-2021  Moffat B	    Initial creation 
******************************************************************************/
SET HEAD ON
SET SERVEROUTPUT ON SIZE 100000
SET LINESIZE 200
SET FEEDBACK ON

SELECT 'You are connected to the database '||name "Database Name"
  FROM v$database;

SELECT 'As the user '||user "User Name"
  FROM dual;

PROMPT 'This process will drop and create all the database objects required for for the task :'
PROMPT 'Please ensure all the files are in the directory your SQL session is pointing to:'
PAUSE  'Please select ENTER to continue or CTRL C to cancel'
PROMPT 

SPOOL install.lis
@LDMSCRTABS.sql
show err
@LDMS_TRANSFORM_PKG.pks
show err
@LDMS_TRANSFORM_PKG.pkb
show err
SPOOL off

PROMPT 'Validate the tables and package created without errors before continuing, view the install.lis file'
PAUSE  'Please select ENTER to continue or CTRL C to cancel'

SPOOL load_data.lis
@LDMS_LOAD_DATA.sql
show err
SELECT * FROM departments;
SELECT * FROM employees;
SPOOL off

PROMPT 'Validate the data content is correct view the load_data.lis file'