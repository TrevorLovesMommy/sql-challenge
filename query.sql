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
SELECT last_name, COUNT(last_name) as "Num Last Name"
FROM employees
GROUP BY last_name;





















