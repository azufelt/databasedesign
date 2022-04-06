USE return_and_report;
-- -----------------------------------
--            ***********
-- --------SEED  INSERT STATEMENTS---------- 
--            ***********
-- -----------------------------------
-- ---------------#1 Ward_unit Table    ---------
INSERT INTO ward_unit (unit_name)
VALUES ('1st ward'),
  ('2nd ward'),
  ('3rd ward'),
  ('4th ward'),
  ('calhoun ward');
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
  ),
  (
    (
      SELECT calling_id
      FROM calling
      WHERE title = 'first _counselor'
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
  ),
  (
    (
      SELECT calling_id
      FROM calling
      WHERE title = 'second_counselor'
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
  ),
  (
    (
      SELECT calling_id
      FROM calling
      WHERE title = 'president'
    ),
    (
      SELECT organization_id
      FROM organization
      WHERE name = 'young women'
    ),
    (
      SELECT idward_unit
      FROM ward_unit
      WHERE unit_name = 'calhoun ward'
    )
  ),
  (
    (
      SELECT calling_id
      FROM calling
      WHERE title = 'first _counselor'
    ),
    (
      SELECT organization_id
      FROM organization
      WHERE name = 'young women'
    ),
    (
      SELECT idward_unit
      FROM ward_unit
      WHERE unit_name = 'calhoun ward'
    )
  ),
  (
    (
      SELECT calling_id
      FROM calling
      WHERE title = 'second_counselor'
    ),
    (
      SELECT organization_id
      FROM organization
      WHERE name = 'young women'
    ),
    (
      SELECT idward_unit
      FROM ward_unit
      WHERE unit_name = 'calhoun ward'
    )
  );
SELECT *
FROM calling c,
  organization o,
  calling_has_organization cho
  CROSS JOIN c.calling_id
  AND cho.calling_id;
-- ---------------#5 circles_group Table    ---------
-- ******** TABLE JOIN *********
-- table1 = calling
-- table2 = calling_has_organization
-- table3 = ward_unit
-- table4 = organization
SELECT *
FROM calling c
  JOIN calling_has_organization cho ON c.calling_id = cho.calling_calling_id
  JOIN ward_unit w ON cho.ward_unit_idward_unit = w.idward_unit
  JOIN organization o ON cho.organization_organization_id = o.organization_id;
-- **********
INSERT INTO circle_group (
    group_name,
    app_circle_guid,
    calling_has_organization_calling_id,
    org_id
  )
VALUES (
    'young women',
    'A group circle for the YW presidency',
    (
      SELECT calling_id
      FROM calling c
      WHERE c.title = 'president'
    ),
    (
      SELECT organization_id
      FROM organization o
      WHERE o.name = 'young women'
    )
  ),
  (
    'relief society',
    'A group circle for the relief society presidency',
    (
      SELECT calling_id
      FROM calling c
      WHERE c.title = 'president'
    ),
    (
      SELECT organization_id
      FROM organization o
      WHERE o.name = 'relief society'
    )
  );
""" Some Select and Joins

    SELECT organization_id FROM calling
     CROSS JOIN organization
      WHERE name = 'primary';
      
      
      -- finds the org_id
      SELECT organization_id
        FROM organization o
		WHERE o.name = 'primary';
        
		SELECT organization_organization_id  as organization
		FROM calling_has_organization cho
		where cho.organization_organization_id = (SELECT organization_id
        FROM organization o
		WHERE o.name = 'primary');
        
        SELECT organization_id FROM calling
		CROSS JOIN organization
		WHERE name = 'primary';
      
      -- finds the calling id 
		SELECT calling_id 
		FROM calling c
		WHERE c.title = 'president';
  """ -- ********** JOIN calling & Organization
-- SELECT *
-- FROM calling
--   CROSS JOIN organization;
-- SELECT *
-- FROM calling
--   CROSS JOIN organization
-- WHERE name = 'primary';
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
  ),
  (
    'sisterSmith',
    'sisterSmithmypassword',
    'Sister.smith@gmail.com',
    'Julie',
    'Smith',
    1234567890
  ),
  (
    'elderSkates',
    'elderSkatesmypassword',
    'elder.skates@gmail.com',
    'Sammy',
    'Skates',
    1234567890
  ),
  (
    'bomLuv',
    'bomLuvmypassword',
    'dillon.love@gmail.com',
    'dillon',
    'love',
    2108370003
  ),
  (
    'naohsark',
    'naohsarkmypassword',
    'noah.sark@gmail.com',
    'Noah',
    'Sark',
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
      WHERE calling_has_organization_calling_id = 9
        and group_name = 'primary'
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
      WHERE project_id = 1
    ),
    CURRENT_DATE()
  );
-- ---------------#11 task Table   ---------
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
      WHERE title = 'Ward Activity'
    ),
    'Handouts/invites',
    10,
    (
      SELECT project_id
      FROM project
      WHERE title = 'Ward Activity'
    ),
    CURRENT_DATE(),
    (
      SELECT work_status_id
      FROM work_status
      WHERE name = 'in progress'
    )
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

-- ---------------EXTRA STUFF ---------

SET foreign_key_checks = 0;