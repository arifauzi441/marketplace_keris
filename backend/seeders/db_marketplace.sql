-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 28 Bulan Mei 2025 pada 05.28
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_marketplace`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `admins`
--

CREATE TABLE `admins` (
  `id_admin` int(11) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin_name` varchar(255) DEFAULT NULL,
  `admin_address` varchar(255) DEFAULT NULL,
  `admin_phone` varchar(255) DEFAULT NULL,
  `admin_photo` varchar(255) DEFAULT NULL,
  `status` enum('diterima','belum diterima') DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `fcm_token` varchar(512) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `admins`
--

INSERT INTO `admins` (`id_admin`, `username`, `password`, `admin_name`, `admin_address`, `admin_phone`, `admin_photo`, `status`, `createdAt`, `updatedAt`, `fcm_token`) VALUES
(1, 'ari', '234', NULL, NULL, NULL, NULL, 'diterima', '2025-05-02 16:49:09', '2025-05-27 15:38:36', 'eCcRoRdBT9Km3cV4CyDWoR:APA91bG-H2-Mpj_jeUDFc4tM-OFn2dkJhubLsVpKAbRcf4-GhG2nUekNO0T_777fZGOQimUIJcoEcVMnVYBOypmusLct4nNThHrZ7AxgbPvcSKWTwR6trhE'),
(2, 'ari2', '123', NULL, NULL, NULL, NULL, 'diterima', '2025-05-02 16:57:45', '2025-05-03 08:17:28', NULL),
(3, 'ari27', '127', NULL, NULL, NULL, NULL, 'belum diterima', '2025-05-02 17:00:57', '2025-05-05 14:23:05', NULL),
(4, 'ari22', '121', NULL, 'jl pala', NULL, NULL, 'belum diterima', '2025-05-02 17:02:20', '2025-05-02 17:02:20', NULL),
(5, 'wkrenklwen', 'slkdfnk', NULL, 'fslkdnfks', NULL, NULL, 'belum diterima', '2025-05-03 04:16:36', '2025-05-03 04:16:36', NULL),
(6, 'wkrenklwenskldf', 'slkdnf', NULL, 'fsldkfn', NULL, NULL, 'belum diterima', '2025-05-03 04:16:41', '2025-05-03 04:16:41', NULL),
(7, 'sdlmfnslknf', 'klsndflksndf', NULL, 'slkdfnksn', NULL, NULL, 'belum diterima', '2025-05-03 04:16:48', '2025-05-03 04:16:48', NULL),
(8, 'sdlmawda', 'sad', NULL, 'sf', NULL, NULL, 'belum diterima', '2025-05-03 04:16:53', '2025-05-03 04:16:53', NULL),
(9, 'fajarw', 'bla', NULL, NULL, '087850366625', NULL, 'diterima', '2025-05-07 04:27:51', '2025-05-27 15:40:04', 'eCcRoRdBT9Km3cV4CyDWoR:APA91bG-H2-Mpj_jeUDFc4tM-OFn2dkJhubLsVpKAbRcf4-GhG2nUekNO0T_777fZGOQimUIJcoEcVMnVYBOypmusLct4nNThHrZ7AxgbPvcSKWTwR6trhE'),
(10, 'fajar2', '1234', NULL, NULL, '0878503666257', NULL, 'belum diterima', '2025-05-07 06:00:17', '2025-05-07 06:00:17', NULL),
(11, 'ibram', 'bjir', NULL, NULL, '085852769382', NULL, 'diterima', '2025-05-19 06:32:59', '2025-05-19 06:34:32', NULL),
(12, 'hiFatih', 'aaaa', 'Rahmat Al Fatih', NULL, '0009988765', NULL, 'belum diterima', '2025-05-23 14:07:45', '2025-05-23 14:07:45', NULL),
(13, 'gsgs', '62ywy', 'ysysts', NULL, '5464845', NULL, 'belum diterima', '2025-05-27 14:52:06', '2025-05-27 14:52:06', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `adminverificationcodes`
--

CREATE TABLE `adminverificationcodes` (
  `id_verification_code` int(11) NOT NULL,
  `verification_code` int(11) DEFAULT NULL,
  `expired_at` datetime DEFAULT NULL,
  `id_admin` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `adminverificationcodes`
--

INSERT INTO `adminverificationcodes` (`id_verification_code`, `verification_code`, `expired_at`, `id_admin`, `createdAt`, `updatedAt`) VALUES
(1, 692997, '2025-05-16 16:33:29', 9, '2025-05-16 16:32:29', '2025-05-16 16:32:29'),
(2, 999568, '2025-05-16 16:57:34', 9, '2025-05-16 16:56:34', '2025-05-16 16:56:34'),
(3, 144217, '2025-05-16 17:03:40', 9, '2025-05-16 17:02:40', '2025-05-16 17:02:40'),
(4, 314874, '2025-05-16 17:04:05', 9, '2025-05-16 17:03:05', '2025-05-16 17:03:05'),
(5, 212300, '2025-05-16 17:22:49', 9, '2025-05-16 17:21:49', '2025-05-16 17:21:49'),
(6, 439913, '2025-05-16 18:45:32', 9, '2025-05-16 18:44:32', '2025-05-16 18:44:32'),
(7, 864628, '2025-05-16 19:02:50', 9, '2025-05-16 19:01:50', '2025-05-16 19:01:50'),
(8, 239232, '2025-05-16 19:03:52', 9, '2025-05-16 19:02:52', '2025-05-16 19:02:52'),
(9, 834472, '2025-05-16 19:12:34', 9, '2025-05-16 19:11:34', '2025-05-16 19:11:34'),
(10, 411968, '2025-05-16 19:19:32', 9, '2025-05-16 19:18:32', '2025-05-16 19:18:32'),
(11, 280715, '2025-05-19 06:34:48', 11, '2025-05-19 06:33:48', '2025-05-19 06:33:48');

-- --------------------------------------------------------

--
-- Struktur dari tabel `productpicts`
--

CREATE TABLE `productpicts` (
  `id_product_pict` int(11) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `id_product` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `productpicts`
--

INSERT INTO `productpicts` (`id_product_pict`, `path`, `id_product`, `createdAt`, `updatedAt`) VALUES
(83, 'images/product_images/1745987274540 - 1000033174.jpg', 33, '2025-04-30 04:27:54', '2025-04-30 04:27:54'),
(84, 'images/product_images/1745987307510 - 1000033177.jpg', 34, '2025-04-30 04:28:27', '2025-04-30 04:28:27'),
(85, 'images/product_images/1745987335504 - 1000033176.jpg', 35, '2025-04-30 04:28:55', '2025-04-30 04:28:55'),
(86, 'images/product_images/1745987373927 - 1000033181.jpg', 36, '2025-04-30 04:29:34', '2025-04-30 04:29:34'),
(87, 'images/product_images/1745987520752 - 1000033182.jpg', 37, '2025-04-30 04:32:00', '2025-04-30 04:32:00'),
(88, 'images/product_images/1745987629023 - 1000033178.jpg', 38, '2025-04-30 04:33:49', '2025-04-30 04:33:49'),
(89, 'images/product_images/1745987656940 - 1000033179.jpg', 39, '2025-04-30 04:34:17', '2025-04-30 04:34:17'),
(90, 'images/product_images/1745987688059 - 1000033180.jpg', 40, '2025-04-30 04:34:50', '2025-04-30 04:34:50'),
(91, 'images/product_images/1745987720344 - 1000033173.jpg', 41, '2025-04-30 04:35:20', '2025-04-30 04:35:20'),
(92, 'images/product_images/1745987786764 - 1000033175.jpg', 42, '2025-04-30 04:36:26', '2025-04-30 04:36:26'),
(93, 'images/product_images/1745988240567 - 1000033171.jpg', 43, '2025-04-30 04:44:04', '2025-04-30 04:44:04'),
(94, 'images/product_images/1745988241547 - 1000032496.jpg', 43, '2025-04-30 04:44:04', '2025-04-30 04:44:04'),
(95, 'images/product_images/1745988243266 - 1000033181.jpg', 43, '2025-04-30 04:44:04', '2025-04-30 04:44:04'),
(99, 'images/product_images/1745988282662 - 1000033172.jpg', 45, '2025-04-30 04:44:43', '2025-04-30 04:44:43'),
(100, 'images/product_images/1745988282681 - 1000033181.jpg', 45, '2025-04-30 04:44:43', '2025-04-30 04:44:43'),
(101, 'images/product_images/1745988283005 - 1000032496.jpg', 45, '2025-04-30 04:44:43', '2025-04-30 04:44:43');

-- --------------------------------------------------------

--
-- Struktur dari tabel `products`
--

CREATE TABLE `products` (
  `id_product` int(11) NOT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_price` int(11) DEFAULT NULL,
  `product_stock` int(11) DEFAULT NULL,
  `click_counts` int(11) DEFAULT 0,
  `product_status` enum('aktif','nonaktif') DEFAULT 'aktif',
  `product_description` text DEFAULT NULL,
  `id_seller` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `products`
--

INSERT INTO `products` (`id_product`, `product_name`, `product_price`, `product_stock`, `click_counts`, `product_status`, `product_description`, `id_seller`, `createdAt`, `updatedAt`) VALUES
(33, 'Keris Panji Mataram', 4000000, 1, 5, 'aktif', 'Keris 1', 1, '2025-04-30 04:27:54', '2025-05-21 04:24:54'),
(34, 'Keris Surya Kencana', 3000000, 1, 3, 'aktif', 'Keris 2', 1, '2025-04-30 04:28:27', '2025-05-21 04:24:34'),
(35, 'Keris Kyai Carubuk', 3500000, 1, 0, 'aktif', 'Keris 3', 1, '2025-04-30 04:28:55', '2025-04-30 04:50:05'),
(36, 'Keris Rakian Naga', 4500000, 1, 0, 'aktif', 'Keris 4', 1, '2025-04-30 04:29:34', '2025-04-30 04:50:05'),
(37, 'Keris Nagasasra', 5000000, 1, 0, 'aktif', 'Keris 5', 1, '2025-04-30 04:32:00', '2025-04-30 04:49:58'),
(38, 'Keris Kalamisani', 2700000, 1, 0, 'aktif', 'Keris 1', 3, '2025-04-30 04:33:49', '2025-04-30 04:33:49'),
(39, 'Keris Pamungkas Seta', 3600000, 1, 0, 'aktif', 'Keris 2', 3, '2025-04-30 04:34:17', '2025-04-30 04:34:17'),
(40, 'Keris Sanghyang Pamenang', 4200000, 1, 0, 'aktif', 'Keris 3', 3, '2025-04-30 04:34:50', '2025-04-30 04:34:50'),
(41, 'Keris Lindu Aji', 3800000, 1, 0, 'aktif', 'Keris 4', 3, '2025-04-30 04:35:20', '2025-04-30 04:35:20'),
(42, 'Keris Ratu Pameling', 1900000, 1, 0, 'aktif', 'Keris 5', 3, '2025-04-30 04:36:26', '2025-04-30 04:36:26'),
(43, 'Keris Nogososro', 2600000, 1, 0, 'aktif', 'Keris 1', 2, '2025-04-30 04:44:04', '2025-04-30 04:44:04'),
(45, 'Keris Kyai Sengkelat', 3700000, 1, 4, 'aktif', 'Keris 2', 2, '2025-04-30 04:44:43', '2025-05-05 05:37:28'),
(46, 'keris q', 30000, 5, 1, 'aktif', 'aksjdbkajsbdjb', 13, '2025-05-21 03:32:43', '2025-05-25 09:02:40');

-- --------------------------------------------------------

--
-- Struktur dari tabel `sellers`
--

CREATE TABLE `sellers` (
  `id_seller` int(11) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `seller_name` varchar(255) DEFAULT NULL,
  `seller_address` varchar(255) DEFAULT NULL,
  `seller_phone` varchar(255) DEFAULT NULL,
  `seller_photo` varchar(255) DEFAULT NULL,
  `status` enum('diterima','belum diterima') DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `sellers`
--

INSERT INTO `sellers` (`id_seller`, `username`, `password`, `seller_name`, `seller_address`, `seller_phone`, `seller_photo`, `status`, `createdAt`, `updatedAt`) VALUES
(1, 'ari3', 'gokil', 'ari fauzi', 'jl Sapeken no.5 blok kk', '082335838167', 'images/user_images/1748177887302 - 1000020411.jpg', 'diterima', '2025-05-02 16:58:41', '2025-05-25 12:58:07'),
(2, 'ari', '44', 'Ibram Maulana', 'pabian', '085852769382', 'images/user_images/1748177719154 - 1000091081.jpg', 'diterima', '2025-04-23 13:53:50', '2025-05-25 12:55:19'),
(3, 'veri', '335', 'vernanda', 'Jl Tuwowo', '081216679709', 'images/user_images/1748177768102 - userPhoto3.png', 'diterima', '2025-04-27 11:30:50', '2025-05-25 12:56:08'),
(4, 'mawlaz', '123', 'agiel', 'jl. torjuNNB', '085517290', 'images/user_images/1748177840626 - 1000032992.jpg', 'diterima', '2025-04-29 08:30:10', '2025-05-25 12:57:21'),
(5, 'arifauzi441@gmail.com', '2', NULL, 'fdhhvghh', NULL, NULL, 'belum diterima', '2025-04-30 05:25:32', '2025-05-23 19:50:55'),
(6, 'blabla', '455', NULL, 'jlGaming', NULL, NULL, 'belum diterima', '2025-05-05 13:56:20', '2025-05-05 14:45:42'),
(10, 'fajar', '123', NULL, NULL, '087850366625', NULL, 'belum diterima', '2025-05-07 04:08:58', '2025-05-23 13:53:01'),
(12, 'fatih', 'gokil', NULL, NULL, '082140651676', NULL, 'belum diterima', '2025-05-19 04:28:40', '2025-05-23 13:53:00'),
(13, 'qasasi', '553', NULL, NULL, '0874783624', NULL, 'belum diterima', '2025-05-21 03:28:22', '2025-05-23 13:53:03'),
(14, 'Qasasi56', 'gokil', NULL, NULL, '082336667', NULL, 'belum diterima', '2025-05-23 13:48:34', '2025-05-23 13:56:25'),
(15, 'king szrc', 'gokil', 'Danang Susetyo P.', NULL, '088777666543', NULL, 'belum diterima', '2025-05-23 13:56:09', '2025-05-25 12:58:42'),
(16, 'sdfsdf', 'wsefsdf', 'sdfsf', NULL, '234234', NULL, 'belum diterima', '2025-05-23 17:21:05', '2025-05-23 17:21:05'),
(17, 'imryzo', '33', 'aqil yoga', 'dakdul', '089531322122', 'images/user_images/1748238502267 - 1000091077.jpg', 'diterima', '2025-05-25 11:41:26', '2025-05-26 05:48:22'),
(18, 'thertuen', '555', 'fauzi', NULL, '085852586638', NULL, 'belum diterima', '2025-05-27 14:49:18', '2025-05-27 14:49:18'),
(19, 'gqgqvq', 'vavqv', 'fahga', NULL, '6484848', NULL, 'belum diterima', '2025-05-27 14:52:50', '2025-05-27 14:52:50'),
(20, 'thereturn', '678', 'Ahmad Ari Fauzi', NULL, '088855325658', NULL, 'belum diterima', '2025-05-27 15:38:08', '2025-05-27 15:38:08');

-- --------------------------------------------------------

--
-- Struktur dari tabel `sellerverificationcodes`
--

CREATE TABLE `sellerverificationcodes` (
  `id_verification_code` int(11) NOT NULL,
  `verification_code` int(11) DEFAULT NULL,
  `expired_at` datetime DEFAULT NULL,
  `id_seller` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `sellerverificationcodes`
--

INSERT INTO `sellerverificationcodes` (`id_verification_code`, `verification_code`, `expired_at`, `id_seller`, `createdAt`, `updatedAt`) VALUES
(1, 281290, '2025-05-16 16:37:14', 1, '2025-05-16 16:36:14', '2025-05-16 16:36:14'),
(2, 124862, '2025-05-16 17:52:54', 10, '2025-05-16 17:51:54', '2025-05-16 17:51:54'),
(3, 216855, '2025-05-16 17:53:06', 10, '2025-05-16 17:52:06', '2025-05-16 17:52:06'),
(4, 109254, '2025-05-16 17:54:01', 1, '2025-05-16 17:53:01', '2025-05-16 17:53:01'),
(5, 770840, '2025-05-16 18:44:51', 1, '2025-05-16 18:43:51', '2025-05-16 18:43:51'),
(6, 360611, '2025-05-16 19:20:50', 1, '2025-05-16 19:19:50', '2025-05-16 19:19:50'),
(7, 656640, '2025-05-17 06:29:15', 1, '2025-05-17 06:28:15', '2025-05-17 06:28:15'),
(8, 693283, '2025-05-17 06:31:04', 1, '2025-05-17 06:30:04', '2025-05-17 06:30:04'),
(9, 509692, '2025-05-17 06:42:57', 1, '2025-05-17 06:41:57', '2025-05-17 06:41:57'),
(10, 359932, '2025-05-17 06:45:42', 1, '2025-05-17 06:44:42', '2025-05-17 06:44:42'),
(11, 260803, '2025-05-17 06:47:15', 1, '2025-05-17 06:46:15', '2025-05-17 06:46:15'),
(12, 223453, '2025-05-17 15:46:10', 1, '2025-05-17 15:45:10', '2025-05-17 15:45:10'),
(13, 746808, '2025-05-17 15:48:56', 1, '2025-05-17 15:47:56', '2025-05-17 15:47:56'),
(14, 909545, '2025-05-17 16:11:03', 1, '2025-05-17 16:10:03', '2025-05-17 16:10:03'),
(15, 235144, '2025-05-17 17:52:15', 1, '2025-05-17 17:51:15', '2025-05-17 17:51:15'),
(16, 781401, '2025-05-17 17:53:12', 1, '2025-05-17 17:52:12', '2025-05-17 17:52:12'),
(17, 678841, '2025-05-17 17:58:03', 1, '2025-05-17 17:57:04', '2025-05-17 17:57:04'),
(18, 398098, '2025-05-17 18:08:54', 1, '2025-05-17 18:07:54', '2025-05-17 18:07:54'),
(19, 129709, '2025-05-17 18:09:17', 1, '2025-05-17 18:08:17', '2025-05-17 18:08:17'),
(20, 348184, '2025-05-17 18:10:28', 1, '2025-05-17 18:09:28', '2025-05-17 18:09:28'),
(21, 654743, '2025-05-17 18:15:37', 1, '2025-05-17 18:14:37', '2025-05-17 18:14:37'),
(22, 284729, '2025-05-17 18:18:54', 1, '2025-05-17 18:17:54', '2025-05-17 18:17:54'),
(23, 236810, '2025-05-17 18:21:20', 1, '2025-05-17 18:20:20', '2025-05-17 18:20:20'),
(24, 536177, '2025-05-17 18:21:35', 1, '2025-05-17 18:20:35', '2025-05-17 18:20:35'),
(25, 116187, '2025-05-17 18:24:35', 1, '2025-05-17 18:23:35', '2025-05-17 18:23:35'),
(26, 316627, '2025-05-17 18:24:59', 1, '2025-05-17 18:23:59', '2025-05-17 18:23:59'),
(27, 613662, '2025-05-17 18:25:22', 1, '2025-05-17 18:24:22', '2025-05-17 18:24:22'),
(28, 839871, '2025-05-17 18:25:50', 1, '2025-05-17 18:24:50', '2025-05-17 18:24:50'),
(29, 178696, '2025-05-17 18:35:38', 1, '2025-05-17 18:34:38', '2025-05-17 18:34:38'),
(30, 503335, '2025-05-17 18:44:23', 1, '2025-05-17 18:43:23', '2025-05-17 18:43:23'),
(31, 991340, '2025-05-17 18:45:01', 1, '2025-05-17 18:44:01', '2025-05-17 18:44:01'),
(32, 821721, '2025-05-17 18:45:24', 1, '2025-05-17 18:44:24', '2025-05-17 18:44:24'),
(33, 591187, '2025-05-18 03:21:06', 1, '2025-05-18 03:20:06', '2025-05-18 03:20:06'),
(34, 327895, '2025-05-18 03:23:25', 1, '2025-05-18 03:22:25', '2025-05-18 03:22:25'),
(35, 681410, '2025-05-18 03:23:44', 1, '2025-05-18 03:22:44', '2025-05-18 03:22:44'),
(36, 659064, '2025-05-18 03:24:15', 1, '2025-05-18 03:23:15', '2025-05-18 03:23:15'),
(37, 269329, '2025-05-18 03:25:00', 1, '2025-05-18 03:24:00', '2025-05-18 03:24:00'),
(38, 378533, '2025-05-18 03:26:58', 1, '2025-05-18 03:25:58', '2025-05-18 03:25:58'),
(39, 394860, '2025-05-18 05:39:14', 10, '2025-05-18 05:38:15', '2025-05-18 05:38:15'),
(40, 691202, '2025-05-18 05:44:21', 10, '2025-05-18 05:43:21', '2025-05-18 05:43:21'),
(41, 899156, '2025-05-18 05:45:55', 10, '2025-05-18 05:44:55', '2025-05-18 05:44:55'),
(42, 504318, '2025-05-18 05:47:19', 10, '2025-05-18 05:46:20', '2025-05-18 05:46:20'),
(43, 243255, '2025-05-18 06:23:54', 10, '2025-05-18 06:22:55', '2025-05-18 06:22:55'),
(44, 421447, '2025-05-18 06:27:01', 10, '2025-05-18 06:26:01', '2025-05-18 06:26:01'),
(45, 243227, '2025-05-18 12:48:59', 1, '2025-05-18 12:47:59', '2025-05-18 12:47:59'),
(46, 914139, '2025-05-18 12:50:46', 1, '2025-05-18 12:49:47', '2025-05-18 12:49:47'),
(47, 537267, '2025-05-19 03:42:22', 1, '2025-05-19 03:41:23', '2025-05-19 03:41:23'),
(48, 802384, '2025-05-19 03:56:47', 1, '2025-05-19 03:55:47', '2025-05-19 03:55:47'),
(49, 281590, '2025-05-19 04:17:57', 1, '2025-05-19 04:16:57', '2025-05-19 04:16:57'),
(50, 390606, '2025-05-19 04:31:14', 12, '2025-05-19 04:30:14', '2025-05-19 04:30:14'),
(51, 712841, '2025-05-19 06:00:56', 1, '2025-05-19 05:59:56', '2025-05-19 05:59:56');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id_admin`);

--
-- Indeks untuk tabel `adminverificationcodes`
--
ALTER TABLE `adminverificationcodes`
  ADD PRIMARY KEY (`id_verification_code`),
  ADD KEY `id_admin` (`id_admin`);

--
-- Indeks untuk tabel `productpicts`
--
ALTER TABLE `productpicts`
  ADD PRIMARY KEY (`id_product_pict`),
  ADD KEY `id_product` (`id_product`);

--
-- Indeks untuk tabel `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id_product`),
  ADD KEY `id_seller` (`id_seller`);

--
-- Indeks untuk tabel `sellers`
--
ALTER TABLE `sellers`
  ADD PRIMARY KEY (`id_seller`);

--
-- Indeks untuk tabel `sellerverificationcodes`
--
ALTER TABLE `sellerverificationcodes`
  ADD PRIMARY KEY (`id_verification_code`),
  ADD KEY `id_seller` (`id_seller`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `admins`
--
ALTER TABLE `admins`
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT untuk tabel `adminverificationcodes`
--
ALTER TABLE `adminverificationcodes`
  MODIFY `id_verification_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT untuk tabel `productpicts`
--
ALTER TABLE `productpicts`
  MODIFY `id_product_pict` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT untuk tabel `products`
--
ALTER TABLE `products`
  MODIFY `id_product` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT untuk tabel `sellers`
--
ALTER TABLE `sellers`
  MODIFY `id_seller` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT untuk tabel `sellerverificationcodes`
--
ALTER TABLE `sellerverificationcodes`
  MODIFY `id_verification_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `adminverificationcodes`
--
ALTER TABLE `adminverificationcodes`
  ADD CONSTRAINT `adminverificationcodes_ibfk_1` FOREIGN KEY (`id_admin`) REFERENCES `admins` (`id_admin`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `productpicts`
--
ALTER TABLE `productpicts`
  ADD CONSTRAINT `productpicts_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `products` (`id_product`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`id_seller`) REFERENCES `sellers` (`id_seller`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `sellerverificationcodes`
--
ALTER TABLE `sellerverificationcodes`
  ADD CONSTRAINT `sellerverificationcodes_ibfk_1` FOREIGN KEY (`id_seller`) REFERENCES `sellers` (`id_seller`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
