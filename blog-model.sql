/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50719
 Source Host           : localhost:3306
 Source Schema         : blog

 Target Server Type    : MySQL
 Target Server Version : 50719
 File Encoding         : 65001

 Date: 28/12/2024 17:47:02
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `post_id`(`post_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (5, 2, 2, '加油，特种兵！', '2024-12-18 11:21:34');
INSERT INTO `comments` VALUES (6, 5, 3, '庆幸科技掌握在文明手中！', '2024-12-27 19:53:11');

-- ----------------------------
-- Table structure for favorites
-- ----------------------------
DROP TABLE IF EXISTS `favorites`;
CREATE TABLE `favorites`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `post_id`(`post_id`) USING BTREE,
  CONSTRAINT `favorites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `favorites_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of favorites
-- ----------------------------
INSERT INTO `favorites` VALUES (10, 1, 3, '2024-12-18 17:15:15');
INSERT INTO `favorites` VALUES (11, 1, 2, '2024-12-18 17:26:32');
INSERT INTO `favorites` VALUES (12, 3, 5, '2024-12-27 19:52:09');

-- ----------------------------
-- Table structure for follows
-- ----------------------------
DROP TABLE IF EXISTS `follows`;
CREATE TABLE `follows`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `follower_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `follower_id`(`follower_id`) USING BTREE,
  CONSTRAINT `follows_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `follows_ibfk_2` FOREIGN KEY (`follower_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of follows
-- ----------------------------
INSERT INTO `follows` VALUES (1, 2, 1, '2024-12-23 19:12:15');

-- ----------------------------
-- Table structure for likes
-- ----------------------------
DROP TABLE IF EXISTS `likes`;
CREATE TABLE `likes`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `post_id`(`post_id`) USING BTREE,
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of likes
-- ----------------------------
INSERT INTO `likes` VALUES (33, 2, 2, '2024-12-18 15:53:44');
INSERT INTO `likes` VALUES (34, 1, 2, '2024-12-18 15:56:50');
INSERT INTO `likes` VALUES (35, 3, 5, '2024-12-27 19:51:54');

-- ----------------------------
-- Table structure for post_tags
-- ----------------------------
DROP TABLE IF EXISTS `post_tags`;
CREATE TABLE `post_tags`  (
  `post_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`post_id`, `tag_id`) USING BTREE,
  INDEX `tag_id`(`tag_id`) USING BTREE,
  CONSTRAINT `post_tags_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `post_tags_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of post_tags
-- ----------------------------

-- ----------------------------
-- Table structure for posts
-- ----------------------------
DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(160) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `comments_count` int(11) NULL DEFAULT 0,
  `likes_count` int(11) NULL DEFAULT 0,
  `favorites_count` int(11) NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of posts
-- ----------------------------
INSERT INTO `posts` VALUES (2, '郭永航到黄埔区开展经济工作专题调研并督导林长制工作', '坚持干字当头奋发有为\n\n以实干实绩开创高质量发展新局面\n\n　　为深入学习贯彻习近平总书记视察广东重要...', '坚持干字当头奋发有为\n\n以实干实绩开创高质量发展新局面\n\n　　为深入学习贯彻习近平总书记视察广东重要讲话重要指示精神，认真贯彻中央经济工作会议精神，落实省委、省政府工作要求，12月17日，广州市委书记郭永航到黄埔区有关企业、产业园区和“百千万工程”典型村开展经济工作专题调研，并督导牵头督办的市政协重点提案和推进林长制工作。\n\n　　在华南新材料创新园，郭永航详细了解园区建设和入驻企业技术创新、产品应用等情况，听取市政协重点提案《关于着力破解广州工业用地瓶颈，让成长型制造业企业“留得住、长得大”的提案》办理情况，强调要紧扣产业发展需要和企业发展需求，精准匹配土地等资源要素，优化产业园区和政策供给，帮助企业降本增效，让企业进得来、留得住、发展得好。在广州华星光电半导体显示技术有限公司、广州立景创新科技有限公司，郭永航实地察看企业生产线和核心产品，了解企业业务布局、产品开发、市场开拓等情况，勉励企业聚焦主业深耕细作，增强自主创新能力，加快技术迭代升级，不断提升企业核心竞争力。在迳下村，郭永航调研新农房建设、乡村酒店发展情况，强调要大力推进新型建筑工业化示范项目，优化提升乡村风貌和环境品质，探索建设公园式住宅，推进农文旅融合发展，加快建设宜居宜业和美乡村。在听取全市推进林长制工作情况汇报后，郭永航强调，要以落实林长制为抓手，深入推进绿美广州生态建设，深化集体林权制度改革，大力推进植树造林，持续优化林分、改善林相，加强古树名木保护，提升城乡绿化品质。要切实抓好森林防火工作，保障森林资源和人民群众生命财产安全。\n\n　　在调研中，郭永航听取黄埔区经济社会发展情况汇报，强调要切实把思想和行动统一到习近平总书记、党中央关于经济工作的决策部署上来，以广州东部中心和活力创新轴建设为牵引，坚持干字当头、奋发有为、狠抓落实，不断开创高质量发展新局面，为广州扛起经济大市挑大梁的责任担当提供重要支撑。要全力推动经济回升向好，对接用好国家增量政策及省、市加力政策，全力抓项目、促投资、增动能，做好明年“两重”“两新”项目谋划储备，确保今年收好官、明年开好局。要以科技创新引领新质生产力发展，深入实施“人工智能+”行动，推动传统产业数智化绿色化转型，打造超高清视频与新型显示、半导体与集成电路、生物医药与健康等战略性产业集群，推动具身智能、细胞与基因等未来产业蓄能成势，加快建设现代化产业体系。要进一步全面深化改革、扩大高水平对外开放，全面提升中新广州知识城等平台发展能级，深入推进营商环境综合改革试点，建设“中小企业能办大事”创新示范区，培育引进更多行业领军企业、专精特新企业，不断激发发展活力动力。要持续用力推动“百千万工程”，统筹好生产生活生态，加力推进城中村改造和城市更新，扩面提质打造典型镇村，奋力打造产城融合、城乡融合标杆区。要抓细抓实安全稳定工作，深入开展安全生产和自然灾害隐患排查整治专项行动，加强建筑施工、道路交通等重点领域安全监管，健全矛盾纠纷多元化解工作机制，全力守护好社会安定、百姓安宁。要坚持用改革精神和严的标准管党治党，深化“干部作风大转变、营商环境大提升”专项行动，切实为基层松绑减负，激发干事创业的内生动力，形成协同联动抓落实的强大合力。\n\n　　市领导边立明、陈杰、潘建国、姚建明参加。', 2, 0, 2, 1, '2024-12-18 11:21:20');
INSERT INTO `posts` VALUES (3, '【光明论坛】坚持稳中求进 做好明年经济工作', '【光明论坛】\n\n　　作者：黄勃（中国人民大学财政金融学院教授）\n\n　　日前召开的中央经济工作会议总结...', '【光明论坛】\n\n　　作者：黄勃（中国人民大学财政金融学院教授）\n\n　　日前召开的中央经济工作会议总结2024年经济工作，分析当前经济形势，部署2025年经济工作。会议要求，明年要坚持稳中求进、以进促稳，守正创新、先立后破，系统集成、协同配合，充实完善政策工具箱，提高宏观调控的前瞻性、针对性、有效性。这为坚定各方发展信心，稳定市场预期，积极主动应对困难挑战，确保高质量完成“十四五”规划目标任务，实现“十五五”良好开局打牢基础。\n\n　　坚持稳中求进是当前经济工作的总基调。稳中求进要求在保持大局稳定的前提下，推动高质量发展；以进促稳，则是通过创新驱动促进经济结构优化，以“进”为动力夯实稳定基础。当前我国经济形势的复杂性有所上升，稳中求进与以进促稳并行推进，既是实现经济平稳增长的必由之路，也是应对复杂挑战的关键。坚持稳中求进、以进促稳需要提升政策调控的前瞻性与灵活性。与此同时，以进促稳则要求通过积极有为的发展稳定经济发展基础。会议明确，要实施更加积极的财政政策。这是提振市场主体信心和预期、持续增强经济内生增长动力的现实需要，为经济稳增长提供更大动能。统计数据显示，今年前三个季度，全国GDP增速分别为5.3%、4.7%和4.6%，虽有波动，但总体走势指向5%左右的预期目标。制造业采购经理指数从8月份低点跃起，在10月份重回扩张区间，并在11月份继续上升0.2个百分点至50.3%，显示经济向好态势进一步确立。在此背景下，应继续推动新质生产力发展，稳步推进传统产业的智能化升级和数字化转型，大力支持集成电路、人工智能、量子技术等前沿科技进步，不断创造新的经济增长点。\n\n　　守正才能把稳方向，创新才能充满生机。将中国实际情况与改革创新措施相结合，充分体现了守正创新是我们党在新时代治国理政的重要思想方法。守正是基础与前提，创新则是方向与动力。我国经济发展坚持稳中求进的总基调，推动技术创新、产业升级和绿色低碳转型等，不仅能优化经济结构，还能为我国经济增长带来新的驱动力。习近平总书记对我国经济发展精准把脉，叮嘱甘肃“因地制宜发展新质生产力，打造全国重要的新能源及新能源装备制造基地”；鼓励宁夏“促进传统产业转型升级，培育战略性新兴产业，因地制宜发展新质生产力”；寄语湖南“推动产业高端化、智能化、绿色化发展，打造国家级产业集群”……在这一过程中，要确保传统优势产业在改革创新过程中得到优化升级，避免破而未立，对现有经济发展情况带来冲击。\n\n　　在立和破的辩证关系中，强调先立后破，即在稳步推动高质量发展的同时，逐步优化和淘汰旧机制。两者相辅相成，前者为后者提供基础，确保经济发展的连续性与稳定性。不应急于破除旧有体系，而应在立的基础上稳步推进改革和结构调整，全方位扩大内需、提振消费。在推动改革、调整政策和化解风险时，须谨慎把握时机，避免急功近利，确保社会预期稳定。\n\n　　在新时代的改革进程中，坚持系统观念是全面深化改革的核心要义之一。通过系统集成与协同配合，我们能够有效统筹推进各项改革，形成更强的改革合力。党的二十届三中全会提出，更加注重系统集成，更加注重突出重点，更加注重改革实效。这要求我们不仅要关注单一领域的突破，还要注重统筹布局的协调性，确保各方面改革措施相互配合、协调推进。政府、企业、社会组织等各方力量必须加强合作，形成有效合力，解决发展中的难题，避免资源浪费，确保政策执行的精准度。今年9月26日召开的中共中央政治局会议作出部署，一揽子增量政策密集推出，利当前、惠长远，被誉为“宏观调控的一次里程碑式出手”。随着存量政策有效落实、增量政策加快推出，经济运行出现积极变化，我国实现全年经济增长5%左右预期目标的信心在逐渐增强。\n\n　　从目前的经济运行情况看，我国前三季度4.8%的经济增速在全球主要经济体中依然名列前茅，是世界经济增长的重要引擎。在当前全球经济发展的宏观背景下，预期管理在宏观调控中的作用日益突出。协同推进政策实施和预期引导，提升政策引导力、影响力，能够提高社会经济的自我调节能力，增强政策的执行力与效果。', 1, 0, 0, 1, '2024-12-18 17:10:55');
INSERT INTO `posts` VALUES (4, '测试', '123456798', '123456798', 1, 0, 0, 0, '2024-12-21 19:36:38');
INSERT INTO `posts` VALUES (5, '中国海军076两栖攻击舰首舰下水命名', '新华社上海12月27日电（记者黎云）12月27日上午，我国自主研制建造的076两栖攻击舰首舰下水命名...', '新华社上海12月27日电（记者黎云）12月27日上午，我国自主研制建造的076两栖攻击舰首舰下水命名仪式在上海举行。\n\n经中央军委批准，076两栖攻击舰首舰命名为“中国人民解放军海军四川舰”，舷号为“51”。四川舰满载排水量4万余吨，设置双舰岛式上层建筑和全纵通飞行甲板，创新应用了电磁弹射和阻拦技术，可搭载固定翼飞机、直升机、两栖装备等，是海军新一代两栖攻击舰，是推进海军转型建设发展、提升远海作战能力的关键装备。该舰下水后，将按计划开展设备调试、系泊试验、航行试验等工作。\n\n上午10时许，下水命名仪式在上海沪东中华造船厂举行，伴随着雄壮的中华人民共和国国歌，五星红旗冉冉升起。参加仪式的海军有关领导宣读中央军委授予舰名、舷号的命令，向接舰部队颁发命名证书，并为076两栖攻击舰首舰下水剪彩。随后进行掷瓶礼，一瓶香槟酒碰击舰体后打碎，舰首彩球打开，舰舷喷射绚丽彩带，船坞开始注水，汽笛长鸣。下水命名仪式在中国人民解放军军歌声中结束。\n海军、中国船舶集团有限公司、四川省以及军地有关部门、舰艇科研生产单位干部职工和部队官兵代表等参加下水命名仪式。', 2, 0, 1, 1, '2024-12-27 19:50:55');

-- ----------------------------
-- Table structure for tags
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tags
-- ----------------------------
INSERT INTO `tags` VALUES (4, '体育');
INSERT INTO `tags` VALUES (5, '娱乐');
INSERT INTO `tags` VALUES (1, '技术');
INSERT INTO `tags` VALUES (6, '教育');
INSERT INTO `tags` VALUES (3, '文化');
INSERT INTO `tags` VALUES (7, '生活');
INSERT INTO `tags` VALUES (2, '金融');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'zhangs', 'zhangs@qq.com', '$2a$10$PcvOLShuR0o2VujgJK.esOn3/m46cwxz1CWwwRvJUekJK5p19nsIe', '2024-12-18 10:50:07');
INSERT INTO `users` VALUES (2, 'lisi', 'lisi@qq.com', '$2a$10$PcvOLShuR0o2VujgJK.esOn3/m46cwxz1CWwwRvJUekJK5p19nsIe', '2024-12-18 10:50:07');
INSERT INTO `users` VALUES (3, 'wangwu', 'wangwu@baiyun.com', '$2a$10$PcvOLShuR0o2VujgJK.esOn3/m46cwxz1CWwwRvJUekJK5p19nsIe', '2024-12-25 15:07:37');
INSERT INTO `users` VALUES (4, 'zhaoliu', 'zhaoliu@baiyun.com', '$2a$10$lVXUxNa3cdheq4.WwMkkh.nW4y2A.X2OIdI9oOTKqTbwwzaIZDctK', '2024-12-25 15:09:15');
INSERT INTO `users` VALUES (5, 'tom', 'tom@baiyun.com', '$2a$10$k/A3KBBQx4plqSSLb59bluxZE0U0Py5fYkk799YjW/i0muo3/atvW', '2024-12-27 19:48:33');

SET FOREIGN_KEY_CHECKS = 1;
