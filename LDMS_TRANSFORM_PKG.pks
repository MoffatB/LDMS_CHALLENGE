create or replace package LDMS_TRANSFORM_PKG
--AUTHID CURRENT_USER
 /*******************************************************************************
   NAME:       LDMS_TRANSFORM_PKG.pks
   PURPOSE:    consists of wrapper to create a package to create an employee,
               and transform employee and department data.

   REVISIONS:
   Ver        Date         Author           Description
   ---------  -----------  ---------------  -----------------------------------
   1.0        01-May-2021  Moffat B         Initial creation
******************************************************************************/

IS

/******************************************************************************
    Name:    Create_Employee
    Purpose: Create a new employee record
*******************************************************************************/

/*#
* This procedure creates an employee record in the EMPLOYEES table.
* @rep:product CHALLENGE
* @rep:displayname LDMS_TRANSFORM_PKG
* @rep:lifecycle DEVELOPMENT
*/

/*#
* @param p_emp_name 		VARCHAR2(50) 		IN MANDATORY Parameter
* @param p_job_title 		VARCHAR2(50) 		IN MANDATORY Parameter
* @param p_date_hired 		DATE (DD/MON/YY) 	IN MANDATORY Parameter
* @param p_salary 			NUMBER		    	IN MANDATORY Parameter
* @param p_department_id 	NUMBER		    	IN MANDATORY Parameter
* @param p_manager_id 		NUMBER		    	IN OPTIONAL DEFAULT TO NULL Parameter
*/
PROCEDURE Create_Employee(p_emp_name IN VARCHAR2, p_job_title IN VARCHAR2,p_date_hired IN DATE
                          ,p_salary IN NUMBER, p_department_id IN NUMBER, p_manager_id IN NUMBER DEFAULT NULL);
						  
						  
/******************************************************************************
    Name:    Salary_Adjustment
    Purpose: Increases or decreases an employee's salary by a percentage 
*******************************************************************************/

/*#
* This procedure updates an employee's salary by a percentage, increase or decrease.
* @rep:product CHALLENGE
* @rep:displayname LDMS_TRANSFORM_PKG
* @rep:lifecycle DEVELOPMENT
*/

/*#
* @param p_emp_id			NUMBER		 		IN MANDATORY Parameter
* @param p_adjustment_value NUMBER		 		IN MANDATORY Parameter
*/
PROCEDURE Salary_Adjustment(p_emp_id IN NUMBER, p_adjustment_value IN NUMBER);


/******************************************************************************
    Name:    Department_Transfer
    Purpose: Transfers an employee to a new department
*******************************************************************************/

/*#
* This procedure transfers an employee to a new department
* @rep:product CHALLENGE
* @rep:displayname LDMS_TRANSFORM_PKG
* @rep:lifecycle DEVELOPMENT
*/

/*#
* @param p_emp_id			NUMBER		 		IN MANDATORY Parameter
* @param p_department_id	NUMBER		 		IN MANDATORY Parameter
*/
PROCEDURE Department_Transfer(p_emp_id IN NUMBER, p_department_id IN NUMBER);


/******************************************************************************
    Name:    Get_Emp_Salary
    Purpose: Return an employee's salary
*******************************************************************************/

/*#
* This function returns an employee's salary
* @rep:product CHALLENGE
* @rep:displayname LDMS_TRANSFORM_PKG
* @rep:lifecycle DEVELOPMENT
*/

/*#
* @param p_emp_id			NUMBER		 		IN MANDATORY Parameter
*/
FUNCTION Get_Emp_Salary(p_emp_id IN NUMBER) RETURN NUMBER;

END LDMS_TRANSFORM_PKG;
/








