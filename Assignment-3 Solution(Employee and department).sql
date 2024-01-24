--1. write a SQL query to find Employees who have the biggest salary in their Department
select employee.emp_id,employee.salary, dp.dept_id, dp.dept_name
from Employee
inner join(
	select department.dept_id, department.dept_name, max(employee.salary) as maximum_salary 
	from department 
	join employee on department.dept_id=employee.dept_id
	group by department.dept_id , department.dept_name
	) dp
on(dp.dept_id=employee.dept_id and employee.salary=dp.maximum_salary);

--2. write a SQL query to find Departments that have less than 3 people in it
select d.dept_id, d.dept_name , count(e.emp_id) as 'Number of employees'
from department d
join employee e on d.dept_id=e.dept_id
group by d.dept_id,d.dept_name
having count(e.emp_id)<=5;

--3. write a SQL query to find All Department along with the number of people there
select d.dept_id, d.dept_name , count(e.emp_id) as 'Number of employees'
from department d
join employee e on d.dept_id=e.dept_id
group by d.dept_id,d.dept_name;

--4. write a SQL query to find All Department along with the total salary there
select d.dept_id, d.dept_name , sum(e.salary) as 'Total Salary'
from department d
join employee e on d.dept_id=e.dept_id
group by d.dept_id,d.dept_name;