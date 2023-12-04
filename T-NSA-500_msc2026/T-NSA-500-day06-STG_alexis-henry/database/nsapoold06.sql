/*
Navicat MySQL Data Transfer

Source Server         : baptisteheraud
Source Server Version : 50505
Source Host           : infra.baptisteheraud.com:3306
Source Database       : nsapoold06

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2023-10-02 15:00:12
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'marvin');
