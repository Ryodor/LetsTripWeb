-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NULL,
  `pseudo` VARCHAR(50) NULL,
  `creation_date` DATETIME NULL,
  `active` TINYINT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`passwords`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`passwords` (
  `password_id` INT NOT NULL,
  `password` VARCHAR(140) NULL,
  `key` VARCHAR(250) NULL,
  `active` TINYINT NULL,
  PRIMARY KEY (`password_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`roadmap`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`roadmap` (
  `roadmap_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `password` VARCHAR(50) NULL,
  `administrator` INT NOT NULL,
  PRIMARY KEY (`roadmap_id`),
  INDEX `fk_roadmap_users1_idx` (`administrator` ASC) VISIBLE,
  CONSTRAINT `fk_roadmap_users1`
    FOREIGN KEY (`administrator`)
    REFERENCES `mydb`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`country` (
  `country` INT NOT NULL AUTO_INCREMENT,
  `country` VARCHAR(80) NULL,
  PRIMARY KEY (`country`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`roadmap_country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`roadmap_country` (
  `country_country` INT NOT NULL,
  `roadmap_roadmap_id` INT NOT NULL,
  INDEX `fk_roadmap_country_country1_idx` (`country_country` ASC) VISIBLE,
  INDEX `fk_roadmap_country_roadmap1_idx` (`roadmap_roadmap_id` ASC) VISIBLE,
  CONSTRAINT `fk_roadmap_country_country1`
    FOREIGN KEY (`country_country`)
    REFERENCES `mydb`.`country` (`country`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_roadmap_country_roadmap1`
    FOREIGN KEY (`roadmap_roadmap_id`)
    REFERENCES `mydb`.`roadmap` (`roadmap_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`users_password`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`users_password` (
  `passwords_password_id` INT NOT NULL,
  `users_user_id` INT NOT NULL,
  INDEX `fk_users_password_passwords1_idx` (`passwords_password_id` ASC) VISIBLE,
  INDEX `fk_users_password_users1_idx` (`users_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_password_passwords1`
    FOREIGN KEY (`passwords_password_id`)
    REFERENCES `mydb`.`passwords` (`password_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_password_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `mydb`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user_roadmap`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user_roadmap` (
  `users_user_id` INT NOT NULL,
  `roadmap_roadmap_id` INT NOT NULL,
  INDEX `fk_user_roadmap_users1_idx` (`users_user_id` ASC) VISIBLE,
  INDEX `fk_user_roadmap_roadmap1_idx` (`roadmap_roadmap_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_roadmap_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `mydb`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_roadmap_roadmap1`
    FOREIGN KEY (`roadmap_roadmap_id`)
    REFERENCES `mydb`.`roadmap` (`roadmap_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`walls`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`walls` (
  `wall_id` INT NOT NULL AUTO_INCREMENT,
  `roadmap_roadmap_id` INT NOT NULL,
  PRIMARY KEY (`wall_id`),
  INDEX `fk_walls_roadmap1_idx` (`roadmap_roadmap_id` ASC) VISIBLE,
  CONSTRAINT `fk_walls_roadmap1`
    FOREIGN KEY (`roadmap_roadmap_id`)
    REFERENCES `mydb`.`roadmap` (`roadmap_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`conversations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`conversations` (
  `conversation_id` INT NOT NULL AUTO_INCREMENT,
  `roadmap_roadmap_id` INT NOT NULL,
  `title` VARCHAR(100) NULL,
  `creation_date` DATETIME NULL,
  PRIMARY KEY (`conversation_id`),
  INDEX `fk_conversations_roadmap1_idx` (`roadmap_roadmap_id` ASC) VISIBLE,
  CONSTRAINT `fk_conversations_roadmap1`
    FOREIGN KEY (`roadmap_roadmap_id`)
    REFERENCES `mydb`.`roadmap` (`roadmap_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`docs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`docs` (
  `doc_id` INT NOT NULL AUTO_INCREMENT,
  `roadmap_roadmap_id` INT NOT NULL,
  `name` VARCHAR(150) NULL,
  `post_date` DATETIME NULL,
  PRIMARY KEY (`doc_id`),
  INDEX `fk_docs_roadmap1_idx` (`roadmap_roadmap_id` ASC) VISIBLE,
  CONSTRAINT `fk_docs_roadmap1`
    FOREIGN KEY (`roadmap_roadmap_id`)
    REFERENCES `mydb`.`roadmap` (`roadmap_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`messages` (
  `message_id` INT NOT NULL AUTO_INCREMENT,
  `conversations_conversation_id` INT NOT NULL,
  `users_user_id` INT NOT NULL,
  `message` TEXT NULL,
  PRIMARY KEY (`message_id`),
  INDEX `fk_messages_conversations1_idx` (`conversations_conversation_id` ASC) VISIBLE,
  INDEX `fk_messages_users1_idx` (`users_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_messages_conversations1`
    FOREIGN KEY (`conversations_conversation_id`)
    REFERENCES `mydb`.`conversations` (`conversation_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_messages_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `mydb`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
