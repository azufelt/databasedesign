-- CREATE SCHEMA `return_and_report`;
-- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS,
  UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS,
  FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE,
  SQL_MODE = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- -----------------------------------------------------
-- Schema drop
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema return_and_report
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema return_and_report
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `return_and_report` DEFAULT CHARACTER SET utf8;
USE `return_and_report`;
-- -----------------------------------------------------
-- Table `return_and_report`.`CALENDAR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `return_and_report`.`CALENDAR` (
  `idCALENDAR` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idCALENDAR`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;
CREATE UNIQUE INDEX `idCALENDAR_UNIQUE` ON `return_and_report`.`CALENDAR` (`idCALENDAR` ASC) VISIBLE;
-- -----------------------------------------------------
-- Table `return_and_report`.`DATE-MODULE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `return_and_report`.`DATE-MODULE` (
  `idDATE-MODULE` INT NOT NULL AUTO_INCREMENT,
  `dayofyear` VARCHAR(45) NULL DEFAULT NULL,
  `day` VARCHAR(45) NULL DEFAULT NULL,
  `week` VARCHAR(45) NULL DEFAULT NULL,
  `month` VARCHAR(45) NULL DEFAULT NULL,
  `year` VARCHAR(45) NULL DEFAULT NULL,
  `CALENDAR_idCALENDAR` INT NOT NULL,
  PRIMARY KEY (`idDATE-MODULE`, `CALENDAR_idCALENDAR`),
  CONSTRAINT `fk_DATE-MODULE_CALENDAR1` FOREIGN KEY (`CALENDAR_idCALENDAR`) REFERENCES `return_and_report`.`CALENDAR` (`idCALENDAR`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;
CREATE UNIQUE INDEX `idDATE-MODULE_UNIQUE` ON `return_and_report`.`DATE-MODULE` (`idDATE-MODULE` ASC) VISIBLE;
CREATE INDEX `fk_DATE-MODULE_CALENDAR1_idx` ON `return_and_report`.`DATE-MODULE` (`CALENDAR_idCALENDAR` ASC) VISIBLE;
-- -----------------------------------------------------
-- Table `return_and_report`.`calling`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `return_and_report`.`calling` (
  `calling_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`calling_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 9 DEFAULT CHARACTER SET = utf8mb4;
-- -----------------------------------------------------
-- Table `return_and_report`.`organization`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `return_and_report`.`organization` (
  `organization_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `app_org_guid` VARCHAR(250) NULL DEFAULT NULL,
  PRIMARY KEY (`organization_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 16 DEFAULT CHARACTER SET = utf8mb4;
CREATE UNIQUE INDEX `name_UNIQUE` ON `return_and_report`.`organization` (`name` ASC) VISIBLE;
-- -----------------------------------------------------
-- Table `return_and_report`.`ward_unit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `return_and_report`.`ward_unit` (
  `idward_unit` INT NOT NULL AUTO_INCREMENT,
  `unit_name` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`idward_unit`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;
-- -----------------------------------------------------
-- Table `return_and_report`.`calling_has_organization`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `return_and_report`.`calling_has_organization` (
  `calling_calling_id` INT NOT NULL,
  `organization_organization_id` INT NOT NULL,
  `ward_unit_idward_unit` INT NULL DEFAULT NULL,
  PRIMARY KEY (
    `calling_calling_id`,
    `organization_organization_id`
  ),
  CONSTRAINT `fk_calling_has_organization_calling1` FOREIGN KEY (`calling_calling_id`) REFERENCES `return_and_report`.`calling` (`calling_id`),
  CONSTRAINT `fk_calling_has_organization_organization1` FOREIGN KEY (`organization_organization_id`) REFERENCES `return_and_report`.`organization` (`organization_id`),
  CONSTRAINT `fk_calling_has_organization_ward_unit1` FOREIGN KEY (`ward_unit_idward_unit`) REFERENCES `return_and_report`.`ward_unit` (`idward_unit`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;
CREATE INDEX `fk_calling_has_organization_organization1_idx` ON `return_and_report`.`calling_has_organization` (`organization_organization_id` ASC) VISIBLE;
CREATE INDEX `fk_calling_has_organization_calling1_idx` ON `return_and_report`.`calling_has_organization` (`calling_calling_id` ASC) VISIBLE;
CREATE INDEX `fk_calling_has_organization_ward_unit1_idx` ON `return_and_report`.`calling_has_organization` (`ward_unit_idward_unit` ASC) VISIBLE;
-- -----------------------------------------------------
-- Table `return_and_report`.`circle_group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `return_and_report`.`circle_group` (
  `circle_group_id` INT NOT NULL AUTO_INCREMENT,
  `group_name` VARCHAR(45) NOT NULL,
  `app_circle_guid` VARCHAR(250) NOT NULL,
  `calling_has_organization_calling_id` INT NOT NULL,
  PRIMARY KEY (`circle_group_id`),
  CONSTRAINT `calling_has_organization_calling_id` FOREIGN KEY (`calling_has_organization_calling_id`) REFERENCES `return_and_report`.`calling_has_organization` (`calling_calling_id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;
CREATE UNIQUE INDEX `idCIRCLES_GROUP_UNIQUE` ON `return_and_report`.`circle_group` (`circle_group_id` ASC) VISIBLE;
CREATE UNIQUE INDEX `calling_name_UNIQUE` ON `return_and_report`.`circle_group` (`group_name` ASC) VISIBLE;
CREATE INDEX `calling_has_organization_calling_id_idx` ON `return_and_report`.`circle_group` (`calling_has_organization_calling_id` ASC) VISIBLE;
-- -----------------------------------------------------
-- Table `return_and_report`.`work_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `return_and_report`.`work_status` (
  `work_status_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`work_status_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 7 DEFAULT CHARACTER SET = utf8mb4;
CREATE UNIQUE INDEX `idSTATUS_UNIQUE` ON `return_and_report`.`work_status` (`work_status_id` ASC) VISIBLE;
-- -----------------------------------------------------
-- Table `return_and_report`.`project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `return_and_report`.`project` (
  `project_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NULL DEFAULT NULL,
  `location` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `start_date` DATETIME NULL DEFAULT NULL,
  `work_status_work_status_id` INT NOT NULL,
  `proj_budget` INT NULL,
  PRIMARY KEY (`project_id`),
  CONSTRAINT `fk_project_work_status1` FOREIGN KEY (`work_status_work_status_id`) REFERENCES `return_and_report`.`work_status` (`work_status_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;
CREATE UNIQUE INDEX `idPROJECTS_UNIQUE` ON `return_and_report`.`project` (`project_id` ASC) VISIBLE;
CREATE INDEX `fk_project_work_status1_idx` ON `return_and_report`.`project` (`work_status_work_status_id` ASC) VISIBLE;
-- -----------------------------------------------------
-- Table `return_and_report`.`circle_group_project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `return_and_report`.`circle_group_project` (
  `circle_group_project` INT NOT NULL AUTO_INCREMENT,
  `circle_group_id` INT NOT NULL,
  `project_id` INT NOT NULL,
  `date_created` DATETIME NULL DEFAULT NULL,
  `start_date` DATE NULL DEFAULT NULL,
  `goal_date` DATE NULL DEFAULT NULL,
  `completed_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`circle_group_project`),
  CONSTRAINT `fk_CIRCLES_GROUP_has_PROJECTS_CIRCLES_GROUP1` FOREIGN KEY (`circle_group_project`) REFERENCES `return_and_report`.`circle_group` (`circle_group_id`),
  CONSTRAINT `fk_CIRCLES_GROUP_has_PROJECTS_PROJECTS1` FOREIGN KEY (`project_id`) REFERENCES `return_and_report`.`project` (`project_id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;
CREATE INDEX `fk_CIRCLES_GROUP_has_PROJECTS_PROJECTS1_idx` ON `return_and_report`.`circle_group_project` (`project_id` ASC) VISIBLE;
CREATE INDEX `fk_CIRCLES_GROUP_has_PROJECTS_CIRCLES_GROUP1_idx` ON `return_and_report`.`circle_group_project` (
  `circle_group_project` ASC,
  `circle_group_id` ASC
) VISIBLE;
-- -----------------------------------------------------
-- Table `return_and_report`.`task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `return_and_report`.`task` (
  `task_id` INT NOT NULL AUTO_INCREMENT,
  `assign-date` DATETIME NULL DEFAULT NULL,
  `end-date` DATETIME NULL DEFAULT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `budget` INT NULL DEFAULT NULL,
  `project_id` INT NOT NULL,
  `date_created` DATETIME NULL DEFAULT NULL,
  `start_date` DATE NULL DEFAULT NULL,
  `goal_date` DATE NULL DEFAULT NULL,
  `completed_date` DATE NULL DEFAULT NULL,
  `work_status_id` INT NULL COMMENT '\n\n',
  PRIMARY KEY (`task_id`),
  CONSTRAINT `fk_TASKS_PROJECTS1` FOREIGN KEY (`project_id`) REFERENCES `return_and_report`.`project` (`project_id`),
  CONSTRAINT `fk_task_work_status1` FOREIGN KEY (`work_status_id`) REFERENCES `return_and_report`.`work_status` (`work_status_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 23 DEFAULT CHARACTER SET = utf8mb4;
CREATE UNIQUE INDEX `idTASKS_UNIQUE` ON `return_and_report`.`task` (`task_id` ASC) VISIBLE;
CREATE INDEX `fk_TASKS_PROJECTS1_idx` ON `return_and_report`.`task` (`project_id` ASC) VISIBLE;
CREATE INDEX `fk_task_work_status1_idx` ON `return_and_report`.`task` (`work_status_id` ASC) VISIBLE;
-- -----------------------------------------------------
-- Table `return_and_report`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `return_and_report`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `phone_num` INT NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;
CREATE UNIQUE INDEX `idUSER_UNIQUE` ON `return_and_report`.`user` (`user_id` ASC) VISIBLE;
CREATE UNIQUE INDEX `username_UNIQUE` ON `return_and_report`.`user` (`username` ASC) VISIBLE;
CREATE UNIQUE INDEX `password_UNIQUE` ON `return_and_report`.`user` (`password` ASC) VISIBLE;
-- -----------------------------------------------------
-- Table `return_and_report`.`user_circle_group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `return_and_report`.`user_circle_group` (
  `user_circle_group_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `circle_group_id` INT NOT NULL,
  PRIMARY KEY (`user_circle_group_id`),
  CONSTRAINT `circle_group_user_fk1` FOREIGN KEY (`user_circle_group_id`) REFERENCES `return_and_report`.`circle_group` (`circle_group_id`),
  CONSTRAINT `circle_group_user_fk2` FOREIGN KEY (`user_id`) REFERENCES `return_and_report`.`user` (`user_id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;
CREATE INDEX `fk_CIRCLES_GROUP_has_USER_USER1_idx` ON `return_and_report`.`user_circle_group` (`user_id` ASC) VISIBLE;
CREATE INDEX `fk_CIRCLES_GROUP_has_USER_CIRCLES_GROUP_idx` ON `return_and_report`.`user_circle_group` (`user_circle_group_id` ASC) VISIBLE;
-- -----------------------------------------------------
-- Table `return_and_report`.`user_has_task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `return_and_report`.`user_has_task` (
  `user_user_id` INT NOT NULL,
  `task_task_id` INT NOT NULL,
  PRIMARY KEY (`user_user_id`, `task_task_id`),
  CONSTRAINT `fk_user_has_task_user1` FOREIGN KEY (`user_user_id`) REFERENCES `return_and_report`.`user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_task_task1` FOREIGN KEY (`task_task_id`) REFERENCES `return_and_report`.`task` (`task_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;
CREATE INDEX `fk_user_has_task_task1_idx` ON `return_and_report`.`user_has_task` (`task_task_id` ASC) VISIBLE;
CREATE INDEX `fk_user_has_task_user1_idx` ON `return_and_report`.`user_has_task` (`user_user_id` ASC) VISIBLE;
SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;