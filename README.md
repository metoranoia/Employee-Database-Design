# Employee-Database-Design
## Database Design
```mysql
create database dbemployee;
use dbemployee;
```
### Table Employee
```mysql
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
```
![image](https://github.com/metoranoia/Employee-Database-Design/assets/88704945/fad3ea42-c89c-438d-b469-1e9e37c7c5e2)

### Table Salary
```mysql
create table tblsalary (
  salary_id char(6) not null,
  hourly_rate int not null,
  daily_rate int not null,
  monthly_rate int not null,
  percent_salary_hike int not null,
  dept_id char(3) not null,
  job_id char(3) not null
  );
```
![image](https://github.com/metoranoia/Employee-Database-Design/assets/88704945/8b71d5a5-2005-47d4-b5b2-bdeb4af140fd)

### Table Department
```mysql
create table tbldepartment (
  dept_id char(3) not null primary key,
  department enum('Sales','Human Resources','Research & Development')
  );
```
![image](https://github.com/metoranoia/Employee-Database-Design/assets/88704945/06a871b6-1c7b-4e6b-9010-41736b7ddfe3)

### Table Job Role
```mysql
create table tbljobrole (
  job_id char(3) not null primary key,
  job_role enum('Sales Executive','Research Scientist','Laboratory Technician','Manufacturing Director','Healthcare Representative','Human Resources','Research Director','Sales Representative','Manager','Healthcare Representative')
  );
```
![image](https://github.com/metoranoia/Employee-Database-Design/assets/88704945/c0ee567d-34da-435b-ba22-76e057396a72)

### Tabel Employee Level of Satisfaction
```mysql
create table tblemployeesatisfaction (
  employee_id char(5) not null primary key,
  job_satisfaction enum('Low','Medium','High','Very High'),
  environment_satisfaction enum('Low','Medium','High','Very High'),
  relationship_satisfaction enum('Low','Medium','High','Very High'),
  work_life_balance enum('Good','Better','Best','Bad')
  );
```
![image](https://github.com/metoranoia/Employee-Database-Design/assets/88704945/d8f3ec2e-c7d8-4a50-b76a-b0cb93d5ce04)

## Implementation Operator AND, OR, NOT
### Operator AND
Seleksi data karyawan dengan education Bachelor dan marital status Married
```mysql
select*from tblemployee where education='Bachelor' and marital_status='Married';
```
![image](https://github.com/metoranoia/Employee-Database-Design/assets/88704945/5dbd5feb-8632-41dd-803c-7f2dcdbfa884)

Seleksi data karyawan dengan percent salary hike 11 dan dept id D03
```mysql
select*from tblsalary where percent_salary_hike='11' and dept_id='D03';
```
![image](https://github.com/metoranoia/Employee-Database-Design/assets/88704945/6eb6cf81-cc38-4c55-8320-b8ba561a4c6a)

### Operator OR
Seleksi data karyawan untuk menampilkan job satisfaction Low dan High
```mysql
select*from tblemployeesatisfaction where job_satisfaction='Low' or job_satisfaction='High';
```
![image](https://github.com/metoranoia/Employee-Database-Design/assets/88704945/cba0e294-9289-4448-a1c4-6a159f9d63c1)

Seleksi data karyawan yang mempunyai environment satisfaction very high atau work life balance Good
```mysql
select*from tblemployeesatisfaction where environment_satisfaction='Very High' or work_life_balance='Good';
```
![image](https://github.com/metoranoia/Employee-Database-Design/assets/88704945/cc3da635-e258-41f1-b9ee-6d0b38ff690c)

### Operator AND & OR
Seleksi untuk mengambil data karyawan perempuan yang memiliki bidang pendidikan life sciences dan medical
```mysql
select*from tblemployee where gender='Female' AND (education_field='Life Sciences' or education_field='Medical');
```
![image](https://github.com/metoranoia/Employee-Database-Design/assets/88704945/09cc1875-0882-4079-80f2-e4e56550c969)

### Operator NOT
Seleksi untuk menampilkan semua data karyawan kecuali job id J03
```mysql
select*from tblsalary where not job_id='J03';
```
![image](https://github.com/metoranoia/Employee-Database-Design/assets/88704945/fd5ef86f-bdd6-451f-83bd-1a031364ad0e)

Seleksi semua data karyawan yang mempunyai job id J09 kecuali dept id D01
```mysql
select*from tblsalary where not dept_id='D01' and job_id='J09';
```
![image](https://github.com/metoranoia/Employee-Database-Design/assets/88704945/60ecdf89-0984-4862-a650-08d1d244381b)

## Implementation Operator JOIN
### Full Outer Join
```mysql
select * from tblsalary
LEFT JOIN tbldepartment ON tblsalary.dept_id = tbldepartment.dept_id
UNION ALL
select * from tblsalary
RIGHT JOIN tbldepartment ON tblsalary.dept_id = tbldepartment.dept_id where tbldepartment.dept_id is null;
```
![image](https://github.com/metoranoia/Employee-Database-Design/assets/88704945/01d5a359-2be1-413c-b86c-343de7e3302f)

### Inner Join
```mysql
select * from tblemployee INNER JOIN tblemployeesatisfaction
ON tblemployee.employee_id=tblemployeesatisfaction.employee_id;
```
![image](https://github.com/metoranoia/Employee-Database-Design/assets/88704945/920c6f4b-7bcd-498d-b97f-4c75f6e5d61d)

### Right Join
```mysql
select * from tblsalary RIGHT JOIN tbljobrole 
ON tblsalary.job_id=tbljobrole.job_id;
```
![image](https://github.com/metoranoia/Employee-Database-Design/assets/88704945/7ddc09dd-1b26-438f-a7fc-5c69d783171d)

### Left Join
```mysql
select * from tblsalary LEFT JOIN tblemployee
ON tblsalary.salary_id=tblemployee.salary_id;
```
![image](https://github.com/metoranoia/Employee-Database-Design/assets/88704945/be521df2-e4ad-4033-8364-2ef881d93832)

### Cross Join
```mysql
select * from tblemployee CROSS JOIN tblemployeesatisfaction order by age asc;
```
![image](https://github.com/metoranoia/Employee-Database-Design/assets/88704945/5a7eaba4-3a54-4f09-ae9f-c37ef2fdd0eb)

## Implementation Operator Sub-query
### Study Case 1
Berdasarkan tabel employee dan tabel salary, tulislah query untuk menghasilkan semua karyawan yang memiliki gaji lebih besar dari rata-rata gaji karyawan. Hasilkan employee_id, age, gender, salary_id, dan monthly_rate
```mysql
SELECT tblemployee.employee_id, tblemployee.age, tblemployee.gender, tblsalary.salary_id, tblsalary.monthly_rate 
FROM tblemployee, tblsalary
WHERE tblemployee.salary_id = tblsalary.salary_id AND tblsalary.monthly_rate >
(SELECT AVG(monthly_rate)
FROM tblsalary)
ORDER BY tblsalary.monthly_rate;
```
![image](https://github.com/metoranoia/Employee-Database-Design/assets/88704945/c1be198f-93e5-4a12-b952-c8d4b4ce2c46)

### Study Case 2
Berdasarkan tabel employee, tabel salary, tabel department tulislah query untuk menghasilkan gaji minimal karyawan di setiap department. Hasilkan employee_id, gender, salary_id, monthly_rate, dept_id, dan department
```mysql
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
```
![image](https://github.com/metoranoia/Employee-Database-Design/assets/88704945/f5105ef0-91dc-44bf-8099-a632e0774f22)

### Study Case 3
Berdasarkan tabel employee, tabel salary, tabel jobrole tulislah query untuk menghasilkan gaji maksimal karyawan di setiap job role. Hasilkan employee_id, gender, education, salary_id, monthly_rate, job_id, dan jobrole
```mysql
select tblemployee.employee_id, tblemployee.gender,tblemployee.education, tblemployee.salary_id, tblsalary.monthly_rate, tblsalary.job_id, tbljobrole.job_role
from tblemployee, tblsalary, tbljobrole 
where tblemployee.salary_id = tblsalary.salary_id and tblsalary.job_id = tbljobrole.job_id and tblsalary.monthly_rate in
(select max(monthly_rate)
 from tblsalary,tbljobrole
 where tblsalary.job_id = tbljobrole.job_id
 group by tblsalary.job_id);
```
![image](https://github.com/metoranoia/Employee-Database-Design/assets/88704945/9783b84d-143b-42ff-90bd-c3de48a81d4a)

### Study Case 4
Berdasarkan tabel employee, tabel salary, tabel jobrole tulislah query untuk menghasilkan jumlah karyawan yang memberikan environment satisfaction “Low” pada setiap job role. Hasilkan  jobrole, environment satisfaction, dan jumlah_karyawan
```mysql
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
```
![image](https://github.com/metoranoia/Employee-Database-Design/assets/88704945/b7ca1a9a-96d8-4be3-be3a-cb30a4b26c69)

### Study Case 5
Berdasarkan tabel employee, tabel salary, tabel department tulislah query untuk menghasilkan jumlah karyawan yang memberikan nilai work life balance “Best” pada setiap department. Hasilkan department, work_life_balance, dan jumlah_karyawan
```mysql
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
```
![image](https://github.com/metoranoia/Employee-Database-Design/assets/88704945/f5111ac0-b57e-4605-8ffd-eefc4d723c6c)
