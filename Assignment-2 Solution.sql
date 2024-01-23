select * from Salesman;

select * from customer;

select * from orders_data;


/*
1.write a SQL query to find the salesperson and customer who reside in the same city. return salesman, cust_name and city
*/
select salesman.salesman_id,salesman.name as salesman_name ,customer.customer_id , customer.cust_name ,customer.city 
from salesman 
inner join customer on salesman.city = customer.city;

/*
2.write a SQL query to find those orders where the order amount exists between 500 
and 2000. Return ord_no, purch_amt, cust_name, city
*/
select orders_data.ord_no, orders_data.purch_amt, customer.cust_name, customer.city 
from orders_data
inner join customer on orders_data.customer_id=customer.customer_id
where orders_data.purch_amt between 500 and 2000;

/*
3.write a SQL query to find the salesperson(s) and the customer(s) he represents. 
Return Customer Name, city, Salesman, commission
*/
select customer.cust_name,customer.city,salesman.name as salesman_name,salesman.commission 
from customer
inner join salesman on customer.salesman_id = salesman.salesman_id;

/*
4.write a SQL query to find salespeople who received commissions of more than 12 
percent from the company. Return Customer Name, customer city, Salesman, 
commission.
*/
select customer.cust_name, customer.city , salesman.name as salesman_name
from customer
inner join salesman on customer.salesman_id=salesman.salesman_id
where salesman.commission>0.12;

/*
5.write a SQL query to locate those salespeople who do not live in the same city where 
their customers live and have received a commission of more than 12% from the 
company. Return Customer Name, customer city, Salesman, salesman city, 
commission
*/
select customer.cust_name, customer.city, salesman.name, salesman.city 
from salesman 
inner join customer on salesman.salesman_id = customer.salesman_id
where salesman.commission>.12
and salesman.city!=customer.city;

/*
6.write a SQL query to find the details of an order. Return ord_no, ord_date, 
purch_amt, Customer Name, grade, Salesman, commission
*/
select orders_data.ord_no, orders_data.ord_date, orders_data.purch_amt , customer.cust_name, customer.grade , salesman.name , salesman.commission
from orders_data
left join customer on orders_data.customer_id=customer.customer_id
left join salesman on orders_data.salesman_id=salesman.salesman_id;

/*
7.Write a SQL statement to join the tables salesman, customer and orders so that the 
same column of each table appears once and only the relational rows are returned. 
*/
SELECT *
FROM salesman
inner JOIN Customer ON salesman.salesman_id = customer.salesman_id
inner JOIN Orders_data ON customer.customer_id = orders_data.customer_id;

/*
8.write a SQL query to display the customer name, customer city, grade, salesman, 
salesman city. The results should be sorted by ascending customer_id.
*/
select customer.cust_name , customer.city, customer.grade, salesman.name ,salesman.city
from customer 
inner join salesman on salesman.salesman_id=customer.salesman_id
order by customer_id asc;

/*
9.write a SQL query to find those customers with a grade less than 300. Return 
cust_name, customer city, grade, Salesman, salesmancity. The result should be 
ordered by ascending customer_id.
*/
select customer.cust_name, customer.city , customer.grade , salesman.name , salesman.city 
from customer 
inner join salesman on salesman.salesman_id=customer.salesman_id
where grade<300;

/*
10.Write a SQL statement to make a report with customer name, city, order number, 
order date, and order amount in ascending order according to the order date to 
determine whether any of the existing customers have placed an order or not
*/
select customer.cust_name, customer.city, orders_data.ord_no , orders_data.ord_date , orders_data.purch_amt  
from customer 
left join orders_data on orders_data.customer_id=customer.customer_id
order by orders_data.ord_date asc;

/*
11.Write a SQL statement to generate a report with customer name, city, order number, 
order date, order amount, salesperson name, and commission to determine if any of 
the existing customers have not placed orders or if they have placed orders through 
their salesman or by themselves
*/
select  customer.cust_name , customer.city , orders_data.ord_no , orders_data.ord_date , orders_data.purch_amt ,
salesman.name , salesman.commission 
from customer 
left join salesman on salesman.salesman_id = customer.salesman_id
left join orders_data on orders_data.salesman_id = salesman.salesman_id;

/*
12.Write a SQL statement to generate a list in ascending order of salespersons who 
work either for one or more customers or have not yet joined any of the customers
*/
select * 
from salesman
order by salesman.name;

/*
13.write a SQL query to list all salespersons along with customer name, city, grade, 
order number, date, and amount.
*/
select s.name, c.cust_name, c.city , c.grade , o.ord_no , o.ord_date , o.purch_amt
from salesman s  
left join customer c on c.salesman_id = s.salesman_id
left join orders_data o on o.salesman_id = s.salesman_id;

/*
14.Write a SQL statement to make a list for the salesmen who either work for one or 
more customers or yet to join any of the customers. The customer may have placed, 
either one or more orders on or above order amount 2000 and must have a grade, or 
he may not have placed any order to the associated supplier.
*/
select distinct salesman.name,customer.grade , customer.city , customer.cust_name ,customer.customer_id 
from salesman 
left join customer on salesman.salesman_id=customer.salesman_id
left join orders_data on customer.customer_id=orders_data.customer_id
where customer.grade is not null
AND orders_data.purch_amt>2000;

/*
15 .Write a SQL statement to make a list for the salesmen who either work for one or 
more customers or yet to join any of the customers. The customer may have placed, 
either one or more orders on or above order amount 2000 and must have a grade, or 
he may not have placed any order to the associated supplier.
*/
select distinct salesman.name,customer.grade , customer.city , customer.cust_name ,customer.customer_id 
from salesman 
left join customer on salesman.salesman_id=customer.salesman_id
left join orders_data on customer.customer_id=orders_data.customer_id
where customer.grade is not null
AND orders_data.purch_amt>2000;

/*
16. Write a SQL statement to generate a report with the customer name, city, order no. 
order date, purchase amount for only those customers on the list who must have a 
grade and placed one or more orders or which order(s) have been placed by the 
customer who neither is on the list nor has a grade.
*/

/*
17. Write a SQL query to combine each row of the salesman table with each row of the 
customer table
*/
select * from salesman cross join customer;

/*
18. Write a SQL statement to create a Cartesian product between salesperson and 
customer, i.e. each salesperson will appear for all customers and vice versa for that 
salesperson who belongs to that city
*/
select * from salesman cross join customer where Customer.city=salesman.city;

/*
19. Write a SQL statement to create a Cartesian product between salesperson and 
customer, i.e. each salesperson will appear for every customer and vice versa for 
those salesmen who belong to a city and customers who require a grade
*/
select * from salesman cross join customer where Customer.city=salesman.city and grade is null ;

/*
20. Write a SQL statement to make a Cartesian product between salesman and 
customer i.e. each salesman will appear for all customers and vice versa for those 
salesmen who must belong to a city which is not the same as his customer and the 
customers should have their own grade
*/
select * from salesman cross join customer where Customer.city!=salesman.city and grade is not null ;
