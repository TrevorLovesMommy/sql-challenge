-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/L4F6cO
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- How to fix permission denied error with copying table data 
-- https://stackoverflow.com/questions/14083311/permission-denied-when-trying-to-import-a-csv-file-from-pgadmin


CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" varchar(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

COPY departments
FROM 'C:\Users\melis\Documents\Data Science\UCB\sql-challenge\data\departments.csv'
CSV Header;

SELECT * FROM departments;

---------------------------------------------------------------------

CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);


COPY dept_emp
FROM 'C:\Users\melis\Documents\Data Science\UCB\sql-challenge\data\dept_emp.csv'
CSV Header;

SELECT * FROM dept_emp;

---------------------------------------------------------------------

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INTEGER   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);


COPY dept_manager
FROM 'C:\Users\melis\Documents\Data Science\UCB\sql-challenge\data\dept_manager.csv'
CSV Header;

SELECT * FROM dept_manager;

---------------------------------------------------------------------

CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

COPY employees
FROM 'C:\Users\melis\Documents\Data Science\UCB\sql-challenge\data\employees.csv'
CSV Header;

SELECT * FROM employees;
--------------------------------------------------------------------

CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

COPY salaries
FROM 'C:\Users\melis\Documents\Data Science\UCB\sql-challenge\data\salaries.csv'
CSV Header;

SELECT * FROM salaries;
--------------------------------------------------------------------

CREATE TABLE "titles" (
    "emp_no" INTEGER   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

COPY titles
FROM 'C:\Users\melis\Documents\Data Science\UCB\sql-challenge\data\titles.csv'
CSV Header;

SELECT * FROM titles;
--------------------------------------------------------------------

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");


-- #1 List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM employees
INNER JOIN salaries 
ON employees.emp_no = salaries.emp_no;


-- #2 List employees who were hired in 1986
SELECT * 
from employees
WHERE hire_date >= '1986-01-01' and hire_date < '1987-01-01';

-- #3 List the manager of each department with the following information: department number, department name, 
--the manager's employee number, last name, first name, and start and end employment dates.

SELECT d.dept_no, d.dept_name, dm.emp_no, dm.from_date, dm.to_date, e.first_name, e.last_name
FROM employees AS e
INNER JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
INNER JOIN departments AS d ON d.dept_no = dm.dept_no;

-- #4 List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT e. emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_emp AS de ON de.emp_no = e.emp_no
INNER JOIN departments AS d ON d.dept_no = de.dept_no;

-- #5 List all employees whose first name is "Hercules" and last names begin with "B."
SELECT *
FROM employees
WHERE first_name = 'Hercules' and last_name LIKE 'B%';

-- #6 List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_emp as de ON de.emp_no = e.emp_no
INNER JOIN departments as d ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales';

--#7 List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_emp as de ON de.emp_no = e.emp_no
INNER JOIN departments as d ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';


--#8 In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) as "num_last_name"
FROM employees
GROUP BY last_name;
 






































