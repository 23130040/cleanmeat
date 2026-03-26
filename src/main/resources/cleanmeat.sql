/*
 Navicat Premium Dump SQL

 Source Server         : LocalHost
 Source Server Type    : MySQL
 Source Server Version : 80407 (8.4.7)
 Source Host           : localhost:3306
 Source Schema         : cleanmeat

 Target Server Type    : MySQL
 Target Server Version : 80407 (8.4.7)
 File Encoding         : 65001

 Date: 26/03/2026 17:51:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `is_default` bit(1) NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of address
-- ----------------------------

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------

-- ----------------------------
-- Table structure for comment_tree
-- ----------------------------
DROP TABLE IF EXISTS `comment_tree`;
CREATE TABLE `comment_tree`  (
  `ancestor_id` int NOT NULL,
  `descendant_id` int NOT NULL,
  `depth` int NOT NULL,
  PRIMARY KEY (`ancestor_id`, `descendant_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment_tree
-- ----------------------------

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `item_id` int NULL DEFAULT NULL,
  `rating` int NULL DEFAULT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `item_id`(`item_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feedback
-- ----------------------------

-- ----------------------------
-- Table structure for item
-- ----------------------------
DROP TABLE IF EXISTS `item`;
CREATE TABLE `item`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `long_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `category_id` int NOT NULL,
  `origin_id` int NOT NULL,
  `unit_id` int NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `discount` decimal(5, 2) NULL DEFAULT 0.00,
  `current_stock` int NULL DEFAULT 0,
  `min_stock` int NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `category_id`(`category_id` ASC) USING BTREE,
  INDEX `origin_id`(`origin_id` ASC) USING BTREE,
  INDEX `unit_id`(`unit_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 133 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of item
-- ----------------------------
INSERT INTO `item` VALUES (1, 'Ba chỉ bò', NULL, NULL, 1, 1, 1, 50000.00, 0.00, 50, 5, '2026-01-02 16:29:12', '2026-01-02 22:24:19');
INSERT INTO `item` VALUES (2, 'Ba chỉ bò', NULL, NULL, 1, 1, 2, 72000.00, 0.00, 50, 5, '2026-01-02 17:08:27', '2026-01-02 22:24:20');
INSERT INTO `item` VALUES (3, 'Ba chỉ bò', NULL, NULL, 1, 1, 3, 90000.00, 0.00, 100, 5, '2026-01-02 17:08:36', '2026-01-02 22:24:21');
INSERT INTO `item` VALUES (4, 'Thịt bò tươi', NULL, NULL, 1, 1, 1, 50000.00, 0.00, 30, 5, '2026-01-02 17:08:41', '2026-01-02 22:24:49');
INSERT INTO `item` VALUES (5, 'Thịt bò tươi', NULL, NULL, 1, 1, 2, 72000.00, 0.00, 10, 5, '2026-01-02 17:08:46', '2026-01-02 22:24:50');
INSERT INTO `item` VALUES (6, 'Thịt bò tươi', NULL, NULL, 1, 1, 3, 90000.00, 0.00, 100, 5, '2026-01-02 17:08:53', '2026-01-02 22:24:54');
INSERT INTO `item` VALUES (7, 'Ba chỉ bò Mỹ', 'Thịt ba chỉ bò nhập khẩu, vân mỡ đều.', 'Ba chỉ bò Mỹ (Shortplate) là phần thịt tại bụng bò, có những dải mỡ và thịt xen kẽ nhau giúp miếng thịt mềm, ngậy, ngọt.', 1, 1, 2, 72000.00, 0.00, 50, 5, '2026-01-02 22:33:36', '2026-01-02 22:33:57');
INSERT INTO `item` VALUES (8, 'Ba chỉ bò Mỹ', 'Thịt ba chỉ bò nhập khẩu, vân mỡ đều.', 'Ba chỉ bò Mỹ (Shortplate) là phần thịt tại bụng bò, có những dải mỡ và thịt xen kẽ nhau giúp miếng thịt mềm, ngậy, ngọt.', 1, 1, 1, 50000.00, 0.00, 50, 5, '2026-01-02 22:33:36', '2026-01-02 22:33:59');
INSERT INTO `item` VALUES (9, 'Ba chỉ bò Mỹ', 'Thịt ba chỉ bò nhập khẩu, vân mỡ đều.', 'Ba chỉ bò Mỹ (Shortplate) là phần thịt tại bụng bò, có những dải mỡ và thịt xen kẽ nhau giúp miếng thịt mềm, ngậy, ngọt.', 1, 1, 3, 90000.00, 0.00, 100, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:01');
INSERT INTO `item` VALUES (10, 'Thăn ngoại bò Úc', 'Thịt thăn mềm, thích hợp làm steak.', 'Thăn ngoại bò là phần thịt nằm ở cuối dẻ sườn hai bên của con bò. Đặc điểm là thịt rất mềm và có một lớp mỡ mỏng phía trên.', 1, 1, 1, 120000.00, 0.00, 30, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:03');
INSERT INTO `item` VALUES (11, 'Thăn ngoại bò Úc', 'Thịt thăn mềm, thích hợp làm steak.', 'Thăn ngoại bò là phần thịt nằm ở cuối dẻ sườn hai bên của con bò. Đặc điểm là thịt rất mềm và có một lớp mỡ mỏng phía trên.', 1, 1, 2, 230000.00, 0.00, 30, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:04');
INSERT INTO `item` VALUES (12, 'Thăn ngoại bò Úc', 'Thịt thăn mềm, thích hợp làm steak.', 'Thăn ngoại bò là phần thịt nằm ở cuối dẻ sườn hai bên của con bò. Đặc điểm là thịt rất mềm và có một lớp mỡ mỏng phía trên.', 1, 1, 3, 350000.00, 0.00, 30, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:05');
INSERT INTO `item` VALUES (13, 'Bắp bò hoa', 'Bắp bò nhiều gân, giòn ngọt.', 'Bắp hoa bò là phần thịt bắp nhỏ nằm ở chân con bò, có nhiều đường gân xen kẽ, khi ăn rất giòn và thơm.', 1, 1, 1, 85000.00, 0.00, 40, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:07');
INSERT INTO `item` VALUES (14, 'Bắp bò hoa', 'Bắp bò nhiều gân, giòn ngọt.', 'Bắp hoa bò là phần thịt bắp nhỏ nằm ở chân con bò, có nhiều đường gân xen kẽ, khi ăn rất giòn và thơm.', 1, 1, 2, 160000.00, 0.00, 40, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:08');
INSERT INTO `item` VALUES (15, 'Bắp bò hoa', 'Bắp bò nhiều gân, giòn ngọt.', 'Bắp hoa bò là phần thịt bắp nhỏ nằm ở chân con bò, có nhiều đường gân xen kẽ, khi ăn rất giòn và thơm.', 1, 1, 3, 240000.00, 0.00, 40, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:09');
INSERT INTO `item` VALUES (16, 'Dẻ sườn bò Mỹ', 'Thịt dẻ sườn đậm đà, béo ngậy.', 'Dẻ sườn bò là phần thịt nằm ở khoang sườn của bò, có vị ngọt đậm và hương thơm đặc trưng của mỡ bò.', 1, 1, 1, 95000.00, 0.00, 25, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:10');
INSERT INTO `item` VALUES (17, 'Dẻ sườn bò Mỹ', 'Thịt dẻ sườn đậm đà, béo ngậy.', 'Dẻ sườn bò là phần thịt nằm ở khoang sườn của bò, có vị ngọt đậm và hương thơm đặc trưng của mỡ bò.', 1, 1, 2, 180000.00, 0.00, 25, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:11');
INSERT INTO `item` VALUES (18, 'Dẻ sườn bò Mỹ', 'Thịt dẻ sườn đậm đà, béo ngậy.', 'Dẻ sườn bò là phần thịt nằm ở khoang sườn của bò, có vị ngọt đậm và hương thơm đặc trưng của mỡ bò.', 1, 1, 3, 270000.00, 0.00, 25, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:13');
INSERT INTO `item` VALUES (19, 'Lõi vai bò Mỹ', 'Thịt lõi vai mềm, ít mỡ.', 'Lõi vai bò (Top Blade) có một sợi gân mỏng ở giữa, thịt rất ngọt và mềm, thường dùng cho món nướng hoặc nhúng lẩu.', 1, 1, 1, 110000.00, 0.00, 35, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:14');
INSERT INTO `item` VALUES (20, 'Lõi vai bò Mỹ', 'Thịt lõi vai mềm, ít mỡ.', 'Lõi vai bò (Top Blade) có một sợi gân mỏng ở giữa, thịt rất ngọt và mềm, thường dùng cho món nướng hoặc nhúng lẩu.', 1, 1, 2, 210000.00, 0.00, 35, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:16');
INSERT INTO `item` VALUES (21, 'Lõi vai bò Mỹ', 'Thịt lõi vai mềm, ít mỡ.', 'Lõi vai bò (Top Blade) có một sợi gân mỏng ở giữa, thịt rất ngọt và mềm, thường dùng cho món nướng hoặc nhúng lẩu.', 1, 1, 3, 310000.00, 0.00, 35, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:19');
INSERT INTO `item` VALUES (22, 'Nạm bò Úc', NULL, NULL, 1, 3, 1, 135000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (23, 'Nạm bò Úc', NULL, NULL, 1, 3, 2, 243000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (24, 'Nạm bò Úc', NULL, NULL, 1, 3, 3, 364500.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (25, 'Bò tươi nguyên miếng', NULL, NULL, 1, 1, 1, 320000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (26, 'Bò tươi nguyên miếng', NULL, NULL, 1, 1, 2, 576000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (27, 'Bò tươi nguyên miếng', NULL, NULL, 1, 1, 3, 864000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (28, 'Thịt má bò', NULL, NULL, 1, 1, 1, 175000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (29, 'Thịt má bò', NULL, NULL, 1, 1, 2, 315000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (30, 'Thịt má bò', NULL, NULL, 1, 1, 3, 472500.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (31, 'Nạm gầu bò tơ', NULL, NULL, 1, 1, 1, 320000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (32, 'Nạm gầu bò tơ', NULL, NULL, 1, 1, 2, 576000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (33, 'Nạm gầu bò tơ', NULL, NULL, 1, 1, 3, 864000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (34, 'Thăn vai bò', NULL, NULL, 1, 1, 1, 380000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (35, 'Thăn vai bò', NULL, NULL, 1, 1, 2, 684000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (36, 'Thăn vai bò', NULL, NULL, 1, 1, 3, 1026000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (37, 'Thịt nạc mông bò tươi', NULL, NULL, 1, 1, 1, 260000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (38, 'Thịt nạc mông bò tươi', NULL, NULL, 1, 1, 2, 468000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (39, 'Thịt nạc mông bò tươi', NULL, NULL, 1, 1, 3, 702000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (40, 'Đuôi bò', NULL, NULL, 1, 1, 1, 220000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (41, 'Đuôi bò', NULL, NULL, 1, 1, 2, 396000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (42, 'Đuôi bò', NULL, NULL, 1, 1, 3, 594000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (43, 'Ba chỉ bò', NULL, NULL, 1, 1, 1, 195000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (44, 'Ba chỉ bò', NULL, NULL, 1, 1, 2, 351000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (45, 'Ba chỉ bò', NULL, NULL, 1, 1, 3, 526500.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (46, 'Phi lê cổ bò', NULL, NULL, 1, 1, 1, 150000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (47, 'Phi lê cổ bò', NULL, NULL, 1, 1, 2, 270000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (48, 'Phi lê cổ bò', NULL, NULL, 1, 1, 3, 405000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (49, 'Thịt bắp bò', NULL, NULL, 1, 1, 1, 275000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (50, 'Thịt bắp bò', NULL, NULL, 1, 1, 2, 495000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (51, 'Thịt bắp bò', NULL, NULL, 1, 1, 3, 742500.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (52, 'Lá sách bò - đen', NULL, NULL, 1, 1, 1, 175000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (53, 'Lá sách bò - đen', NULL, NULL, 1, 1, 2, 315000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (54, 'Lá sách bò - đen', NULL, NULL, 1, 1, 3, 472500.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (55, 'Lá sách bò - trắng', NULL, NULL, 1, 1, 1, 190000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (56, 'Lá sách bò - trắng', NULL, NULL, 1, 1, 2, 342000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (57, 'Lá sách bò - trắng', NULL, NULL, 1, 1, 3, 513000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (58, 'Mỡ heo sạch', NULL, NULL, 2, 1, 1, 52000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (59, 'Mỡ heo sạch', NULL, NULL, 2, 1, 2, 93600.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (60, 'Mỡ heo sạch', NULL, NULL, 2, 1, 3, 140400.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (61, 'Ba rọi rút sườn CleanMeat', NULL, NULL, 2, 1, 1, 169000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (62, 'Ba rọi rút sườn CleanMeat', NULL, NULL, 2, 1, 2, 304200.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (63, 'Ba rọi rút sườn CleanMeat', NULL, NULL, 2, 1, 3, 456300.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (64, 'Sườn non heo CleanMeat', NULL, NULL, 2, 1, 1, 159000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (65, 'Sườn non heo CleanMeat', NULL, NULL, 2, 1, 2, 286200.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (66, 'Sườn non heo CleanMeat', NULL, NULL, 2, 1, 3, 429300.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (67, 'Sườn bẹ heo', NULL, NULL, 2, 1, 1, 175000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (68, 'Sườn bẹ heo', NULL, NULL, 2, 1, 2, 315000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (69, 'Sườn bẹ heo', NULL, NULL, 2, 1, 3, 472500.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (70, 'Thịt heo cốt lết', NULL, NULL, 2, 1, 1, 162000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (71, 'Thịt heo cốt lết', NULL, NULL, 2, 1, 2, 291600.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (72, 'Thịt heo cốt lết', NULL, NULL, 2, 1, 3, 437400.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (73, 'Thịt nạc thăn heo', NULL, NULL, 2, 1, 1, 185000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (74, 'Thịt nạc thăn heo', NULL, NULL, 2, 1, 2, 333000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (75, 'Thịt nạc thăn heo', NULL, NULL, 2, 1, 3, 499500.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (76, 'Nạc đùi heo', NULL, NULL, 2, 1, 1, 110000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (77, 'Nạc đùi heo', NULL, NULL, 2, 1, 2, 198000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (78, 'Nạc đùi heo', NULL, NULL, 2, 1, 3, 297000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (79, 'Nạc vai heo', NULL, NULL, 2, 1, 1, 126000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (80, 'Nạc vai heo', NULL, NULL, 2, 1, 2, 226800.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (81, 'Nạc vai heo', NULL, NULL, 2, 1, 3, 340200.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (82, 'Nạc dăm hữu cơ', NULL, NULL, 2, 1, 1, 135000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (83, 'Nạc dăm hữu cơ', NULL, NULL, 2, 1, 2, 243000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (84, 'Nạc dăm hữu cơ', NULL, NULL, 2, 1, 3, 364500.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (85, 'Tai heo', NULL, NULL, 2, 1, 1, 75000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (86, 'Tai heo', NULL, NULL, 2, 1, 2, 135000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (87, 'Tai heo', NULL, NULL, 2, 1, 3, 202500.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (88, 'Chân giò', NULL, NULL, 2, 1, 1, 118000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (89, 'Chân giò', NULL, NULL, 2, 1, 2, 212400.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (90, 'Chân giò', NULL, NULL, 2, 1, 3, 318600.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (91, 'Xương cổ heo', NULL, NULL, 2, 1, 1, 119000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (92, 'Xương cổ heo', NULL, NULL, 2, 1, 2, 214200.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (93, 'Xương cổ heo', NULL, NULL, 2, 1, 3, 321300.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (94, 'Dồi trường', NULL, NULL, 2, 1, 1, 190000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (95, 'Dồi trường', NULL, NULL, 2, 1, 2, 342000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (96, 'Dồi trường', NULL, NULL, 2, 1, 3, 513000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (97, 'Xương ống nạc heo', NULL, NULL, 2, 1, 1, 109000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (98, 'Xương ống nạc heo', NULL, NULL, 2, 1, 2, 196200.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (99, 'Xương ống nạc heo', NULL, NULL, 2, 1, 3, 294300.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (100, 'Gà nguyên con', NULL, NULL, 3, 1, 1, 170000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (101, 'Gà nguyên con', NULL, NULL, 3, 1, 2, 306000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (102, 'Gà nguyên con', NULL, NULL, 3, 1, 3, 459000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (103, 'Cổ gà', NULL, NULL, 3, 1, 1, 65000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (104, 'Cổ gà', NULL, NULL, 3, 1, 2, 117000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (105, 'Cổ gà', NULL, NULL, 3, 1, 3, 175500.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (106, 'Sụn gà', NULL, NULL, 3, 1, 1, 189000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (107, 'Sụn gà', NULL, NULL, 3, 1, 2, 340200.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (108, 'Sụn gà', NULL, NULL, 3, 1, 3, 510300.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (109, 'Cánh gà', NULL, NULL, 3, 1, 1, 98000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (110, 'Cánh gà', NULL, NULL, 3, 1, 2, 176400.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (111, 'Cánh gà', NULL, NULL, 3, 1, 3, 264600.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (112, 'Phao câu gà', NULL, NULL, 3, 1, 1, 48000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (113, 'Phao câu gà', NULL, NULL, 3, 1, 2, 86400.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (114, 'Phao câu gà', NULL, NULL, 3, 1, 3, 129600.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (115, 'Cánh gà khúc giữa', NULL, NULL, 3, 1, 1, 101000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (116, 'Cánh gà khúc giữa', NULL, NULL, 3, 1, 2, 181800.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (117, 'Cánh gà khúc giữa', NULL, NULL, 3, 1, 3, 272700.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (118, 'Chân gà có xương', NULL, NULL, 3, 1, 1, 105000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (119, 'Chân gà có xương', NULL, NULL, 3, 1, 2, 189000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (120, 'Chân gà có xương', NULL, NULL, 3, 1, 3, 283500.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (121, 'Má đùi gà', NULL, NULL, 3, 1, 1, 98000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (122, 'Má đùi gà', NULL, NULL, 3, 1, 2, 176400.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (123, 'Má đùi gà', NULL, NULL, 3, 1, 3, 264600.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (124, 'Đùi tỏi gà', NULL, NULL, 3, 1, 1, 110000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (125, 'Đùi tỏi gà', NULL, NULL, 3, 1, 2, 198000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (126, 'Đùi tỏi gà', NULL, NULL, 3, 1, 3, 297000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (127, 'Cơm má đùi không xương', NULL, NULL, 3, 1, 1, 60000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (128, 'Cơm má đùi không xương', NULL, NULL, 3, 1, 2, 108000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (129, 'Cơm má đùi không xương', NULL, NULL, 3, 1, 3, 162000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (130, 'Mề gà', NULL, NULL, 3, 1, 1, 104000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (131, 'Mề gà', NULL, NULL, 3, 1, 2, 187200.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (132, 'Mề gà', NULL, NULL, 3, 1, 3, 280800.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-03-23 16:15:12');

-- ----------------------------
-- Table structure for item_image
-- ----------------------------
DROP TABLE IF EXISTS `item_image`;
CREATE TABLE `item_image`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `item_id` int NOT NULL,
  `url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `is_primary` bit(1) NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `item_id`(`item_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 157 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of item_image
-- ----------------------------
INSERT INTO `item_image` VALUES (1, 1, 'sp_1.jpg', b'1', '2026-01-02 23:02:29');
INSERT INTO `item_image` VALUES (2, 1, 'sp_1_1.jpg', b'0', '2026-01-02 23:02:42');
INSERT INTO `item_image` VALUES (3, 1, 'sp_1_2.jpg', b'0', '2026-01-02 23:03:05');
INSERT INTO `item_image` VALUES (4, 1, 'sp_1_3.jpg', b'0', '2026-01-02 23:03:16');
INSERT INTO `item_image` VALUES (5, 1, 'sp_1_4.jpg', b'0', '2026-01-02 23:03:37');
INSERT INTO `item_image` VALUES (6, 2, 'sp_1.jpg', b'1', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (7, 2, 'sp_1_1.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (8, 2, 'sp_1_2.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (9, 2, 'sp_1_3.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (10, 2, 'sp_1_4.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (11, 3, 'sp_1.jpg', b'1', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (12, 3, 'sp_1_1.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (13, 3, 'sp_1_2.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (14, 3, 'sp_1_3.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (15, 3, 'sp_1_4.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (16, 4, 'sp_2.jpg', b'1', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (17, 4, 'sp_2_1.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (18, 4, 'sp_2_2.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (19, 4, 'sp_2_3.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (20, 4, 'sp_2_4.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (21, 5, 'sp_2.jpg', b'1', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (22, 5, 'sp_2_1.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (23, 5, 'sp_2_2.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (24, 5, 'sp_2_3.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (25, 5, 'sp_2_4.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (26, 6, 'sp_2.jpg', b'1', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (27, 6, 'sp_2_1.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (28, 6, 'sp_2_2.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (29, 6, 'sp_2_3.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (30, 6, 'sp_2_4.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (31, 7, 'sp_3.jpg', b'1', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (32, 7, 'sp_3_1.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (33, 7, 'sp_3_2.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (34, 7, 'sp_3_3.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (35, 7, 'sp_3_4.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (36, 8, 'sp_3.jpg', b'1', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (37, 8, 'sp_3_1.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (38, 8, 'sp_3_2.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (39, 8, 'sp_3_3.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (40, 8, 'sp_3_4.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (41, 9, 'sp_3.jpg', b'1', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (42, 9, 'sp_3_1.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (43, 9, 'sp_3_2.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (44, 9, 'sp_3_3.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (45, 9, 'sp_3_4.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (46, 22, 'images/Bo1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (47, 23, 'images/Bo1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (48, 24, 'images/Bo1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (49, 25, 'images/Bo2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (50, 26, 'images/Bo2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (51, 27, 'images/Bo2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (52, 28, 'images/Bo3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (53, 29, 'images/Bo3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (54, 30, 'images/Bo3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (55, 31, 'images/Bo4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (56, 32, 'images/Bo4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (57, 33, 'images/Bo4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (58, 34, 'images/Bo5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (59, 35, 'images/Bo5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (60, 36, 'images/Bo5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (61, 37, 'images/Bo6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (62, 38, 'images/Bo6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (63, 39, 'images/Bo6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (64, 40, 'images/Bo7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (65, 41, 'images/Bo7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (66, 42, 'images/Bo7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (67, 43, 'images/Bo8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (68, 44, 'images/Bo8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (69, 45, 'images/Bo8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (70, 46, 'images/Bo9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (71, 47, 'images/Bo9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (72, 48, 'images/Bo9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (73, 49, 'images/Bo10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (74, 50, 'images/Bo10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (75, 51, 'images/Bo10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (76, 52, 'images/Bo11.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (77, 53, 'images/Bo11.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (78, 54, 'images/Bo11.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (79, 55, 'images/Bo12.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (80, 56, 'images/Bo12.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (81, 57, 'images/Bo12.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (82, 58, 'images/Heo1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (83, 59, 'images/Heo1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (84, 60, 'images/Heo1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (85, 61, 'images/Heo2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (86, 62, 'images/Heo2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (87, 63, 'images/Heo2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (88, 64, 'images/Heo3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (89, 65, 'images/Heo3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (90, 66, 'images/Heo3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (91, 67, 'images/Heo4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (92, 68, 'images/Heo4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (93, 69, 'images/Heo4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (94, 70, 'images/Heo5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (95, 71, 'images/Heo5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (96, 72, 'images/Heo5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (97, 73, 'images/Heo6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (98, 74, 'images/Heo6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (99, 75, 'images/Heo6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (100, 76, 'images/Heo7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (101, 77, 'images/Heo7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (102, 78, 'images/Heo7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (103, 79, 'images/Heo8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (104, 80, 'images/Heo8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (105, 81, 'images/Heo8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (106, 82, 'images/Heo9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (107, 83, 'images/Heo9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (108, 84, 'images/Heo9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (109, 85, 'images/Heo10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (110, 86, 'images/Heo10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (111, 87, 'images/Heo10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (112, 88, 'images/Heo11.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (113, 89, 'images/Heo11.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (114, 90, 'images/Heo11.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (115, 91, 'images/Heo12.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (116, 92, 'images/Heo12.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (117, 93, 'images/Heo12.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (118, 94, 'images/Heo13.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (119, 95, 'images/Heo13.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (120, 96, 'images/Heo13.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (121, 97, 'images/Heo14.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (122, 98, 'images/Heo14.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (123, 99, 'images/Heo14.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (124, 100, 'images/Ga1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (125, 101, 'images/Ga1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (126, 102, 'images/Ga1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (127, 103, 'images/Ga2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (128, 104, 'images/Ga2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (129, 105, 'images/Ga2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (130, 106, 'images/Ga3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (131, 107, 'images/Ga3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (132, 108, 'images/Ga3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (133, 109, 'images/Ga4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (134, 110, 'images/Ga4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (135, 111, 'images/Ga4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (136, 112, 'images/Ga5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (137, 113, 'images/Ga5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (138, 114, 'images/Ga5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (139, 115, 'images/Ga6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (140, 116, 'images/Ga6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (141, 117, 'images/Ga6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (142, 118, 'images/Ga7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (143, 119, 'images/Ga7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (144, 120, 'images/Ga7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (145, 121, 'images/Ga8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (146, 122, 'images/Ga8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (147, 123, 'images/Ga8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (148, 124, 'images/Ga9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (149, 125, 'images/Ga9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (150, 126, 'images/Ga9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (151, 127, 'images/Ga10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (152, 128, 'images/Ga10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (153, 129, 'images/Ga10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (154, 130, 'images/Ga11.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (155, 131, 'images/Ga11.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (156, 132, 'images/Ga11.png', b'1', '2026-01-23 11:30:00');

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `picture_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `created_by`(`created_by` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of news
-- ----------------------------

-- ----------------------------
-- Table structure for notification
-- ----------------------------
DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `email` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `is_read` bit(1) NULL DEFAULT NULL,
  `type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notification
-- ----------------------------

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `total_price` decimal(10, 2) NULL DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `address_id` int NOT NULL,
  `transport_id` int NULL DEFAULT NULL,
  `payment_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `address_id`(`address_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------

-- ----------------------------
-- Table structure for orders_item
-- ----------------------------
DROP TABLE IF EXISTS `orders_item`;
CREATE TABLE `orders_item`  (
  `order_id` int NOT NULL,
  `item_id` int NOT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `quantity` decimal(10, 2) NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`, `item_id`) USING BTREE,
  INDEX `item_id`(`item_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders_item
-- ----------------------------

-- ----------------------------
-- Table structure for origin
-- ----------------------------
DROP TABLE IF EXISTS `origin`;
CREATE TABLE `origin`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of origin
-- ----------------------------

-- ----------------------------
-- Table structure for payment
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` bit(1) NULL DEFAULT b'1',
  `created_day` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_day` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of payment
-- ----------------------------

-- ----------------------------
-- Table structure for stock_history
-- ----------------------------
DROP TABLE IF EXISTS `stock_history`;
CREATE TABLE `stock_history`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `item_id` int NULL DEFAULT NULL,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` decimal(10, 2) NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_id`(`item_id` ASC) USING BTREE,
  INDEX `created_by`(`created_by` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of stock_history
-- ----------------------------

-- ----------------------------
-- Table structure for system_config
-- ----------------------------
DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hotline` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `tax_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `facebook` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `logo_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `created_by`(`created_by` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_config
-- ----------------------------

-- ----------------------------
-- Table structure for transport
-- ----------------------------
DROP TABLE IF EXISTS `transport`;
CREATE TABLE `transport`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `base_fee` int NULL DEFAULT 0,
  `estimated_day` int NULL DEFAULT NULL,
  `status` bit(1) NULL DEFAULT b'1',
  `created_day` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_day` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of transport
-- ----------------------------

-- ----------------------------
-- Table structure for unit
-- ----------------------------
DROP TABLE IF EXISTS `unit`;
CREATE TABLE `unit`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(10, 2) NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of unit
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT ' ',
  `birthday` date NULL DEFAULT '2005-02-02',
  `role` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'user',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT ' ',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` bit(1) NULL DEFAULT b'0',
  `verify_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
