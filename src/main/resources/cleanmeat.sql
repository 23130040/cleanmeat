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

 Date: 02/04/2026 17:24:05
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
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (9, 1, 'vffgfdg', b'1', '2026-03-29 20:03:41', '2026-03-29 20:03:41');
INSERT INTO `address` VALUES (11, 3, 'tpHCM', b'1', '2026-04-01 10:57:53', '2026-04-01 10:57:55');

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comment_tree
-- ----------------------------

-- ----------------------------
-- Table structure for contacts
-- ----------------------------
DROP TABLE IF EXISTS `contacts`;
CREATE TABLE `contacts`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('pending','processing','replied') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'pending',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `handled_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_status`(`status`) USING BTREE,
  INDEX `idx_created_at`(`created_at`) USING BTREE,
  INDEX `idx_email`(`email`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of contacts
-- ----------------------------
INSERT INTO `contacts` VALUES (1, 'Nguyễn Bích Dân', '23130040@st.hcmuaf.edu.vn', 'Hỗ trợ kỹ thuật', 'Tôi không thể đăng nhập vào hệ thống admin.', 'replied', '2026-04-01 08:30:00', '2026-04-01 09:15:00', 1);
INSERT INTO `contacts` VALUES (2, 'Nguyễn Bích Dân', 'bichdantqn2005@gmail.com', 'Hỏi về đơn hàng', 'Đơn hàng của tôi bao giờ thì được giao?', 'pending', '2026-04-02 10:20:00', '2026-04-02 10:20:00', NULL);
INSERT INTO `contacts` VALUES (3, 'Nguyễn Bích Dân', '23130040@st.hcmuaf.edu.vn', 'Góp ý dịch vụ', 'Sản phẩm rất chất lượng, tôi sẽ ủng hộ tiếp.', 'processing', '2026-04-02 14:45:12', '2026-04-02 15:00:00', 1);
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
  `status` bit(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `item_id`(`item_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feedback
-- ----------------------------
INSERT INTO `feedback` VALUES (1, 1, 94, 5, 'Sản phẩm tuyệt vời, đóng gói rất cẩn thận!', '2026-04-02 17:00:00', '2026-04-02 17:00:00', b'1');
INSERT INTO `feedback` VALUES (2, 3, 25, 4, 'Chất lượng tốt nhưng giao hàng hơi chậm một chút.', '2026-04-02 18:15:20', '2026-04-02 18:15:20', b'1');
INSERT INTO `feedback` VALUES (3, 3, 22, 5, 'Rất đáng tiền, sẽ tiếp tục ủng hộ shop.', '2026-04-02 19:30:45', '2026-04-02 19:30:45', b'1');
INSERT INTO `feedback` VALUES (4, 1, 25, 3, 'Sản phẩm tạm ổn, cần cải thiện khâu tư vấn.', '2026-04-02 20:10:00', '2026-04-02 20:10:00', b'0');
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
  `packaging` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
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
INSERT INTO `item` VALUES (1, 'Ba chỉ bò', NULL, NULL, 1, 1, 1, 50000.00, 0.00, 50, 5, '500g', '2026-01-02 16:29:12', '2026-01-02 22:24:19');
INSERT INTO `item` VALUES (2, 'Ba chỉ bò', NULL, NULL, 1, 1, 2, 72000.00, 0.00, 50, 5, '500g', '2026-01-02 17:08:27', '2026-01-02 22:24:20');
INSERT INTO `item` VALUES (3, 'Ba chỉ bò', NULL, NULL, 1, 1, 3, 90000.00, 0.00, 100, 5, '500g', '2026-01-02 17:08:36', '2026-01-02 22:24:21');
INSERT INTO `item` VALUES (4, 'Thịt bò tươi', NULL, NULL, 1, 1, 1, 50000.00, 0.00, 30, 5, '500g', '2026-01-02 17:08:41', '2026-01-02 22:24:49');
INSERT INTO `item` VALUES (5, 'Thịt bò tươi', NULL, NULL, 1, 1, 2, 72000.00, 0.00, 10, 5, '500g', '2026-01-02 17:08:46', '2026-01-02 22:24:50');
INSERT INTO `item` VALUES (6, 'Thịt bò tươi', NULL, NULL, 1, 1, 3, 90000.00, 0.00, 100, 5, '500g', '2026-01-02 17:08:53', '2026-01-02 22:24:54');
INSERT INTO `item` VALUES (7, 'Ba chỉ bò Mỹ', 'Thịt ba chỉ bò nhập khẩu, vân mỡ đều.', 'Ba chỉ bò Mỹ (Shortplate)...', 1, 1, 2, 72000.00, 0.00, 50, 5, '500g', '2026-01-02 22:33:36', '2026-01-02 22:33:57');
INSERT INTO `item` VALUES (8, 'Ba chỉ bò Mỹ', 'Thịt ba chỉ bò nhập khẩu, vân mỡ đều.', 'Ba chỉ bò Mỹ (Shortplate)...', 1, 1, 1, 50000.00, 0.00, 50, 5, '500g', '2026-01-02 22:33:36', '2026-01-02 22:33:59');
INSERT INTO `item` VALUES (9, 'Ba chỉ bò Mỹ', 'Thịt ba chỉ bò nhập khẩu, vân mỡ đều.', 'Ba chỉ bò Mỹ (Shortplate)...', 1, 1, 3, 90000.00, 0.00, 100, 5, '500g', '2026-01-02 22:33:36', '2026-01-02 22:34:01');
INSERT INTO `item` VALUES (10, 'Thăn ngoại bò Úc', 'Thịt thăn mềm, thích hợp làm steak.', 'Thăn ngoại bò là phần...', 1, 1, 1, 120000.00, 0.00, 30, 5, '500g', '2026-01-02 22:33:36', '2026-01-02 22:34:03');
INSERT INTO `item` VALUES (11, 'Thăn ngoại bò Úc', 'Thịt thăn mềm, thích hợp làm steak.', 'Thăn ngoại bò là phần...', 1, 1, 2, 230000.00, 0.00, 30, 5, '500g', '2026-01-02 22:33:36', '2026-01-02 22:34:04');
INSERT INTO `item` VALUES (12, 'Thăn ngoại bò Úc', 'Thịt thăn mềm, thích hợp làm steak.', 'Thăn ngoại bò là phần...', 1, 1, 3, 350000.00, 0.00, 30, 5, '500g', '2026-01-02 22:33:36', '2026-01-02 22:34:05');
INSERT INTO `item` VALUES (13, 'Bắp bò hoa', 'Bắp bò nhiều gân, giòn ngọt.', 'Bắp hoa bò là phần...', 1, 1, 1, 85000.00, 0.00, 40, 5, '500g', '2026-01-02 22:33:36', '2026-01-02 22:34:07');
INSERT INTO `item` VALUES (14, 'Bắp bò hoa', 'Bắp bò nhiều gân, giòn ngọt.', 'Bắp hoa bò là phần...', 1, 1, 2, 160000.00, 0.00, 40, 5, '500g', '2026-01-02 22:33:36', '2026-01-02 22:34:08');
INSERT INTO `item` VALUES (15, 'Bắp bò hoa', 'Bắp bò nhiều gân, giòn ngọt.', 'Bắp hoa bò là phần...', 1, 1, 3, 240000.00, 0.00, 40, 5, '500g', '2026-01-02 22:33:36', '2026-01-02 22:34:09');
INSERT INTO `item` VALUES (16, 'Dẻ sườn bò Mỹ', 'Thịt dẻ sườn đậm đà, béo ngậy.', 'Dẻ sườn bò là phần thịt...', 1, 1, 1, 95000.00, 0.00, 25, 5, '500g', '2026-01-02 22:33:36', '2026-01-02 22:34:10');
INSERT INTO `item` VALUES (17, 'Dẻ sườn bò Mỹ', 'Thịt dẻ sườn đậm đà, béo ngậy.', 'Dẻ sườn bò là phần thịt...', 1, 1, 2, 180000.00, 0.00, 25, 5, '500g', '2026-01-02 22:33:36', '2026-01-02 22:34:11');
INSERT INTO `item` VALUES (18, 'Dẻ sườn bò Mỹ', 'Thịt dẻ sườn đậm đà, béo ngậy.', 'Dẻ sườn bò là phần thịt...', 1, 1, 3, 270000.00, 0.00, 25, 5, '500g', '2026-01-02 22:33:36', '2026-01-02 22:34:13');
INSERT INTO `item` VALUES (19, 'Lõi vai bò Mỹ', 'Thịt lõi vai mềm, ít mỡ.', 'Lõi vai bò (Top Blade)...', 1, 1, 1, 110000.00, 0.00, 35, 5, '500g', '2026-01-02 22:33:36', '2026-01-02 22:34:14');
INSERT INTO `item` VALUES (20, 'Lõi vai bò Mỹ', 'Thịt lõi vai mềm, ít mỡ.', 'Lõi vai bò (Top Blade)...', 1, 1, 2, 210000.00, 0.00, 35, 5, '500g', '2026-01-02 22:33:36', '2026-01-02 22:34:16');
INSERT INTO `item` VALUES (21, 'Lõi vai bò Mỹ', 'Thịt lõi vai mềm, ít mỡ.', 'Lõi vai bò (Top Blade)...', 1, 1, 3, 310000.00, 0.00, 35, 5, '500g', '2026-01-02 22:33:36', '2026-01-02 22:34:19');
INSERT INTO `item` VALUES (22, 'Nạm bò Úc', NULL, NULL, 1, 3, 1, 135000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (23, 'Nạm bò Úc', NULL, NULL, 1, 3, 2, 243000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (24, 'Nạm bò Úc', NULL, NULL, 1, 3, 3, 364500.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (25, 'Bò tươi nguyên miếng', NULL, NULL, 1, 1, 1, 320000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (26, 'Bò tươi nguyên miếng', NULL, NULL, 1, 1, 2, 576000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (27, 'Bò tươi nguyên miếng', NULL, NULL, 1, 1, 3, 864000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (28, 'Thịt má bò', NULL, NULL, 1, 1, 1, 175000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (29, 'Thịt má bò', NULL, NULL, 1, 1, 2, 315000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (30, 'Thịt má bò', NULL, NULL, 1, 1, 3, 472500.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (31, 'Nạm gầu bò tơ', NULL, NULL, 1, 1, 1, 320000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (32, 'Nạm gầu bò tơ', NULL, NULL, 1, 1, 2, 576000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (33, 'Nạm gầu bò tơ', NULL, NULL, 1, 1, 3, 864000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (34, 'Thăn vai bò', NULL, NULL, 1, 1, 1, 380000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (35, 'Thăn vai bò', NULL, NULL, 1, 1, 2, 684000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (36, 'Thăn vai bò', NULL, NULL, 1, 1, 3, 1026000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (37, 'Thịt nạc mông bò tươi', NULL, NULL, 1, 1, 1, 260000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (38, 'Thịt nạc mông bò tươi', NULL, NULL, 1, 1, 2, 468000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (39, 'Thịt nạc mông bò tươi', NULL, NULL, 1, 1, 3, 702000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (40, 'Đuôi bò', NULL, NULL, 1, 1, 1, 220000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (41, 'Đuôi bò', NULL, NULL, 1, 1, 2, 396000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (42, 'Đuôi bò', NULL, NULL, 1, 1, 3, 594000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (43, 'Ba chỉ bò', NULL, NULL, 1, 1, 1, 195000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (44, 'Ba chỉ bò', NULL, NULL, 1, 1, 2, 351000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (45, 'Ba chỉ bò', NULL, NULL, 1, 1, 3, 526500.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (46, 'Phi lê cổ bò', NULL, NULL, 1, 1, 1, 150000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (47, 'Phi lê cổ bò', NULL, NULL, 1, 1, 2, 270000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (48, 'Phi lê cổ bò', NULL, NULL, 1, 1, 3, 405000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (49, 'Thịt bắp bò', NULL, NULL, 1, 1, 1, 275000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (50, 'Thịt bắp bò', NULL, NULL, 1, 1, 2, 495000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (51, 'Thịt bắp bò', NULL, NULL, 1, 1, 3, 742500.00, 0.00, 100, 10, '1kg', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (52, 'Lá sách bò - đen', NULL, NULL, 1, 1, 1, 175000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (53, 'Lá sách bò - đen', NULL, NULL, 1, 1, 2, 315000.00, 0.00, 100, 10, '1kg', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (54, 'Lá sách bò - đen', NULL, NULL, 1, 1, 3, 472500.00, 0.00, 100, 10, '1.5kg', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (55, 'Lá sách bò - trắng', NULL, NULL, 1, 1, 1, 190000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (56, 'Lá sách bò - trắng', NULL, NULL, 1, 1, 2, 342000.00, 0.00, 100, 10, '1kg', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (57, 'Lá sách bò - trắng', NULL, NULL, 1, 1, 3, 513000.00, 0.00, 100, 10, '1.5kg', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (58, 'Mỡ heo sạch', NULL, NULL, 2, 1, 1, 52000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (59, 'Mỡ heo sạch', NULL, NULL, 2, 1, 2, 93600.00, 0.00, 100, 10, '1kg', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (60, 'Mỡ heo sạch', NULL, NULL, 2, 1, 3, 140400.00, 0.00, 100, 10, '1.5kg', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (61, 'Ba rọi rút sườn CleanMeat', NULL, NULL, 2, 1, 1, 169000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (62, 'Ba rọi rút sườn CleanMeat', NULL, NULL, 2, 1, 2, 304200.00, 0.00, 100, 10, '1kg', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (63, 'Ba rọi rút sườn CleanMeat', NULL, NULL, 2, 1, 3, 456300.00, 0.00, 100, 10, '1.5kg', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (64, 'Sườn non heo CleanMeat', NULL, NULL, 2, 1, 1, 159000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (65, 'Sườn non heo CleanMeat', NULL, NULL, 2, 1, 2, 286200.00, 0.00, 100, 10, '1kg', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (66, 'Sườn non heo CleanMeat', NULL, NULL, 2, 1, 3, 429300.00, 0.00, 100, 10, '1.5kg', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (67, 'Sườn bẹ heo', NULL, NULL, 2, 1, 1, 175000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (68, 'Sườn bẹ heo', NULL, NULL, 2, 1, 2, 315000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (69, 'Sườn bẹ heo', NULL, NULL, 2, 1, 3, 472500.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (70, 'Thịt heo cốt lết', NULL, NULL, 2, 1, 1, 162000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (71, 'Thịt heo cốt lết', NULL, NULL, 2, 1, 2, 291600.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (72, 'Thịt heo cốt lết', NULL, NULL, 2, 1, 3, 437400.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (73, 'Thịt nạc thăn heo', NULL, NULL, 2, 1, 1, 185000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (74, 'Thịt nạc thăn heo', NULL, NULL, 2, 1, 2, 333000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (75, 'Thịt nạc thăn heo', NULL, NULL, 2, 1, 3, 499500.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (76, 'Nạc đùi heo', NULL, NULL, 2, 1, 1, 110000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (77, 'Nạc đùi heo', NULL, NULL, 2, 1, 2, 198000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (78, 'Nạc đùi heo', NULL, NULL, 2, 1, 3, 297000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (79, 'Nạc vai heo', NULL, NULL, 2, 1, 1, 126000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (80, 'Nạc vai heo', NULL, NULL, 2, 1, 2, 226800.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (81, 'Nạc vai heo', NULL, NULL, 2, 1, 3, 340200.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (82, 'Nạc dăm hữu cơ', NULL, NULL, 2, 1, 1, 135000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (83, 'Nạc dăm hữu cơ', NULL, NULL, 2, 1, 2, 243000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (84, 'Nạc dăm hữu cơ', NULL, NULL, 2, 1, 3, 364500.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (85, 'Tai heo', NULL, NULL, 2, 1, 1, 75000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (86, 'Tai heo', NULL, NULL, 2, 1, 2, 135000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (87, 'Tai heo', NULL, NULL, 2, 1, 3, 202500.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (88, 'Chân giò', NULL, NULL, 2, 1, 1, 118000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (89, 'Chân giò', NULL, NULL, 2, 1, 2, 212400.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (90, 'Chân giò', NULL, NULL, 2, 1, 3, 318600.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (91, 'Xương cổ heo', NULL, NULL, 2, 1, 1, 119000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (92, 'Xương cổ heo', NULL, NULL, 2, 1, 2, 214200.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (93, 'Xương cổ heo', NULL, NULL, 2, 1, 3, 321300.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (94, 'Dồi trường', NULL, NULL, 2, 1, 1, 190000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (95, 'Dồi trường', NULL, NULL, 2, 1, 2, 342000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (96, 'Dồi trường', NULL, NULL, 2, 1, 3, 513000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (97, 'Xương ống nạc heo', NULL, NULL, 2, 1, 1, 109000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (98, 'Xương ống nạc heo', NULL, NULL, 2, 1, 2, 196200.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (99, 'Xương ống nạc heo', NULL, NULL, 2, 1, 3, 294300.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (100, 'Gà nguyên con', NULL, NULL, 3, 1, 1, 170000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (101, 'Gà nguyên con', NULL, NULL, 3, 1, 2, 306000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (102, 'Gà nguyên con', NULL, NULL, 3, 1, 3, 459000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (103, 'Cổ gà', NULL, NULL, 3, 1, 1, 65000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (104, 'Cổ gà', NULL, NULL, 3, 1, 2, 117000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (105, 'Cổ gà', NULL, NULL, 3, 1, 3, 175500.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (106, 'Sụn gà', NULL, NULL, 3, 1, 1, 189000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (107, 'Sụn gà', NULL, NULL, 3, 1, 2, 340200.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (108, 'Sụn gà', NULL, NULL, 3, 1, 3, 510300.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (109, 'Cánh gà', NULL, NULL, 3, 1, 1, 98000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (110, 'Cánh gà', NULL, NULL, 3, 1, 2, 176400.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (111, 'Cánh gà', NULL, NULL, 3, 1, 3, 264600.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (112, 'Phao câu gà', NULL, NULL, 3, 1, 1, 48000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (113, 'Phao câu gà', NULL, NULL, 3, 1, 2, 86400.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (114, 'Phao câu gà', NULL, NULL, 3, 1, 3, 129600.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (115, 'Cánh gà khúc giữa', NULL, NULL, 3, 1, 1, 101000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (116, 'Cánh gà khúc giữa', NULL, NULL, 3, 1, 2, 181800.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (117, 'Cánh gà khúc giữa', NULL, NULL, 3, 1, 3, 272700.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (118, 'Chân gà có xương', NULL, NULL, 3, 1, 1, 105000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (119, 'Chân gà có xương', NULL, NULL, 3, 1, 2, 189000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (120, 'Chân gà có xương', NULL, NULL, 3, 1, 3, 283500.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (121, 'Má đùi gà', NULL, NULL, 3, 1, 1, 98000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (122, 'Má đùi gà', NULL, NULL, 3, 1, 2, 176400.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (123, 'Má đùi gà', NULL, NULL, 3, 1, 3, 264600.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (124, 'Đùi tỏi gà', NULL, NULL, 3, 1, 1, 110000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (125, 'Đùi tỏi gà', NULL, NULL, 3, 1, 2, 198000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (126, 'Đùi tỏi gà', NULL, NULL, 3, 1, 3, 297000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (127, 'Cơm má đùi không xương', NULL, NULL, 3, 1, 1, 60000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (128, 'Cơm má đùi không xương', NULL, NULL, 3, 1, 2, 108000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (129, 'Cơm má đùi không xương', NULL, NULL, 3, 1, 3, 162000.00, 0.00, 100, 10, NULL, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (130, 'Mề gà', NULL, NULL, 3, 1, 1, 104000.00, 0.00, 100, 10, '500g', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (131, 'Mề gà', NULL, NULL, 3, 1, 2, 187200.00, 0.00, 100, 10, '1kg', '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (132, 'Mề gà', NULL, NULL, 3, 1, 3, 280800.00, 0.00, 100, 10, '1.5kg', '2026-01-23 11:00:00', '2026-03-23 16:15:12');

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
INSERT INTO `item_image` VALUES (46, 22, 'Bo1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (47, 23, 'Bo1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (48, 24, 'Bo1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (49, 25, 'Bo2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (50, 26, 'Bo2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (51, 27, 'Bo2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (52, 28, 'Bo3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (53, 29, 'Bo3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (54, 30, 'Bo3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (55, 31, 'Bo4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (56, 32, 'Bo4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (57, 33, 'Bo4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (58, 34, 'Bo5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (59, 35, 'Bo5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (60, 36, 'Bo5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (61, 37, 'Bo6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (62, 38, 'Bo6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (63, 39, 'Bo6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (64, 40, 'Bo7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (65, 41, 'Bo7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (66, 42, 'Bo7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (67, 43, 'Bo8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (68, 44, 'Bo8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (69, 45, 'Bo8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (70, 46, 'Bo9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (71, 47, 'Bo9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (72, 48, 'Bo9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (73, 49, 'Bo10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (74, 50, 'Bo10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (75, 51, 'Bo10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (76, 52, 'Bo11.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (77, 53, 'Bo11.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (78, 54, 'Bo11.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (79, 55, 'Bo12.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (80, 56, 'Bo12.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (81, 57, 'Bo12.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (82, 58, 'Heo1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (83, 59, 'Heo1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (84, 60, 'Heo1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (85, 61, 'Heo2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (86, 62, 'Heo2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (87, 63, 'Heo2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (88, 64, 'Heo3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (89, 65, 'Heo3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (90, 66, 'Heo3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (91, 67, 'Heo4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (92, 68, 'Heo4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (93, 69, 'Heo4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (94, 70, 'Heo5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (95, 71, 'Heo5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (96, 72, 'Heo5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (97, 73, 'Heo6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (98, 74, 'Heo6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (99, 75, 'Heo6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (100, 76, 'Heo7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (101, 77, 'Heo7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (102, 78, 'Heo7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (103, 79, 'Heo8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (104, 80, 'Heo8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (105, 81, 'Heo8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (106, 82, 'Heo9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (107, 83, 'Heo9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (108, 84, 'Heo9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (109, 85, 'Heo10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (110, 86, 'Heo10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (111, 87, 'Heo10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (112, 88, 'Heo11.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (113, 89, 'Heo11.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (114, 90, 'Heo11.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (115, 91, 'Heo12.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (116, 92, 'Heo12.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (117, 93, 'Heo12.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (118, 94, 'Heo13.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (119, 95, 'Heo13.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (120, 96, 'Heo13.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (121, 97, 'Heo14.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (122, 98, 'Heo14.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (123, 99, 'Heo14.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (124, 100, 'Ga1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (125, 101, 'Ga1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (126, 102, 'Ga1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (127, 103, 'Ga2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (128, 104, 'Ga2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (129, 105, 'Ga2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (130, 106, 'Ga3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (131, 107, 'Ga3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (132, 108, 'Ga3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (133, 109, 'Ga4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (134, 110, 'Ga4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (135, 111, 'Ga4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (136, 112, 'Ga5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (137, 113, 'Ga5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (138, 114, 'Ga5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (139, 115, 'Ga6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (140, 116, 'Ga6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (141, 117, 'Ga6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (142, 118, 'Ga7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (143, 119, 'Ga7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (144, 120, 'Ga7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (145, 121, 'Ga8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (146, 122, 'Ga8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (147, 123, 'Ga8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (148, 124, 'Ga9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (149, 125, 'Ga9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (150, 126, 'Ga9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (151, 127, 'Ga10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (152, 128, 'Ga10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (153, 129, 'Ga10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (154, 130, 'Ga11.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (155, 131, 'Ga11.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (156, 132, 'Ga11.png', b'1', '2026-01-23 11:30:00');

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
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (1, 'Làm sao biết thịt luộc đã chín?', 'Bùi Thúy', 'images/news1.png', 'Một số người nội trợ có mẹo kiểm tra bằng cách cắm đũa xuyên vào phần dày nhất, nếu xiên được và không có nước đỏ hồng rỉ ra là thịt đã đạt độ chín cần thiết. Các đầu bếp phương Tây cũng dùng \"nhiệt kế thủ công\" này để kiểm tra độ chín của lõi thịt. Một số người nội trợ có kinh nghiệm còn chia sẻ cách nhận diện gián tiếp bằng quan sát thịt nổi, nước trong. Khi miếng thịt chín, protein đông tụ khiến thớ co lại, khối thịt nhẹ đi và nổi dần lên mặt nước. Cách này đơn giản, nhưng không phải lúc nào cũng đúng. Thịt ba chỉ nổi nhanh hơn thịt nạc. Xét dưới góc độ khoa học, khi luộc, nhiệt truyền vào thịt theo cơ chế đối lưu và dẫn nhiệt. Bề mặt bên ngoài thịt tiếp xúc với nước sôi ở 100°C, nhưng phải cần một khoảng thời gian để nhiệt đi dần vào lõi. Trong khi đó, protein trong thịt biến đổi theo từng ngưỡng nhiệt: myosin bắt đầu đông đặc ở 40–50°C khiến thớ thịt săn lại; actin biến tính ở 70–80°C quyết định độ cứng; collagen trong gân, bì chỉ thật sự mềm ở 68–80°C. Khi thịt nổi, lớp ngoài có thể đã co rút, tạo túi khí và làm miếng thịt nhẹ hơn, nhưng lõi vẫn chưa chín. Chỉ khi cắm đũa và không còn dịch hồng rỉ ra, mới chắc chắn lõi đã đạt 70–75°C. Điều này lý giải vì sao kinh nghiệm \"cắm đũa thấy không ra nước hồng là thịt đã chín\" từ xưa là hoàn toàn có cơ sở khoa học.', 'published', '2026-01-10 18:50:22', 1, '2026-01-10 19:20:45');
INSERT INTO `news` VALUES (2, 'Xe tải chở gần 6 tấn thịt hôi thối', 'Hoàng Táo', 'images/news2.png', 'QUẢNG TRỊ - Xe tải chở gần 6 tấn thịt bốc mùi, chảy nước, không giấy tờ kiểm dịch đang trên đường từ Hà Nội sang Lào thì bị cảnh sát phát hiện. 11h20 ngày 8/2, tại Km37 quốc lộ 9, đoạn qua xã Hướng Hiệp, huyện Đakrong, Cảnh sát phòng chống tội phạm về môi trường phối hợp với Trạm CSGT Đakrông dừng kiểm tra ôtô tải do tài xế Võ Tá Ý điều khiển. Nhà chức trách phát hiện xe chở 172 bao tải chứa 5,9 tấn thịt bốc mùi hôi, màu sắc biến đổi, chảy nước. Trong đó, 80 bao lưỡi heo, 20 bao tai heo, 10 bao thịt nạc heo, 23 bao da heo, 10 bao chân gà, 15 bao thịt vụn, 15 bao nạm bò. Số thịt này không có giấy chứng nhận kiểm dịch, được vận chuyển bằng phương tiện không bảo đảm yêu cầu vệ sinh thú y. Chủ hàng khai nhận số thịt này được lấy từ khu công nghiệp Quang Minh, Hà Nội sau đó vận chuyển bằng xe đông lạnh vào Thừa Thiên Huế rồi dùng xe tải đưa sang Lào tiêu thụ.', 'published', '2023-02-09 14:49:00', 1, '2023-02-09 14:49:00');
INSERT INTO `news` VALUES (3, 'Lợi ích ít biết của thịt gà', 'Bảo Bảo', 'images/news3.png', 'Thịt gà rất giàu protein, ít calo, chất béo, hỗ trợ giảm cân, tăng cơ và thúc đẩy sức khỏe tim mạch, cải thiện tâm trạng. Thịt gà là một trong những loại thịt phổ biến trong bữa ăn hàng ngày. Thực phẩm này dễ chế biến, có thể làm thành nhiều món ăn khác nhau. Giá trị dinh dưỡng: Thị gà rất nhiều chất dinh dưỡng quan trọng bao gồm protein, niacin, selen và phốt pho. Một khẩu phần ức gà 85 g chứa: Calo: 122 kcal, Protein: 24 g, Chất béo: 3 g, Carb: 0 g. Lượng dinh dưỡng cơ thể cần hàng ngày (DV): Vitamin B3: 51%, Selen: 36%, Phốt pho: 17%, Vitamin B6: 16%, Vitamin B12: 10%. Protein trong thịt gà rất cần thiết cho việc xây dựng và sửa chữa các mô. Nhóm vitamin B như B3, B6 và B12 đóng vai trò quan trọng trong việc sản xuất năng lượng, tổng hợp DNA và sức khỏe não bộ. Lợi ích sức khỏe: Hỗ trợ giảm cân vì ít calo nhưng giàu protein; Hỗ trợ tập luyện tăng trưởng cơ bắp; Hỗ trợ xương và cơ chắc khỏe hơn bảo vệ cơ thể khi tuổi già; Tăng cường sức khỏe tim mạch và Cải thiện tâm trạng. Lưu ý khi ăn thịt gà: nên ăn gà nướng, gà hầm thay vì gà rán giòn vì chứa nhiều chất béo, calo không lành mạnh.', 'published', '2025-10-27 06:00:00', 1, '2026-01-10 19:51:52');
INSERT INTO `news` VALUES (4, 'Người Nhật Bản chuộng thịt gà chế biến của Việt Nam', 'Thu Hà', 'images/news4.png', 'Thịt gà chế biến của doanh nghiệp Việt đang được đón nhận tại thị trường Nhật Bản. Sau 3 năm kể từ khi xuất khẩu lô gà chế biến đầu tiên sang Nhật Bản, ông Pawalit Ua-Amornwanit, Tổng Giám đốc C.P Việt Nam cho biết, đến nay đơn vị này đã xuất khẩu thành công 10.000 tấn thịt gà chế biến sang thị trường này. Ông tin rằng điều này cho thấy Việt Nam ngày càng đủ năng lực đáp ứng các tiêu chuẩn xuất khẩu thực phẩm nghiêm ngặt, đặc biệt tại thị trường cao cấp như Nhật Bản. Tuy nhiên, doanh nghiệp cho biết, hiện các sản phẩm vẫn chưa bán trực tiếp cho người tiêu dùng Nhật Bản mà phải thông qua các kênh phân phối và đối tác địa phương. Đơn cử, nếu muốn bán sản phẩm qua hệ thống 7-Eleven của Nhật Bản, nhà máy phải hợp tác với công ty quản lý kênh này để phân phối sản phẩm theo đơn đặt hàng của đối tác. Tháng 9-2025, Việt Nam và Nhật Bản đã khởi động Giai đoạn 3 của Tầm nhìn Trung và Dài hạn về hợp tác nông nghiệp (2025-2030), sau nhiều năm hợp tác ổn định trong lĩnh vực nông lâm thủy sản, với giá trị thương mại tăng từ 3,02 tỉ USD năm 2015 lên khoảng 4,9 tỉ USD vào năm 2024.', 'published', '2025-10-24 17:54:00', 1, '2026-01-10 19:57:51');
INSERT INTO `news` VALUES (5, 'Tranh cãi vì sao giá thịt bò ở Mỹ ngày càng đắt đỏ', 'Phiên An', 'images/news5.png', 'Ông Trump cáo buộc các doanh nghiệp thao túng khiến giá thịt bò tăng cao trong khi nhà chế biến nói nguồn cung trong nước và nhập khẩu siết chặt. Hôm thứ sáu (7/11), Tổng thống Mỹ Donald Trump lên tiếng cáo buộc cộng đồng các doanh nghiệp thịt đã cùng nhau đẩy giá thịt bò tại Mỹ lên mức kỷ lục. Theo Cục Thống kê Lao động, giá bán lẻ mỗi pound thịt bò xay vào tháng 9 là khoảng 6,33 USD, tăng 13,5% so với cùng kỳ 2024. Trên mạng xã hội Truth Social, ông Trump cho biết đã chỉ đạo Bộ Tư pháp mở cuộc điều tra về việc các công ty chế biến đang đẩy giá thịt bò lên, bằng cách thông đồng bất hợp pháp, ấn định giá và thao túng giá. Động thái diễn ra trong bối cảnh người dân Mỹ đang lo lắng về túi tiền, đặc biệt là giá thực phẩm tăng nhanh hơn lạm phát. Không công ty cụ thể nào bị Nhà Trắng nêu đích danh. Hiện ở Mỹ, Tyson Foods, Cargill, JBS USA và National Beef Packing Company đang giết mổ khoảng 85% số bò được vỗ béo bằng ngũ cốc, nguồn cung cấp thịt dùng làm bít tết tại siêu thị. Giới kinh doanh cho rằng giá thịt bò ở Mỹ lập đỉnh vào 2025 sau nhiều năm hạn hán thiêu rụi đồng cỏ và đẩy chi phí thức ăn chăn nuôi tăng cao, buộc các chủ trại phải cắt giảm đàn bò xuống mức thấp nhất gần 75 năm.', 'published', '2025-11-09 00:03:00', 1, '2026-01-10 19:58:05');
INSERT INTO `news` VALUES (6, 'Người đàn ông suýt mất mạng sau chế biến thịt lợn sống', 'Thúy Quỳnh', 'images/news6.png', 'QUẢNG NINH - Sau khi chế biến thịt lợn sống, người đàn ông 61 tuổi sốt cao, nổi vân tím toàn thân, đau bụng, bác sĩ phát hiện nhiễm liên cầu lợn, tiên lượng tử vong. Ngày 21/8, đại diện Bệnh viện Bãi Cháy cho biết bệnh nhân nhập viện trong tình trạng sốt cao, mệt mỏi nhiều, hội chứng nhiễm trùng, mất nước. Kết quả siêu âm, chụp CT có hình ảnh tràn dịch khoang màng phổi hai bên, xẹp phổi. Bác sĩ chẩn đoán sốc nhiễm khuẩn, nhiễm khuẩn huyết, viêm phổi trên nền tăng huyết áp, tiên lượng tử vong rất cao. Bệnh nhân được điều trị hồi sức tích cực chuyên sâu theo phác đồ với kháng sinh, an thần thở máy, lọc máu liên tục, truyền dịch, vận mạch. Sau 7 ngày, người bệnh có tình trạng đau đầu, ý thức chậm, chẩn đoán viêm màng não do liên cầu lợn. Hiện, bệnh nhân thoát nguy kịch, sức khỏe ổn định. Liên cầu khuẩn lợn là bệnh lây truyền từ động vật sang người, chưa có bằng chứng bệnh lây từ người sang người. Bệnh nặng có thể tiến triển nhanh chóng thành nhiễm khuẩn huyết sốc nhiễm khuẩn, tụt huyết áp, rối loạn đông máu, hôn mê và tử vong. Cơ quan y tế khuyến cáo chỉ ăn thịt lợn đã được nấu chín hoàn toàn, không ăn tiết canh và các món tái sống. Khi chế biến thịt lợn, cần sử dụng găng tay bảo hộ để tránh nguy cơ lây nhiễm.', 'published', '2025-08-21 13:55:00', 1, '2026-01-16 20:53:20');
INSERT INTO `news` VALUES (7, '5 sai lầm phổ biến khiến món thịt bò xào bị dai', 'Bùi Thủy', 'images/news7.png', 'Nhiều người nội trợ thắc mắc tại sao dù chọn miếng thịt bò tươi ngon, khi xào lên vẫn bị khô và dai cứng. Vấn đề không chỉ nằm ở miếng thịt mà còn ở cách chúng ta xử lý và kiểm soát nhiệt độ. Thịt bò có cấu trúc sợi cơ to và nhiều mô liên kết (collagen) hơn thịt heo, gà. Khi gặp nhiệt độ cao đột ngột và trong thời gian ngắn như lúc xào, các protein chính trong thịt sẽ co rút mạnh. Những sai lầm phổ biến khiến bò xào dai: Xào quá kỹ khiến protein co rút tối đa, nước bốc hơi hết. Ướp muối, nước mắm quá sớm làm gia vị mặn rút nước ra khỏi thịt nhanh chóng. Cho thịt vào chảo khô quá nóng, bề mặt thịt cháy xém tức thì trong khi bên trong chưa chín tới. Thái thịt sai thớ. Bí quyết để món bò xào luôn mềm mọng: Luôn thái thịt ngang thớ. Ướp thịt với một ít dầu ăn, bột bắp trước khi nêm gia vị. Chỉ nêm gia vị mặn khi thịt đã gần chín. Xào thịt bò trên lửa lớn thật nhanh tay. Xào riêng rau củ trước, sau đó mới cho thịt bò đã xào sơ vào đảo nhanh ở bước cuối cùng để làm nóng và hòa quyện gia vị. Cách này đảm bảo thịt vừa chín tới, giữ được độ mềm và ngọt.', 'published', '2025-10-25 17:41:00', 1, '2026-01-16 20:56:05');
INSERT INTO `news` VALUES (8, 'Trời lạnh, nhất định phải ăn 5 món hấp này', 'Huệ Lan', 'images/news8.png', 'Mùa đông, tiết trời lạnh, bạn nhất định không thể bỏ qua 5 món hấp này. Vừa đơn giản, vừa tươi mát, thơm ngon, lại ấm áp. Thời gian nấu chỉ từ 15 phút là hoàn thành. Hấp chính là kỹ nghệ nấu nướng hoàn hảo giúp giữ được hương vị nguyên bản mà thao tác đơn giản, nấu cũng siêu nhanh. 1. Đùi gà hấp đậu phụ và đậu nành Nhật Bản: Đùi gà chặt miếng nhỏ ướp gia vị, xếp đậu phụ ở đĩa lòng sâu, gà ở trên rồi hấp 20 phút. 2. Sườn heo hấp nấm nhung hươu: Ướp sườn với nước tương, gừng, bắp, tỏi, nấm nhung ngâm nở rồi cho vào đĩa hấp 30 phút, thành phẩm ngọt thanh. 3. Thịt gà hấp nấm: Ướp đùi gà nhuyễn xương với nấm hương và xì dầu dầu hào, bỏ vào nồi cách thuỷ 30 phút. 4. Thịt bò hấp cải thảo non: Miếng bò mỏng lót trên lá cải thảo, chỉ cần hấp 12-15 phút để lấy vị thanh mát. 5. Trứng hấp phi lê cá: Cá lấy phi lê ướp gừng hành, trứng quậy chưng trước 8 phút rồi bỏ cá lên trên mặt chưng thêm 10 phút, ăn miếng ngon như bánh pudding cá ngọt ngào ấm áp giữa mùa đông.', 'published', '2025-11-06 06:00:00', 1, '2026-01-16 20:56:08');

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, 3, 760000.00, 'Chờ xác nhận', '2026-04-02 16:38:07', '2026-04-02 16:38:07', 11, 1, 1);
INSERT INTO `orders` VALUES (2, 3, 320000.00, 'Chờ xác nhận', '2026-04-02 16:38:24', '2026-04-02 16:38:24', 11, 1, 2);
INSERT INTO `orders` VALUES (3, 3, 590000.00, 'Chờ xác nhận', '2026-04-02 16:42:07', '2026-04-02 16:42:07', 11, 1, 2);

-- ----------------------------
-- Table structure for orders_item
-- ----------------------------
DROP TABLE IF EXISTS `orders_item`;
CREATE TABLE `orders_item`  (
  `order_id` int NOT NULL,
  `item_id` int NOT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `weight` int NOT NULL,
  `quantity` decimal(10, 2) NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`, `item_id`, `weight`) USING BTREE,
  INDEX `item_id`(`item_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders_item
-- ----------------------------
INSERT INTO `orders_item` VALUES (1, 94, 760000.00, 1000, 1.00, '2026-04-02 16:38:07');
INSERT INTO `orders_item` VALUES (2, 25, 320000.00, 250, 1.00, '2026-04-02 16:38:24');
INSERT INTO `orders_item` VALUES (3, 22, 270000.00, 500, 1.00, '2026-04-02 16:42:07');
INSERT INTO `orders_item` VALUES (3, 25, 320000.00, 250, 1.00, '2026-04-02 16:42:07');

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
INSERT INTO `origin` VALUES (1, 'Việt Nam', NULL, '2026-04-02 23:20:00', '2026-04-02 23:20:00');
INSERT INTO `origin` VALUES (2, 'Mỹ', NULL, '2026-04-02 23:20:00', '2026-04-02 23:20:00');
INSERT INTO `origin` VALUES (3, 'Úc', NULL, '2026-04-02 23:20:00', '2026-04-02 23:20:00');
INSERT INTO `origin` VALUES (6, 'Hàn Quốc', NULL, '2026-04-02 23:20:00', '2026-04-02 23:20:00');
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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of payment
-- ----------------------------
INSERT INTO `payment` VALUES (1, 'Thanh toán khi nhận hàng (COD)', b'1', '2026-04-01 11:05:18', '2026-04-01 11:06:21');
INSERT INTO `payment` VALUES (2, 'Thanh toán qua VNPay', b'1', '2026-04-01 11:05:33', '2026-04-01 11:06:36');
INSERT INTO `payment` VALUES (3, 'Thanh toán qua Momo', b'1', '2026-04-01 11:06:51', '2026-04-01 11:06:51');

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_config
-- ----------------------------
INSERT INTO `system_config`VALUES (1, 'Clean Meat', 'cleanmeat@gmail.com', '0312345678', 'MS123456', 'https://www.facebook.com/cleanmeat', '142 Đường số 10, Khu dân cư Tân Quy Đông, Phường Tân Phong, Quận 7, TP.HCM.', 'https://example.com/cleanmeat.png');

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
  `free_ship` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of transport
-- ----------------------------
INSERT INTO `transport` VALUES (1, 'Giao hàng nhanh', 15000, 2, b'1', '2026-04-01 11:08:43', '2026-04-01 20:52:31', 100000);
INSERT INTO `transport` VALUES (2, 'Giao hàng tiết kiệm', 25000, 3, b'1', '2026-04-01 11:09:32', '2026-04-01 20:52:35', 100000);

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'Nguyễn Bích Dân', '23130040@st.hcmuaf.edu.vn', '$2a$12$KooUNBYAOltcr.gzrDM6luFM6AXJTaq23VfEj61fmUEUyzNdy33nq', '0312345678', 'other', '2026-03-31', 'admin', 'https://pub-71ec9cf4f0b64801a2907204d81a0b26.r2.dev/1_1713542063746.png', '2026-03-31 15:49:51', '2026-03-31 22:52:56', b'1', NULL);
INSERT INTO `user` VALUES (3, 'Nguyễn Bích Dân', 'bichdantqn2005@gmail.com', '$2a$12$1YY7cndfEIO8WWGfQZ.Cf.OOv6tIBxdJNTOP5fBbQzWgCyRagwDtG', '0312345678', 'Other', '2026-03-31', 'customer', NULL, '2026-03-31 16:09:26', '2026-03-31 23:42:13', b'1', NULL);

SET FOREIGN_KEY_CHECKS = 1;
