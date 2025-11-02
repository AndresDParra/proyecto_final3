-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: elixir_db:3306
-- Generation Time: Nov 02, 2025 at 02:33 PM
-- Server version: 8.0.44
-- PHP Version: 8.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `taxis_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `drivers`
--

CREATE TABLE `drivers` (
  `id` bigint UNSIGNED NOT NULL,
  `vehicle_model` varchar(255) DEFAULT NULL,
  `vehicle_plate` varchar(255) DEFAULT NULL,
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `results_and_ranking`
--

CREATE TABLE `results_and_ranking` (
  `id` bigint UNSIGNED NOT NULL,
  `date_trip` datetime DEFAULT NULL,
  `passenger_points` int DEFAULT NULL,
  `driver_points` int DEFAULT NULL,
  `origin` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `passenger_id` bigint UNSIGNED DEFAULT NULL,
  `driver_id` bigint UNSIGNED DEFAULT NULL,
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `schema_migrations`
--

CREATE TABLE `schema_migrations` (
  `version` bigint NOT NULL,
  `inserted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `schema_migrations`
--

INSERT INTO `schema_migrations` (`version`, `inserted_at`) VALUES
(20251101215027, '2025-11-01 21:50:31'),
(20251101215701, '2025-11-02 01:13:22'),
(20251101215815, '2025-11-02 01:13:22'),
(20251101220130, '2025-11-02 01:13:22'),
(20251101220704, '2025-11-02 01:13:22'),
(20251101220754, '2025-11-02 01:13:22');

-- --------------------------------------------------------

--
-- Table structure for table `travel_requests`
--

CREATE TABLE `travel_requests` (
  `id` bigint UNSIGNED NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `passenger_id` bigint UNSIGNED DEFAULT NULL,
  `driver_id` bigint UNSIGNED DEFAULT NULL,
  `origin_location_id` bigint UNSIGNED DEFAULT NULL,
  `destination_location_id` bigint UNSIGNED DEFAULT NULL,
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role_id` bigint UNSIGNED DEFAULT NULL,
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `password`, `role_id`, `inserted_at`, `updated_at`) VALUES
(1, 'trujillo', 'matraz', 'fernely', NULL, '2025-11-02 02:52:02', '2025-11-02 02:52:02');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `drivers`
--
ALTER TABLE `drivers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `results_and_ranking`
--
ALTER TABLE `results_and_ranking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `results_and_ranking_passenger_id_index` (`passenger_id`),
  ADD KEY `results_and_ranking_driver_id_index` (`driver_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `schema_migrations`
--
ALTER TABLE `schema_migrations`
  ADD PRIMARY KEY (`version`);

--
-- Indexes for table `travel_requests`
--
ALTER TABLE `travel_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `travel_requests_passenger_id_index` (`passenger_id`),
  ADD KEY `travel_requests_driver_id_index` (`driver_id`),
  ADD KEY `travel_requests_origin_location_id_index` (`origin_location_id`),
  ADD KEY `travel_requests_destination_location_id_index` (`destination_location_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_role_id_index` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `drivers`
--
ALTER TABLE `drivers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `results_and_ranking`
--
ALTER TABLE `results_and_ranking`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `travel_requests`
--
ALTER TABLE `travel_requests`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `results_and_ranking`
--
ALTER TABLE `results_and_ranking`
  ADD CONSTRAINT `results_and_ranking_driver_id_fkey` FOREIGN KEY (`driver_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `results_and_ranking_passenger_id_fkey` FOREIGN KEY (`passenger_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `travel_requests`
--
ALTER TABLE `travel_requests`
  ADD CONSTRAINT `travel_requests_destination_location_id_fkey` FOREIGN KEY (`destination_location_id`) REFERENCES `locations` (`id`),
  ADD CONSTRAINT `travel_requests_driver_id_fkey` FOREIGN KEY (`driver_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `travel_requests_origin_location_id_fkey` FOREIGN KEY (`origin_location_id`) REFERENCES `locations` (`id`),
  ADD CONSTRAINT `travel_requests_passenger_id_fkey` FOREIGN KEY (`passenger_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_role_id_fkey` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
