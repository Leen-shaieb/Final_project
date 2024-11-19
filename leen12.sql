-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 19, 2024 at 09:33 AM
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
-- Database: `leen12`
--

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `companyID` int(11) NOT NULL,
  `companyName` varchar(500) NOT NULL,
  `location` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`companyID`, `companyName`, `location`) VALUES
(1, 'Microsoft', 'Haifa'),
(2, 'CheckPoint', 'TelAviv');

-- --------------------------------------------------------

--
-- Table structure for table `degrees`
--

CREATE TABLE `degrees` (
  `DegreeID` int(11) NOT NULL,
  `DegreeNAme` varchar(500) NOT NULL,
  `Excellence` tinyint(1) NOT NULL,
  `avarege` int(11) NOT NULL,
  `universityID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `jobID` int(11) NOT NULL,
  `companyID` int(11) NOT NULL,
  `location` varchar(500) NOT NULL,
  `workingHours` int(11) NOT NULL,
  `salaryPerHour` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`jobID`, `companyID`, `location`, `workingHours`, `salaryPerHour`) VALUES
(1, 1, 'haifa', 12, 20),
(2, 2, 'haifa', 12, 20),
(3, 1, 'hg', 5, 60);

-- --------------------------------------------------------

--
-- Table structure for table `universities`
--

CREATE TABLE `universities` (
  `universityID` int(11) NOT NULL,
  `location` varchar(500) NOT NULL,
  `universityName` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `universities`
--

INSERT INTO `universities` (`universityID`, `location`, `universityName`) VALUES
(1, 'Haifa', '');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userID` int(11) NOT NULL,
  `firstName` varchar(500) NOT NULL,
  `lastName` varchar(500) NOT NULL,
  `BirthDate` date NOT NULL DEFAULT current_timestamp(),
  `Degree` varchar(500) NOT NULL,
  `University` int(11) NOT NULL,
  `password` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userID`, `firstName`, `lastName`, `BirthDate`, `Degree`, `University`, `password`) VALUES
(1, 'Leen', 'Shaieb', '2024-11-16', '', 0, '123'),
(6, '', '', '2024-11-16', '', 0, ''),
(7, 'leen', 'leen', '2024-11-16', '', 0, 'leen'),
(8, 'leen', 'leen', '2024-11-16', '', 0, 'leen'),
(9, 'leen', 'leen', '2024-11-16', '', 0, 'leen'),
(10, 'leen', 'leen', '2024-11-16', '', 0, 'leen'),
(11, 'leen', 'leen', '2024-11-16', '', 0, 'leen'),
(12, 'leen', 'leen', '2024-11-16', '', 0, 'leen'),
(13, 'leen', 'leen', '2024-11-16', '', 0, 'leen'),
(14, 'leen', 'leen', '2024-11-16', '', 0, 'leen'),
(15, 'leen', 'leen', '2024-11-16', '', 0, 'leen'),
(16, 'leen', 'leen', '2024-11-16', '', 0, 'leen'),
(17, 'leen', 'leen', '2024-11-16', '', 0, 'leen'),
(18, 'leen', 'leen', '2024-11-16', '', 0, 'leen');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`companyID`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`jobID`);

--
-- Indexes for table `universities`
--
ALTER TABLE `universities`
  ADD PRIMARY KEY (`universityID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `companyID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `jobID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `universities`
--
ALTER TABLE `universities`
  MODIFY `universityID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `userID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
