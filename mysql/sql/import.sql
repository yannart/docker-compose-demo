use taskmanager;
create table task(id int not null auto_increment, task_name varchar(100) not null, task_description text,task_priority varchar(20),task_status varchar(20), task_archived bool default false,primary key(id));
insert into task values(1,'Gathering Requirement','Requirement Gathering','MEDIUM','ACTIVE',0);
insert into task values(2,'Application Designing','Application Designing','MEDIUM','ACTIVE',0);
insert into task values(3,'Implementation','Implementation','MEDIUM','ACTIVE',0);
insert into task values(4,'Unit Testing','Unit Testing','LOW','ACTIVE',0);
insert into task values(5,'Maintanence','Maintanence','LOW','ACTIVE',0);
