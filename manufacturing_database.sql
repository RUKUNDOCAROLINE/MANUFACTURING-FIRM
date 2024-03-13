-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema manufacturing_firm
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema manufacturing_firm
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `manufacturing_firm` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `manufacturing_firm` ;

-- -----------------------------------------------------
-- Table `manufacturing_firm`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `manufacturing_firm`.`customers` (
  `customer_id` INT NOT NULL,
  `first_name` VARCHAR(255) NULL DEFAULT NULL,
  `last_name` VARCHAR(255) NULL DEFAULT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `phone_number` VARCHAR(255) NULL DEFAULT NULL,
  `address` VARCHAR(255) NULL DEFAULT NULL,
  `city` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `manufacturing_firm`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `manufacturing_firm`.`employees` (
  `employee_id` INT NOT NULL,
  `first_name` VARCHAR(255) NULL DEFAULT NULL,
  `last_name` VARCHAR(255) NULL DEFAULT NULL,
  `position` VARCHAR(255) NULL DEFAULT NULL,
  `department` VARCHAR(255) NULL DEFAULT NULL,
  `hire_date` DATE NULL DEFAULT NULL,
  `salary` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`employee_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `manufacturing_firm`.`departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `manufacturing_firm`.`departments` (
  `department_id` INT NOT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `manager_id` INT NULL DEFAULT NULL,
  `location` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`department_id`),
  INDEX `manager_id` (`manager_id` ASC) VISIBLE,
  CONSTRAINT `departments_ibfk_1`
    FOREIGN KEY (`manager_id`)
    REFERENCES `manufacturing_firm`.`employees` (`employee_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `manufacturing_firm`.`manufacturers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `manufacturing_firm`.`manufacturers` (
  `manufacturer_id` INT NOT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `contact_name` VARCHAR(255) NULL DEFAULT NULL,
  `contact_number` VARCHAR(255) NULL DEFAULT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `address` VARCHAR(255) NULL DEFAULT NULL,
  `city` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`manufacturer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `manufacturing_firm`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `manufacturing_firm`.`products` (
  `product_id` INT NOT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `category` VARCHAR(255) NULL DEFAULT NULL,
  `price` DECIMAL(10,2) NULL DEFAULT NULL,
  `quantity_in_stock` INT NULL DEFAULT NULL,
  `manufacturer_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `manufacturer_id` (`manufacturer_id` ASC) VISIBLE,
  CONSTRAINT `products_ibfk_1`
    FOREIGN KEY (`manufacturer_id`)
    REFERENCES `manufacturing_firm`.`manufacturers` (`manufacturer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `manufacturing_firm`.`suppliers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `manufacturing_firm`.`suppliers` (
  `supplier_id` INT NOT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `contact_name` VARCHAR(255) NULL DEFAULT NULL,
  `contact_number` VARCHAR(255) NULL DEFAULT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `address` VARCHAR(255) NULL DEFAULT NULL,
  `city` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`supplier_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `manufacturing_firm`.`inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `manufacturing_firm`.`inventory` (
  `inventory_id` INT NOT NULL,
  `product_id` INT NULL DEFAULT NULL,
  `quantity` INT NULL DEFAULT NULL,
  `last_restock_date` DATE NULL DEFAULT NULL,
  `location` VARCHAR(255) NULL DEFAULT NULL,
  `supplier_id` INT NULL DEFAULT NULL,
  `restock_threshold` INT NULL DEFAULT NULL,
  PRIMARY KEY (`inventory_id`),
  INDEX `product_id` (`product_id` ASC) VISIBLE,
  INDEX `supplier_id` (`supplier_id` ASC) VISIBLE,
  CONSTRAINT `inventory_ibfk_1`
    FOREIGN KEY (`product_id`)
    REFERENCES `manufacturing_firm`.`products` (`product_id`),
  CONSTRAINT `inventory_ibfk_2`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `manufacturing_firm`.`suppliers` (`supplier_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `manufacturing_firm`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `manufacturing_firm`.`orders` (
  `order_id` INT NOT NULL,
  `customer_id` INT NULL DEFAULT NULL,
  `order_date` DATE NULL DEFAULT NULL,
  `total_price` DECIMAL(10,2) NULL DEFAULT NULL,
  `status` VARCHAR(255) NULL DEFAULT NULL,
  `shipping_address` VARCHAR(255) NULL DEFAULT NULL,
  `employee_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `customer_id` (`customer_id` ASC) VISIBLE,
  INDEX `employee_id` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `orders_ibfk_1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `manufacturing_firm`.`customers` (`customer_id`),
  CONSTRAINT `orders_ibfk_2`
    FOREIGN KEY (`employee_id`)
    REFERENCES `manufacturing_firm`.`employees` (`employee_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `manufacturing_firm`.`sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `manufacturing_firm`.`sales` (
  `sale_id` INT NOT NULL,
  `product_id` INT NULL DEFAULT NULL,
  `quantity_sold` INT NULL DEFAULT NULL,
  `sale_date` DATE NULL DEFAULT NULL,
  `customer_id` INT NULL DEFAULT NULL,
  `employee_id` INT NULL DEFAULT NULL,
  `total_price` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`sale_id`),
  INDEX `product_id` (`product_id` ASC) VISIBLE,
  INDEX `customer_id` (`customer_id` ASC) VISIBLE,
  INDEX `employee_id` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `sales_ibfk_1`
    FOREIGN KEY (`product_id`)
    REFERENCES `manufacturing_firm`.`products` (`product_id`),
  CONSTRAINT `sales_ibfk_2`
    FOREIGN KEY (`customer_id`)
    REFERENCES `manufacturing_firm`.`customers` (`customer_id`),
  CONSTRAINT `sales_ibfk_3`
    FOREIGN KEY (`employee_id`)
    REFERENCES `manufacturing_firm`.`employees` (`employee_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `manufacturing_firm`.`transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `manufacturing_firm`.`transactions` (
  `transaction_id` INT NOT NULL,
  `transaction_date` DATE NULL DEFAULT NULL,
  `type` VARCHAR(255) NULL DEFAULT NULL,
  `amount` DECIMAL(10,2) NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `related_id` INT NULL DEFAULT NULL,
  `employee_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  INDEX `employee_id` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `transactions_ibfk_1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `manufacturing_firm`.`employees` (`employee_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
