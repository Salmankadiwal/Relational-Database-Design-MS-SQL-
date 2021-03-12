create database Bank_Workers
use Bank_Workers


create table role(

Id int not null primary key,
role_name varchar(100) not null


)

insert into role (Id,role_name) 
values(101,'Trader'),
      (102,'Fund Manager'),
      (103,'Receptionist'),
      (104,'Financial Advisor'),
      (105,'Investment Analyst'),
      (106,'Sales')




create table user_has_role(

Id int not null primary key,
role_start_time datetime not null,
role_end_time datetime null,
user_account_id int not null,
role_id int not null


)

insert into user_has_role (Id,role_start_time,role_end_time,user_account_id,role_id)
values(670,'2014-11-23 11:30:34',Null,7303,106 ),
      (671,'2015-01-09 12:45:13','2019-12-15 03:12:11',7301,104),
	  (672,'2016-08-21 09:11:22',Null,7304,103 ),
	  (673,'2016-09-23 01:30:29','2020-01-11 04:19:09',7307,106 ),
	  (674,'2017-03-09 01:10:14',Null,7305,102 ),
	  (675,'2018-07-07 09:03:32',Null,7302,105 ),
	  (676,'2019-11-03 01:18:55',Null,7306,101 ),
	  (677,'2020-02-27 06:44:58',Null,7308,103 )

Create table user_account(

Id int not null primary key,
user_names varchar(100) not null,
email varchar(254) not null,
password varchar(200) not null,
password_salt varchar(50) null,
password_hash_algorithm varchar(50) not null

)

insert into user_account (Id,user_names,email,password,password_salt,password_hash_algorithm)
values(7301,'KevinThomas','kevitho123@hotmail.com',hashbytes('MD2','Irondata45@'),'bE3XiWw=','pbFwXWE99vobT6g+vPWFy93NtUU/orrIWafF01hccfM='),
      (7302,'Stepenchan15','chanyoof@gmail.com',hashbytes('MD2','Dhivila0--'),'wbPZqMw=','AC3F4536-BB2E-41C5-B70D-454BE460C1BD'),
	  (7303,'Xingkhu88','tianstepu@gmail.com',hashbytes('MD2','Gsyte45kv'),'PwSunQU=','B3FA4C24-2E96-477C-A923-0CB0F6FA5C80'),
	  (7304,'Marieclerk','lepapclerk@yahoo.com',hashbytes('MD2','Flowersfgh'),'a9GiLUA=','BBE788B9-8D6D-4799-87A7-7B85B6BD67DC'),
	  (7305,'Willamcurran','curranroot77@gmail.com',hashbytes('MD2','Hasding66*'),'FlCpzTU=','4FE51B60-130E-4209-9E67-28DC4D91446C'),
	  (7306,'Jamieanderson01','andersongush@hotmail.com',hashbytes('MD2','Jigglingven++'),'K7dMpTY=','82F25F0C-5D75-4246-958A-B6DF67559D09'),
	  (7307,'KyleMitchell','seedkylewww@gmail.com',hashbytes('MD2','Manofpower2'),'ufS9t98=','6C52CCCA-C922-4FC3-AD0C-C4A651A9EF31'),
	  (7308,'Johnwilley','willeysams333@gmail.com',hashbytes('MD2','Karnalogs2323'),'jkd7f12=','4FC3-AD0C-C4A651A9EF31-6C52CCCA-C922')

create table user_has_status(

Id int not null primary key,
Status_start_date datetime not null,
Status_end_date datetime null,
user_account_id int not null,
status_id int not null


)

insert into user_has_status (Id,Status_start_date,Status_end_date,user_account_id,status_id)
values(11,'2015-01-09 12:45:13','2019-12-15 03:12:11',7301,201),
      (12,'2016-08-21 09:11:22',Null,7304,203),
      (13,'2019-11-03 01:18:55',Null,7306,203),
      (14,'2018-07-07 09:03:32',Null,7302,203),
      (15,'2021-02-18 11:30:34','2021-03-08 01:10:14',7303,202),
      (16,'2020-02-27 06:44:58',Null,7308,203),
      (17,'2017-03-09 01:10:14',Null,7305,203),
	  (18,'2016-09-23 01:30:29','2020-01-11 04:19:09',7307,201)


create table status(

Id int not null primary key,
status_name varchar(100) not null,
is_user_working bit not null
)

insert into status (Id,status_name,is_user_working)
values(201,'Terminated','False'),
      (202,'Leave','False'),
      (203,'Active','True')
      


---Making relationship from Foreign Key 

Alter table user_has_role
Add constraint Foreignkey_User_account_id foreign key (user_account_id) references user_account(Id),
    constraint Foreignkey_role_id foreign key (role_id) references role(Id)


Alter table user_has_status 
Add constraint Foreignkey_User_account_id_for_Status foreign key (user_account_id) references user_account(Id),
    constraint Foreignkey_status_id foreign key (status_id) references status(Id)



---we can not delete the table or delete records directly parent table if the child table has foreign key relationship.
---if we wanna drop parent table then first we have to drop foreign key from the child table and then we can delete parent table.


begin tran

Alter table user_has_role
drop constraint [Foreignkey_role_id],[Foreignkey_User_account_id]

---now we can delete role and user_has_role tables because there is no relationship between tables

truncate table role
truncate table user_has_role

Alter table user_has_status
drop constraint [Foreignkey_status_id],[Foreignkey_User_account_id_for_Status]

----now we can delete user_account, user_has_status, status tables because there is no relationship between tables

truncate table user_account
truncate table user_has_status
truncate table status

rollback tran -- Just using begin tran and rollback tran to check everything is working fine



---Using select statement to check whether constraints are dropped or not
select * from role
select * from user_has_role
select * from user_account
select * from user_has_status
select * from status





