USE return_and_report;
-- -----------------------------------
--            ***********
-- --------DELETE STATEMENTS---------- 
--            ***********
--
-- ---------------#1 Ward_unit Table    ---------
DELETE FROM `return_and_report`.`organization`
WHERE unit_name = 'calhoun ward';
-- ---------------#2 Organization Table    ---------
DELETE FROM `return_and_report`.`organization`
WHERE name = 'activity comittee';
-- ---------------#3 Calling Table    ---------
DELETE FROM `return_and_report`.`calling`
WHERE title = 'specialist';
-- ---------------#4 calling_has_organization Table    ---------
DELETE FROM `return_and_report`.`calling_has_organization`
WHERE (
    calling_calling_id = (
      SELECT calling_id
      FROM calling
      WHERE title = 'president'
    )
    AND organization_organization_id = (
      SELECT organization_id
      FROM organization
      WHERE name = 'primary'
    )
    AND ward_unit_idward_unit = (
      SELECT idward_unit
      FROM ward_unit
      WHERE unit_name = 'calhoun ward'
    )
  );
-- ---------------#5 circles_group Table    ---------
DELETE FROM `return_and_report`.`circle_group`
WHERE group_name = 'primary';
-- ---------------#6 user Table    ---------
DELETE FROM `return_and_report`.`user`
WHERE username = 'azufelt'
  AND email = 'ashley.zufelt@gmail.com';
-- ---------------#7 user_circle_group Table     ---------
DELETE FROM `return_and_report`.`user_circle_group`
WHERE user_id = (
    SELECT user_id
    FROM user
    WHERE username = 'azufelt'
      and email = 'ashley.zufelt@gmail.com'
  );
-- ---------------#8 work_status Table  ---------
DELETE FROM `return_and_report`.`work_status`
WHERE name = 'pending';
-- ---------------#9 project Table   ---------
DELETE FROM `return_and_report`.`project`
WHERE title = 'Ward Activity';
-- ---------------#10 circle_group_project Table    ---------
DELETE FROM `return_and_report`.`circle_group_project`
WHERE project_id = (
    SELECT project_id
    FROM project
    WHERE name = 'Ward Activity'
  );
-- ---------------#11 task Table   ---------
DELETE FROM `return_and_report`.`task`
WHERE task_id = '1';
-- ---------------#12 user_task Table   ---------
DELETE FROM `return_and_report`.`user_has_task`
WHERE (
    SELECT user_id
    FROM user
    WHERE username = 'azufelt'
      and email = 'ashley.zufelt@gmail.com'
  )
  AND (
    SELECT task_id
    FROM task
    WHERE project_id = '1'
  );