-- Day 8: Facility Inspection & Complaint Management
-- MySQL 8+. Run this script once in a MySQL client.
CREATE DATABASE IF NOT EXISTS day8_facility_management
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE day8_facility_management;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS complaints;
DROP TABLE IF EXISTS inspections;
DROP TABLE IF EXISTS facilities;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS users;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE users (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    email VARCHAR(190) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL COMMENT 'Store a password hash, never plaintext',
    role ENUM('admin','employee','inspector','resident') NOT NULL DEFAULT 'resident',
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE departments (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL UNIQUE,
    location VARCHAR(150) NOT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE employees (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NULL UNIQUE,
    department_id BIGINT UNSIGNED NOT NULL,
    employee_code VARCHAR(30) NOT NULL UNIQUE,
    job_title VARCHAR(100) NOT NULL,
    salary DECIMAL(12,2) NOT NULL,
    hire_date DATE NOT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_employees_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    CONSTRAINT fk_employees_department FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE RESTRICT,
    CONSTRAINT chk_employee_salary CHECK (salary >= 0),
    INDEX idx_employees_department_salary (department_id, salary)
) ENGINE=InnoDB;

CREATE TABLE facilities (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    location VARCHAR(180) NOT NULL,
    cleanliness_score DECIMAL(4,2) NOT NULL DEFAULT 5.00,
    status ENUM('active','maintenance','closed') NOT NULL DEFAULT 'active',
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT chk_facility_cleanliness CHECK (cleanliness_score BETWEEN 0 AND 10),
    INDEX idx_facilities_location (location),
    INDEX idx_facilities_score (cleanliness_score)
) ENGINE=InnoDB;

CREATE TABLE inspections (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    facility_id BIGINT UNSIGNED NOT NULL,
    inspector_id BIGINT UNSIGNED NOT NULL,
    inspection_date DATE NOT NULL,
    cleanliness_score DECIMAL(4,2) NOT NULL,
    odor_score TINYINT UNSIGNED NOT NULL DEFAULT 1,
    waste_level ENUM('low','medium','high','critical') NOT NULL DEFAULT 'low',
    notes TEXT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_inspections_facility FOREIGN KEY (facility_id) REFERENCES facilities(id) ON DELETE CASCADE,
    CONSTRAINT fk_inspections_inspector FOREIGN KEY (inspector_id) REFERENCES employees(id) ON DELETE RESTRICT,
    CONSTRAINT chk_inspection_cleanliness CHECK (cleanliness_score BETWEEN 0 AND 10),
    CONSTRAINT chk_inspection_odor CHECK (odor_score BETWEEN 1 AND 5),
    INDEX idx_inspections_facility_date (facility_id, inspection_date),
    INDEX idx_inspections_waste_date (waste_level, inspection_date)
) ENGINE=InnoDB;

CREATE TABLE complaints (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    facility_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(180) NOT NULL,
    description TEXT NOT NULL,
    priority ENUM('low','medium','high','critical') NOT NULL DEFAULT 'medium',
    status ENUM('open','in_progress','resolved','rejected') NOT NULL DEFAULT 'open',
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_complaints_facility FOREIGN KEY (facility_id) REFERENCES facilities(id) ON DELETE CASCADE,
    CONSTRAINT fk_complaints_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT,
    INDEX idx_complaints_facility_status (facility_id, status),
    INDEX idx_complaints_status_priority (status, priority)
) ENGINE=InnoDB;
