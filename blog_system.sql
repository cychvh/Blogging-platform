/*
 Navicat Premium Dump SQL

 Source Server         : homework
 Source Server Type    : MySQL
 Source Server Version : 80026 (8.0.26)
 Source Host           : localhost:3306
 Source Schema         : blog_system

 Target Server Type    : MySQL
 Target Server Version : 80026 (8.0.26)
 File Encoding         : 65001

 Date: 24/08/2025 15:17:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for blogs
-- ----------------------------
DROP TABLE IF EXISTS `blogs`;
CREATE TABLE `blogs`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_id` bigint NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  INDEX `idx_title`(`title` ASC) USING BTREE,
  CONSTRAINT `blogs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of blogs
-- ----------------------------
INSERT INTO `blogs` VALUES (4, '项目总结', '项目开发经验总结...', 1, '2025-06-02 16:31:34', '2025-06-02 16:31:34');
INSERT INTO `blogs` VALUES (5, '前端开发', '前端开发技巧分享...', 1, '2025-06-07 16:31:34', '2025-06-07 16:31:34');
INSERT INTO `blogs` VALUES (6, '我的博客', '这是test1的第一篇博客...', 2, '2025-05-20 16:31:34', '2025-05-20 16:31:34');
INSERT INTO `blogs` VALUES (7, '开发日记', '开发过程记录...', 2, '2025-05-27 16:31:34', '2025-05-27 16:31:34');
INSERT INTO `blogs` VALUES (8, '心得体会', '学习心得分享...', 2, '2025-06-03 16:31:34', '2025-06-03 16:31:34');
INSERT INTO `blogs` VALUES (9, 'Vue学习笔记', 'Vue开发经验总结...', 2, '2025-06-10 16:31:34', '2025-06-10 16:31:34');
INSERT INTO `blogs` VALUES (10, '测试博客', '测试内容...', 3, '2025-05-22 16:31:34', '2025-05-22 16:31:34');
INSERT INTO `blogs` VALUES (11, '数据库学习', 'MySQL学习笔记...', 3, '2025-05-29 16:31:34', '2025-05-29 16:31:34');
INSERT INTO `blogs` VALUES (12, 'Spring Boot', 'Spring Boot使用技巧...', 3, '2025-06-05 16:31:34', '2025-06-05 16:31:34');
INSERT INTO `blogs` VALUES (13, '项目实践', '项目实战经验...', 3, '2025-06-12 16:31:34', '2025-06-12 16:31:34');
INSERT INTO `blogs` VALUES (14, '今日总结', '今天的工作总结...', 1, '2025-06-17 16:31:34', '2025-06-17 16:31:34');
INSERT INTO `blogs` VALUES (15, '技术分享', '分享今天学到的技术点...', 2, '2025-06-17 16:31:34', '2025-06-17 16:31:34');
INSERT INTO `blogs` VALUES (16, '第一篇博客', '111', 1, '2025-06-17 13:58:46', '2025-06-17 13:58:46');
INSERT INTO `blogs` VALUES (17, '222', '2222', 1, '2025-06-17 14:00:16', '2025-06-17 14:00:16');
INSERT INTO `blogs` VALUES (18, '2222', '2222', 1, '2025-06-17 14:02:25', '2025-06-17 14:02:25');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE,
  INDEX `idx_username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', '1234567', 'admin@example.com', '2025-06-17 16:31:34');
INSERT INTO `users` VALUES (2, 'test1', '123456', 'test1@example.com', '2025-06-17 16:31:34');
INSERT INTO `users` VALUES (3, 'test2', '123456', 'test2@example.com', '2025-06-17 16:31:34');
INSERT INTO `users` VALUES (4, 't3', '123456', NULL, '2025-06-17 14:02:03');
INSERT INTO `users` VALUES (5, 'cyc', '123456', NULL, '2025-08-24 07:05:32');

SET FOREIGN_KEY_CHECKS = 1;
