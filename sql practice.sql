create database office;
create table emp( emp_id int,
name varchar(20),
dept varchar(20),
salary int,
experience int);
insert into emp (emp_id,name,dept,salary,experience) 
values
(1,'tanu','it',9000,5),
(2,'deepu','hr',8000,1),
(3,'vanshu','it',7000,2),
(4,'lucky','hr',6000,2),
(5,'aradhya','it',5000,2);
select * from emp;

select name,salary,
case
	when salary<5000 then 'high salary'
    else 'low salary'
end as salary_status
from emp;

select name,experience,
case
	when experience>4 then 'Experienced'
    else 'Fresher'
end as experience_status
from emp;

select name,dept,
case
	when dept='it' then 'Technical'
	else 'non-technical'
end as status
from emp;

select name,salary,
case
	when salary>8000 then 'bonus eligible'
    else 'not'
end as bonus_avail
from emp;

select name,salary,
case
	when salary>=8000 then 'A'
    when salary>6000 then 'B'
    when salary>5000 then 'C'
    when salary>4000 then 'D'
end as grade
from emp;

create table emps(emp_id int,
name varchar(20),
dept_id int,
salary int);

drop table dept;
create table dept( dept_id int,
dept_name varchar(20)
);

insert into emps (emp_id,name,dept_id,salary) values
 (1,'tanu',1,9000),
 (2,'aradhya',2,2000),
 (3,'deepu',3,3000),
 (4,'vanshu',3,4000);
 
 select * from emps;
 
 insert into dept (dept_id,dept_name) values
 (1,'it'),
 (2,'hr'),
 (3,'finance');
 
 select * from dept;
 
 select name,dept_name
 from emps 
 inner join dept
 on emps.dept_id=dept.dept_id;
 
 select name,salary,dept_name
 from emps
 left join dept
 on emps.dept_id=dept.dept_id;
 
 select * from emps cross join dept;
 
 select e.name,d.dept_name
 from emps e
 inner join dept d
 on e.dept_id=d.dept_id
 where d.dept_name='it';

select dept_name,count(*)
from dept
group by dept_name;

select e.name,d.dept_name
from emps e
left join dept d
on e.dept_id=d.dept_id
and salary>5000;

select d.dept_name,sum(e.salary) as total_salary
from emps e
join dept d
on e.dept_id=d.dept_id
group by d.dept_name;

select d.dept_name,avg(e.salary)as avg_salary 
from emps e
join dept d
on e.dept_id=d.dept_id 
group by d.dept_name
order by avg_salary desc;

select d.dept_name, count(e.emp_id) as total
from dept d
inner join emps e
on d.dept_id=e.dept_id
group by d.dept_name
having count(e.emp_id)>2;

select e.name,d.dept_name,e.salary
from emps e
join dept d
on e.dept_id=d.dept_id
where e.salary=(select max(salary) from emps where dept_id=e.dept_id);

select name 
from emps where salary>(select avg(salary) as avg_salary from emps);

select name 
from emps where salary<(select max(salary) from emps);

select name 
from emps where salary=(select min(salary) from emps);

select name,salary
from emps where salary=(select avg(salary) as avg_salary from emps);

with cte_emp as
(
select * from emps )
select * from cte_emp;

with cte_salary as
(
select name from emps where salary>2000)
select * from cte_salary;

with cte_avg as
(
select dept_name,avg(salary) as avg_salary from emps
group by dept_name)
select * from cte_avg;

create table empss(
emp_id int,name varchar(50),dept varchar(20),salary int );

insert into empss (emp_id,name,dept,salary) values
(1,'tanu','it',40000),
(2,'deepu','hr',30000),
(3,'vanshu','it',20000),
(4,'lucky','hr',10000);

select name,salary,avg(salary) over() as company_avg from empss;
select name,salary,avg(salary) over(partition by dept) as dept_avg from empss;
select name,salary,row_number() over(order by salary desc) as rn from empss;
select name,salary,rank() over(order by salary desc) as salary_rank from empss;
select name,salary,dense_rank() over(partition by dept order by salary desc) dept_rank from empss;


create table employss(
emp_id int,emp_name varchar(20),dept varchar(20),
salary int, hire_date date);

insert into employss(emp_id,emp_name,dept,salary,hire_date) 
values
(1,'Alice','HR',50000,'2022-01-10'),
(2,'Bob','IT',70000,'2021-03-15'),
(3,'Charlie','IT',80000,'2020-07-22'),
(4,'David','HR',60000,'2023-05-11'),
(5,'Eva','Sales',55000,'2022-09-18'),
(6,'Frank','Sales',65000,'2021-12-05'),
(7,'Grace','IT',70000,'2022-02-08'),
(8,'Helen','HR',52000,'2020-11-30');

select * from employss;

select 
emp_name,salary,avg(salary) 
over() as company_avg
from employss;

select emp_name,salary,sum(salary)
over() as total_salary
from employss;

select emp_name,salary,max(salary)
over() as highest_salary
from employss;

select emp_name,salary,min(salary)
over() as lowest_salary
from employss;

select emp_name,salary,count(emp_id)
over() as total
from employss; 

select emp_name,dept,salary,avg(salary)
over(partition by dept) as dept_avg
from employss;

select emp_name,salary,dept,max(salary)
over(partition by dept) as dept_max
from employss;

select emp_name,dept,salary,min(salary)
over(partition by dept) as dept_min
from employss;

select emp_name,dept,count(emp_id)
over(partition by dept) as dept_count
from employss;

select emp_name,dept,salary,sum(salary)
over(partition by dept) as dept_total
from employss;

select emp_name,salary,row_number() over(order by salary desc) as rn 
from employss;

select emp_name,salary,row_number() over(partition by dept) as
dept_rn from employss;

select emp_name,dept,salary
from( 
select emp_name,dept,salary,row_number() over(partition by dept
order by salary desc) as rn from employss)t where rn=1; 

select emp_name,salary,dept
from(
select emp_name,dept,salary,row_number() 
over(partition by dept order by salary desc)as rn from employss)t
where rn>=2;

select emp_name,dept,hire_date
from(
select emp_name,dept,hire_date,row_number() 
over(partition by dept order by hire_date)as rn from employss)t 
where rn=1;

select emp_name, salary,rank() over(order by salary desc) as 
salary_rank from employss;

select emp_name,salary,dept,rank() over(partition by dept order by 
salary desc) as dept_rank from employss; 

select emp_name,salary,dept
from(
select emp_name,salary,dept,rank() over(order by salary desc)
as rnk from employss)t where rnk=2;

select dept
from( 
select dept,rank() over(partition by dept 
order by salary desc) as rnk from employss)t where rnk=1
group by dept
having count(*)>1;

select emp_name,salary,dept,dense_rank() over(order by salary desc) 
as salary_drnk from employss; 

select emp_name,salary,dept
from(
select emp_name,salary,dept,dense_rank() over(order by salary desc)as rnk from employss)t 
where rnk<=3;

select emp_name,salary,dept
from(select emp_name,salary,dept,dense_rank() over(order by salary desc)
as rnk from employss)t where rnk=2;

select emp_name,salary,dept
from
(select emp_name,salary,dept,dense_rank() over(partition by dept order by salary desc)
as rnk from employss)t where rnk<=2;

select *,row_number() over(order by salary desc) as rn from employss;
select *,rank() over(order by salary desc) as rnk from employss;
select *,dense_rank() over(order by salary desc) as drnk from employss;

select emp_name,salary,sum(salary) over (order by salary desc) as running_total
from employss;

select emp_name,salary,dept,sum(salary) over( partition by dept  order by salary desc)
as running_dept from employss;


select emp_name,salary,hire_date,sum(salary) over(partition by hire_date order by salary desc)
as running_date from employss;

select emp_name,salary,hire_date,avg(salary) over(partition by hire_date order by salary desc)
as running_date from employss;

select hire_date,count(*) over (order by hire_date ) as count_by_date 
from employss;

select emp_name,salary,lag(salary)
over(order by salary) as previous_salary from employss;

select emp_name,salary,lag(salary)
over(order by salary) as previous_salary,
salary-lag(salary) over(order by salary) as salary_differene
from employss;

select emp_name,hire_date,lag(hire_date)
over( partition by dept order by hire_date) as dept 
from employss;

select emp_name,salary,lead(salary)
over(order by salary desc) as next from employss;

select emp_name,salary,ntile(4) over(order by salary desc) as salary_quartile
from employss;

select emp_name,salary,dept,ntile(3) over(partition by dept order by salary desc)
as dept_quartile from employss;

select emp_name,salary,ntile(9) over(order by salary desc) as salary_qua
from employss;

select emp_name,dept,salary
from(
select emp_name,dept,salary,avg(salary)
over(partition by dept) as dept_avg from employss)t
where salary<dept_avg;

select emp_name,dept,salary
from(
select emp_name,dept,salary,max(salary)
over(partition by dept) as dept_max from employss)t
where salary=dept_max;
