USE return_and_report;
-- -----------------------------------
--            ***********
-- --------INSERT STATEMENTS---------- 
--            ***********
-- -----------------------------------
-- ---------------#1 Ward_unit Table    ---------
INSERT INTO ward_unit (unit_name)
VALUES ('calhoun ward');
-- ---------------#2 Organization Table    ---------
INSERT INTO organization (name)
VALUES ('bishopric'),
  ('relief society'),
  ('elders quorum'),
  ('sunday school'),
  ('primary'),
  ('young women'),
  ('young men');
-- ---------------#3 Calling Table    ---------
INSERT INTO calling (title)
VALUES ('president'),
  ('first_counselor'),
  ('second_counselor'),
  ('secretary'),
  ('assistant'),
  ('specialist'),
  ('teacher'),
  ('clerk');
-- ---------------#4 calling_has_organization Table    ---------
INSERT INTO calling_has_organization (
    calling_calling_id,
    organization_organization_id,
    ward_unit_idward_unit
  )
VALUES (
    (
      SELECT calling_id
      FROM calling
      WHERE title = 'president'
    ),
    (
      SELECT organization_id
      FROM organization
      WHERE name = 'primary'
    ),
    (
      SELECT idward_unit
      FROM ward_unit
      WHERE unit_name = 'calhoun ward'
    )
  );
-- ---------------#5 circles_group Table    ---------
INSERT INTO circle_group (
    group_name,
    app_circle_guid,
    calling_has_organization_calling_id,
    calling_has_organization_organization_id
  )
VALUES (
    'primary',
    'A group circle for the primary presidency',
    (
      SELECT calling_calling_id
      FROM calling_has_organization
      WHERE (
          SELECT calling_id
          FROM calling
          WHERE title = 'president'
        )
    ),
    (
      SELECT organization_id
      FROM calling
        CROSS JOIN organization
      WHERE name = 'primary'
    )
  );
-- ********** JOIN calling & Organization
SELECT *
FROM calling
  CROSS JOIN organization;
SELECT *
FROM calling
  CROSS JOIN organization
WHERE name = 'primary';
-- ---------------#6 user Table    ---------
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
    2108370003
  );
-- ---------------#7 user_circle_group Table     ---------
INSERT INTO user_circle_group (user_id, circle_group_id)
VALUES (
    (
      SELECT user_id
      FROM user
      WHERE username = 'azufelt'
        and email = 'ashley.zufelt@gmail.com'
    ),
    (
      SELECT circle_group_id
      FROM circle_group
      WHERE calling_has_organization_calling_id = 1
        and calling_has_organization_organization_id = 6
    )
  );
-- ---------------#8 work_status Table  ---------
INSERT INTO work_status (name)
VALUES ('In progress'),
  ('Pending'),
  ('Completed'),
  ('Awaiting review'),
  ('Needs Attention'),
  ('On Hold');
-- ---------------#9 project Table   ---------
INSERT INTO project (
    title,
    location,
    description,
    start_date,
    work_status_work_status_id,
    proj_budget
  )
VALUES (
    'Ward Activity',
    'City Park',
    'Fun potluck for all families',
    '2022-04-17',
    (
      SELECT work_status_id
      FROM work_status
      WHERE name = 'In Progress'
    ),
    50
  );
-- ---------------#10 circle_group_project Table    ---------
INSERT INTO circle_group_project (
    circle_group_project,
    circle_group_id,
    project_id,
    date_created
  )
VALUES (
    (
      SELECT circle_group_id
      FROM circle_group
      WHERE group_name = 'ward council'
    ),
    (
      SELECT project_id
      FROM project
      WHERE circle_group_id = 1
    ),
    CURRENT_DATE()
  );
-- ---------------#11 task Table   ---------
INSERT INTO task (
    `assign-date`,
    `end-date`,
    description,
    budget,
    owner_id,
    current_status_id,
    project_id,
    date_created
  )
VALUES (
    CURRENT_DATE(),
    (
      SELECT start_date
      FROM project
      WHERE title = 'Ward Activity'
    ),
    '2022-04-1',
    'Handouts/invites',
    '5',
    1,
    3,
    CURRENT_DATE()
  );
-- ---------------#12 user_task Table   ---------
INSERT INTO `return_and_report`.`user_has_task` (`user_user_id`, `task_task_id`)
VALUES (
    (
      SELECT user_id
      FROM user
      WHERE username = 'azufelt'
        and email = 'ashley.zufelt@gmail.com'
    ),
    1
  );
-- ---------------#13 calendar Table   ---------
INSERT INTO CALENDAR (idCALENDAR)
VALUES (< { idCALENDAR: } >);
SELECT idCALENDAR
FROM CALENDAR;
-- ---------------#14 date-module Table  ---------
INSERT INTO DATE - MODULE (
    dayofyear,
    day,
    week,
    month,
    year,
    CALENDAR_idCALENDAR
  )
VALUES (
    < { dayofyear: } >,
    < { day: } >,
    < { week: } >,
    < { month: } >,
    < { year: } >,
    (
      SELECT idCALENDAR
      FROM CALENDAR `;
)
);