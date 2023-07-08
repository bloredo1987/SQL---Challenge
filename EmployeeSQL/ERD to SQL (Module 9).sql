-- DROP TABLE IF EXISTS "Departments";
-- DROP TABLE IF EXISTS "Department_Employee";
-- DROP TABLE IF EXISTS "Department_Manager";
-- DROP TABLE IF EXISTS "Employees";
-- DROP TABLE IF EXISTS "Salaries";
-- DROP TABLE IF EXISTS "Titles";

CREATE TABLE "Departments" (
    "dept_no" text   NOT NULL,
    "dept_name" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Department_Employee" (
    "emp_no" INT   NOT NULL,
    "dept_no" text   NOT NULL,
    CONSTRAINT "pk_Department_Employee" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "Department_Manager" (
    "dept_no" text   NOT NULL,
    "emp_no" INT   NOT NULL,
    CONSTRAINT "pk_Department_Manager" PRIMARY KEY (
        "dept_no", "emp_no"
     )
);

CREATE TABLE "Employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" text   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(255)   NOT NULL,
    "last_name" VARCHAR(255)   NOT NULL,
    "sex" VARCHAR(5)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Titles" (
    "title_id" text   NOT NULL,
    "title" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "Department_Employee" ADD CONSTRAINT "fk_Department_Employee_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Department_Employee" ADD CONSTRAINT "fk_Department_Employee_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Department_Manager" ADD CONSTRAINT "fk_Department_Manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Department_Manager" ADD CONSTRAINT "fk_Department_Manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("title_id");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

SELECT * FROM "Departments";
SELECT * FROM "Department_Employee";
SELECT * FROM "Department_Manager";
SELECT * FROM "Employees";
SELECT * FROM "Salaries";
SELECT * FROM "Titles";
----------------------------------------------------------------------------------------------------------
--1)List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM "Employees" AS e
JOIN "Salaries" AS s ON e.emp_no = s.emp_no;
----------------------------------------------------------------------------------------------------------
--2)List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM "Employees"
WHERE hire_date >= '1986-01-01' AND hire_date < '1987-01-01'
ORDER BY hire_date ASC;
----------------------------------------------------------------------------------------------------------
--3)List the manager of each department along with their department number, department name, employee
-- number, last name, and first name.
SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM "Departments" d
JOIN "Department_Manager" dm ON d.dept_no = dm.dept_no
JOIN "Employees" e ON dm.emp_no = e.emp_no;
----------------------------------------------------------------------------------------------------------
--4)List the department number for each employee along with that employee’s employee number, last name,
-- first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name, de.dept_no
FROM "Employees" e
JOIN "Department_Employee" de ON e.emp_no = de.emp_no
JOIN "Departments" d ON de.dept_no = d.dept_no;
----------------------------------------------------------------------------------------------------------
--5)List first name, last name, and sex of each employee whose first name is Hercules and whose last
-- name begins with the letter B.
SELECT first_name, last_name, sex
FROM "Employees"
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';
----------------------------------------------------------------------------------------------------------
--6)List each employee in the Sales department, including their employee number, last name, and first name.
SELECT e.emp_no, e.last_name, e.first_name
FROM "Employees" e
JOIN "Department_Employee" de ON e.emp_no = de.emp_no
JOIN "Departments" d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';
----------------------------------------------------------------------------------------------------------
--7)List each employee in the Sales and Development departments, including their employee number, last name,
-- first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM "Employees" e
JOIN "Department_Employee" de ON e.emp_no = de.emp_no
JOIN "Departments" d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');
----------------------------------------------------------------------------------------------------------
--8)List the frequency counts, in descending order, of all the employee last names (that is, how many 
-- employees share each last name).
SELECT last_name, COUNT(*) AS frequency
FROM "Employees"
GROUP BY last_name
ORDER BY frequency DESC;


