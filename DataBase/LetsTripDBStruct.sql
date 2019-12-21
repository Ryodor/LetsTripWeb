-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema lets_Trip
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema lets_Trip
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lets_Trip` DEFAULT CHARACTER SET utf8 ;
USE `lets_Trip` ;

-- -----------------------------------------------------
-- Table `lets_Trip`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lets_Trip`.`users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NULL,
  `last_name` VARCHAR(30) NULL,
  ` first_name` VARCHAR(30) NULL,
  `registration_date` DATETIME NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lets_Trip`.`passwords`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lets_Trip`.`passwords` (
  `password_id` INT NOT NULL AUTO_INCREMENT,
  `password` VARCHAR(250) NULL,
  `key` VARCHAR(250) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`password_id`),
  -- INDEX `fk_passwords_users_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_passwords_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `lets_Trip`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
