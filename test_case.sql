SELECT *
FROM return_and_report;
-- **********************************************************************
-- User Login
--** check entered username/password against db then get name **
Select first_name,
  last_name
FROM user
WHERE username = 'azufelt'
  AND password = 'mypassword';
-- **********************************************************************
-- Create User
INSERT INTO user (
    username,
    password,
    email,
    first_name,
    last_name,
    phone_num
  )
VALUES (
    'azufelt',
    'mypassword',
    'ashley.zufelt@gmail.com',
    'Ashley',
    'Zufelt',
    1234567890
  );
-- **********************************************************************
-- Edit/Update User
SELECT user_id,
  username,
  password,
  email,
  first_name,
  last_name,
  phone_num
FROM user
WHERE username = 'azufelt'
  AND email = 'ashley.zufelt@gmail.com';
UPDATE user u1
  JOIN user u2
SET u1.password = 'newpassword',
  u1.email = 'new.email@gmail.com',
  u1.first_name = 'Ashley',
  u1.last_name = 'Zufelt',
  u1.phone_num = '1518675309'
WHERE u1.user_id = u2.user_id
  AND u1.username = 'azufelt';
-- Circles Groups
SELECT distinct group_name
FROM circle_group cg
  join user_circle_group ucg ON cg.circle_group_id = ucg.circle_group_id
  join `user` u ON ucg.user_id = u.user_id
WHERE u.username = 'azufelt';
-- New Project
INSERT INTO project (
    title,
    location,
    description,
    start_date,
    work_status_work_status_id,
    proj_budget
  )
VALUES (
    'Pioneer Day Activity',
    'North City Park',
    'A fun activity for families to 
    gather and celebrate our pioneer 
    ancestors',
    '2022-04-17',
    (
      SELECT work_status_id
      FROM work_status
      WHERE name = 'In Progress'
    ),
    10
  );
-- **********************************************************************
-- add the new project to the circles group
INSERT INTO circle_group_project (
    circle_group_id,
    project_id,
    date_created
  )
VALUES (
    (
      SELECT circle_group_id
      FROM circle_group
      WHERE group_name = 'primary'
    ),
    (
      SELECT project_id
      FROM project
      WHERE project_id = 7
    ),
    CURRENT_DATE()
  );
-- **********************************************************************
-- Get View of Project
-- ** join to get name of work status from project table * *
SELECT p.title,
  p.location,
  p.description,
  p.start_date,
  (
    SELECT name
    FROM work_status w
      JOIN project p ON w.work_status_id = p.work_status_work_status_id
    WHERE project_id = 7
  ) as status,
  p.proj_budget
FROM project p
WHERE project_id = 7;
-- **********************************************************************
-- New Task
INSERT INTO task (
    `assign-date`,
    `end-date`,
    description,
    budget,
    project_id,
    date_created,
    work_status_id
  )
VALUES (
    CURRENT_DATE(),
    (
      SELECT start_date
      FROM project
      WHERE (title = 'Pioneer Day Activity')
        AND (project_id = 7)
    ),
    'Handouts/invites',
    10,
    (
      SELECT project_id
      FROM project
      WHERE (title = 'Pioneer Day Activity')
        AND (project_id = 7)
    ),
    CURRENT_DATE(),
    (
      SELECT work_status_id
      FROM work_status
      WHERE name = 'needs attention'
    )
  );
-- **********************************************************************
-- Edit Task
UPDATE task
SET task_id = 27,
  `assign-date` = CURRENT_DATE(),
  `end-date` = (
    SELECT start_date
    FROM project
    WHERE title = 'Pioneer Day Activity'
  ),
  description = 'Schedule Facility on 
      shared calendar',
  budget = 0,
  owner_id = (
    SELECT user_id
    FROM user u
      JOIN user_circle_group ucg ON u.user_id = ucg.user_id
      JOIN circle_group cg ON ucg.circle_group_id = cg.circle_group_id
  ),
  current_status_id =(
    SELECT work_status_id
    FROM work_status
    WHERE name = 'need attention'
  ),
  project_id = (
    SELECT project_id
    FROM project
    WHERE (title = 'Pioneer 
            Day Activity')
      AND (project_id = 7)
  ),
  date_created = current_Date()
WHERE task_id = 27
  AND owner_id = (
    SELECT user_id
    FROM user
    WHERE (first_name = 'Julie')
      AND (last_name = 'Smith')
  )
  AND project_id = (
    SELECT project_id
    FROM project
    WHERE (title = 'Pioneer Day Activity')
      AND (project_id = 7)
  );
-- **********************************************************************
-- Edit Project
-- READ One TASK
SELECT description,
  budget,
  date_created,
  work_status_id,
  task_title
FROM task
WHERE task_title = 'Pioneer Day Activity'
  AND task_id = 27;
-- READ All Tasks
SELECT t1.task_id,
  t1.description
FROM task t1
  join task t2 ON t1.task_id = t2.task_id
  join project p ON t2.project_id = p.project_id
WHERE p.title = 'Pioneer Day Activity';
-- READ all Circles Groups
SELECT p.title,
  p.project_id
FROM project p
  join circle_group_project cgp ON p.project_id = cgp.project_id
  join user_circle_group u ON cgp.circle_group_id = u.circle_group_id;