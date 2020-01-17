-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema lets_trip
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema lets_trip
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lets_trip` DEFAULT CHARACTER SET utf8 ;
USE `lets_trip` ;

-- -----------------------------------------------------
-- Table `lets_trip`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lets_trip`.`users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NULL,
  `pseudo` VARCHAR(50) NULL,
  `creation_date` DATETIME NULL,
  `is_active` TINYINT NULL,
  `firstname` VARCHAR(50) NULL,
  `lastname` VARCHAR(50) NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lets_trip`.`passwords`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lets_trip`.`passwords` (
  `password_id` INT NOT NULL,  
  `password` VARCHAR(140) NULL,
  `key` VARCHAR(250) NULL,
  `active` TINYINT NULL,
  PRIMARY KEY (`password_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lets_trip`.`roadmap`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lets_trip`.`roadmap` (
  `roadmap_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `password` VARCHAR(50) NULL,
  `administrator` INT NOT NULL,
  PRIMARY KEY (`roadmap_id`),
  CONSTRAINT `fk_roadmap_users1`
    FOREIGN KEY (`administrator`)
    REFERENCES `lets_trip`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lets_trip`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lets_trip`.`country` (
  `country_id` INT NOT NULL AUTO_INCREMENT,
  `country` VARCHAR(80) NULL,
  PRIMARY KEY (`country_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lets_trip`.`roadmap_country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lets_trip`.`roadmap_country` (
  `roadmap_country_id` INT NOT NULL AUTO_INCREMENT,
  `roadmap_roadmap_id` INT NOT NULL,
  `country_country_id` INT NOT NULL,
  PRIMARY KEY (`roadmap_country_id`),
  CONSTRAINT `fk_roadmap_country_roadmap1`
    FOREIGN KEY (`roadmap_roadmap_id`)
    REFERENCES `lets_trip`.`roadmap` (`roadmap_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_roadmap_country_country1`
    FOREIGN KEY (`country_country_id`)
    REFERENCES `lets_trip`.`country` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lets_trip`.`user_password`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lets_trip`.`user_password` (
  `user_password_id` INT NOT NULL AUTO_INCREMENT,
  `passwords_password_id` INT NOT NULL,
  `users_user_id` INT NOT NULL,
  PRIMARY KEY (`user_password_id`),
  CONSTRAINT `fk_users_password_passwords1`
    FOREIGN KEY (`passwords_password_id`)
    REFERENCES `lets_trip`.`passwords` (`password_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_password_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `lets_trip`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lets_trip`.`user_roadmap`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lets_trip`.`user_roadmap` (
  `user_roadmap_id` INT NOT NULL AUTO_INCREMENT,
  `users_user_id` INT NOT NULL,
  `roadmap_roadmap_id` INT NOT NULL,
  PRIMARY KEY (`user_roadmap_id`),
  CONSTRAINT `fk_user_roadmap_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `lets_trip`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_roadmap_roadmap1`
    FOREIGN KEY (`roadmap_roadmap_id`)
    REFERENCES `lets_trip`.`roadmap` (`roadmap_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lets_trip`.`walls`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lets_trip`.`walls` (
  `wall_id` INT NOT NULL AUTO_INCREMENT,
  `roadmap_roadmap_id` INT NOT NULL,
  PRIMARY KEY (`wall_id`),
  CONSTRAINT `fk_walls_roadmap1`
    FOREIGN KEY (`roadmap_roadmap_id`)
    REFERENCES `lets_trip`.`roadmap` (`roadmap_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lets_trip`.`conversations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lets_trip`.`conversations` (
  `conversation_id` INT NOT NULL AUTO_INCREMENT,
  `roadmap_roadmap_id` INT NOT NULL,
  `title` VARCHAR(100) NULL,
  `creation_date` DATETIME NULL,
  PRIMARY KEY (`conversation_id`),
  CONSTRAINT `fk_conversations_roadmap1`
    FOREIGN KEY (`roadmap_roadmap_id`)
    REFERENCES `lets_trip`.`roadmap` (`roadmap_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lets_trip`.`docs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lets_trip`.`docs` (
  `doc_id` INT NOT NULL AUTO_INCREMENT,
  `roadmap_roadmap_id` INT NOT NULL,
  `name` VARCHAR(150) NULL,
  `post_date` DATETIME NULL,
  PRIMARY KEY (`doc_id`),
  CONSTRAINT `fk_docs_roadmap1`
    FOREIGN KEY (`roadmap_roadmap_id`)
    REFERENCES `lets_trip`.`roadmap` (`roadmap_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lets_trip`.`messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lets_trip`.`messages` (
  `message_id` INT NOT NULL AUTO_INCREMENT,
  `conversations_conversation_id` INT NOT NULL,
  `users_user_id` INT NOT NULL,
  `message` TEXT NULL,
  PRIMARY KEY (`message_id`),
  CONSTRAINT `fk_messages_conversations1`
    FOREIGN KEY (`conversations_conversation_id`)
    REFERENCES `lets_trip`.`conversations` (`conversation_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_messages_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `lets_trip`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lets_trip`.`profile_picture`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lets_trip`.`profile_picture` (
  `profile_picture_id` INT NOT NULL AUTO_INCREMENT,
  `path_folder` VARCHAR(150) NULL,
  `file_name` VARCHAR(100) NULL,
  `users_user_id` INT NOT NULL,
  PRIMARY KEY (`profile_picture_id`),
  CONSTRAINT `fk_profile_picture_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `lets_trip`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
