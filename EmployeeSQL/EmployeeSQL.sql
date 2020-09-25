-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/rlVJT6
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" varchar(50)   NOT NULL,
    "dept_name" varchar(50)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(50)   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar(50)   NOT NULL,
    "emp_no" int   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" varchar(50)   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(50)   NOT NULL,
    "last_name" varchar(50)   NOT NULL,
    "sex" varchar(50)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" varchar(50)   NOT NULL,
    "title" varchar(50)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

--List the following details of each employee: employee number, last name, first name, sex, and salary.
CREATE VIEW salary_details as
select emp_no, last_name, first_name, sex
from employees
where emp_no IN
( select salary 
from salaries 
);

select emp_no, last_name, first_name, sex, salaries
from salary_details



--List first name, last name, and hire date for employees who were hired in 1986.
select first_name, last_name, hire_date
from employees
where hire_date between '1/1/1986' and '12/31/1986';

--List the manager of each department with the following information: department number, department name, 
--the manager's employee number, last name, first name.
select emp_no, first_name, last_name
from employees
where emp_no IN
(
	Select emp_no
	from dept_manager
	where dept_no IN
	(
	select dept_no 
	from departments
	where dept_name IN
		(
		select dept_name
		from departments
		)
	)	
);

--List the department of each employee with the following information: employee number, last name, first name, and department name.

select emp_no, first_name, last_name 
from employees
where emp_no in 
(
	select emp_no
 	from dept_emp
 	where dept_no IN
	(	
		select dept_no
		from departments
		where dept_name IN
		(
			select dept_name
			from departments
			)	
 	)
);

select first_name, last_name, sex
from employees 
where first_name = 'Hercules' AND last_name like 'B%';


--List all employees in the Sales department, including their employee number, last name, first name, and department name.

select emp_no, first_name, last_name
from employees
where emp_no IN

(	select emp_no 
 	from dept_emp
 	where dept_no IN
 	(
		select dept_no
		from departments 
		where dept_name IN
		(
			select dept_name
			from departments
			where dept_name = 'Sales'
			)
	)
 );







