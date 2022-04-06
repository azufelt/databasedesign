USE return_and_report;
-- --------UPDATE STATEMENTS---------- 
-- ---------------#1 Organization Table    ---------
UPDATE organization
SET organization_id = 1,
  name = 'bishopric',
  app_org_guid = ''
WHERE organization_id = 1;
-- ---------------#2 Calling Table    ---------
UPDATE calling
SET calling_id = 1,
  title = 'President'
WHERE calling_id = 1;
-- ---------------#3 Ward_unit Table    ---------
UPDATE ward_unit
SET idward_unit = 1,
  unit_name = 'calhoun ward'
WHERE idward_unit = 1;
-- ---------------#4 calling_has_organization Table    ---------
UPDATE calling_has_organization
SET calling_calling_id = 1,
  organization_organization_id = 6,
  ward_unit_idward_unit = 1
WHERE calling_calling_id = 1
  AND organization_organization_id = 6;
-- ---------------#5 circles_group Table    ---------
UPDATE circle_group
SET circle_group_id = 1,
  group_name = 'ward council',
  app_circle_guid = ' ',
  calling_has_organization_calling_id = 1,
  calling_has_organization_organization_id = 6
WHERE circle_group_id = 1;
-- ---------------#6 user Table    ---------
UPDATE user
SET user_id = < { user_id: } >,
  username = < { username: } >,
  password = < { password: } >,
  email = < { email: } >,
  first_name = < { first_name: } >,
  last_name = < { last_name: } >,
  phone_num = < { phone_num: } >
WHERE user_id = < { expr } >;
-- ---------------#7 user_circle_group Table     ---------
UPDATE user_circle_group
SET user_circle_group_id = < { user_circle_group_id: } >,
  user_id = < { user_id: } >,
  circle_group_id = < { circle_group_id: } >
WHERE user_circle_group_id = < { expr } >;
-- ---------------#8 project Table   ---------
UPDATE project
SET project_id = < { project_id: } >,
  title = < { title: } >,
  location = < { location: } >,
  description = < { description: } >,
  start_date = < { start_date: } >,
  circle_group_id = < { circle_group_id: } >
WHERE project_id = < { expr } >;
-- ---------------#9 circle_group_project Table    ---------
UPDATE circle_group_project
SET circle_group_project = < { circle_group_project: } >,
  circle_group_id = < { circle_group_id: } >,
  project_id = < { project_id: } >,
  date_created = < { date_created: } >,
  start_date = < { start_date: } >,
  goal_date = < { goal_date: } >,
  completed_date = < { completed_date: } >,
  current_status = < { current_status: } >
WHERE circle_group_project = < { expr } >;
-- ---------------#10 work_status Table  ---------
UPDATE work_status
SET work_status_id = < { work_status_id: } >,
  name = < { name: } >
WHERE work_status_id = < { expr } >;
-- ---------------#11 task Table   ---------
UPDATE task
SET task_id = < { task_id: } >,
  assign - date = < { assign - date: } >,
end - date = < {
end - date: } >,
description = < { description: } >,
budget = < { budget: } >,
owner_id = < { owner_id: } >,
current_status_id = < { current_status_id: } >,
project_id = < { project_id: } >,
date_created = < { date_created: } >,
start_date = < { start_date: } >,
goal_date = < { goal_date: } >,
completed_date = < { completed_date: } >
WHERE task_id = < { expr } >
  AND owner_id = < { expr } >
  AND project_id = < { expr } >;
-- ---------------#12 user_task Table   ---------
UPDATE user_task
SET user_task_id = < { user_task_id: } >,
  user_id = < { user_id: } >,
  task_id = < { task_id: } >
WHERE user_task_id = < { expr } >;