/*

Reasoning for this design is described here:
https://trevorscode.com/toward-a-standard-model-for-snowflake-roles-and-privileges/

For an overview of Snowflake Privileges: 
https://trevorscode.com/comprehensive-tutorial-of-snowflake-privileges-and-access-control/

For a description of what privileges are needed to complete certain tasks:
https://trevorscode.com/what-snowflake-privileges-do-i-need-to-do-insert-command-here/

*/



/*
WARNING: Make sure if you run these drops that you aren't nuking something you want to keep
use role accountadmin;
drop database if exists db_1;
drop role if exists owner_db_1;
drop role if exists reader_db_1;
drop role if exists monitor_all;
drop role if exists reader_all;
*/



--Set this up once per account----------------------------------------------------------
use role accountadmin;

create role reader_all;

create role monitor_all;
grant monitor execution, monitor usage on account to role monitor_all;
grant role reader_all to role monitor_all;
grant role monitor_all to role sysadmin;




--For a New Database--------------------------------------------------------------------------

create role owner_db_1;
grant execute task on account to role owner_db_1;
grant role owner_db_1 to role sysadmin;

create role reader_db_1;
grant usage, monitor on warehouse xs_wh to role reader_db_1;
grant role reader_db_1 to role owner_db_1;
grant role reader_db_1 to role reader_all;


create database db_1;
grant ownership on database db_1 to role owner_db_1;

grant monitor, usage on database db_1 to role reader_db_1;

grant monitor on future tasks in database db_1 to role reader_db_1;
grant usage on future schemas in database db_1 to role reader_db_1;
grant USAGE on future functions in database db_1 to role reader_db_1;
grant USAGE on future PROCEDURES in database db_1 to role reader_db_1;
grant select on future TABLES in database db_1 to role reader_db_1;
grant monitor on future TASKS in database db_1 to role reader_db_1;
grant select on future VIEWS in database db_1 to role reader_db_1;
grant usage, read on future stages in database db_1 to role reader_db_1;
grant usage on future file formats in database db_1 to role reader_db_1;
grant select on future streams in database db_1 to role reader_db_1;

--The _temp schema is useful for readers so they can create temporary tables
use role owner_db_1;
create schema db_1._temp;
grant create table on schema db_1._temp to role reader_db_1;



--Create a new schema in the new database -----------------------------------------------------
use role owner_db_1;
create schema db_1.db_1_schema;
use schema db_1.db_1_schema;
