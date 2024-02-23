-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:1337
-- Generation Time: Feb 23, 2024 at 08:49 PM
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
-- Database: `webbutvecklingslutprojekt`
--

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `coursesId` int(11) NOT NULL,
  `name` text NOT NULL,
  `YHP` int(11) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`coursesId`, `name`, `YHP`, `description`) VALUES
(1, 'Webbutveckling', 25, 'grunderna i webbutveckling'),
(2, 'konsultrollen', 20, 'lär dig bli konsult'),
(3, 'avancerad javascript', 25, 'lär dig avancerad javascript'),
(4, 'javascript', 30, 'grundläggande kunskap i javascript'),
(5, 'java web services', 30, 'kunskap gällande java web'),
(6, 'databaser och databasdesign', 25, 'grundläggande utbildning i databaser'),
(7, 'avancerad javaprogrammering', 20, 'lär dig avancerad java'),
(8, 'javaprogrammering', 30, 'grundläggande kunskap i java'),
(9, 'html och css', 30, 'grundläggande utbildning i html och css'),
(10, 'basketweaving', 0, 'learn how to make your own baskets');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `studentId` int(11) NOT NULL,
  `firstName` text NOT NULL,
  `lastName` text NOT NULL,
  `town` text NOT NULL,
  `email` text NOT NULL,
  `phone` text NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`studentId`, `firstName`, `lastName`, `town`, `email`, `phone`, `username`, `password`) VALUES
(1, 'Henry', 'VIII', 'London', 'theking@england.co.uk', '0709473333', 'coppernose', 'password'),
(2, 'stavros', 'popudopulus', 'Athens', 'thegreek@gmail.com', '0709433102', 'theGreek', 'password'),
(3, 'test', 'test', 'test', 'test@gmail.com', '07070750', 'test', 'password'),
(4, 'elsa', 'andersson', 'göteborg', 'elsa.andersson@gmail.com', '0704443331', 'elsa88', 'password'),
(5, 'karlssons', 'klister', 'stockholm', 'karlsonnsklister@gmail.com', '0709544321', 'klibbigakalle', 'password'),
(6, 'arvid', 'jönsson', 'malmö', 'jöns@hotmail.com', '0609433712', 'potatisbullen', 'password'),
(7, 'greger', 'larsson', 'malmö', 'grodan@yahoo.com', '060883334', 'grodan77', 'password'),
(8, 'sofia', 'persson', 'toarp', 'perren@gmail.com', '0604433888', 'raggarn', 'password'),
(9, 'johnny', 'stråhed', 'leksand', 'johnny@gmail.com', '0609433666', 'långben', 'password'),
(10, 'jamie', 'oliver', 'london', 'jamie@gmail.com', '00006666444', 'thechef', 'password');

-- --------------------------------------------------------

--
-- Table structure for table `studentscourses`
--

CREATE TABLE `studentscourses` (
  `studentCoursesId` int(11) NOT NULL,
  `studentsId` int(11) NOT NULL,
  `coursesId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `studentscourses`
--

INSERT INTO `studentscourses` (`studentCoursesId`, `studentsId`, `coursesId`) VALUES
(1, 1, 2),
(2, 1, 2),
(3, 10, 7),
(4, 9, 4),
(5, 4, 9),
(6, 4, 10),
(7, 5, 5),
(8, 2, 9),
(9, 10, 10),
(10, 10, 4),
(11, 5, 1),
(12, 7, 2),
(13, 3, 10);

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `teachersId` int(11) NOT NULL,
  `firstName` text NOT NULL,
  `lastName` text NOT NULL,
  `town` text NOT NULL,
  `email` text NOT NULL,
  `phone` text NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `privilegeType` enum('user','admin') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`teachersId`, `firstName`, `lastName`, `town`, `email`, `phone`, `username`, `password`, `privilegeType`) VALUES
(1, 'Lukas', 'Kurasinski', 'Malmö', 'lukas.kurasinski@gritacademy.se', '0709473111', 'WebTeach', 'password', 'admin'),
(2, 'teacheruser', 'test', 'lidingö', 'teachertest@gmail.com', '0709433256', 'teacheruser', 'password', 'user'),
(3, 'admin', 'teacher', 'malmö', 'adminteacher@gmail.com', '00000000000', 'adminteacher', 'password', 'admin'),
(4, 'Alrik', 'He', 'malmö', 'alrik.he@gritacademy.se', '0606060000', 'timearchitect', 'password', 'user'),
(5, 'Martin', 'Haagen', 'simrishamn', 'martin.haagen@gritacademy.se', '00066664444', 'martin', 'password', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `teacherscourses`
--

CREATE TABLE `teacherscourses` (
  `teachersCoursesId` int(11) NOT NULL,
  `teachersId` int(11) NOT NULL,
  `coursesId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teacherscourses`
--

INSERT INTO `teacherscourses` (`teachersCoursesId`, `teachersId`, `coursesId`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 1),
(4, 3, 1),
(5, 4, 7),
(6, 1, 1),
(7, 5, 6),
(8, 4, 4),
(9, 4, 10);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`coursesId`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`studentId`);

--
-- Indexes for table `studentscourses`
--
ALTER TABLE `studentscourses`
  ADD PRIMARY KEY (`studentCoursesId`),
  ADD KEY `coursesId` (`coursesId`),
  ADD KEY `studentsId` (`studentsId`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`teachersId`);

--
-- Indexes for table `teacherscourses`
--
ALTER TABLE `teacherscourses`
  ADD PRIMARY KEY (`teachersCoursesId`),
  ADD KEY `coursesId` (`coursesId`),
  ADD KEY `teachersId` (`teachersId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `coursesId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `studentId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `studentscourses`
--
ALTER TABLE `studentscourses`
  MODIFY `studentCoursesId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `teachers`
--
ALTER TABLE `teachers`
  MODIFY `teachersId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `teacherscourses`
--
ALTER TABLE `teacherscourses`
  MODIFY `teachersCoursesId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `studentscourses`
--
ALTER TABLE `studentscourses`
  ADD CONSTRAINT `studentscourses_ibfk_1` FOREIGN KEY (`coursesId`) REFERENCES `courses` (`coursesId`),
  ADD CONSTRAINT `studentscourses_ibfk_2` FOREIGN KEY (`studentsId`) REFERENCES `students` (`studentId`);

--
-- Constraints for table `teacherscourses`
--
ALTER TABLE `teacherscourses`
  ADD CONSTRAINT `teacherscourses_ibfk_1` FOREIGN KEY (`coursesId`) REFERENCES `courses` (`coursesId`),
  ADD CONSTRAINT `teacherscourses_ibfk_2` FOREIGN KEY (`teachersId`) REFERENCES `teachers` (`teachersId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
