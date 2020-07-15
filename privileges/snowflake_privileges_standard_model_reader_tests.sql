/*
Use this script to make sure the reader roles can do everyting we need them to

For an overview of Snowflake Privileges: 
https://trevorscode.com/comprehensive-tutorial-of-snowflake-privileges-and-access-control/

For a description of what privileges are needed to complete certain tasks:
https://trevorscode.com/what-snowflake-privileges-do-i-need-to-do-insert-command-here/

*/

use role reader_db_1;
--use role reader_all;
--use role monitor_all;

select * from DEMO_TABLE;
select demo_func();
call demo_proc();
select * from DEMO_VIEW;

show tables;
show user functions;
show procedures;
show views;
show tasks;

describe table demo_table;
describe function demo_func();
describe procedure demo_proc();
describe view demo_view;
describe task demo_task;

select get_ddl('table', 'demo_table');
select get_ddl('function', 'demo_func()');
select get_ddl('procedure', 'demo_proc()');
select get_ddl('view', 'demo_view');
select get_ddl('task', 'demo_task');

create temporary table _temp.demo_table_temp as
select * from demo_table;

select * from _temp.demo_table_temp;