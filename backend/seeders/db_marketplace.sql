-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 11 Bulan Mei 2025 pada 11.21
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
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `admins`
--

INSERT INTO `admins` (`id_admin`, `username`, `password`, `admin_name`, `admin_address`, `admin_phone`, `admin_photo`, `status`, `createdAt`, `updatedAt`) VALUES
(1, 'ari', '234', NULL, NULL, NULL, NULL, 'diterima', '2025-05-02 16:49:09', '2025-05-03 08:17:36'),
(2, 'ari2', '123', NULL, NULL, NULL, NULL, 'diterima', '2025-05-02 16:57:45', '2025-05-03 08:17:28'),
(3, 'ari27', '127', NULL, NULL, NULL, NULL, 'belum diterima', '2025-05-02 17:00:57', '2025-05-05 14:23:05'),
(4, 'ari22', '121', NULL, 'jl pala', NULL, NULL, 'belum diterima', '2025-05-02 17:02:20', '2025-05-02 17:02:20'),
(5, 'wkrenklwen', 'slkdfnk', NULL, 'fslkdnfks', NULL, NULL, 'belum diterima', '2025-05-03 04:16:36', '2025-05-03 04:16:36'),
(6, 'wkrenklwenskldf', 'slkdnf', NULL, 'fsldkfn', NULL, NULL, 'belum diterima', '2025-05-03 04:16:41', '2025-05-03 04:16:41'),
(7, 'sdlmfnslknf', 'klsndflksndf', NULL, 'slkdfnksn', NULL, NULL, 'belum diterima', '2025-05-03 04:16:48', '2025-05-03 04:16:48'),
(8, 'sdlmawda', 'sad', NULL, 'sf', NULL, NULL, 'belum diterima', '2025-05-03 04:16:53', '2025-05-03 04:16:53'),
(9, 'fajarw', '1234', NULL, NULL, '087850366625', NULL, 'belum diterima', '2025-05-07 04:27:51', '2025-05-07 04:27:51'),
(10, 'fajar2', '1234', NULL, NULL, '0878503666257', NULL, 'belum diterima', '2025-05-07 06:00:17', '2025-05-07 06:00:17');

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
(33, 'Keris Panji Mataram', 4000000, 1, 3, 'aktif', 'Keris 1', 1, '2025-04-30 04:27:54', '2025-05-05 05:37:06'),
(34, 'Keris Surya Kencana', 3000000, 1, 2, 'aktif', 'Keris 2', 1, '2025-04-30 04:28:27', '2025-05-03 16:27:27'),
(35, 'Keris Kyai Carubuk', 3500000, 1, 0, 'aktif', 'Keris 3', 1, '2025-04-30 04:28:55', '2025-04-30 04:50:05'),
(36, 'Keris Rakian Naga', 4500000, 1, 0, 'aktif', 'Keris 4', 1, '2025-04-30 04:29:34', '2025-04-30 04:50:05'),
(37, 'Keris Nagasasra', 5000000, 1, 0, 'aktif', 'Keris 5', 1, '2025-04-30 04:32:00', '2025-04-30 04:49:58'),
(38, 'Keris Kalamisani', 2700000, 1, 0, 'aktif', 'Keris 1', 3, '2025-04-30 04:33:49', '2025-04-30 04:33:49'),
(39, 'Keris Pamungkas Seta', 3600000, 1, 0, 'aktif', 'Keris 2', 3, '2025-04-30 04:34:17', '2025-04-30 04:34:17'),
(40, 'Keris Sanghyang Pamenang', 4200000, 1, 0, 'aktif', 'Keris 3', 3, '2025-04-30 04:34:50', '2025-04-30 04:34:50'),
(41, 'Keris Lindu Aji', 3800000, 1, 0, 'aktif', 'Keris 4', 3, '2025-04-30 04:35:20', '2025-04-30 04:35:20'),
(42, 'Keris Ratu Pameling', 1900000, 1, 0, 'aktif', 'Keris 5', 3, '2025-04-30 04:36:26', '2025-04-30 04:36:26'),
(43, 'Keris Nogososro', 2600000, 1, 0, 'aktif', 'Keris 1', 2, '2025-04-30 04:44:04', '2025-04-30 04:44:04'),
(45, 'Keris Kyai Sengkelat', 3700000, 1, 4, 'aktif', 'Keris 2', 2, '2025-04-30 04:44:43', '2025-05-05 05:37:28');

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
(1, 'ari3', '2344', 'ari fauzi', 'jl Sapeken no.5 blok kk', '082335838167', 'images/user_images/1746288861166 - 1000012271.jpg', 'diterima', '2025-05-02 16:58:41', '2025-05-03 16:14:21'),
(2, 'ari', '44', 'ari', 'J. Sapeken no. 05', '0823358383167', NULL, 'diterima', '2025-04-23 13:53:50', '2025-05-07 03:48:37'),
(3, 'veri', '335', 'vernanda', 'Jl Tuwowo', '776544321', 'images/user_images/1745988123146 - 1000023222.jpg', 'diterima', '2025-04-27 11:30:50', '2025-04-30 04:42:03'),
(4, 'mawlaz01@gmail.com', '123', 'agiel', 'jl. torjuNNB', '085517290', 'images/user_images/1745939229048 - 1000740200.jpg', 'diterima', '2025-04-29 08:30:10', '2025-05-03 16:25:13'),
(5, 'arifauzi441@gmail.com', '2', NULL, 'fdhhvghh', NULL, NULL, 'belum diterima', '2025-04-30 05:25:32', '2025-05-05 14:45:43'),
(6, 'blabla', '455', NULL, 'jlGaming', NULL, NULL, 'belum diterima', '2025-05-05 13:56:20', '2025-05-05 14:45:42'),
(10, 'fajar', '123', NULL, NULL, '087850366625', NULL, 'diterima', '2025-05-07 04:08:58', '2025-05-07 06:07:11');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id_admin`);

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
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `admins`
--
ALTER TABLE `admins`
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `productpicts`
--
ALTER TABLE `productpicts`
  MODIFY `id_product_pict` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT untuk tabel `products`
--
ALTER TABLE `products`
  MODIFY `id_product` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT untuk tabel `sellers`
--
ALTER TABLE `sellers`
  MODIFY `id_seller` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
