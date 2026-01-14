/*
 Navicat Premium Data Transfer

 Source Server         : JSPWork
 Source Server Type    : MySQL
 Source Server Version : 80044 (8.0.44)
 Source Host           : localhost:3306
 Source Schema         : game_forum

 Target Server Type    : MySQL
 Target Server Version : 80044 (8.0.44)
 File Encoding         : 65001

*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `created_at` date NULL DEFAULT NULL,
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (1, '动作游戏', '包含射击、格斗等快节奏游戏', '2025-11-16');
INSERT INTO `categories` VALUES (2, '角色扮演', 'RPG类游戏讨论区', '2025-11-16');
INSERT INTO `categories` VALUES (3, '策略游戏', 'SLG、RTS等策略类游戏', '2025-11-16');
INSERT INTO `categories` VALUES (4, '休闲游戏', '轻松娱乐的小游戏', '2025-11-16');

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `comment_id` int NOT NULL AUTO_INCREMENT,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `user_id` int NULL DEFAULT NULL,
  `post_id` int NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (1, '确实，实机演示太帅了！', 2, 11, '2025-12-12 00:00:00');
INSERT INTO `comments` VALUES (2, '显卡在燃烧...', 3, 11, '2025-12-12 00:00:00');
INSERT INTO `comments` VALUES (3, '多练练拼刀吧，熟能生巧。', 1, 13, '2025-12-12 00:00:00');
INSERT INTO `comments` VALUES (4, '我也觉得博德之门3是神作。', 3, 23, '2025-12-12 00:00:00');
INSERT INTO `comments` VALUES (5, '2414', 12, 45, NULL);
INSERT INTO `comments` VALUES (6, '2414', 12, 45, NULL);
INSERT INTO `comments` VALUES (7, '21312', 12, 45, NULL);
INSERT INTO `comments` VALUES (8, '21321', 12, 45, NULL);
INSERT INTO `comments` VALUES (9, '231', 12, 45, NULL);
INSERT INTO `comments` VALUES (10, '2131', 12, 45, NULL);
INSERT INTO `comments` VALUES (11, '2131', 12, 45, NULL);
INSERT INTO `comments` VALUES (12, '2131', 12, 45, NULL);
INSERT INTO `comments` VALUES (13, 'g', 12, 45, NULL);
INSERT INTO `comments` VALUES (14, '测试', 12, 45, NULL);
INSERT INTO `comments` VALUES (15, '2313', 1, 23, NULL);
INSERT INTO `comments` VALUES (16, '所以什么时候折扣', 1, 23, NULL);
INSERT INTO `comments` VALUES (17, '12', 1, 23, NULL);
INSERT INTO `comments` VALUES (18, '213', 1, 23, '2025-12-16 09:04:22');
INSERT INTO `comments` VALUES (19, '132', 1, 23, '2025-12-16 09:04:25');

-- ----------------------------
-- Table structure for posts
-- ----------------------------
DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts`  (
  `post_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `user_id` int NULL DEFAULT NULL,
  `category_id` int NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `likes` int NULL DEFAULT 0 COMMENT '点赞数',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of posts
-- ----------------------------
INSERT INTO `posts` VALUES (1, '汪汪队', '汪汪队的产后护理', 1, 1, '2025-11-13 00:00:00', '2025-12-11 17:49:01', 3);
INSERT INTO `posts` VALUES (2, '12321', '123', 12, 4, NULL, '2025-12-11 18:12:04', 7);
INSERT INTO `posts` VALUES (7, '灌水', '12345', 12, 1, '2025-12-12 02:02:58', '2025-12-12 02:02:58', 0);
INSERT INTO `posts` VALUES (8, '灌水*1', '21421', 12, 1, '2025-12-12 02:03:16', '2025-12-12 02:03:16', 0);
INSERT INTO `posts` VALUES (9, '灌水*2', '12313', 12, 1, '2025-12-12 02:03:30', '2025-12-12 02:03:30', 0);
INSERT INTO `posts` VALUES (10, '灌水*3', '123123', 12, 1, '2025-12-12 02:03:45', '2025-12-12 02:03:45', 0);
INSERT INTO `posts` VALUES (11, '《黑神话：悟空》实机演示太震撼了', '国产之光！这打击感简直无敌，显卡已备好，坐等发售！', 1, 1, '2025-12-12 01:07:40', '2025-12-12 02:07:40', 999);
INSERT INTO `posts` VALUES (12, '求助：鬼泣5维吉尔怎么连招？', '手指都要按断了，总是接不上次元斩，有没有大佬教一下？', 3, 1, '2025-12-12 00:07:40', '2025-12-12 02:07:40', 5);
INSERT INTO `posts` VALUES (13, '只狼：影逝二度，犹豫就会败北', '打了一晚上的剑圣一心，心态崩了，在线求安慰。', 2, 1, '2025-12-11 21:07:40', '2025-12-12 02:07:40', 230);
INSERT INTO `posts` VALUES (14, '使命召唤新作的多人模式评测', '这次的枪匠系统改动很大，TTK变短了，节奏更快。', 4, 1, '2025-12-11 02:07:40', '2025-12-12 02:07:40', 45);
INSERT INTO `posts` VALUES (15, '艾尔登法环DLC什么时候出啊？', '急急急，我的大剑已经饥渴难耐了！', 1, 1, '2025-12-10 02:07:40', '2025-12-12 02:07:40', 888);
INSERT INTO `posts` VALUES (16, '怪猎崛起：太刀侠的自我修养', '居合才是男人的浪漫，登龙剑帅就完事了。', 4, 1, '2025-12-09 02:07:40', '2025-12-12 02:07:40', 120);
INSERT INTO `posts` VALUES (17, 'Apex英雄新赛季上分指南', '推荐几个好用的组合，不管是刚枪还是苟分都很强。', 2, 1, '2025-12-08 02:07:40', '2025-12-12 02:07:40', 67);
INSERT INTO `posts` VALUES (18, '永劫无间振刀技巧分享', '特别是针对太刀的百裂斩，看到蓝光直接振！', 1, 1, '2025-12-07 02:07:40', '2025-12-12 02:07:40', 89);
INSERT INTO `posts` VALUES (19, '毁灭战士：永恒，这就叫爽游', '撕碎恶魔的感觉太解压了，BGM一响，爹妈白养。', 2, 1, '2025-12-06 02:07:40', '2025-12-12 02:07:40', 34);
INSERT INTO `posts` VALUES (20, '泰坦陨落2单人战役真是神作', '协议三：保护铁驭。玩哭了兄弟们。', 3, 1, '2025-12-05 02:07:40', '2025-12-12 02:07:40', 560);
INSERT INTO `posts` VALUES (21, '战神5诸神黄昏通关感想', '奎爷真的老了，父子情的描写非常细腻。', 4, 1, '2025-12-04 02:07:40', '2025-12-12 02:07:40', 410);
INSERT INTO `posts` VALUES (22, '这游戏手柄玩和键鼠玩是两个游戏', '辅助瞄准太强了，键鼠玩家毫无人权。', 2, 1, '2025-12-03 02:07:40', '2025-12-12 02:07:40', 12);
INSERT INTO `posts` VALUES (23, '博德之门3：年度最佳当之无愧', '自由度高到离谱，每一个选择真的都会影响剧情走向。', 4, 2, '2025-12-12 02:07:40', '2025-12-12 02:07:40', 1200);
INSERT INTO `posts` VALUES (24, '最终幻想16的剧情有点高开低走', '前面的召唤兽大战很燃，后面剧情稍微有点拉跨。', 1, 2, '2025-12-11 23:07:40', '2025-12-12 02:07:40', 150);
INSERT INTO `posts` VALUES (25, '巫师3次世代版画面提升明显', '重新回杰洛特的世界看风景，光追效果很棒。', 2, 2, '2025-12-11 20:07:40', '2025-12-12 02:07:40', 340);
INSERT INTO `posts` VALUES (26, '女神异闻录5：天下第一！', 'P5R的音乐和UI设计真的是艺术品，每天只想偷心。', 3, 2, '2025-12-11 14:07:40', '2025-12-12 02:07:40', 520);
INSERT INTO `posts` VALUES (27, '赛博朋克2077现在的优化怎么样了？', '想入手往日之影DLC，显卡是3060能带动吗？', 3, 2, '2025-12-11 02:07:40', '2025-12-12 02:07:40', 22);
INSERT INTO `posts` VALUES (28, '星空 Starfield 让人略感失望', '加载黑屏太多了，探索感不如无人深空。', 2, 2, '2025-12-10 02:07:40', '2025-12-12 02:07:40', 15);
INSERT INTO `posts` VALUES (29, '如龙8：无限财富预告片分析', '桐生一马的发型怎么变了？回合制战斗还能玩出花吗？', 1, 2, '2025-12-09 02:07:40', '2025-12-12 02:07:40', 88);
INSERT INTO `posts` VALUES (30, '仙剑奇侠传还有救吗？', '情怀还能卖多久？希望国产RPG能支棱起来。', 4, 2, '2025-12-08 02:07:40', '2025-12-12 02:07:40', 45);
INSERT INTO `posts` VALUES (31, '文明6：再来一回合就睡觉', '结果天亮了...这游戏真是时间黑洞。', 4, 3, '2025-12-12 02:07:40', '2025-12-12 02:07:40', 666);
INSERT INTO `posts` VALUES (32, 'P社玩家人均战犯？', '群星里把外星人做成罐头算不算违反日内瓦公约？', 1, 3, '2025-12-12 00:07:40', '2025-12-12 02:07:40', 233);
INSERT INTO `posts` VALUES (34, '全面战争：战锤3 凡世帝国', '地图太大了，玩着玩着就容易弃档。', 3, 3, '2025-12-11 02:07:40', '2025-12-12 02:07:40', 98);
INSERT INTO `posts` VALUES (35, '红警2还有人在玩吗？', '冷酷的敌人还是打不过，我是不是太菜了。', 1, 3, '2025-12-10 02:07:40', '2025-12-12 02:07:40', 450);
INSERT INTO `posts` VALUES (36, '星际争霸2是不是已经凉了？', '暴雪都不管了，且玩且珍惜吧。', 4, 3, '2025-12-09 02:07:40', '2025-12-12 02:07:40', 110);
INSERT INTO `posts` VALUES (37, '火焰纹章：结合 戒指搭配攻略', '主角配马尔斯戒指前期无敌，回避率拉满。', 2, 3, '2025-12-08 02:07:40', '2025-12-12 02:07:40', 76);
INSERT INTO `posts` VALUES (38, '动森：今天大头菜多少钱？', '我家才80，求个高价岛去卖菜！', 3, 4, '2025-12-12 02:07:40', '2025-12-12 02:07:40', 55);
INSERT INTO `posts` VALUES (39, '星露谷物语：和海莉结婚了', '绿帽谷名不虚传，但我就是喜欢她。', 2, 4, '2025-12-12 01:07:40', '2025-12-18 10:41:11', 127);
INSERT INTO `posts` VALUES (40, '双人成行：分手厨房升级版', '和女朋友玩到一半吵架了，这游戏废对象。', 1, 4, '2025-12-11 23:07:40', '2025-12-12 02:07:40', 890);
INSERT INTO `posts` VALUES (41, '植物大战僵尸杂交版太魔性了', '魅惑菇加坚果是什么鬼组合，笑死我了。', 4, 4, '2025-12-11 02:07:40', '2025-12-12 02:07:40', 345);
INSERT INTO `posts` VALUES (42, '蛋仔派对有人一起玩吗？', '找个固玩，我跑图很溜，可以带飞。', 3, 4, '2025-12-10 02:07:40', '2025-12-12 02:07:40', 12);
INSERT INTO `posts` VALUES (43, '我的世界：生存模式第一天做什么？', '撸树，造工作台，挖三填一，标准流程。', 2, 4, '2025-12-09 02:07:40', '2025-12-12 02:07:40', 666);
INSERT INTO `posts` VALUES (45, '灌水*5', '2131231', 12, 4, '2025-12-12 02:10:10', '2025-12-13 16:31:45', 1);
INSERT INTO `posts` VALUES (46, '测试灌水*6', '# ***114514***', 12, 2, '2025-12-13 16:38:24', '2025-12-13 16:38:24', 0);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `role` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'user',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', 'admin123', 'admin@example.com', 'admin', '2025-11-16 00:00:00');
INSERT INTO `users` VALUES (2, 'user1', 'user123', 'user1@example.com', 'user', '2025-11-16 00:00:00');
INSERT INTO `users` VALUES (4, 'z', 'z', 'z@qq.com', 'admin', '2025-12-13 20:45:14');
INSERT INTO `users` VALUES (11, 'g', 'g', 'g@qq.com', 'user', '2025-12-14 20:34:00');

SET FOREIGN_KEY_CHECKS = 1;
