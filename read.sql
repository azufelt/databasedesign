USE return_and_report;
-- -------- SELECT/READ STATEMENTS ---------- 
-- ---------------#1 Organization Table    ---------
SELECT organization_id,
  name,
  app_org_guid
FROM organization;
-- ---------------#2 Calling Table    ---------
SELECT calling.calling_id,
  calling.title
FROM calling;
-- ---------------#3 Ward_unit Table    ---------
SELECT idward_unit,
  unit_name
FROM ward_unit;
-- ---------------#4 calling_has_organization Table    ---------
SELECT calling_calling_id,
  organization_organization_id,
  ward_unit_idward_unit
FROM calling_has_organization;
-- ---------------#5 circles_group Table    ---------
SELECT circle_group_id,
  group_name,
  app_circle_guid,
  calling_has_organization_calling_id,
  calling_has_organization_organization_id
FROM circle_group;
-- ---------------#6 user Table    ---------
SELECT user_id,
  username,
  password,
  email,
  first_name,
  last_name,
  phone_num
FROM user;
-- ---------------#7 user_circle_group Table     ---------
SELECT user_circle_group_id,
  user_id,
  circle_group_id
FROM user_circle_group;
-- ---------------#8 project Table   ---------
SELECT project_id,
  title,
  location,
  description,
  start_date,
  circle_group_id
FROM project;
-- ---------------#9 circle_group_project Table    ---------
SELECT circle_group_project,
  circle_group_id,
  project_id,
  date_created,
  start_date,
  goal_date,
  completed_date,
  current_status
FROM circle_group_project;
-- ---------------#10 work_status Table  ---------
SELECT work_status_id,
  name
FROM work_status;
-- ---------------#11 task Table   ---------
SELECT task_id,
  assign - date,
end - date,
description,
budget,
owner_id,
project_id,
date_created,
start_date,
goal_date,
completed_date
FROM task;
-- ---------------#12 user_task Table   ---------
SELECT user_task_id,
  user_id,
  task_id
FROM user_task;
-- ---------------#13 calendar Table   ---------
SELECT *
FROM CALENDAR;
-- ---------------#14 date-module Table  ---------
SELECT *
FROM `DATE-MODULE`;
-- ---------------EXTRA STUFF ---------
SET foreign_key_checks = 1