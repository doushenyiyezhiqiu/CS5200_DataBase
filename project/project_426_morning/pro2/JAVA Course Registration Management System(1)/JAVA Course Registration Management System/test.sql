/*
 Navicat Premium Data Transfer

 Source Server         : mysql数据库
 Source Server Type    : MySQL
 Source Server Version : 80021
 Source Host           : localhost:3306
 Source Schema         : courese

 Target Server Type    : MySQL
 Target Server Version : 80021
 File Encoding         : 65001

 Date: 27/08/2021 15:39:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for college
-- ----------------------------
DROP TABLE IF EXISTS `college`;
CREATE TABLE `college`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '删除学院旗下学生也会删除',
  `college` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`college`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of college
-- ----------------------------
INSERT INTO `college` VALUES (59, '计算机学院');
INSERT INTO `college` VALUES (60, '通信学院');

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `colleges` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `teachname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `star` int NULL DEFAULT 0,
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  INDEX `co`(`colleges`) USING BTREE,
  INDEX `bo_1`(`teachname`) USING BTREE,
  INDEX `cname`(`cname`) USING BTREE,
  INDEX `tem`(`id`) USING BTREE,
  CONSTRAINT `co` FOREIGN KEY (`colleges`) REFERENCES `college` (`college`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bo_1` FOREIGN KEY (`teachname`) REFERENCES `teacher` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tem` FOREIGN KEY (`id`) REFERENCES `teacher` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('计算机学院', '路飞', '大数据可视化', 1, '12021591');
INSERT INTO `course` VALUES ('计算机学院', '路飞', 'mysqld', 1, '12021591');
INSERT INTO `course` VALUES ('计算机学院', '路飞', 'java', 2, '12021591');
INSERT INTO `course` VALUES ('计算机学院', '路飞', 'excel', 1, '12021591');
INSERT INTO `course` VALUES ('计算机学院', '路飞', '测试数据', 3, '12021591');

-- ----------------------------
-- Table structure for major
-- ----------------------------
DROP TABLE IF EXISTS `major`;
CREATE TABLE `major`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `college` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '学院',
  `proname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '专业名称',
  PRIMARY KEY (`proname`) USING BTREE,
  UNIQUE INDEX `id_name`(`id`) USING BTREE COMMENT '唯一',
  INDEX `co_1`(`college`) USING BTREE,
  CONSTRAINT `co_1` FOREIGN KEY (`college`) REFERENCES `college` (`college`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of major
-- ----------------------------
INSERT INTO `major` VALUES (33, '计算机学院', '互联网');
INSERT INTO `major` VALUES (34, '通信学院', '移动应用');

-- ----------------------------
-- Table structure for optcous
-- ----------------------------
DROP TABLE IF EXISTS `optcous`;
CREATE TABLE `optcous`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '课程编码',
  `college` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学院',
  `teanum` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '老师工号',
  `teacher` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '老师',
  `coursname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '课程名字',
  `clstime` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时间',
  `numpeo` int NULL DEFAULT 0 COMMENT '人数',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `co_3`(`college`) USING BTREE,
  INDEX `t_1`(`teacher`) USING BTREE,
  INDEX `t_2`(`coursname`) USING BTREE,
  INDEX `t_4`(`teanum`) USING BTREE,
  CONSTRAINT `co_3` FOREIGN KEY (`college`) REFERENCES `college` (`college`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_1` FOREIGN KEY (`teacher`) REFERENCES `teacher` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_2` FOREIGN KEY (`coursname`) REFERENCES `course` (`cname`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_4` FOREIGN KEY (`teanum`) REFERENCES `teacher` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of optcous
-- ----------------------------
INSERT INTO `optcous` VALUES (12021541, '计算机学院', '12021591', '路飞', '大数据可视化', '第一大节', 1);
INSERT INTO `optcous` VALUES (12021542, '计算机学院', '12021591', '路飞', 'mysqld', '第一大节', 1);
INSERT INTO `optcous` VALUES (12021543, '计算机学院', '12021591', '路飞', 'excel', '第一大节', 0);

-- ----------------------------
-- Table structure for studengcours
-- ----------------------------
DROP TABLE IF EXISTS `studengcours`;
CREATE TABLE `studengcours`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
  `college` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学院',
  `pro` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '专业',
  `optcouse` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '选课的名称',
  `count` int NULL DEFAULT NULL COMMENT '分数',
  `stunum` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学号',
  `cousid` int NULL DEFAULT NULL COMMENT '课程ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `stu_s`(`stunum`) USING BTREE,
  INDEX `cou_s`(`cousid`) USING BTREE,
  INDEX `co_4`(`college`) USING BTREE,
  INDEX `t_5`(`optcouse`) USING BTREE,
  INDEX `t_6`(`pro`) USING BTREE,
  CONSTRAINT `cou_s` FOREIGN KEY (`cousid`) REFERENCES `optcous` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stu_s` FOREIGN KEY (`stunum`) REFERENCES `student` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `co_4` FOREIGN KEY (`college`) REFERENCES `college` (`college`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_5` FOREIGN KEY (`optcouse`) REFERENCES `course` (`cname`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_6` FOREIGN KEY (`pro`) REFERENCES `student` (`peojob`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 151 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of studengcours
-- ----------------------------
INSERT INTO `studengcours` VALUES (171, '计算机学院', '互联网', '大数据可视化', 98, '2021592', 12021541);
INSERT INTO `studengcours` VALUES (172, '计算机学院', '互联网', 'mysqld', 99, '2021592', 12021542);

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `oncollege` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `peojob` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `inyear` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `co_5`(`oncollege`) USING BTREE,
  INDEX `peojob`(`peojob`) USING BTREE,
  CONSTRAINT `co_5` FOREIGN KEY (`oncollege`) REFERENCES `college` (`college`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `q_8` FOREIGN KEY (`peojob`) REFERENCES `major` (`proname`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('2021592', '鸣人', '计算机学院', '互联网', '男', '2021年');

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `oncollege` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edu` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `inyear` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `co_6`(`oncollege`) USING BTREE,
  INDEX `name`(`name`) USING BTREE,
  CONSTRAINT `co_6` FOREIGN KEY (`oncollege`) REFERENCES `college` (`college`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('12021591', '路飞', '计算机学院', '博士生', '男', '2021年');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `account` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是数字的表示',
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pow` int NULL DEFAULT NULL COMMENT '1是管理员2是老师3是学生',
  PRIMARY KEY (`account`) USING BTREE,
  UNIQUE INDEX `id_one`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 150404 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (161174, '12021591', '12021591', 2);
INSERT INTO `users` VALUES (161175, '2021592', '2021592', 3);
INSERT INTO `users` VALUES (1, 'root', 'root', 1);

-- ----------------------------
-- Triggers structure for table student
-- ----------------------------
DROP TRIGGER IF EXISTS `demos`;
delimiter ;;
CREATE TRIGGER `demos` BEFORE DELETE ON `student` FOR EACH ROW BEGIN

delete from users where account=old.id;


end
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table teacher
-- ----------------------------
DROP TRIGGER IF EXISTS `demo`;
delimiter ;;
CREATE TRIGGER `demo` BEFORE DELETE ON `teacher` FOR EACH ROW BEGIN

delete from users where account=old.id;


end
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
