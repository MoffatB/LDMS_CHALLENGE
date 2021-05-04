CREATE OR REPLACE PACKAGE BODY LDMS_TRANSFORM_PKG
--AUTHID CURRENT_USER
 /*******************************************************************************
   NAME:       LDMS_TRANSFORM_PKG.pkb
   PURPOSE:    consists of wrapper to create a package body to create an employee,
               and transform employee and department data.

   REVISIONS:
   Ver        Date         Author           Description
   ---------  -----------  ---------------  -----------------------------------
   1.0        01-May-2021  Moffat B         Initial creation
******************************************************************************/

AS    
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
                             ,p_salary IN NUMBER, p_department_id IN NUMBER, p_manager_id IN NUMBER DEFAULT NULL)
   IS

   --cursor to validate the department id parameter passed--
   CURSOR C1 (c_department_id IN NUMBER)
   IS Select 'Y' 
      From   Departments
      Where  department_id = c_department_id;

   l_emp_name       employees.employee_name%type;
   l_job_title      employees.job_title%type;
   l_manager_id     employees.manager_id%type;
   l_date_hired     employees.date_hired%type;
   l_salary         employees.salary%type;
   l_department_id  employees.department_id%type;
   l_dept_check     Varchar2(1);  

   invalid_department EXCEPTION;
   missing_parameter  EXCEPTION;  

   PRAGMA exception_init(invalid_department, -20001);   
   PRAGMA exception_init(missing_parameter, -20002);

   BEGIN

      --initialise local parameters--
      l_emp_name	:= p_emp_name;
      l_job_title  	:= p_job_title;
      l_manager_id 	:= p_manager_id;
      l_date_hired 	:= p_date_hired;
      l_salary     	:= p_salary;
      l_department_id	:= p_department_id;

      --validate mandatory parameters--
      IF l_emp_name is null OR l_job_title is null OR l_date_hired is null OR l_salary is null OR l_department_id is null 
	     OR UPPER(l_emp_name) like '%NULL%' OR UPPER(l_job_title) like '%NULL%' THEN 

         RAISE missing_parameter;         
   
      ELSE
         --validate department id is valid--
         IF l_department_id IS NOT NULL THEN

            IF C1%ISOPEN THEN
            
               CLOSE C1;

            END IF;

            OPEN C1(l_department_id);
            FETCH C1 INTO l_dept_check;

            IF C1%NOTFOUND THEN

			   CLOSE C1;
               RAISE invalid_department;               

            ELSE
        
               CLOSE C1;

               BEGIN
			   
			      IF UPPER(l_manager_id) like '%NULL%' THEN
				  
				     l_manager_id := NULL;
					 
				  END IF;

                  INSERT INTO EMPLOYEES(EMPLOYEE_NAME,JOB_TITLE,MANAGER_ID,DATE_HIRED,SALARY,DEPARTMENT_ID)
                              VALUES(INITCAP(l_emp_name),INITCAP(l_job_title),l_manager_id,to_date(l_date_hired,'dd/Mon/yy'),l_salary,l_department_id);
                  COMMIT;

                  DBMS_OUTPUT.PUT_LINE('Employee '||l_emp_name||' successfully created');

               EXCEPTION WHEN OTHERS THEN

                  DBMS_OUTPUT.PUT_LINE(SQLCODE||'  '||SQLERRM);

              END;

            END IF;
			
		END IF; --validate department id is valid--
		
	END IF; --validate mandatory parameters--
		
   EXCEPTION 
   WHEN missing_parameter THEN

      DBMS_OUTPUT.PUT_LINE('Employee Name, Job Title, Date Hired, Salary, Department ID are all mandatory parameters');
      DBMS_OUTPUT.PUT_LINE('Please re-execute the procedure with the required parameters');	

   WHEN invalid_department THEN
   
      DBMS_OUTPUT.PUT_LINE('The Department ID is not a valid value, the employee record cannot be created.');
      DBMS_OUTPUT.PUT_LINE('Please re-execute the procedure with a valid Department ID value.'); 
	     
   WHEN OTHERS THEN

     DBMS_OUTPUT.PUT_LINE(SQLCODE||'  '||SQLERRM);
	 
   END;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
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
   PROCEDURE Salary_Adjustment(p_emp_id IN NUMBER, p_adjustment_value IN NUMBER)
   
   IS
   --cursor to validate the employee id parameter passed and obtain their salary--
   CURSOR C1 (c_employee_id IN NUMBER)
   IS Select salary 
             ,employee_name
      From   employees
      Where  employee_id = c_employee_id FOR UPDATE NOWAIT;
	  
   --local variables--
   l_emp_id 			employees.employee_id%type;
   l_emp_name 			employees.employee_name%type;
   l_salary 			employees.salary%type;   
   l_adjustment_value 	NUMBER;
   l_amend_value        NUMBER;
   
   
   invalid_employee EXCEPTION;
   
   PRAGMA exception_init(invalid_employee, -20003);   

	  
   BEGIN
   
      l_emp_id 			 := p_emp_id;
	  l_adjustment_value := p_adjustment_value;
	  
      IF C1%ISOPEN THEN
	  
	     CLOSE C1;
		 
	  END IF;
	  
	     OPEN C1(l_emp_id);
		 FETCH C1 INTO l_salary,l_emp_name;
		 
		 IF C1%NOTFOUND THEN
		  
		    CLOSE C1;
		    RAISE invalid_employee;
			
		 ELSE
		 		    
		    l_amend_value := l_salary * l_adjustment_value / 100;
			l_salary := l_salary + l_amend_value;
			
			BEGIN 
			
		       UPDATE EMPLOYEES SET salary = l_salary where employee_id = l_emp_id;
			   COMMIT;
			   DBMS_OUTPUT.PUT_LINE('Employee '||l_emp_id||' '||l_emp_name||' salary successfully updated');
			   CLOSE C1;			
			   
			EXCEPTION WHEN OTHERS THEN

               ROLLBACK;
               DBMS_OUTPUT.PUT_LINE(SQLCODE||'  '||SQLERRM);

            END;
			
		END IF;
   
   EXCEPTION 
   
   WHEN invalid_employee THEN
   
     DBMS_OUTPUT.PUT_LINE('The Employee ID is not a valid value, the employee record cannot be updated.');
     DBMS_OUTPUT.PUT_LINE('Please re-execute the procedure with a valid Employee ID value.'); 

   
   WHEN OTHERS THEN

     DBMS_OUTPUT.PUT_LINE(SQLCODE||'  '||SQLERRM);
	 
   END;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
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
   PROCEDURE Department_Transfer(p_emp_id IN NUMBER, p_department_id IN NUMBER)

   IS  
   
   CURSOR C1 (c_department_id IN NUMBER)
   IS Select department_name  
      From   Departments
      Where  department_id = c_department_id;
	  
   CURSOR C2 (c_employee_id IN NUMBER)
   IS Select department_id
             ,employee_name
      From   Employees
      Where  employee_id = c_employee_id FOR UPDATE NOWAIT;
	  
   --local variables--
   l_orig_dept 		departments.department_id%type;
   l_orig_dept_name departments.department_name%type;
   l_department_id  departments.department_id%type;
   l_emp_id         employees.employee_id%type;
   l_emp_name       employees.employee_name%type;
   l_dept_check 	departments.department_name%type;
	  
   invalid_employee EXCEPTION;
   invalid_department EXCEPTION;
   
   PRAGMA exception_init(invalid_employee,   -20001);  
   PRAGMA exception_init(invalid_department, -20002);     
   
   BEGIN
     
      l_department_id := p_department_id;
	  l_emp_id        := p_emp_id;
	  
      IF C1%ISOPEN THEN
              
         CLOSE C1;

      END IF;

	  --validate department id--
      OPEN C1(l_department_id);
      FETCH C1 INTO l_dept_check;

      IF C1%NOTFOUND THEN

		CLOSE C1;
        
			RAISE invalid_department;               

      ELSE
        
        CLOSE C1;
		
      END IF;
			
	  IF C2%ISOPEN THEN
              
         CLOSE C2;

      END IF;

	  --validate employee id--
      OPEN C2(l_emp_id);
      FETCH C2 INTO l_orig_dept,l_emp_name;

      IF C2%NOTFOUND THEN

		CLOSE C2;
        
			RAISE invalid_employee;               

      ELSE
        
		SELECT department_name INTO l_orig_dept_name
		FROM   departments
		WHERE  department_id = l_orig_dept;
		
	    --sublock to update the employee department--	
	    BEGIN		   
		
		   UPDATE EMPLOYEES SET department_id = l_department_id where employee_id = l_emp_id;
		   COMMIT;
		   DBMS_OUTPUT.PUT_LINE('Employee '||l_emp_id||' '||l_emp_name||', has transferred from department '||l_orig_dept ||' '||l_orig_dept_name||' to department '||l_department_id||' '||l_dept_check||' successfully');

           CLOSE C2;
		   
		EXCEPTION WHEN OTHERS THEN

			ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLCODE||'  '||SQLERRM);

        END;
		
      END IF;

   EXCEPTION 
   
   WHEN invalid_employee THEN
   
     DBMS_OUTPUT.PUT_LINE('The Employee ID is not a valid value, the department transfer cannot be completed.');
     DBMS_OUTPUT.PUT_LINE('Please re-execute the procedure with a valid Employee ID value.'); 
	 
   WHEN invalid_department THEN
   
     DBMS_OUTPUT.PUT_LINE('The Department ID is not a valid value, the department transfer cannot be completed.');
     DBMS_OUTPUT.PUT_LINE('Please re-execute the procedure with a valid Department ID value.'); 
   
   WHEN OTHERS THEN

     DBMS_OUTPUT.PUT_LINE(SQLCODE||'  '||SQLERRM);
	 
   END;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
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
   FUNCTION Get_Emp_Salary(p_emp_id IN NUMBER)
   RETURN NUMBER

   IS  
   
   CURSOR C1 (c_employee_id IN NUMBER)
   IS Select salary
             ,employee_name
      From   Employees
      Where  employee_id = c_employee_id;
	  
   --local variables--
   l_emp_id         employees.employee_id%type;
   l_emp_name       employees.employee_name%type;
   l_salary    	    employees.salary%type;
	  
   invalid_employee EXCEPTION;
   
   PRAGMA exception_init(invalid_employee,   -20001);  
   
   BEGIN
     
      l_emp_id        := p_emp_id;
	  
      IF C1%ISOPEN THEN
              
         CLOSE C1;

      END IF;

	  --validate employee id--
      OPEN C1(l_emp_id);
      FETCH C1 INTO l_salary,l_emp_name;

      IF C1%NOTFOUND THEN

		CLOSE C1;
        
		   RAISE invalid_employee;	

      ELSE
        
        CLOSE C1;
		RETURN l_salary;
		
      END IF;
			
   EXCEPTION 
   
   WHEN invalid_employee THEN
   
     RAISE_APPLICATION_ERROR (-20001,'invalid Employee ID. Please re-execute the function with a valid Employee ID value.') ;     
	 
   WHEN OTHERS THEN

     RAISE_APPLICATION_ERROR (SQLCODE,SQLERRM) ;
	 
   END;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

END LDMS_TRANSFORM_PKG;
/

