/*
The following queries make sure that the owner of our database can create and manage objects in the database

For an overview of Snowflake Privileges: 
https://trevorscode.com/comprehensive-tutorial-of-snowflake-privileges-and-access-control/

For a description of what privileges are needed to complete certain tasks:
https://trevorscode.com/what-snowflake-privileges-do-i-need-to-do-insert-command-here/

*/

use role owner_db_1;

--Test it out by creating some objects
create table db_1.db_1_schema.demo_table(demo_col int); 

create function db_1.db_1_schema.demo_func()
  returns double
  language javascript
  as 'return 1';

create procedure db_1.db_1_schema.demo_proc()
  returns float
  language javascript
  execute as caller
  as
  $$
    return 3.1415926;
  $$
  ;

create view db_1.db_1_schema.demo_view as
select 1 col_1;

create task db_1.db_1_schema.demo_task
warehouse = xs_wh
SCHEDULE = 'USING CRON * * * * * America/Los_Angeles'
as
select 1;