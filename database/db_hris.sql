-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 27, 2025 at 02:19 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_hris`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_address`
--

CREATE TABLE `tbl_address` (
  `address_id` int(11) NOT NULL,
  `address_line_one` varchar(255) DEFAULT NULL,
  `address_line_two` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip_code` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_applicant`
--

CREATE TABLE `tbl_applicant` (
  `applicant_id` int(11) NOT NULL,
  `residential_address_id` int(11) DEFAULT NULL,
  `school_address_id` int(11) DEFAULT NULL,
  `first_name` varchar(150) DEFAULT NULL,
  `last_name` varchar(150) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `mobile_number` varchar(11) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `place_of_birth` varchar(255) DEFAULT NULL,
  `marital_status` varchar(50) DEFAULT NULL,
  `citizenship` varchar(50) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_character_reference`
--

CREATE TABLE `tbl_character_reference` (
  `character_reference_id` int(11) NOT NULL,
  `applicant_id` int(11) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `mobile_number` varchar(11) DEFAULT NULL,
  `position` varchar(150) DEFAULT NULL,
  `employer_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_coordinator`
--

CREATE TABLE `tbl_coordinator` (
  `coordinator_id` int(11) NOT NULL,
  `applicant_id` int(11) DEFAULT NULL,
  `first_name` varchar(150) DEFAULT NULL,
  `middle_name` varchar(150) DEFAULT NULL,
  `last_name` varchar(150) DEFAULT NULL,
  `position` varchar(150) DEFAULT NULL,
  `mobile_number` varchar(11) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_department`
--

CREATE TABLE `tbl_department` (
  `department_id` int(11) NOT NULL,
  `department_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_employment_type`
--

CREATE TABLE `tbl_employment_type` (
  `employment_type_id` int(11) NOT NULL,
  `type_name` varchar(255) DEFAULT NULL,
  `work_setup` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_family_member`
--

CREATE TABLE `tbl_family_member` (
  `family_member_id` int(11) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `mobile_number` varchar(11) DEFAULT NULL,
  `occupation` varchar(255) DEFAULT NULL,
  `employer_name` varchar(255) DEFAULT NULL,
  `relationship_type` enum('mother','father','sibling one','sibling two') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_job_application`
--

CREATE TABLE `tbl_job_application` (
  `application_id` int(11) NOT NULL,
  `applicant_id` int(11) DEFAULT NULL,
  `employment_id` int(11) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `position_id` int(11) DEFAULT NULL,
  `position_group_id` int(11) DEFAULT NULL,
  `working_hours` int(11) DEFAULT NULL,
  `orientation_date` date DEFAULT NULL,
  `first_day` date DEFAULT NULL,
  `employment_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_position`
--

CREATE TABLE `tbl_position` (
  `position_id` int(11) NOT NULL,
  `position_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_position_group`
--

CREATE TABLE `tbl_position_group` (
  `position_group_id` int(11) NOT NULL,
  `group_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_school`
--

CREATE TABLE `tbl_school` (
  `school_id` int(11) NOT NULL,
  `school_name` varchar(255) DEFAULT NULL,
  `course` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_address`
--
ALTER TABLE `tbl_address`
  ADD PRIMARY KEY (`address_id`);

--
-- Indexes for table `tbl_applicant`
--
ALTER TABLE `tbl_applicant`
  ADD PRIMARY KEY (`applicant_id`),
  ADD KEY `residential_address_id_fk` (`residential_address_id`),
  ADD KEY `school_address_id_fk` (`school_address_id`);

--
-- Indexes for table `tbl_character_reference`
--
ALTER TABLE `tbl_character_reference`
  ADD PRIMARY KEY (`character_reference_id`),
  ADD KEY `applicant_id` (`applicant_id`);

--
-- Indexes for table `tbl_coordinator`
--
ALTER TABLE `tbl_coordinator`
  ADD PRIMARY KEY (`coordinator_id`),
  ADD KEY `applicant_id_fk1` (`applicant_id`);

--
-- Indexes for table `tbl_department`
--
ALTER TABLE `tbl_department`
  ADD PRIMARY KEY (`department_id`);

--
-- Indexes for table `tbl_employment_type`
--
ALTER TABLE `tbl_employment_type`
  ADD PRIMARY KEY (`employment_type_id`);

--
-- Indexes for table `tbl_family_member`
--
ALTER TABLE `tbl_family_member`
  ADD PRIMARY KEY (`family_member_id`);

--
-- Indexes for table `tbl_job_application`
--
ALTER TABLE `tbl_job_application`
  ADD PRIMARY KEY (`application_id`),
  ADD KEY `applicant_id_fk2` (`applicant_id`),
  ADD KEY `employment_id_fk` (`employment_id`),
  ADD KEY `department_id_fk` (`department_id`),
  ADD KEY `position_id_fk` (`position_id`),
  ADD KEY `position_group_id_fk` (`position_group_id`);

--
-- Indexes for table `tbl_position`
--
ALTER TABLE `tbl_position`
  ADD PRIMARY KEY (`position_id`);

--
-- Indexes for table `tbl_position_group`
--
ALTER TABLE `tbl_position_group`
  ADD PRIMARY KEY (`position_group_id`);

--
-- Indexes for table `tbl_school`
--
ALTER TABLE `tbl_school`
  ADD PRIMARY KEY (`school_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_address`
--
ALTER TABLE `tbl_address`
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_applicant`
--
ALTER TABLE `tbl_applicant`
  MODIFY `applicant_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_character_reference`
--
ALTER TABLE `tbl_character_reference`
  MODIFY `character_reference_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_coordinator`
--
ALTER TABLE `tbl_coordinator`
  MODIFY `coordinator_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_department`
--
ALTER TABLE `tbl_department`
  MODIFY `department_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_employment_type`
--
ALTER TABLE `tbl_employment_type`
  MODIFY `employment_type_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_family_member`
--
ALTER TABLE `tbl_family_member`
  MODIFY `family_member_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_job_application`
--
ALTER TABLE `tbl_job_application`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_position`
--
ALTER TABLE `tbl_position`
  MODIFY `position_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_position_group`
--
ALTER TABLE `tbl_position_group`
  MODIFY `position_group_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_school`
--
ALTER TABLE `tbl_school`
  MODIFY `school_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_applicant`
--
ALTER TABLE `tbl_applicant`
  ADD CONSTRAINT `residential_address_id_fk` FOREIGN KEY (`residential_address_id`) REFERENCES `tbl_address` (`address_id`),
  ADD CONSTRAINT `school_address_id_fk` FOREIGN KEY (`school_address_id`) REFERENCES `tbl_address` (`address_id`);

--
-- Constraints for table `tbl_character_reference`
--
ALTER TABLE `tbl_character_reference`
  ADD CONSTRAINT `applicant_id` FOREIGN KEY (`applicant_id`) REFERENCES `tbl_applicant` (`applicant_id`);

--
-- Constraints for table `tbl_coordinator`
--
ALTER TABLE `tbl_coordinator`
  ADD CONSTRAINT `applicant_id_fk1` FOREIGN KEY (`applicant_id`) REFERENCES `tbl_applicant` (`applicant_id`);

--
-- Constraints for table `tbl_job_application`
--
ALTER TABLE `tbl_job_application`
  ADD CONSTRAINT `applicant_id_fk2` FOREIGN KEY (`applicant_id`) REFERENCES `tbl_applicant` (`applicant_id`),
  ADD CONSTRAINT `department_id_fk` FOREIGN KEY (`department_id`) REFERENCES `tbl_department` (`department_id`),
  ADD CONSTRAINT `employment_id_fk` FOREIGN KEY (`employment_id`) REFERENCES `tbl_employment_type` (`employment_type_id`),
  ADD CONSTRAINT `position_group_id_fk` FOREIGN KEY (`position_group_id`) REFERENCES `tbl_position_group` (`position_group_id`),
  ADD CONSTRAINT `position_id_fk` FOREIGN KEY (`position_id`) REFERENCES `tbl_position` (`position_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
