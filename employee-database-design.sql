-- Database Design
create database dbemployee;
use dbemployee;

create table tblemployee (
  employee_id char(5) not null primary key,
  age int not null,
  gender enum('Female','Male'),
  marital_status enum('Single','Married','Divorced') not null,
  distance_from_home int not null,
  education enum('College','Below College','Master','Bachelor','Doctor') not null,
  education_field enum('Life Sciences','Medical','Marketing','Technical Degree','Other') not null,
  salary_id char(6) not null
  );

create table tblsalary (
  salary_id char(6) not null,
  hourly_rate int not null,
  daily_rate int not null,
  monthly_rate int not null,
  percent_salary_hike int not null,
  dept_id char(3) not null,
  job_id char(3) not null
  );

create table tbldepartment (
  dept_id char(3) not null primary key,
  department enum('Sales','Human Resources','Research & Development')
  );

create table tbljobrole (
  job_id char(3) not null primary key,
  job_role enum('Sales Executive','Research Scientist','Laboratory Technician','Manufacturing Director','Healthcare Representative','Human Resources','Research Director','Sales Representative','Manager','Healthcare Representative')
  );

create table tblemployeesatisfaction (
  employee_id char(5) not null primary key,
  job_satisfaction enum('Low','Medium','High','Very High'),
  environment_satisfaction enum('Low','Medium','High','Very High'),
  relationship_satisfaction enum('Low','Medium','High','Very High'),
  work_life_balance enum('Good','Better','Best','Bad')
  );

load data infile 'D:/dbemployee/tbl_employee.txt' into table tblemployee;
load data infile 'D:/dbemployee/tbl_salary.txt' into table tblsalary;
LOAD DATA INFILE 'D:/dbemployee/tbl_department.csv' into table tbldepartment
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
LOAD DATA INFILE 'D:/dbemployee/tbl_job_role.csv' into table tbljobrole
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
LOAD DATA INFILE 'D:/dbemployee/tbl_employee_satisfaction.csv' into table tblemployeesatisfaction
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

-- Implementation Operator AND, OR, NOT
select*from tblemployee where education='Bachelor' and marital_status='Married';
select*from tblsalary where percent_salary_hike='11' and dept_id='D03';
select*from tblemployeesatisfaction where job_satisfaction='Low' or job_satisfaction='High';
select*from tblemployeesatisfaction where environment_satisfaction='Very High' or work_life_balance='Good';
select*from tblemployee where gender='Female' AND (education_field='Life Sciences' or education_field='Medical');
select*from tblsalary where not job_id='J03';
select*from tblsalary where not dept_id='D01' and job_id='J09';

-- Implementation Operator JOIN
-- Full Outer Join
select * from tblsalary
LEFT JOIN tbldepartment ON tblsalary.dept_id = tbldepartment.dept_id
UNION ALL
select * from tblsalary
RIGHT JOIN tbldepartment ON tblsalary.dept_id = tbldepartment.dept_id where tbldepartment.dept_id is null;
-- Inner Join
select * from tblemployee INNER JOIN tblemployeesatisfaction
ON tblemployee.employee_id=tblemployeesatisfaction.employee_id;
-- Right Join
select * from tblsalary RIGHT JOIN tbljobrole 
ON tblsalary.job_id=tbljobrole.job_id;
-- Left Join
select * from tblsalary LEFT JOIN tblemployee
ON tblsalary.salary_id=tblemployee.salary_id;
-- Cross Join
select * from tblemployee CROSS JOIN tblemployeesatisfaction order by age asc;

-- Implementasion Sub query
-- Study Case 1
SELECT tblemployee.employee_id, tblemployee.age, tblemployee.gender, tblsalary.salary_id, tblsalary.monthly_rate 
FROM tblemployee, tblsalary
WHERE tblemployee.salary_id = tblsalary.salary_id AND tblsalary.monthly_rate >
(SELECT AVG(monthly_rate)
FROM tblsalary)
ORDER BY tblsalary.monthly_rate;
-- Study Case 2
select tblemployee.employee_id, tblemployee.gender, 
tblemployee.salary_id, 
tblsalary.monthly_rate, tblsalary.dept_id, tbldepartment.department
from tblemployee, tblsalary, tbldepartment
where tblemployee.salary_id = tblsalary.salary_id and tblsalary.dept_id = 
tbldepartment.dept_id and tblsalary.monthly_rate in
(select min(monthly_rate)
 from tblsalary,tbldepartment
 where tblsalary.dept_id = tbldepartment.dept_id
 group by tblsalary.dept_id);
-- Study Case 3
select tblemployee.employee_id, tblemployee.gender,tblemployee.education, tblemployee.salary_id, tblsalary.monthly_rate, tblsalary.job_id, tbljobrole.job_role
from tblemployee, tblsalary, tbljobrole 
where tblemployee.salary_id = tblsalary.salary_id and tblsalary.job_id = tbljobrole.job_id and tblsalary.monthly_rate in
(select max(monthly_rate)
 from tblsalary,tbljobrole
 where tblsalary.job_id = tbljobrole.job_id
 group by tblsalary.job_id);
-- Study Case 4
select tbljobrole.job_role, 
tblemployeesatisfaction.environment_satisfaction,
count (tblemployeesatisfaction.environment_satisfaction) 
jumlah_karyawan
from tblemployee, tblsalary, tbljobrole, tblemployeesatisfaction 
where tblemployee.salary_id = tblsalary.salary_id and tblsalary.job_id = 
tbljobrole.job_id and tblemployee.employee_id = 
tblemployeesatisfaction.employee_id and 
tblemployeesatisfaction.environment_satisfaction in
(select environment_satisfaction
 from tblemployeesatisfaction
 where environment_satisfaction = "Low")
group by tbljobrole.job_role;
-- Study Case 5
select tbldepartment.department, 
tblemployeesatisfaction.work_life_balance,
count (tblemployeesatisfaction.work_life_balance) jumlah_karyawan
from tblemployee, tblsalary, tbldepartment, tblemployeesatisfaction 
where tblemployee.salary_id = tblsalary.salary_id and tblsalary.dept_id = 
tbldepartment.dept_id and tblemployee.employee_id = 
tblemployeesatisfaction.employee_id and 
tblemployeesatisfaction.work_life_balance in
(select work_life_balance
 from tblemployeesatisfaction
 where work_life_balance = "Best")
group by tbldepartment.department;



