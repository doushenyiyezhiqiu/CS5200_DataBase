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
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'cascading delete student',
  `college` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`college`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of college
-- ----------------------------
INSERT INTO `college` VALUES (59, 'Khoury College of Computer Sciences');
INSERT INTO `college` VALUES (60, 'College of Engineering');

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `colleges` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `teachname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `star` int NULL DEFAULT 0,
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
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
INSERT INTO `course` VALUES ('Khoury College of Computer Sciences', 'Alex', 'Computer System', 1, '12021591');
INSERT INTO `course` VALUES ('Khoury College of Computer Sciences', 'Alex', 'Database', 1, '12021591');
INSERT INTO `course` VALUES ('Khoury College of Computer Sciences', 'Alex', 'Data Visualization', 2, '12021591');
INSERT INTO `course` VALUES ('Khoury College of Computer Sciences', 'Alex', 'Data Mining', 1, '12021591');
INSERT INTO `course` VALUES ('Khoury College of Computer Sciences', 'Alex', 'Computer Security', 3, '12021591');

-- ----------------------------
-- Table structure for major
-- ----------------------------
DROP TABLE IF EXISTS `major`;
CREATE TABLE `major`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `college` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'College',
  `proname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Major name',
  PRIMARY KEY (`proname`) USING BTREE,
  UNIQUE INDEX `id_name`(`id`) USING BTREE COMMENT 'unique',
  INDEX `co_1`(`college`) USING BTREE,
  CONSTRAINT `co_1` FOREIGN KEY (`college`) REFERENCES `college` (`college`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of major
-- ----------------------------
INSERT INTO `major` VALUES (33, 'Khoury College of Computer Sciences', 'Computer Science');
INSERT INTO `major` VALUES (34, 'College of Engineering', 'Electrical and Computer Engineering');

-- ----------------------------
-- Table structure for optcous
-- ----------------------------
DROP TABLE IF EXISTS `optcous`;
CREATE TABLE `optcous`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'CRN',
  `college` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'College',
  `teanum` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'teacher id',
  `teacher` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'teacher',
  `coursname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'course name',
  `clstime` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'time',
  `numpeo` int NULL DEFAULT 0 COMMENT 'student number',
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
INSERT INTO `optcous` VALUES (12021541, 'Khoury College of Computer Sciences', '12021591', 'Alex', 'Computer System', 'morning', 1);
INSERT INTO `optcous` VALUES (12021542, 'Khoury College of Computer Sciences', '12021591', 'Alex', 'Database', 'morning', 1);
INSERT INTO `optcous` VALUES (12021543, 'Khoury College of Computer Sciences', '12021591', 'Alex', 'Data Mining', 'morning', 0);

-- ----------------------------
-- Table structure for studengcours
-- ----------------------------
DROP TABLE IF EXISTS `studengcours`;
CREATE TABLE `studengcours`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'SN',
  `college` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'college',
  `pro` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT 'major',
  `optcouse` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'course name',
  `count` int NULL DEFAULT NULL COMMENT 'score',
  `stunum` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'student id',
  `cousid` int NULL DEFAULT NULL COMMENT 'course ID',
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
INSERT INTO `studengcours` VALUES (171, 'Khoury College of Computer Sciences', 'Computer Science', 'Computer System', 98, '2021592', 12021541);
INSERT INTO `studengcours` VALUES (172, 'Khoury College of Computer Sciences', 'Computer Science', 'Database', 99, '2021592', 12021542);

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `oncollege` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `peojob` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `inyear` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `co_5`(`oncollege`) USING BTREE,
  INDEX `peojob`(`peojob`) USING BTREE,
  CONSTRAINT `co_5` FOREIGN KEY (`oncollege`) REFERENCES `college` (`college`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `q_8` FOREIGN KEY (`peojob`) REFERENCES `major` (`proname`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('2021592', 'Jack', 'Khoury College of Computer Sciences', 'Computer Science', 'Male', '2021');
INSERT INTO `student` VALUES ('2021593', 'Victor', 'College of Engineering', 'Electrical and Computer Engineering', 'Male', '2021');


-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `oncollege` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edu` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `inyear` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `co_6`(`oncollege`) USING BTREE,
  INDEX `name`(`name`) USING BTREE,
  CONSTRAINT `co_6` FOREIGN KEY (`oncollege`) REFERENCES `college` (`college`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('12021591', 'Alex', 'Khoury College of Computer Sciences', 'Doctor', 'Male', '2021');
INSERT INTO `teacher` VALUES ('12021592', 'Tony', 'College of Engineering', 'Doctor', 'Male', '2022');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `account` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pow` int NULL DEFAULT NULL COMMENT '1 is manager 2 is teacher 3 is student',
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
-- Records of students to teachers
-- ----------------------------

DROP TABLE IF EXISTS `teachers_to_students`;
CREATE TABLE `teachers_to_students`(
`student_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
`student_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
`teacher_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
`teacher_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
PRIMARY KEY (`student_id`,`teacher_id`) USING BTREE,
FOREIGN KEY(`student_id`) REFERENCES `student`(`id`) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;


INSERT INTO `teachers_to_students` VALUES('2021592', 'Jack','12021591', 'Alex');

-- ----------------------------
-- Records of students' reviews
-- ----------------------------

DROP TABLE IF EXISTS `student_reviews`;
CREATE TABLE `student_reviews`(
`student_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
`course_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
`review_content`  varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
PRIMARY KEY (`student_id`,`course_name`) USING BTREE,
FOREIGN KEY(`student_id`) REFERENCES `student`(`id`) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

INSERT INTO `student_reviews` VALUES('2021592', 'Computer System', 'Good');

-- ----------------------------
-- Records of syllabus of course
-- ---------------------------

DROP TABLE IF EXISTS `course_syllabus`;
CREATE TABLE `course_syllabus`(
`course_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
`syllabus_content`  varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
PRIMARY KEY (`course_name`) USING BTREE
)ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

INSERT INTO `course_syllabus` VALUES('Computer System', 'score>=90:A;80<=score<90,B;60<=score<80,C;score<60:D');

-- ----------------------------
-- Procedure for optcous
-- ----------------------------

DROP PROCEDURE IF EXISTS `student_course`;
delimiter $$
CREATE PROCEDURE `student_course`(
	IN student_id VARCHAR(100))
BEGIN
SELECT `id`, `coursname` FROM `optcous` WHERE `id` = student_id
; 
END$$

delimiter ;

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
