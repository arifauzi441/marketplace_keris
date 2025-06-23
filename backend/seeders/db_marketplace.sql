-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 23 Jun 2025 pada 04.28
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
(1, 'ari', '234', NULL, NULL, NULL, NULL, 'diterima', '2025-05-02 16:49:09', '2025-06-22 23:00:42', 'eCcRoRdBT9Km3cV4CyDWoR:APA91bG-H2-Mpj_jeUDFc4tM-OFn2dkJhubLsVpKAbRcf4-GhG2nUekNO0T_777fZGOQimUIJcoEcVMnVYBOypmusLct4nNThHrZ7AxgbPvcSKWTwR6trhE'),
(2, 'ari2', '123', NULL, NULL, NULL, NULL, 'diterima', '2025-05-02 16:57:45', '2025-05-03 08:17:28', NULL),
(3, 'ari27', '127', NULL, NULL, NULL, NULL, 'belum diterima', '2025-05-02 17:00:57', '2025-05-05 14:23:05', NULL),
(4, 'ari22', '121', NULL, 'jl pala', NULL, NULL, 'belum diterima', '2025-05-02 17:02:20', '2025-05-02 17:02:20', NULL),
(5, 'wkrenklwen', 'slkdfnk', NULL, 'fslkdnfks', NULL, NULL, 'belum diterima', '2025-05-03 04:16:36', '2025-05-03 04:16:36', NULL),
(6, 'wkrenklwenskldf', 'slkdnf', NULL, 'fsldkfn', NULL, NULL, 'belum diterima', '2025-05-03 04:16:41', '2025-05-03 04:16:41', NULL),
(7, 'sdlmfnslknf', 'klsndflksndf', NULL, 'slkdfnksn', NULL, NULL, 'belum diterima', '2025-05-03 04:16:48', '2025-05-03 04:16:48', NULL),
(8, 'sdlmawda', 'sad', NULL, 'sf', NULL, NULL, 'belum diterima', '2025-05-03 04:16:53', '2025-05-03 04:16:53', NULL),
(9, 'fajarw', 'sadi', NULL, NULL, '087850366625', NULL, 'diterima', '2025-05-07 04:27:51', '2025-06-10 17:17:23', 'eCcRoRdBT9Km3cV4CyDWoR:APA91bG-H2-Mpj_jeUDFc4tM-OFn2dkJhubLsVpKAbRcf4-GhG2nUekNO0T_777fZGOQimUIJcoEcVMnVYBOypmusLct4nNThHrZ7AxgbPvcSKWTwR6trhE'),
(10, 'fajar2', '1234', NULL, NULL, '0878503666257', NULL, 'belum diterima', '2025-05-07 06:00:17', '2025-05-07 06:00:17', NULL),
(11, 'ibram', 'bjir', NULL, NULL, '085852769382', NULL, 'diterima', '2025-05-19 06:32:59', '2025-05-19 06:34:32', NULL),
(12, 'hiFatih', 'aaaa', 'Rahmat Al Fatih', NULL, '0009988765', NULL, 'belum diterima', '2025-05-23 14:07:45', '2025-05-23 14:07:45', NULL),
(13, 'gsgs', '62ywy', 'ysysts', NULL, '5464845', NULL, 'belum diterima', '2025-05-27 14:52:06', '2025-05-27 14:52:06', NULL),
(14, 'hfcgh', 'hgffg', 'sdgg', NULL, '65568', NULL, 'belum diterima', '2025-06-04 05:10:47', '2025-06-04 05:10:47', NULL),
(15, 'fgg', 'ffg', 'dgg', NULL, '889', NULL, 'belum diterima', '2025-06-12 07:48:01', '2025-06-12 07:48:01', NULL),
(16, 'vah', 'gavag', 'gabha', NULL, '11111', NULL, 'belum diterima', '2025-06-12 08:06:48', '2025-06-12 08:06:48', NULL);

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
(11, 280715, '2025-05-19 06:34:48', 11, '2025-05-19 06:33:48', '2025-05-19 06:33:48'),
(12, 761313, '2025-06-09 00:22:09', 9, '2025-06-09 00:21:09', '2025-06-09 00:21:09'),
(13, 481859, '2025-06-09 00:22:57', 9, '2025-06-09 00:21:57', '2025-06-09 00:21:57'),
(14, 197014, '2025-06-10 17:05:28', 9, '2025-06-10 17:04:28', '2025-06-10 17:04:28'),
(15, 854696, '2025-06-10 17:06:24', 9, '2025-06-10 17:05:24', '2025-06-10 17:05:24'),
(16, 372354, '2025-06-10 17:07:02', 9, '2025-06-10 17:06:02', '2025-06-10 17:06:02'),
(17, 873090, '2025-06-10 17:07:47', 9, '2025-06-10 17:06:47', '2025-06-10 17:06:47'),
(18, 757818, '2025-06-10 17:08:15', 9, '2025-06-10 17:07:15', '2025-06-10 17:07:15'),
(19, 640418, '2025-06-10 17:10:46', 9, '2025-06-10 17:09:46', '2025-06-10 17:09:46'),
(20, 903453, '2025-06-10 17:13:11', 9, '2025-06-10 17:12:11', '2025-06-10 17:12:11'),
(21, 812594, '2025-06-10 17:16:05', 9, '2025-06-10 17:15:05', '2025-06-10 17:15:05'),
(22, 921263, '2025-06-10 17:18:02', 9, '2025-06-10 17:17:02', '2025-06-10 17:17:02');

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
(84, 'images/product_images/1745987307510 - 1000033177.jpg', 34, '2025-04-30 04:28:27', '2025-04-30 04:28:27'),
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
(101, 'images/product_images/1745988283005 - 1000032496.jpg', 45, '2025-04-30 04:44:43', '2025-04-30 04:44:43'),
(103, 'images/product_images/1750633018870 - product35Photo1750632998511.png', 35, '2025-06-22 22:56:58', '2025-06-22 22:56:58');

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
(34, 'Keris Surya Kencana', 3000000, 1, 7, 'aktif', 'Keris 2', 1, '2025-04-30 04:28:27', '2025-06-12 05:32:57'),
(35, 'Keris Kyai Carubuk gg gaming', 3500000, 1, 1, 'aktif', 'Keris 3', 1, '2025-04-30 04:28:55', '2025-06-22 22:56:58'),
(36, 'Keris Rakian Naga', 4500000, 1, 0, 'aktif', 'Keris 4', 1, '2025-04-30 04:29:34', '2025-04-30 04:50:05'),
(37, 'Keris Nagasasra', 5000000, 1, 0, 'aktif', 'Keris 5', 1, '2025-04-30 04:32:00', '2025-06-11 22:30:36'),
(38, 'Keris Kalamisani', 2700000, 1, 0, 'aktif', 'Keris 1', 3, '2025-04-30 04:33:49', '2025-04-30 04:33:49'),
(39, 'Keris Pamungkas Seta', 3600000, 1, 0, 'aktif', 'Keris 2', 3, '2025-04-30 04:34:17', '2025-04-30 04:34:17'),
(40, 'Keris Sanghyang Pamenang', 4200000, 1, 0, 'aktif', 'Keris 3', 3, '2025-04-30 04:34:50', '2025-04-30 04:34:50'),
(41, 'Keris Lindu Aji', 3800000, 1, 1, 'aktif', 'Keris 4', 3, '2025-04-30 04:35:20', '2025-06-10 16:29:12'),
(42, 'Keris Ratu Pameling', 1900000, 1, 0, 'aktif', 'Keris 5', 3, '2025-04-30 04:36:26', '2025-04-30 04:36:26'),
(43, 'Keris Nogososro', 2600000, 1, 0, 'aktif', 'Keris 1', 2, '2025-04-30 04:44:04', '2025-04-30 04:44:04'),
(45, 'Keris Kyai Sengkelat', 3700000, 1, 5, 'aktif', 'Keris 2', 2, '2025-04-30 04:44:43', '2025-06-12 05:33:02'),
(46, 'keris q', 30000, 5, 2, 'aktif', 'aksjdbkajsbdjb', 13, '2025-05-21 03:32:43', '2025-06-05 05:08:34');

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
(1, 'ari3', 'lll', 'ari fauzi', 'jl Sapeken no.5 blok kk', '082335838167', NULL, 'diterima', '2025-05-02 16:58:41', '2025-06-22 22:54:19'),
(2, 'ari', '44', 'Ibram Maulana', 'pabian', '085852769382', 'images/user_images/1749099580750 - 1000092219.jpg', 'diterima', '2025-04-23 13:53:50', '2025-06-05 04:59:40'),
(3, 'veri', '335', 'vernanda', 'Jl Tuwowo', '081216679709', 'images/user_images/1749099454693 - 1000092213.jpg', 'diterima', '2025-04-27 11:30:50', '2025-06-05 04:57:35'),
(4, 'mawlaz', '123', 'agiel', 'jl. torjuNNB', '085517290', 'images/user_images/1749099636824 - 1000092215.jpg', 'diterima', '2025-04-29 08:30:10', '2025-06-05 05:00:37'),
(5, 'arifauzi441@gmail.com', '2', NULL, 'fdhhvghh', NULL, NULL, 'belum diterima', '2025-04-30 05:25:32', '2025-06-04 05:09:31'),
(6, 'blabla', '455', NULL, 'jlGaming', NULL, NULL, 'belum diterima', '2025-05-05 13:56:20', '2025-05-05 14:45:42'),
(10, 'fajar', 'fajar', NULL, NULL, '087850366625', NULL, 'belum diterima', '2025-05-07 04:08:58', '2025-06-10 16:36:56'),
(12, 'fatih', 'gokil', NULL, NULL, '082140651676', NULL, 'belum diterima', '2025-05-19 04:28:40', '2025-05-23 13:53:00'),
(13, 'qasasi', '553', NULL, NULL, '0874783624', NULL, 'belum diterima', '2025-05-21 03:28:22', '2025-06-22 23:01:34'),
(14, 'Qasasi56', 'gokil', NULL, NULL, '082336667', NULL, 'belum diterima', '2025-05-23 13:48:34', '2025-06-22 23:01:04'),
(15, 'king szrc', 'gokil', 'Danang Susetyo P.', NULL, '088777666543', NULL, 'belum diterima', '2025-05-23 13:56:09', '2025-05-25 12:58:42'),
(16, 'sdfsdf', 'wsefsdf', 'sdfsf', NULL, '234234', NULL, 'belum diterima', '2025-05-23 17:21:05', '2025-05-23 17:21:05'),
(17, 'imryzo', '33', 'aqil yoga', 'dakdul', '089531322122', 'images/user_images/1749100021695 - 1000092217.jpg', 'diterima', '2025-05-25 11:41:26', '2025-06-05 05:07:01'),
(18, 'thertuen', '555', 'fauzi', NULL, '085852586638', NULL, 'belum diterima', '2025-05-27 14:49:18', '2025-05-27 14:49:18'),
(19, 'gqgqvq', 'vavqv', 'fahga', NULL, '6484848', NULL, 'belum diterima', '2025-05-27 14:52:50', '2025-05-27 14:52:50'),
(20, 'thereturn', '678', 'Ahmad Ari Fauzi', NULL, '088855325658', NULL, 'belum diterima', '2025-05-27 15:38:08', '2025-05-27 15:38:08'),
(21, 'orca', 'bsbsj', 'IBRAM ORAC', NULL, '34584649464', NULL, 'belum diterima', '2025-05-28 04:52:35', '2025-05-28 04:52:35'),
(22, 'Pramono', '2344', 'Aqil Yoga', NULL, '08854376192', NULL, 'belum diterima', '2025-05-28 05:04:13', '2025-05-28 05:04:13'),
(23, 'gsggsg', 'geu7dg', 'hshshs', NULL, '6494848480', NULL, 'belum diterima', '2025-06-04 05:12:47', '2025-06-04 05:12:47'),
(24, 'dafahtml', 'ggg', 'dafa fahrisi', '', '08548764861', 'images/user_images/1749099069192 - 1000092213.jpg', 'belum diterima', '2025-06-04 06:05:33', '2025-06-05 04:58:21'),
(25, 'dgggg', 'vghhb', 'ffgh', NULL, '556688565', NULL, 'belum diterima', '2025-06-10 16:37:24', '2025-06-10 16:37:24'),
(26, 'ggg', 'ggg', 'hhh', NULL, '333', NULL, 'belum diterima', '2025-06-10 17:02:48', '2025-06-10 17:02:48');

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
(51, 712841, '2025-05-19 06:00:56', 1, '2025-05-19 05:59:56', '2025-05-19 05:59:56'),
(52, 388413, '2025-06-09 00:02:11', 1, '2025-06-09 00:01:11', '2025-06-09 00:01:11'),
(53, 617457, '2025-06-09 00:03:51', 1, '2025-06-09 00:02:51', '2025-06-09 00:02:51'),
(54, 905479, '2025-06-09 00:04:01', 1, '2025-06-09 00:03:01', '2025-06-09 00:03:01'),
(55, 384660, '2025-06-09 00:04:23', 1, '2025-06-09 00:03:23', '2025-06-09 00:03:23'),
(56, 531632, '2025-06-09 00:05:38', 1, '2025-06-09 00:04:38', '2025-06-09 00:04:38'),
(57, 111721, '2025-06-09 00:06:19', 1, '2025-06-09 00:05:19', '2025-06-09 00:05:19'),
(58, 898613, '2025-06-09 00:12:28', 10, '2025-06-09 00:11:28', '2025-06-09 00:11:28'),
(59, 195396, '2025-06-09 00:17:20', 10, '2025-06-09 00:16:20', '2025-06-09 00:16:20'),
(60, 548492, '2025-06-10 16:58:47', 1, '2025-06-10 16:57:47', '2025-06-10 16:57:47'),
(61, 604825, '2025-06-10 16:59:15', 1, '2025-06-10 16:58:15', '2025-06-10 16:58:15'),
(62, 455856, '2025-06-10 17:01:55', 1, '2025-06-10 17:00:55', '2025-06-10 17:00:55'),
(63, 938128, '2025-06-10 17:03:11', 1, '2025-06-10 17:02:11', '2025-06-10 17:02:11'),
(64, 993289, '2025-06-10 17:18:57', 1, '2025-06-10 17:17:57', '2025-06-10 17:17:57'),
(65, 663402, '2025-06-10 17:19:39', 1, '2025-06-10 17:18:39', '2025-06-10 17:18:39'),
(66, 240785, '2025-06-11 06:56:14', 1, '2025-06-11 06:55:14', '2025-06-11 06:55:14'),
(67, 579742, '2025-06-11 06:58:10', 1, '2025-06-11 06:57:10', '2025-06-11 06:57:10'),
(68, 656571, '2025-06-22 22:54:51', 1, '2025-06-22 22:53:52', '2025-06-22 22:53:52');

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
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT untuk tabel `adminverificationcodes`
--
ALTER TABLE `adminverificationcodes`
  MODIFY `id_verification_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT untuk tabel `productpicts`
--
ALTER TABLE `productpicts`
  MODIFY `id_product_pict` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT untuk tabel `products`
--
ALTER TABLE `products`
  MODIFY `id_product` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT untuk tabel `sellers`
--
ALTER TABLE `sellers`
  MODIFY `id_seller` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT untuk tabel `sellerverificationcodes`
--
ALTER TABLE `sellerverificationcodes`
  MODIFY `id_verification_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

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
