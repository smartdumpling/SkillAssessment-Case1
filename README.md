# SkillAssessment-Case1

### Please Click [Here](https://github.com/smartdumpling/SkillAssessment-Case1/blob/main/Endingbalance.sql) to Check my Solution in MySQL 

### Case Scenario

John Smith opened an account with ABC Bank on 1st January 2020, the 'Transactions' table shows each transaction by date. The amounts received by him are reflected as positive values while payments made by John to others are negative in value. 

He will be charged a monthly activity fee of 2 dollars if he fails to make total payment of at least 100 dollars within the month AND if the total number of payments made for that month is less than 3. If he meets both criteria, the bank will waive the charges for that month. Note that the charges have been deducted from his account balance but are not reflected in the 'Transactions' table.

Please write a query to derive the actual ending balance of this account at year end without updating the 'Transactions' table. The result of the query should be just a numeric value. For example, if he received $2,000 in total, paid out $500 to others and activity fees of $14 have been deducted for the entire year, the query result should be $1,486.
Feel free to use any tool available (online tools such as DB Fiddle, SQL Fiddle etc are free to use) to test your query. Kindly send back the solution (by Word, text file, Google Docs or provide a link to online IDE containing your solution) and state the SQL dialect used (T-SQL, PostgreSQL, etc).

### Transaction table
```MySQL
create table transactions (

        amount integer not null,
        date date not null
  );
  
insert into transactions values ('1000', '2020-01-06');
insert into transactions values ('-5', '2020-01-16');
insert into transactions values ('-80', '2020-01-22');
insert into transactions values ('-5', '2020-01-25');
insert into transactions values ('2000', '2020-05-10');
insert into transactions values ('-80', '2020-05-12');
insert into transactions values ('-5', '2020-05-15');
insert into transactions values ('50', '2020-05-15');
insert into transactions values ('-50', '2020-05-17');
insert into transactions values ('2000', '2020-11-07');
insert into transactions values ('1000', '2020-11-07');
insert into transactions values ('-200', '2020-11-21');
```
