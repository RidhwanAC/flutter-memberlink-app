-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 23, 2025 at 01:43 PM
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
-- Database: `db_memberlink_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `date_reg` timestamp NOT NULL DEFAULT current_timestamp(),
  `profile_pic` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`id`, `username`, `email`, `password`, `date_reg`, `profile_pic`) VALUES
(1, 'user1', 'user1@example.com', '$2y$10$r/QNSwLZIiVXnpcjBvnHxuTtgd767kZh1RBMsf8VaUtIsBeIK2By.', '2025-01-23 08:16:31', NULL),
(2, 'user2', 'user2@example.com', '$2y$10$bogIpfjojuFuWexWPC3zSu4KJTphhhGm.kaQbZ8x3m1nXR2waUase', '2025-01-23 08:23:27', NULL),
(3, 'user3', 'user3@example.com', '$2y$10$V3Fz9ryl8YH34/2vNV/of.q/Twm3A2/MvDbb6otKp.81TRIx4lJj2', '2025-01-23 08:26:35', NULL),
(4, 'user4', 'user4@example.com', '$2y$10$9zpXsXeAHQmaSGlHBMHtce8FKKewt9udX47QfbR4NBT0QvjgqHQjq', '2025-01-23 12:28:15', NULL),
(5, 'user5', 'user5@example.com', '$2y$10$quhZACpOcQBuxBVaE/vQGekWTlss40vaBKcphDTsroRSHEi5u2JbK', '2025-01-23 12:37:59', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
