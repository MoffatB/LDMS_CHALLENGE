/*******************************************************************************
   NAME:       LDMS_LOAD_DATA.sql
   PURPOSE:    Populates the department and employee tables.

   REVISIONS:
   Ver        Date         Author           Description
   ---------  -----------  ---------------  -----------------------------------
   1.0        03-May-2021  Moffat B	    Initial creation 
******************************************************************************/
INSERT INTO DEPARTMENTS(Department_Name,Location) values ('Management','London');
INSERT INTO DEPARTMENTS(Department_Name,Location) values ('Engineering','Cardiff');
INSERT INTO DEPARTMENTS(Department_Name,Location) values ('Research'||' & '||'Development','Edinburgh');
INSERT INTO DEPARTMENTS(Department_Name,Location) values ('Sales','Belfast'); 
COMMIT; 

INSERT INTO EMPLOYEES(Employee_Name,Job_Title,Manager_id,Date_Hired,Salary,Department_id) values ('John Smith','CEO',NULL,TO_DATE('01/01/1995','DD/MM/YYYY'),100000,1);
INSERT INTO EMPLOYEES(Employee_Name,Job_Title,Manager_id,Date_Hired,Salary,Department_id) values ('Jimmy Willis','Manager',90001,TO_DATE('23/09/2003','DD/MM/YYYY'),52500,4);
INSERT INTO EMPLOYEES(Employee_Name,Job_Title,Manager_id,Date_Hired,Salary,Department_id) values ('Roxy Jones','Salesperson',NULL,TO_DATE('11/02/2017','DD/MM/YYYY'),35000,4);
INSERT INTO EMPLOYEES(Employee_Name,Job_Title,Manager_id,Date_Hired,Salary,Department_id) values ('Selwyn Field','Salesperson',NULL,TO_DATE('20/05/2015','DD/MM/YYYY'),32000,4);
INSERT INTO EMPLOYEES(Employee_Name,Job_Title,Manager_id,Date_Hired,Salary,Department_id) values ('David Hallett','Engineer',90006,TO_DATE('17/04/2018','DD/MM/YYYY'),40000,2);
INSERT INTO EMPLOYEES(Employee_Name,Job_Title,Manager_id,Date_Hired,Salary,Department_id) values ('Sarah Phelps','Manager',90001,TO_DATE('21/03/2015','DD/MM/YYYY'),45000,2);
INSERT INTO EMPLOYEES(Employee_Name,Job_Title,Manager_id,Date_Hired,Salary,Department_id) values ('Louise Harper','Engineer',90006,TO_DATE('01/01/2013','DD/MM/YYYY'),47000,2);
INSERT INTO EMPLOYEES(Employee_Name,Job_Title,Manager_id,Date_Hired,Salary,Department_id) values ('Tina Hart','Engineer',90009,TO_DATE('27/07/2014','DD/MM/YYYY'),45000,3);
INSERT INTO EMPLOYEES(Employee_Name,Job_Title,Manager_id,Date_Hired,Salary,Department_id) values ('Gus Jones','Manager',90001,TO_DATE('15/05/2018','DD/MM/YYYY'),50000,3);
INSERT INTO EMPLOYEES(Employee_Name,Job_Title,Manager_id,Date_Hired,Salary,Department_id) values ('Mildred Hall','Secretary',90001,TO_DATE('12/10/1996','DD/MM/YYYY'),35000,1);
COMMIT;