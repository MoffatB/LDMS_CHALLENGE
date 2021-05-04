/*******************************************************************************
   NAME:       LDMSCRTABS.sql
   PURPOSE:    consists of wrapper to create required tables.

   REVISIONS:
   Ver        Date         Author           Description
   ---------  -----------  ---------------  -----------------------------------
   1.0        01-May-2021  Moffat B	    Initial creation 
******************************************************************************/

DROP TABLE EMPLOYEES
/

CREATE TABLE EMPLOYEES (
 EMPLOYEE_ID      				NUMBER(10)      GENERATED ALWAYS AS IDENTITY START WITH 90001 INCREMENT BY 1
 ,EMPLOYEE_NAME                 VARCHAR2(50)    NOT NULL
 ,JOB_TITLE                     VARCHAR2(50)    NOT NULL
 ,MANAGER_ID                    NUMBER(10)      NULL
 ,DATE_HIRED                    DATE            NOT NULL
 ,SALARY                        NUMBER(10)      NOT NULL
 ,DEPARTMENT_ID                 NUMBER(5)       NOT NULL )
/

DROP TABLE DEPARTMENTS
/

CREATE TABLE DEPARTMENTS (
 DEPARTMENT_ID      			NUMBER(5)   	GENERATED ALWAYS AS IDENTITY START WITH 1 INCREMENT BY 1
,DEPARTMENT_NAME                VARCHAR2(50)    NOT NULL
,LOCATION                       VARCHAR2(50)    NOT NULL)
/


ALTER TABLE DEPARTMENTS
ADD CONSTRAINT DEPARTMENT_ID_PK PRIMARY KEY (DEPARTMENT_ID)
/

ALTER TABLE EMPLOYEES
ADD CONSTRAINT EMPLOYEE_ID_PK PRIMARY KEY (EMPLOYEE_ID)
/

ALTER TABLE EMPLOYEES
ADD CONSTRAINT DEPARTMENT_ID_FK FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS (DEPARTMENT_ID)
/
