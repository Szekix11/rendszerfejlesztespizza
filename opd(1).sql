-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2023. Okt 04. 22:49
-- Kiszolgáló verziója: 10.4.28-MariaDB
-- PHP verzió: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `opd`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `categories`
--

CREATE TABLE `categories` (
  `categorieId` int(12) NOT NULL,
  `categorieName` varchar(255) NOT NULL,
  `categorieDesc` text NOT NULL,
  `categorieCreateDate` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `categories`
--

INSERT INTO `categories` (`categorieId`, `categorieName`, `categorieDesc`, `categorieCreateDate`) VALUES
(1, 'Zöldség PIZZA', 'Egy gyönyörűség a zöldség szerelmeseinek! Válassz széles választékunkból finom vegetáriánus pizzáink közül, puha és ízletes.', '2023-10-04 00:00:00'),
(2, 'Hússal PIZZA', 'Válassza ki kedvenc hússal pizzáit a Domino\'s Pizza étlapjáról. Friss húsos pizza választékunkat megrendelheti kedvenc kéreggel és feltétekkel.', '2023-10-04 00:00:00'),
(3, 'PIZZA MANIA', 'Merüljön el a Pizza mania kínálta ízletes ízekben, a tökéletes válasz minden étvágy csillapításához.', '2023-10-04 00:00:00'),
(4, 'KÖRET', 'Egészítse ki pizzáját széles körű köretekkel, amelyek a Domino\'s Pizza India kínálatában találhatók.', '2023-10-04 00:00:00'),
(5, 'ITAL ÜDÍTŐK', 'Egészítse ki pizzáját széles italkínálattal, amely a Domino\'s Pizza India kínálatában található.', '2023-10-04 00:00:00'),
(6, 'CRUST VÁLASZTÉK', 'Friss Pan Pizza. A legfinomabb pan pizza. ... Domino\'s frissen készült serpenyős pizzája; ízletesen puha, vajos, extra sajtos és örömteli ropogós.', '2023-10-04 00:00:00'),
(7, 'BURGER PIZZA', 'Domino\'s Pizza bemutatja az új Burger Pizzát azzal a szlogenjével, hogy úgy néz ki, mint egy burger, de úgy ízlik, mint egy pizza. A Burger Pizza burger méretű, de egy kis pizzadobozban érkezik. Pizzabevonatokkal, mint például fűszerek, zöldségek, paradicsomszósz és mozzarella.', '2023-10-04 00:00:00'),
(8, 'TÖLTELÉK VÁLASZTÉK', 'TÖLTELÉK VÁLASZTÉK', '2023-10-04 00:00:00');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `contact`
--

CREATE TABLE `contact` (
  `contactId` int(21) NOT NULL,
  `userId` int(21) NOT NULL,
  `email` varchar(35) NOT NULL,
  `phoneNo` bigint(21) NOT NULL,
  `orderId` int(21) NOT NULL DEFAULT 0 COMMENT 'If problem is not related to the order then order id = 0',
  `message` text NOT NULL,
  `time` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `contact`
--

INSERT INTO `contact` (`contactId`, `userId`, `email`, `phoneNo`, `orderId`, `message`, `time`) VALUES
(1, 2, 'szekix16@gmail.com', 5362517622, 1, 'Romlott volt a sajt.', '2023-10-04 15:04:17');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `contactreply`
--

CREATE TABLE `contactreply` (
  `id` int(21) NOT NULL,
  `contactId` int(21) NOT NULL,
  `userId` int(23) NOT NULL,
  `message` text NOT NULL,
  `datetime` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `deliverydetails`
--

CREATE TABLE `deliverydetails` (
  `id` int(21) NOT NULL,
  `orderId` int(21) NOT NULL,
  `deliveryBoyName` varchar(35) NOT NULL,
  `deliveryBoyPhoneNo` bigint(25) NOT NULL,
  `deliveryTime` int(200) NOT NULL COMMENT 'Time in minutes',
  `dateTime` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `orderitems`
--

CREATE TABLE `orderitems` (
  `id` int(21) NOT NULL,
  `orderId` int(21) NOT NULL,
  `pizzaId` int(21) NOT NULL,
  `itemQuantity` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `orderitems`
--

INSERT INTO `orderitems` (`id`, `orderId`, `pizzaId`, `itemQuantity`) VALUES
(1, 1, 21, 7),
(2, 1, 30, 8),
(3, 1, 15, 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `orders`
--

CREATE TABLE `orders` (
  `orderId` int(21) NOT NULL,
  `userId` int(21) NOT NULL,
  `address` varchar(255) NOT NULL,
  `zipCode` int(21) NOT NULL,
  `phoneNo` bigint(21) NOT NULL,
  `amount` int(200) NOT NULL,
  `paymentMode` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0=cash on delivery, \r\n1=online ',
  `orderStatus` enum('0','1','2','3','4','5','6') NOT NULL DEFAULT '0' COMMENT '0=Order Placed.\r\n1=Order Confirmed.\r\n2=Preparing your Order.\r\n3=Your order is on the way!\r\n4=Order Delivered.\r\n5=Order Denied.\r\n6=Order Cancelled.',
  `orderDate` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `orders`
--

INSERT INTO `orders` (`orderId`, `userId`, `address`, `zipCode`, `phoneNo`, `amount`, `paymentMode`, `orderStatus`, `orderDate`) VALUES
(1, 2, 'Szeged, Erős utca 5', 232323, 3334434232, 38711, '0', '0', '2023-10-04 15:54:28');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `pizza`
--

CREATE TABLE `pizza` (
  `pizzaId` int(12) NOT NULL,
  `pizzaName` varchar(255) NOT NULL,
  `pizzaPrice` int(12) NOT NULL,
  `pizzaDesc` text NOT NULL,
  `pizzaCategorieId` int(12) NOT NULL,
  `pizzaPubDate` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `pizza`
--

INSERT INTO `pizza` (`pizzaId`, `pizzaName`, `pizzaPrice`, `pizzaDesc`, `pizzaCategorieId`, `pizzaPubDate`) VALUES
(1, 'Margaréta', 2317, 'Egy rendkívül népszerű margaréta pizza, csodálatosan fanyar, egyedülálló sajtos feltéttel.', 1, '2023-10-04 00:00:00'),
(2, 'Dupla Sajtos Margaréta', 2734, 'Az örök népszerűségű Margaréta - extra sajttal megrakva... rengeteg van belőle.', 1, '2023-10-04 00:00:00'),
(3, 'Farm Ház', 2716, 'Egy pizza, amelynek zöldségekben nincs hiány! Nézd meg ezt a szájban összefolyó ropogós paprikát, lédús gombát és friss paradicsomot.', 1, '2023-10-04 00:00:00'),
(4, 'Pikáns Paneer', 2380, 'Darabos paneer ropogós paprikával és fűszeres piros paprikával - igazi csemege!', 1, '2023-10-04 00:00:00'),
(5, 'Mexikói Zöld Hullám', 2751, 'Egy pizza, amely tele van ropogós hagymával, friss paprikával, lédús paradicsommal és jalapenóval, bőséges adag mexikói fűszernövényekkel megszórva.', 1, '2023-10-04 00:00:00'),
(6, 'Deluxe Veggie', 2616, 'A vegetáriánusoknak, akik nagy élményt keresnek, de kevesebbet szeretnének fűszerezni, ez mindent tartalmaz... a hagymát, a paprikát, azokat a válogatott gombákat - paneerrel és arany kukoricával a tetején.', 1, '2023-10-04 00:00:00'),
(7, 'Zöldség Extravagancia', 2825, 'Egy pizza, amely alattomosan meghajol a bőséges kukoricával, exkluzív fekete olajbogyóval, ropogós hagymával, friss paprikával, lédús gombával, szaftos friss paradicsommal és jalapenóval - plusz sajttal mindenhol.', 1, '2023-10-04 00:00:00'),
(8, 'Sajt és Kukorica', 2275, 'Sajt I Arany Kukorica', 1, '2023-10-04 00:00:00'),
(9, 'PANEER MAKHANI', 2905, 'Paneer és Paprika Makhani Szósszal', 1, '2023-10-04 00:00:00'),
(10, 'Zöldség Paradicsom', 2695, 'Goldern Kukorica, Fekete Olajbogyók, Paprika és Piros Paprika', 1, '2023-10-04 00:00:00'),
(11, 'Friss Zöldség', 2762, 'Friss Zöldség', 1, '2023-10-04 00:00:00'),
(12, 'Indi Tandoori Paneer', 2726, 'Forró. Fűszeres. Oh-só-Indiai. Tandoori paneer paprikával, piros paprikával, menta majonézzel.', 1, '2023-10-04 00:00:00'),
(13, 'PEPPER BARBECUE CHICKEN', 2342, 'Borsos Barbecue Csirke I Sajt', 2, '2023-10-04 00:00:00'),
(14, 'CSIRKESZÁRNY', 2532, 'Csirkekolbász I Sajt', 2, '2023-10-04 00:00:00'),
(15, 'Chicken Golden Delight', 2633, 'Mmm! Barbecue csirke arany kukoricával és extra sajttal. Aranyat ér!', 2, '2023-10-04 00:00:00'),
(16, 'Nem Veg Supreme', 2569, 'Harapj a fekete olajbogyók, hagymák, grillezett gombák, Pepper BBQ csirke, Peri-Peri csirke, grillezett csirkeszeletek abszolút élvezetébe.', 2, '2023-10-04 00:00:00'),
(17, 'Chicken Dominator', 2948, 'Tartsd meg ízlelőbimbóidat Dupla Borsos Barbecue Csirke, Peri-Peri Csirke, Csirke Tikka és Grillezett Csirkeszeletek.', 2, '2023-10-04 00:00:00'),
(18, 'PEPPER BARBECUE & ONION', 2030, 'Borsos Barbecue Csirke I Hagyma', 2, '2023-10-04 00:00:00'),
(19, 'CSIRKESZEÁRNY', 2309, 'Grillezett Csirkeszeletek I Peri-Peri Csirke I Hagyma I Paprika', 2, '2023-10-04 00:00:00'),
(20, 'Indi Chicken Tikka', 2455, 'Indi Chicken Tikka', 2, '2023-10-04 00:00:00'),
(21, 'Pomidor', 2346, 'Sajátos paradicsom egy ízletes sajtos szószban.', 3, '2023-10-04 00:00:00'),
(22, 'Zöldségekkel Töltött', 2368, 'Paradicsom | Grillezett Gomba | Jalapeno | Arany Kukorica | Babhüvelykék friss serpenyőben', 3, '2023-10-04 00:00:00'),
(23, 'Sajtos', 2803, 'Sajt I Paradicsom', 3, '2023-10-04 00:00:00'),
(24, 'Paprika', 2908, 'Paprika', 3, '2023-10-04 00:00:00'),
(25, 'Hagyma', 2130, 'Hagyma', 3, '2023-10-04 00:00:00'),
(26, 'Arany Kukorica', 2931, 'Arany Kukorica', 3, '2023-10-04 00:00:00'),
(27, 'PANEER & HAGYMA', 2262, 'Paneer és Hagyma', 3, '2023-10-04 00:00:00'),
(28, 'Sajt és Paradicsom', 2518, 'Sajt és Paradicsom', 3, '2023-10-04 00:00:00'),
(29, 'Fokhagymás Bagetták', 2802, 'Fokhagymás Bagetták', 4, '2023-10-04 00:00:00'),
(30, 'Töltött Fokhagymás Bagetták', 2457, 'Töltött Fokhagymás Bagetták', 4, '2023-10-04 00:00:00'),
(31, 'Veg Pasta Italiano White', 2879, 'Veg Pasta Italiano White', 4, '2023-10-04 00:00:00'),
(32, 'Nem Veg Pasta Italiano White', 2022, 'Nem Veg Pasta Italiano White', 4, '2023-10-04 00:00:00'),
(33, 'Sajtos Jalapeno Mártás', 2477, 'Sajtos Jalapeno Mártás', 4, '2023-10-04 00:00:00'),
(34, 'Sajtos Mártás', 2318, 'Sajtos Mártás', 4, '2023-10-04 00:00:00'),
(35, 'Láva Torta', 2160, 'Láva Torta', 4, '2023-10-04 00:00:00'),
(36, 'Butterscotch Mousse Cake', 2847, 'Butterscotch Mousse Cake', 4, '2023-10-04 00:00:00'),
(37, 'Lipton Jeges Tea', 2751, 'Lipton Jeges Tea', 5, '2023-10-04 00:00:00'),
(38, 'Mirinda', 2212, 'Mirinda', 5, '2023-10-04 00:00:00'),
(39, 'PEPSI BLACK CAN', 2813, 'PEPSI BLACK CAN', 5, '2023-10-04 00:00:00'),
(40, 'Pepsi', 2425, 'Pepsi', 5, '2023-10-04 00:00:00'),
(41, '7Up', 2689, '7Up', 5, '2023-10-04 00:00:00'),
(42, 'Sajt Burst', 2166, 'Sajt Burst', 6, '2023-10-04 00:00:00'),
(43, 'Classic Hand Tossed', 2768, 'Classic Hand Tossed', 6, '2023-10-04 00:00:00'),
(44, 'Búzavékony Tészta', 2337, 'Búzavékony Tészta', 6, '2023-10-04 00:00:00'),
(45, 'Friss Pan Pizza', 2383, 'Friss Pan Pizza', 6, '2023-10-04 00:00:00'),
(46, 'Új kézzel hajtott', 2904, 'Új kézzel hajtott', 6, '2023-10-04 00:00:00'),
(47, 'BURGER PIZZA - CLASSIC VEG', 2369, 'BURGER PIZZA - CLASSIC VEG', 7, '2023-10-04 00:00:00'),
(48, 'BURGER PIZZA - PREMIUM VEG', 2134, 'BURGER PIZZA - PREMIUM VEG', 7, '2023-10-04 00:00:00'),
(49, 'BURGER PIZZA - CLASSIC NON VEG', 2566, 'BURGER PIZZA - CLASSIC NON VEG', 7, '2023-10-04 00:00:00'),
(50, 'Extra Sajt', 2424, 'Extra Sajt', 8, '2023-10-04 00:00:00'),
(51, 'Zöldség Toppings', 2424, 'Zöldség Toppings', 8, '2023-10-04 00:00:00'),
(52, 'Nem Veg Toppings', 2850, 'Nem Veg Toppings', 8, '2023-10-04 00:00:00'),
(53, 'Csomagolt Ivóvíz', 2975, 'Csomagolt Ivóvíz', 5, '2023-10-04 00:00:00');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `sitedetail`
--

CREATE TABLE `sitedetail` (
  `tempId` int(11) NOT NULL,
  `systemName` varchar(21) NOT NULL,
  `email` varchar(35) NOT NULL,
  `contact1` bigint(21) NOT NULL,
  `contact2` bigint(21) DEFAULT NULL COMMENT 'Optional',
  `address` text NOT NULL,
  `dateTime` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `sitedetail`
--

INSERT INTO `sitedetail` (`tempId`, `systemName`, `email`, `contact1`, `contact2`, `address`, `dateTime`) VALUES
(1, 'Pizza Mánia', 'pizzamania@ugyfelszolgalat.hu', 703607888, 62555222, 'Szeged Futó utca 5.', '2021-03-23 19:56:25');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE `users` (
  `id` int(21) NOT NULL,
  `username` varchar(21) NOT NULL,
  `firstName` varchar(21) NOT NULL,
  `lastName` varchar(21) NOT NULL,
  `email` varchar(35) NOT NULL,
  `phone` bigint(20) NOT NULL,
  `userType` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0=user\r\n1=admin',
  `password` varchar(255) NOT NULL,
  `joinDate` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`id`, `username`, `firstName`, `lastName`, `email`, `phone`, `userType`, `password`, `joinDate`) VALUES
(1, 'admin', 'admin', 'admin', 'admin@gmail.com', 1111111111, '1', '$2y$10$AAfxRFOYbl7FdN17rN3fgeiPu/xQrx6MnvRGzqjVHlGqHAM4d9T1i', '2021-04-11 11:40:58'),
(2, 'Szekix16', 'Alex', 'Szekeres', 'szekix16@gmail.com', 5362517622, '0', '$2y$10$Ysi793WTEVJeZ3ZGKrq/q.ITiYfMy2DKTsrON3PHUv.Ft5xfV/gX2', '2023-10-04 11:50:40');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `viewcart`
--

CREATE TABLE `viewcart` (
  `cartItemId` int(11) NOT NULL,
  `pizzaId` int(11) NOT NULL,
  `itemQuantity` int(100) NOT NULL,
  `userId` int(11) NOT NULL,
  `addedDate` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`categorieId`);
ALTER TABLE `categories` ADD FULLTEXT KEY `categorieName` (`categorieName`,`categorieDesc`);

--
-- A tábla indexei `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`contactId`);

--
-- A tábla indexei `contactreply`
--
ALTER TABLE `contactreply`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `deliverydetails`
--
ALTER TABLE `deliverydetails`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `orderId` (`orderId`);

--
-- A tábla indexei `orderitems`
--
ALTER TABLE `orderitems`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`orderId`);

--
-- A tábla indexei `pizza`
--
ALTER TABLE `pizza`
  ADD PRIMARY KEY (`pizzaId`);
ALTER TABLE `pizza` ADD FULLTEXT KEY `pizzaName` (`pizzaName`,`pizzaDesc`);

--
-- A tábla indexei `sitedetail`
--
ALTER TABLE `sitedetail`
  ADD PRIMARY KEY (`tempId`);

--
-- A tábla indexei `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `username` (`username`);

--
-- A tábla indexei `viewcart`
--
ALTER TABLE `viewcart`
  ADD PRIMARY KEY (`cartItemId`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `categories`
--
ALTER TABLE `categories`
  MODIFY `categorieId` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT a táblához `contact`
--
ALTER TABLE `contact`
  MODIFY `contactId` int(21) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `contactreply`
--
ALTER TABLE `contactreply`
  MODIFY `id` int(21) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `deliverydetails`
--
ALTER TABLE `deliverydetails`
  MODIFY `id` int(21) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `orderitems`
--
ALTER TABLE `orderitems`
  MODIFY `id` int(21) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `orders`
--
ALTER TABLE `orders`
  MODIFY `orderId` int(21) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `pizza`
--
ALTER TABLE `pizza`
  MODIFY `pizzaId` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT a táblához `sitedetail`
--
ALTER TABLE `sitedetail`
  MODIFY `tempId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `id` int(21) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `viewcart`
--
ALTER TABLE `viewcart`
  MODIFY `cartItemId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
