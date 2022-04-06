-- Added Organization_id to "circle_group" table
ALTER TABLE `circles_app`.`circle_group`
ADD COLUMN `org_id` VARCHAR(45) NOT NULL
AFTER `calling_has_organization_calling_id`,
  ADD UNIQUE INDEX `org_id_UNIQUE` (`org_id` ASC) VISIBLE;
;
-- Project description was too short
ALTER TABLE `circles_app`.`project` CHANGE COLUMN `description` `description` VARCHAR(250) NULL DEFAULT NULL;
-- Forgot to put a title on the tasks
ALTER TABLE `circles_app`.`task`
ADD COLUMN `task_title` VARCHAR(45) NOT NULL
AFTER `work_status_id`;