# LDMS_CHALLENGE
LDMS technical challenge

 /*******************************************************************************
   NAME:       README.md
   PURPOSE:    Installation and executable instructions and key notes.

   REVISIONS:
   Ver        Date         Author           Description
   ---------  -----------  ---------------  -----------------------------------
   1.0        01-May-2021  Moffat B         Initial creation
******************************************************************************/
PREREQUISITES:
All files should be executed in a sqlplus session.
The database user must have the privileges to create and update tables. Create and Execute packages.

Extract the files from GITHUB and put them into the directory the SQLPLUS session is defaulted to.

EXECUTABLE FILE LIST:
LDMS_CREATE_EMPLOYEE.sql
LDMS_GET_EMPLOYEE_SALARY.sql
LDMS_INSTALL.sql
LDMS_List_of_Employees.sql
LDMS_LOAD_DATA.sql
LDMS_Salary_Total_by_Dept.sql
LDMS_TRANSFER_EMPLOYEE.sql
LDMS_TRANSFORM_PKG.pkb
LDMS_TRANSFORM_PKG.pks
LDMS_UPDATE_SALARY.sql
LDMSCRTABS.sql

Connect to a SQLPLUS session.
Run the following command;

@LDMS_INSTALL.sql
This script will create the tables and package required, and also load the data into the tables.  Validate the outputs 'install.lis' and 'load_data.lis'

Assuming the tables are populated the four executable processes can be ran.

---------------------------------------------------------------------------------------------------------
To create an employee run the following command;
@LDMS_CREATE_EMPLOYEE.sql

NOTE ON PARAMETERS:
Employee Name has a max 50 charactors limit and is a mandatory parameter
Job Title has a max 50 charactors limit and is a mandatory parameter
Date hired FORMAT MUST BE DD/MON/YY and is a mandatory parameter
Salary must be a number and is a mandatory parameter
Department id must be a number and is a mandatory parameter check the departments table for valid values
Manager id must be a number but is an optional parameter enter NULL if not required
---------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------
To update an employee salary run the following command;
@LMDS_UPDATE_SALARY.sql 

NOTE ON PARAMETERS:                 
Employee id must be a number, and is a mandatory parameter check the employees table for valid values
Adjustment Value must be a number, and is a mandatory parameter can be negative or positive
---------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------
To transfer an employee to a new department run the following command;
@LMDS_TRANSFER_EMPLOYEE.sql                  

NOTE ON PARAMETERS:                 
Employee id must be a number, and is a mandatory parameter check the employees table for valid values
Department id must be a number and is a mandatory parameter check the departments table for valid values
--------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------
To return the salary for an employee run the following command;
@LMDS_GET_EMPLOYEE_SALARY.sql

NOTE ON PARAMETERS:                 
Employee id must be a number, and is a mandatory parameter check the employees table for valid values
--------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------
To generate the report List of Employees run the following command;
@LDMS_List_of_Employees.sql
NOTE you will be prompted to enter a directory and file name the file extension must be HTML, i.e. List of Employees.html                
--------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------
To generate the report Salary Total by Department run the following command;
@LDMS_Salary_Total_by_Dept.sql
NOTE you will be prompted to enter a directory and file name the file extension must be HTML, i.e. Salary Total by Department.html                
--------------------------------------------------------------------------------------------------------
