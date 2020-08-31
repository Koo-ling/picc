/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50642
 Source Host           : localhost:3306
 Source Schema         : picc

 Target Server Type    : MySQL
 Target Server Version : 50642
 File Encoding         : 65001

 Date: 31/08/2020 09:21:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_document
-- ----------------------------
DROP TABLE IF EXISTS `tb_document`;
CREATE TABLE `tb_document`  (
  `document_id` int(11) NOT NULL AUTO_INCREMENT,
  `seg_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `user_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `document_allocator_id` int(11) NULL DEFAULT NULL,
  `allocator_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `document_num` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `document_status` int(5) NULL DEFAULT NULL,
  `document_use_time` timestamp(0) NULL DEFAULT NULL,
  `document_create_time` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`document_id`) USING BTREE,
  INDEX `FK_FK_document_allocator`(`document_allocator_id`) USING BTREE,
  INDEX `FK_FK_document_seg`(`seg_id`) USING BTREE,
  INDEX `FK_FK_document_user`(`user_id`) USING BTREE,
  CONSTRAINT `FK_FK_document_allocator` FOREIGN KEY (`document_allocator_id`) REFERENCES `tb_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_FK_document_seg` FOREIGN KEY (`seg_id`) REFERENCES `tb_document_num_seg` (`seg_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_FK_document_user` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3605 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tb_document_num_seg
-- ----------------------------
DROP TABLE IF EXISTS `tb_document_num_seg`;
CREATE TABLE `tb_document_num_seg`  (
  `seg_id` int(11) NOT NULL AUTO_INCREMENT,
  `seg_allocator_id` int(11) NULL DEFAULT NULL,
  `document_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `seg_begin_num` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `seg_end_num` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `seg_allot_num` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `seg_status` int(5) NULL DEFAULT NULL,
  `seg_create_time` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`seg_id`) USING BTREE,
  INDEX `FK_FK_Seg_User`(`seg_allocator_id`) USING BTREE,
  CONSTRAINT `FK_FK_Seg_User` FOREIGN KEY (`seg_allocator_id`) REFERENCES `tb_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '领用的可以使用的单证' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tb_insurer
-- ----------------------------
DROP TABLE IF EXISTS `tb_insurer`;
CREATE TABLE `tb_insurer`  (
  `insurer_id` int(11) NOT NULL AUTO_INCREMENT,
  `insurer_card_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `insurer_card_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `insurer_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `insurer_phone` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `insurer_address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `insurer_birthday` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`insurer_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tb_log
-- ----------------------------
DROP TABLE IF EXISTS `tb_log`;
CREATE TABLE `tb_log`  (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `user_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `operation_model` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `operation_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `operation_time` timestamp(0) NULL DEFAULT NULL,
  `log_desc` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`log_id`) USING BTREE,
  INDEX `FK_log_user`(`user_id`) USING BTREE,
  CONSTRAINT `FK_log_user` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 400 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tb_organization
-- ----------------------------
DROP TABLE IF EXISTS `tb_organization`;
CREATE TABLE `tb_organization`  (
  `organization_id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`organization_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tb_policy
-- ----------------------------
DROP TABLE IF EXISTS `tb_policy`;
CREATE TABLE `tb_policy`  (
  `policy_id` int(11) NOT NULL AUTO_INCREMENT,
  `document_id` int(11) NULL DEFAULT NULL,
  `product_id` int(11) NULL DEFAULT NULL,
  `website_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `policy_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `document_num` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `document_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `policy_create_time` timestamp(0) NULL DEFAULT NULL,
  `policy_begin_time` timestamp(0) NULL DEFAULT NULL,
  `policy_end_time` timestamp(0) NULL DEFAULT NULL,
  `policy_num` int(10) NULL DEFAULT NULL,
  `policy_premium` decimal(10, 2) NULL DEFAULT NULL,
  `policy_premium_total` decimal(10, 2) NULL DEFAULT NULL,
  `policy_coverage` decimal(10, 2) NULL DEFAULT NULL,
  `policy_coverage_total` decimal(10, 2) NULL DEFAULT NULL,
  `policy_holder_id` int(11) NULL DEFAULT NULL,
  `insured_id` int(11) NULL DEFAULT NULL,
  `beneficiary_id` int(11) NULL DEFAULT NULL,
  `policy_status` int(5) NULL DEFAULT NULL,
  PRIMARY KEY (`policy_id`) USING BTREE,
  INDEX `FK_FK_policy_beneficiary`(`beneficiary_id`) USING BTREE,
  INDEX `FK_FK_policy_document`(`document_id`) USING BTREE,
  INDEX `FK_FK_policy_holder`(`policy_holder_id`) USING BTREE,
  INDEX `FK_FK_policy_insured`(`insured_id`) USING BTREE,
  INDEX `FK_FK_policy_product`(`product_id`) USING BTREE,
  INDEX `FK_FK_policy_user`(`user_id`) USING BTREE,
  INDEX `FK_FK_policy_website`(`website_id`) USING BTREE,
  CONSTRAINT `FK_FK_policy_beneficiary` FOREIGN KEY (`beneficiary_id`) REFERENCES `tb_insurer` (`insurer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_FK_policy_document` FOREIGN KEY (`document_id`) REFERENCES `tb_document` (`document_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_FK_policy_holder` FOREIGN KEY (`policy_holder_id`) REFERENCES `tb_insurer` (`insurer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_FK_policy_insured` FOREIGN KEY (`insured_id`) REFERENCES `tb_insurer` (`insurer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_FK_policy_product` FOREIGN KEY (`product_id`) REFERENCES `tb_product` (`product_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_FK_policy_user` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_FK_policy_website` FOREIGN KEY (`website_id`) REFERENCES `tb_website` (`website_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 105 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tb_product
-- ----------------------------
DROP TABLE IF EXISTS `tb_product`;
CREATE TABLE `tb_product`  (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NULL DEFAULT NULL,
  `product_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `product_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `document_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `product_info` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `product_time_limit` int(10) NULL DEFAULT NULL,
  `product_coverage` decimal(10, 2) NULL DEFAULT NULL,
  `product_premium` decimal(10, 2) NULL DEFAULT NULL,
  `product_compensate1` decimal(10, 2) NULL DEFAULT NULL,
  `product_compensate2` decimal(10, 2) NULL DEFAULT NULL,
  `product_compensate3` decimal(10, 2) NULL DEFAULT NULL,
  `product_compensate4` decimal(10, 2) NULL DEFAULT NULL,
  `product_status` int(2) NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`) USING BTREE,
  INDEX `FK_FK_product_type`(`type_id`) USING BTREE,
  CONSTRAINT `FK_FK_product_type` FOREIGN KEY (`type_id`) REFERENCES `tb_product_type` (`type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tb_product_type
-- ----------------------------
DROP TABLE IF EXISTS `tb_product_type`;
CREATE TABLE `tb_product_type`  (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user`  (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_role` int(5) NULL DEFAULT NULL,
  `user_create_time` timestamp(0) NULL DEFAULT NULL,
  `user_status` int(5) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '1、出单员\r\n2、保险公司管理员\r\n3、景区管理员' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tb_website
-- ----------------------------
DROP TABLE IF EXISTS `tb_website`;
CREATE TABLE `tb_website`  (
  `website_id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NULL DEFAULT NULL,
  `marketing_channel_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `website_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `website_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `saleman_phone` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `saleman_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`website_id`) USING BTREE,
  INDEX `FK_FK_webiste_organization`(`organization_id`) USING BTREE,
  CONSTRAINT `FK_FK_webiste_organization` FOREIGN KEY (`organization_id`) REFERENCES `tb_organization` (`organization_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;
