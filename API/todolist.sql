-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 19, 2024 at 08:07 AM
-- Server version: 10.5.20-MariaDB
-- PHP Version: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `id20516546_mytodo`
--

-- --------------------------------------------------------

--
-- Table structure for table `todolist`
--

CREATE TABLE `todolist` (
  `todolist_id` varchar(225) NOT NULL,
  `title` text NOT NULL,
  `jenis` varchar(1) NOT NULL,
  `tanggal` date NOT NULL,
  `status` varchar(1) NOT NULL,
  `id_user` varchar(225) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `todolist`
--

INSERT INTO `todolist` (`todolist_id`, `title`, `jenis`, `tanggal`, `status`, `id_user`) VALUES
('345wersds', 'Complete all the college assignments ', 'T', '2024-04-19', 'y', '1'),
('67384eyd', 'Complete the Case Study and send it to the professor', 'T', '2024-04-26', 'y', '1'),
('duit7e', 'Rafael\'s birthday party at Coves Inn', 'H', '2024-04-26', '', '1'),
('f76c1cfc-fe17-11ee-8188-feed01270013', 'Buy watch for dad on Father\'s day', 'D', '2024-04-19', 'y', '1');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `todolist`
--
ALTER TABLE `todolist`
  ADD PRIMARY KEY (`todolist_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
