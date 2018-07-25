-- ProblemSet 00,July 25 2018
-- Submission by nivetha.seenivasan 

1)Select the Employee with the top three salaries

select * from employee order by salary desc limit 3;

A142|Tara Cummings|D04|99475|A187
A132|PAUL VINCET|D01|94791|A120
A128|Adam Wayne|D05|94324|A165

record count- 3

2)Select the Employee with the least salary

select * from employee order by salary limit 1;
A111|John Helen|D01|15380|A120

select emp_id,name,dept_id,min(salary) from employee;
A111|John Helen|D01|15380

select * from employee where salary =(select min(salary) from employee);
A111|John Helen|D01|15380|A120

record count-1

3)Select the Employee who does not have a manager in the department table

select * from employee where manager_Id not in(select emp_id from Employee e Inner Join Dept d where e.dept_id=d.dept_id and e.name=d.Dept_manager);

A178|BRUCE WILLS|D03|66861|A298
A120|Tim Archer|D01|48834|A298
A187|Adam Justin|D02|80543|A298
A165|Natasha Stevens|D05|31377|A298

record count-4

4)Select the Employee who is also a Manager

select distinct e.emp_id,e.name from employee e,employee e1 where e.emp_id=e1.manager_id;

A120|Tim Archer
A187|Adam Justin
A165|Natasha Stevens
A178|BRUCE WILLS

record count-4

5)Select the Empolyee who is a Manager and has least salary

 select * from employee where salary =(select min(e.salary) from employee e,employee e1 where e.emp_id=e1.manager_id);

A165|Natasha Stevens|D05|31377|A298

record count-1

6)Select the total number of Employees in Communications departments
 
select count(*) from employee where dept_id =(select dept_id from dept where Dept_name='COmmunications');

6

record count-1

7)Select the Employee in Finance Department who has the top salary

 select emp_id,name,max(salary) from employee where dept_id =(select dept_id from dept where Dept_name='Finance');

A128|Adam Wayne|94324

record count-1

8)Select the Employee in product depatment who has the least salary

select emp_id,name,min(salary) from employee where dept_id =(select dept_id from dept where Dept_name='Product');

A156|Nick Martin|50174

record count-1

9)Select the count of Empolyees in Health with maximum salary

select count(*) from employee where salary=(select max(salary) from employee where dept_id =(select dept_id from dept where Dept_name='Health'));

1

record count-1

10)Select the Employees who report to Natasha Stevens

select * from employee where manager_Id in(select distinct e.emp_id from employee e,employee e1 where e.emp_id=e1.manager_id and e.name='Natasha Stevens');

A128|Adam Wayne|D05|94324|A165
A129|Joseph Angeline|D05|44280|A165

record count-1

11) Display the Employee name,Employee count,Dep name,Dept manager in the Health department

select e.name,count(e.name),d.dept_name,d.dept_manager from employee e inner join dept d where e.dept_Id=d.dept_Id and dept_name='Health' order by e.name;
John Helen|6|Health|Tim Archer

record count-1

select e.name,count(e.name),d.dept_Name,d.Dept_manager from dept d inner join(select name from employee where dept_id=(select dept_id from dept where dept_name='Health')) as e where dept_name='Health';

Brad Michael|Health|Tim Archer
Edward Cane|Health|Tim Archer
John Helen|Health|Tim Archer
Martin Tredeau|Health|Tim Archer
PAUL VINCET|Health|Tim Archer
Tim Archer|Health|Tim Archer

record count-6

12)Display the Department id,Employee ids and Manager ids for the Communications department

select name from employee where dept_id=(select dept_id from dept where dept_name='COmmunications');

select d.dept_id,e.emp_id,d.dept_Manager from dept d inner join(select emp_id from employee where dept_id=(select dept_id from dept where dept_name='COmmunications')) as e where dept_name='COmmunications';
D02|A116|Adam Justin
D02|A121|Adam Justin
D02|A133|Adam Justin
D02|A187|Adam Justin
D02|A194|Adam Justin
D02|A198|Adam Justin


13)Select the Average Expenses for Each dept with Dept id and Dept name

 select d.dept_id,d.dept_name,e.salary from dept d inner join (select dept_id,avg(salary) as salary from employee group by dept_id) as e where e.dept_id=d.dept_id;

D01|Health|54527.6666666667
D02|COmmunications|48271.3333333333
D03|PRODCUT|58517.5
D04|Insurance|64020.0
D05|Finance|56660.3333333333

record count-5

14))Select the total expense for the department finance

select e.dept_id,d.dept_name,avg(salary) from employee e inner join (select dept_id,dept_name from dept where dept_name='Finance') as d where d.dept_id=e.dept_id ;
D05|Finance|56660.3333333333

select dept_id,avg(salary) from employee where dept_id =(select dept_id from dept where dept_name='Finance');

D05|56660.3333333333

record count-1

15)Select the department which spends the least with Dept id and Dept manager name

select l.DEPT_ID,l.Dept_name,l.dept_manager,min(Total) from(select e.dept_id as DEPT_ID,d.dept_name as Dept_name,d.dept_manager,total(salary) as Total from employee e inner join dept d where d.dept_id=e.dept_id group by e.dept_id ) as l;

D03|PRODCUT|BRUCE WILLS|117035.0

 select d.DEPT_ID,d.Dept_name,d.dept_manager,min(l.Total)  from dept d inner join(select e.dept_id as DEPT_ID,d.dept_name as Dept_name,d.dept_manager,total(salary) as Total from employee e inner join dept d where d.dept_id=e.dept_id group by e.dept_id ) as l where d.dept_id=l.dept_id;
D03|PRODCUT|BRUCE WILLS|117035.0

record count-1

16)Select the count of Employees in each department

select e.dept_id,d.dept_name,count(*) from employee e inner join dept d where e.dept_id=d.dept_id group by d.dept_id;

D01|Health|6
D02|COmmunications|6
D03|PRODCUT|2
D04|Insurance|2
D05|Finance|3

record count-5

17)Select the count of Employees in each department having salary <10000

select count(*) from employee where salary<10000 group by dept_id;

Empty set

record count-0

18)Select the total number of Employees in Dept id D04

 select e.dept_id,d.dept_name,count(*) from employee e inner join dept d where e.dept_id=d.dept_id and e.dept_id='D04' ;

 D04|2


select e.dept_id,d.dept_name,count(*) from employee e inner join dept d where e.dept_id=d.dept_id and e.dept_id='D04' ;
D04|Insurance|2

record count-2


19) Select all department details of the Department with Maximum Employees

select p.dept_id,p.dept_name,k.c1 from(select max(l.count) as c1 from (select e.dept_id,d.dept_name,count(*) as count from employee e inner join dept d where e.dept_id=d.dept_id group by d.dept_id) as l)  as k inner join  (select e.dept_id,d.dept_name,count(*) as count from employee e inner join dept d where e.dept_id=d.dept_id group by d.dept_id) as p where k.c1=p.count ;
D01|Health|6
D02|COmmunications|6
record count-2

20)Select the Employees who has Tim Cook as their manager

select * from employee where manager_id =(select emp_id from Employee e Inner Join Dept d where e.dept_id=d.dept_id and e.name=d.dept_manager and d.Dept_manager='Tim Cook');

Empty set

record count-0


