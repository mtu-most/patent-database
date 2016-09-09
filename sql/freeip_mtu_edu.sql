-- phpMyAdmin SQL Dump
-- version 4.0.10.14
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: Aug 12, 2016 at 10:47 AM
-- Server version: 5.5.50-cll
-- PHP Version: 5.6.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `freeipmt_expired_patents`
--
CREATE DATABASE IF NOT EXISTS `freeipmt_expired_patents` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `freeipmt_expired_patents`;

-- --------------------------------------------------------

--
-- Table structure for table `expired_patents_checked`
--

DROP TABLE IF EXISTS `expired_patents_checked`;
CREATE TABLE IF NOT EXISTS `expired_patents_checked` (
  `us_patent_number` varchar(7) NOT NULL,
  PRIMARY KEY (`us_patent_number`),
  KEY `us_patent_number` (`us_patent_number`),
  KEY `us_patent_number_2` (`us_patent_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `full_text_us_patents`
--

DROP TABLE IF EXISTS `full_text_us_patents`;
CREATE TABLE IF NOT EXISTS `full_text_us_patents` (
  `us_patent_number` varchar(8) NOT NULL,
  `us_patent_title` varchar(500) NOT NULL,
  `us_patent_issue_date` int(11) NOT NULL,
  `us_term_of_grant` int(11) NOT NULL,
  PRIMARY KEY (`us_patent_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `maintenance_fee_events`
--

DROP TABLE IF EXISTS `maintenance_fee_events`;
CREATE TABLE IF NOT EXISTS `maintenance_fee_events` (
  `us_patent_number` varchar(7) NOT NULL,
  `us_application_number` varchar(8) NOT NULL,
  `small_entity` varchar(1) NOT NULL,
  `us_application_filing_date` int(11) NOT NULL,
  `us_grant_issue_date` int(11) NOT NULL,
  `maintenance_fee_event_entry_date` int(11) NOT NULL,
  `maintenance_fee_event_code` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sgml_full_text_us_patents`
--

DROP TABLE IF EXISTS `sgml_full_text_us_patents`;
CREATE TABLE IF NOT EXISTS `sgml_full_text_us_patents` (
  `us_patent_number` varchar(8) NOT NULL,
  `us_patent_title` varchar(500) NOT NULL,
  `us_patent_issue_date` int(11) NOT NULL,
  `us_term_of_grant` int(11) NOT NULL,
  PRIMARY KEY (`us_patent_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `txt_full_text_us_patents`
--

DROP TABLE IF EXISTS `txt_full_text_us_patents`;
CREATE TABLE IF NOT EXISTS `txt_full_text_us_patents` (
  `us_patent_number` varchar(8) NOT NULL,
  `us_patent_title` varchar(500) NOT NULL,
  `us_patent_issue_date` int(11) NOT NULL,
  `us_term_of_grant` int(11) NOT NULL,
  PRIMARY KEY (`us_patent_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `us_inactive_patents`
--

DROP TABLE IF EXISTS `us_inactive_patents`;
CREATE TABLE IF NOT EXISTS `us_inactive_patents` (
  `us_patent_number` varchar(7) NOT NULL,
  `us_patent_title` varchar(500) NOT NULL,
  `us_patent_issue_date` int(11) NOT NULL,
  `us_term_of_grant` int(11) NOT NULL,
  PRIMARY KEY (`us_patent_number`),
  KEY `us_patent_title` (`us_patent_title`(255)),
  KEY `us_patent_issue_date` (`us_patent_issue_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
