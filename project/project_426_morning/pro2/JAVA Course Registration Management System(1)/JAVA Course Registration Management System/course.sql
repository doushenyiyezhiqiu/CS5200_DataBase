/*
 Source Host           : localhost:3306
 Source Schema         : course
 Date: 
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for college
-- ----------------------------
DROP TABLE IF EXISTS `college`;
CREATE TABLE `college`  (
  `college_id` int NOT NULL AUTO_INCREMENT COMMENT 'student will be deleted if college is deleted',
  `college_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`college_id`) USING BTREE,
  UNIQUE INDEX `name`(`college_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of college
-- ----------------------------
INSERT INTO `college` VALUES (59, 'khoury college of computer sciences');
INSERT INTO `college` VALUES (60, 'college of engineering');

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `college_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `teacher_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `course_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `credit` int NULL DEFAULT 0,
  `teacher_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  INDEX `co`(`college_name`) USING BTREE,
  INDEX `bo_1`(`teacher_name`) USING BTREE,
  INDEX `cname`(`course_name`) USING BTREE,
  INDEX `tem`(`teacher_id`) USING BTREE,
  CONSTRAINT `co` FOREIGN KEY (`college_name`) REFERENCES `college` (`college_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bo_1` FOREIGN KEY (`teacher_name`) REFERENCES `teacher` (`teacher_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tem` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`teacher_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('khoury college of computer sciences', 'Alex', 'Data Visualization', 1, '12021591');
INSERT INTO `course` VALUES ('khoury college of computer sciences', 'Alex', 'Computer System', 1, '12021591');
INSERT INTO `course` VALUES ('khoury college of computer sciences', 'Alex', 'Compiler', 2, '12021591');
INSERT INTO `course` VALUES ('khoury college of computer sciences', 'Alex', 'Advanced Software Development', 1, '12021591');
INSERT INTO `course` VALUES ('khoury college of computer sciences', 'Alex', 'Assistive Robotics', 3, '12021591');

-- ----------------------------
-- Table structure for major
-- ----------------------------
DROP TABLE IF EXISTS `major`;
CREATE TABLE `major`  (
  `major_id` int NOT NULL AUTO_INCREMENT,
  `college_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `major_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`major_name`) USING BTREE,
  UNIQUE INDEX `id_name`(`major_id`) USING BTREE ,
  INDEX `co_1`(`college_name`) USING BTREE,
  CONSTRAINT `co_1` FOREIGN KEY (`college_name`) REFERENCES `college` (`college_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of major
-- ----------------------------
INSERT INTO `major` VALUES (33, 'khoury college of computer sciences', 'Computer Science');
INSERT INTO `major` VALUES (34, 'college of engineering', 'electrical and computer engineering');

-- ----------------------------
-- Table structure for available_course
-- ----------------------------
DROP TABLE IF EXISTS `available_course`;
CREATE TABLE `available_course`  (
  `course_id` int NOT NULL AUTO_INCREMENT,
  `college_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `teacher_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `teacher_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `course_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `class_time` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `current_student_number` int NULL DEFAULT 0,
  PRIMARY KEY (`course_id`) USING BTREE,
  INDEX `co_3`(`college_name`) USING BTREE,
  INDEX `t_1`(`teacher_name`) USING BTREE,
  INDEX `t_2`(`course_name`) USING BTREE,
  INDEX `t_4`(`teacher_id`) USING BTREE,
  CONSTRAINT `co_3` FOREIGN KEY (`college_name`) REFERENCES `college` (`college_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_1` FOREIGN KEY (`teacher_name`) REFERENCES `teacher` (`teacher_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_2` FOREIGN KEY (`course_name`) REFERENCES `course` (`course_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_4` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`teacher_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of optcous
-- ----------------------------
INSERT INTO `available_course` VALUES (12021541, 'khoury college of computer sciences', '12021591', 'Alex', 'Data Visualization', 'morning', 1);
INSERT INTO `available_course` VALUES (12021542, 'khoury college of computer sciences', '12021591', 'Alex', 'Computer System', 'morning', 1);
INSERT INTO `available_course` VALUES (12021543, 'khoury college of computer sciences', '12021591', 'Alex', 'Advanced Software Development', 'morning', 0);

-- ----------------------------
-- Table structure for studengcours
-- ----------------------------
DROP TABLE IF EXISTS `student_course_score`;
CREATE TABLE `student_course_score`  (
  `serial_number` int NOT NULL AUTO_INCREMENT,
  `college_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `student_major` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  `course_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `score` int NULL DEFAULT NULL,
  `student_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `course_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`serial_number`) USING BTREE,
  INDEX `stu_s`(`student_id`) USING BTREE,
  INDEX `cou_s`(`course_id`) USING BTREE,
  INDEX `co_4`(`college_name`) USING BTREE,
  INDEX `t_5`(`course_name`) USING BTREE,
  INDEX `t_6`(`student_major`) USING BTREE,
  CONSTRAINT `cou_s` FOREIGN KEY (`course_id`) REFERENCES `available_course` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stu_s` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `co_4` FOREIGN KEY (`college_name`) REFERENCES `college` (`college_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_5` FOREIGN KEY (`course_name`) REFERENCES `course` (`course_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_6` FOREIGN KEY (`student_major`) REFERENCES `student` (`student_major`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 151 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of studengcours
-- ----------------------------
INSERT INTO `student_course_score` VALUES (171, 'khoury college of computer sciences', 'Computer Science', 'Data Visualization', 98, '2021592', 12021541);
INSERT INTO `student_course_score` VALUES (172, 'khoury college of computer sciences', 'Computer Science', 'Computer System', 99, '2021592', 12021542);

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `student_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `student_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `student_college` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `student_major` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `inyear` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`student_id`) USING BTREE,
  INDEX `co_5`(`student_college`) USING BTREE,
  INDEX `peojob`(`student_major`) USING BTREE,
  CONSTRAINT `co_5` FOREIGN KEY (`student_college`) REFERENCES `college` (`college_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `q_8` FOREIGN KEY (`student_major`) REFERENCES `major` (`major_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('2021592', 'Lee', 'khoury college of computer sciences', 'Computer Science', 'Male', '2021');

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `teacher_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `teacher_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `teacher_college` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `education` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `inyear` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`teacher_id`) USING BTREE,
  INDEX `co_6`(`teacher_college`) USING BTREE,
  INDEX `name`(`teacher_name`) USING BTREE,
  CONSTRAINT `co_6` FOREIGN KEY (`teacher_college`) REFERENCES `college` (`college_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('12021591', 'Alex', 'khoury college of computer sciences', 'Doctor', 'Male', '2021');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `users_id` int NOT NULL AUTO_INCREMENT,
  `account` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是数字的表示',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pow` int NULL DEFAULT NULL COMMENT '1是管理员2是老师3是学生',
  PRIMARY KEY (`account`) USING BTREE,
  UNIQUE INDEX `id_one`(`users_id`) USING BTREE
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

delete from users where account=old.student_id;


end
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table teacher
-- ----------------------------
DROP TRIGGER IF EXISTS `demo`;
delimiter ;;
CREATE TRIGGER `demo` BEFORE DELETE ON `teacher` FOR EACH ROW BEGIN

delete from users where account=old.teacher_id;


end
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;

