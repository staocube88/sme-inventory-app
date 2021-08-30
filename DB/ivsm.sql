-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 06, 2021 at 07:36 PM
-- Server version: 10.1.32-MariaDB
-- PHP Version: 7.2.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ivsm`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart_tab`
--

CREATE TABLE `cart_tab` (
  `sn` int(11) NOT NULL,
  `cart_id` varchar(50) NOT NULL,
  `order_id` varchar(50) NOT NULL,
  `product_id` varchar(50) NOT NULL,
  `cart_qty` int(11) NOT NULL,
  `unit_price` double NOT NULL,
  `sub_amount` double NOT NULL,
  `staff_id` varchar(50) NOT NULL,
  `order_status_id` varchar(50) NOT NULL,
  `date_entered` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `category_tab`
--

CREATE TABLE `category_tab` (
  `sn` int(11) NOT NULL,
  `category_id` varchar(60) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `date_entered` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `customer_tab`
--

CREATE TABLE `customer_tab` (
  `sn` int(11) NOT NULL,
  `customer_id` varchar(50) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `customer_phone` varchar(100) NOT NULL,
  `customer_email` varchar(100) NOT NULL,
  `date_entered` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `denomination_tab`
--

CREATE TABLE `denomination_tab` (
  `sn` int(11) NOT NULL,
  `denomination_id` varchar(50) NOT NULL,
  `denomination_name` varchar(100) NOT NULL,
  `date_entered` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `denomination_tab`
--

INSERT INTO `denomination_tab` (`sn`, `denomination_id`, `denomination_name`, `date_entered`) VALUES
(1, '001', '100', '2021-01-23 12:36:40'),
(2, '002', '200', '2021-01-23 12:36:40'),
(3, '003', '400', '2021-01-23 12:36:40'),
(4, '004', '500', '2021-01-23 12:36:40'),
(5, '005', '1000', '2021-01-23 12:36:40');

-- --------------------------------------------------------

--
-- Table structure for table `load_product_tab`
--

CREATE TABLE `load_product_tab` (
  `sn` int(11) NOT NULL,
  `lp_id` varchar(50) NOT NULL,
  `product_id` varchar(50) NOT NULL,
  `quantity` int(11) NOT NULL,
  `staff_id` varchar(50) NOT NULL,
  `date_entered` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `load_stock_tab`
--

CREATE TABLE `load_stock_tab` (
  `sn` int(11) NOT NULL,
  `ls_id` varchar(50) NOT NULL,
  `voucher_id` varchar(50) NOT NULL,
  `denomination_id` varchar(50) NOT NULL,
  `qty` double NOT NULL,
  `staff_id` varchar(50) NOT NULL,
  `date_entered` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `master_tab`
--

CREATE TABLE `master_tab` (
  `sn` int(11) NOT NULL,
  `master_id` varchar(50) NOT NULL,
  `master_desc` varchar(100) NOT NULL,
  `master_value` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `master_tab`
--

INSERT INTO `master_tab` (`sn`, `master_id`, `master_desc`, `master_value`) VALUES
(1, 'STAFF', 'STAFF COUNT', '1'),
(2, 'CATEGORY', 'CATEGORY COUNT', '0'),
(3, 'PRODUCT', 'PRODUCT COUNT', '0'),
(4, 'CART', 'CART COUNT', '0'),
(5, 'ORDER', 'ORDER COUNT', '0'),
(6, 'CUSTOMER', 'CUSTOMER COUNT', '0'),
(7, 'LOAD_STOCK', 'STOCK COUNT', '0'),
(8, 'LOAD_PRODUCT', 'LOAD PRODUCT COUNT', '0'),
(9, 'VOUCHER_DENOMINATION', 'VOUCHER DENOMINATION COUNT', '20'),
(10, 'VOUCHER_CART', 'VOUCHER CART COUNT', '0');

-- --------------------------------------------------------

--
-- Table structure for table `order_status_tab`
--

CREATE TABLE `order_status_tab` (
  `sn` int(11) NOT NULL,
  `order_status_id` varchar(50) NOT NULL,
  `order_status_name` varchar(100) NOT NULL,
  `date_entered` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `order_status_tab`
--

INSERT INTO `order_status_tab` (`sn`, `order_status_id`, `order_status_name`, `date_entered`) VALUES
(1, 'S', 'SUCCESSFUL', '2021-01-23 13:09:27'),
(2, 'P', 'PENDING', '2021-01-23 13:09:27');

-- --------------------------------------------------------

--
-- Table structure for table `order_tab`
--

CREATE TABLE `order_tab` (
  `sn` int(11) NOT NULL,
  `order_id` varchar(50) NOT NULL,
  `total_qty` int(11) NOT NULL,
  `total_amount` double NOT NULL,
  `payment_method_id` varchar(50) NOT NULL,
  `otp` varchar(255) NOT NULL,
  `staff_id` varchar(50) NOT NULL,
  `customer_id` varchar(50) NOT NULL,
  `date_entered` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `order_voucher_tab`
--

CREATE TABLE `order_voucher_tab` (
  `sn` int(11) NOT NULL,
  `order_id` varchar(50) NOT NULL,
  `total_qty` int(11) NOT NULL,
  `total_amount` double NOT NULL,
  `payment_method_id` varchar(50) NOT NULL,
  `otp` varchar(50) NOT NULL,
  `payment_type_id` varchar(50) NOT NULL,
  `staff_id` varchar(50) NOT NULL,
  `customer_id` varchar(50) NOT NULL,
  `date_entered` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `payment_method_tab`
--

CREATE TABLE `payment_method_tab` (
  `sn` int(11) NOT NULL,
  `payment_method_id` varchar(50) NOT NULL,
  `payment_method_name` varchar(100) NOT NULL,
  `date_entered` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `payment_method_tab`
--

INSERT INTO `payment_method_tab` (`sn`, `payment_method_id`, `payment_method_name`, `date_entered`) VALUES
(1, '001', 'CASH', '2021-01-23 13:09:27'),
(2, '002', 'BANK TRANSFER', '2021-01-23 13:09:27'),
(3, '003', 'CHEQUE', '2021-01-23 13:09:27'),
(4, '004', 'ONLINE DIRECT PAYMENT', '2021-01-23 13:09:27');

-- --------------------------------------------------------

--
-- Table structure for table `payment_tab`
--

CREATE TABLE `payment_tab` (
  `sn` int(11) NOT NULL,
  `order_id` varchar(50) NOT NULL,
  `total_amount` double NOT NULL,
  `staff_id` varchar(50) NOT NULL,
  `customer_id` varchar(50) NOT NULL,
  `date_entered` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `payment_type_tab`
--

CREATE TABLE `payment_type_tab` (
  `sn` int(11) NOT NULL,
  `payment_type_id` varchar(50) NOT NULL,
  `payment_type_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `payment_type_tab`
--

INSERT INTO `payment_type_tab` (`sn`, `payment_type_id`, `payment_type_name`) VALUES
(1, '001', 'FULL'),
(2, '002', 'CREDIT');

-- --------------------------------------------------------

--
-- Table structure for table `product_tab`
--

CREATE TABLE `product_tab` (
  `sn` int(11) NOT NULL,
  `category_id` varchar(50) NOT NULL,
  `product_id` varchar(50) NOT NULL,
  `product_name` varchar(300) NOT NULL,
  `product_details` text NOT NULL,
  `product_price` double NOT NULL,
  `product_status` varchar(50) NOT NULL,
  `product_picture` varchar(255) NOT NULL,
  `date_entered` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `role_tab`
--

CREATE TABLE `role_tab` (
  `sn` int(11) NOT NULL,
  `role_id` varchar(20) NOT NULL,
  `role_name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `role_tab`
--

INSERT INTO `role_tab` (`sn`, `role_id`, `role_name`) VALUES
(1, 'A', 'ADMIN'),
(2, 'S', 'STAFF');

-- --------------------------------------------------------

--
-- Table structure for table `staff_tab`
--

CREATE TABLE `staff_tab` (
  `sn` int(11) NOT NULL,
  `user_id` varchar(100) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `phone_number` varchar(50) NOT NULL,
  `email_address` varchar(100) NOT NULL,
  `passport` varchar(255) NOT NULL,
  `status_id` varchar(50) NOT NULL,
  `role_id` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `otp` varchar(50) NOT NULL,
  `last_login_date` datetime NOT NULL,
  `date_entered` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `staff_tab`
--

INSERT INTO `staff_tab` (`sn`, `user_id`, `first_name`, `last_name`, `address`, `phone_number`, `email_address`, `passport`, `status_id`, `role_id`, `password`, `otp`, `last_login_date`, `date_entered`) VALUES
(1, 'STAFF1', 'IDRIS', 'ABIODUN', 'ODE REMO', '07069576909', 'idris@gmail.com', '202104063434ffac89e5-84ab-416d-8b37-a6a6e87909df.jpg', 'A', 'A', 'b59c67bf196a4758191e42f76670ceba', '410995', '2021-04-06 18:27:09', '2021-04-06 18:34:34');

-- --------------------------------------------------------

--
-- Table structure for table `status_tab`
--

CREATE TABLE `status_tab` (
  `sn` int(11) NOT NULL,
  `status_id` varchar(20) NOT NULL,
  `status_name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `status_tab`
--

INSERT INTO `status_tab` (`sn`, `status_id`, `status_name`) VALUES
(1, 'A', 'ACTIVE'),
(2, 'S', 'SUSPENDED'),
(3, 'P', 'PENDING');

-- --------------------------------------------------------

--
-- Table structure for table `voucher_cart_tab`
--

CREATE TABLE `voucher_cart_tab` (
  `sn` int(11) NOT NULL,
  `vc_id` varchar(50) NOT NULL,
  `order_id` varchar(50) NOT NULL,
  `vd_id` varchar(50) NOT NULL,
  `order_qty` int(11) NOT NULL,
  `unit_price` double NOT NULL,
  `sub_amount` double NOT NULL,
  `staff_id` varchar(50) NOT NULL,
  `order_status_id` varchar(50) NOT NULL,
  `date_entered` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `voucher_denomination_tab`
--

CREATE TABLE `voucher_denomination_tab` (
  `sn` int(11) NOT NULL,
  `vd_id` varchar(50) NOT NULL,
  `voucher_id` varchar(50) NOT NULL,
  `denomination_id` varchar(50) NOT NULL,
  `unit_price` double NOT NULL,
  `staff_id` varchar(50) NOT NULL,
  `date_entered` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `voucher_denomination_tab`
--

INSERT INTO `voucher_denomination_tab` (`sn`, `vd_id`, `voucher_id`, `denomination_id`, `unit_price`, `staff_id`, `date_entered`) VALUES
(1, 'VOUCHER_DENOMINATION1', '001', '001', 97, 'STAFF1', '2021-01-27 13:04:53'),
(2, 'VOUCHER_DENOMINATION2', '001', '002', 194, 'STAFF1', '2021-01-27 13:20:52'),
(3, 'VOUCHER_DENOMINATION3', '001', '003', 388, 'STAFF1', '2021-01-27 14:38:47'),
(4, 'VOUCHER_DENOMINATION4', '001', '004', 485, 'STAFF1', '2021-01-27 14:40:01'),
(5, 'VOUCHER_DENOMINATION5', '001', '005', 970, 'STAFF1', '2021-01-27 14:40:12'),
(6, 'VOUCHER_DENOMINATION6', '002', '001', 96, 'STAFF1', '2021-01-27 14:40:22'),
(7, 'VOUCHER_DENOMINATION7', '002', '002', 192, 'STAFF1', '2021-01-27 14:40:43'),
(8, 'VOUCHER_DENOMINATION8', '002', '003', 384, 'STAFF1', '2021-01-27 14:41:06'),
(9, 'VOUCHER_DENOMINATION9', '002', '004', 480, 'STAFF1', '2021-01-27 14:41:28'),
(10, 'VOUCHER_DENOMINATION10', '002', '005', 960, 'STAFF1', '2021-01-27 14:41:39'),
(11, 'VOUCHER_DENOMINATION11', '003', '001', 96, 'STAFF1', '2021-01-27 14:42:01'),
(12, 'VOUCHER_DENOMINATION12', '003', '002', 192, 'STAFF1', '2021-01-27 14:42:13'),
(13, 'VOUCHER_DENOMINATION13', '003', '003', 384, 'STAFF1', '2021-01-27 14:45:27'),
(14, 'VOUCHER_DENOMINATION14', '003', '004', 480, 'STAFF1', '2021-01-27 14:45:39'),
(15, 'VOUCHER_DENOMINATION15', '003', '005', 960, 'STAFF1', '2021-01-27 14:45:59'),
(16, 'VOUCHER_DENOMINATION16', '004', '001', 95, 'STAFF1', '2021-01-27 14:47:56'),
(17, 'VOUCHER_DENOMINATION17', '004', '002', 190, 'STAFF1', '2021-01-27 14:48:23'),
(18, 'VOUCHER_DENOMINATION18', '004', '003', 380, 'STAFF1', '2021-01-27 14:48:43'),
(19, 'VOUCHER_DENOMINATION19', '004', '004', 475, 'STAFF1', '2021-01-27 14:49:02'),
(20, 'VOUCHER_DENOMINATION20', '004', '005', 950, 'STAFF1', '2021-01-27 14:49:17');

-- --------------------------------------------------------

--
-- Table structure for table `voucher_tab`
--

CREATE TABLE `voucher_tab` (
  `sn` int(11) NOT NULL,
  `voucher_id` varchar(50) NOT NULL,
  `voucher_name` varchar(100) NOT NULL,
  `date_entered` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `voucher_tab`
--

INSERT INTO `voucher_tab` (`sn`, `voucher_id`, `voucher_name`, `date_entered`) VALUES
(1, '001', 'MTN', '2021-01-23 12:36:40'),
(2, '002', 'GLO', '2021-01-23 12:36:40'),
(3, '003', 'AIRTEL', '2021-01-23 12:36:40'),
(4, '004', '9 MOBILE', '2021-01-23 12:36:40');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart_tab`
--
ALTER TABLE `cart_tab`
  ADD PRIMARY KEY (`sn`);

--
-- Indexes for table `category_tab`
--
ALTER TABLE `category_tab`
  ADD PRIMARY KEY (`sn`);

--
-- Indexes for table `customer_tab`
--
ALTER TABLE `customer_tab`
  ADD PRIMARY KEY (`sn`);

--
-- Indexes for table `denomination_tab`
--
ALTER TABLE `denomination_tab`
  ADD PRIMARY KEY (`sn`);

--
-- Indexes for table `load_product_tab`
--
ALTER TABLE `load_product_tab`
  ADD PRIMARY KEY (`sn`);

--
-- Indexes for table `load_stock_tab`
--
ALTER TABLE `load_stock_tab`
  ADD PRIMARY KEY (`sn`);

--
-- Indexes for table `master_tab`
--
ALTER TABLE `master_tab`
  ADD PRIMARY KEY (`sn`);

--
-- Indexes for table `order_status_tab`
--
ALTER TABLE `order_status_tab`
  ADD PRIMARY KEY (`sn`);

--
-- Indexes for table `order_tab`
--
ALTER TABLE `order_tab`
  ADD PRIMARY KEY (`sn`);

--
-- Indexes for table `order_voucher_tab`
--
ALTER TABLE `order_voucher_tab`
  ADD PRIMARY KEY (`sn`);

--
-- Indexes for table `payment_method_tab`
--
ALTER TABLE `payment_method_tab`
  ADD PRIMARY KEY (`sn`);

--
-- Indexes for table `payment_tab`
--
ALTER TABLE `payment_tab`
  ADD PRIMARY KEY (`sn`);

--
-- Indexes for table `payment_type_tab`
--
ALTER TABLE `payment_type_tab`
  ADD PRIMARY KEY (`sn`);

--
-- Indexes for table `product_tab`
--
ALTER TABLE `product_tab`
  ADD PRIMARY KEY (`sn`);

--
-- Indexes for table `role_tab`
--
ALTER TABLE `role_tab`
  ADD PRIMARY KEY (`sn`);

--
-- Indexes for table `staff_tab`
--
ALTER TABLE `staff_tab`
  ADD PRIMARY KEY (`sn`);

--
-- Indexes for table `status_tab`
--
ALTER TABLE `status_tab`
  ADD PRIMARY KEY (`sn`);

--
-- Indexes for table `voucher_cart_tab`
--
ALTER TABLE `voucher_cart_tab`
  ADD PRIMARY KEY (`sn`);

--
-- Indexes for table `voucher_denomination_tab`
--
ALTER TABLE `voucher_denomination_tab`
  ADD PRIMARY KEY (`sn`);

--
-- Indexes for table `voucher_tab`
--
ALTER TABLE `voucher_tab`
  ADD PRIMARY KEY (`sn`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart_tab`
--
ALTER TABLE `cart_tab`
  MODIFY `sn` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `category_tab`
--
ALTER TABLE `category_tab`
  MODIFY `sn` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customer_tab`
--
ALTER TABLE `customer_tab`
  MODIFY `sn` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `denomination_tab`
--
ALTER TABLE `denomination_tab`
  MODIFY `sn` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `load_product_tab`
--
ALTER TABLE `load_product_tab`
  MODIFY `sn` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `load_stock_tab`
--
ALTER TABLE `load_stock_tab`
  MODIFY `sn` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_tab`
--
ALTER TABLE `master_tab`
  MODIFY `sn` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `order_status_tab`
--
ALTER TABLE `order_status_tab`
  MODIFY `sn` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `order_tab`
--
ALTER TABLE `order_tab`
  MODIFY `sn` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_voucher_tab`
--
ALTER TABLE `order_voucher_tab`
  MODIFY `sn` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_method_tab`
--
ALTER TABLE `payment_method_tab`
  MODIFY `sn` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `payment_tab`
--
ALTER TABLE `payment_tab`
  MODIFY `sn` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_type_tab`
--
ALTER TABLE `payment_type_tab`
  MODIFY `sn` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `product_tab`
--
ALTER TABLE `product_tab`
  MODIFY `sn` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `role_tab`
--
ALTER TABLE `role_tab`
  MODIFY `sn` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `staff_tab`
--
ALTER TABLE `staff_tab`
  MODIFY `sn` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `status_tab`
--
ALTER TABLE `status_tab`
  MODIFY `sn` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `voucher_cart_tab`
--
ALTER TABLE `voucher_cart_tab`
  MODIFY `sn` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `voucher_denomination_tab`
--
ALTER TABLE `voucher_denomination_tab`
  MODIFY `sn` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `voucher_tab`
--
ALTER TABLE `voucher_tab`
  MODIFY `sn` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
