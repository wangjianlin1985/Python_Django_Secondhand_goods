/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50620
Source Host           : localhost:3306
Source Database       : mysite

Target Server Type    : MYSQL
Target Server Version : 50620
File Encoding         : 65001

Date: 2019-01-31 16:06:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `app01_cart`
-- ----------------------------
DROP TABLE IF EXISTS `app01_cart`;
CREATE TABLE `app01_cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `owner_id` (`owner_id`),
  CONSTRAINT `app01_cart_owner_id_71aeb1e1_fk_app01_user_id` FOREIGN KEY (`owner_id`) REFERENCES `app01_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of app01_cart
-- ----------------------------
INSERT INTO `app01_cart` VALUES ('1', '1');
INSERT INTO `app01_cart` VALUES ('2', '2');

-- ----------------------------
-- Table structure for `app01_cart_products`
-- ----------------------------
DROP TABLE IF EXISTS `app01_cart_products`;
CREATE TABLE `app01_cart_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cart_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app01_cart_products_cart_id_product_id_0cf17920_uniq` (`cart_id`,`product_id`),
  KEY `app01_cart_products_product_id_b059023a_fk_app01_product_id` (`product_id`),
  CONSTRAINT `app01_cart_products_cart_id_46c67fd5_fk_app01_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `app01_cart` (`id`),
  CONSTRAINT `app01_cart_products_product_id_b059023a_fk_app01_product_id` FOREIGN KEY (`product_id`) REFERENCES `app01_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of app01_cart_products
-- ----------------------------
INSERT INTO `app01_cart_products` VALUES ('2', '2', '2');

-- ----------------------------
-- Table structure for `app01_coin`
-- ----------------------------
DROP TABLE IF EXISTS `app01_coin`;
CREATE TABLE `app01_coin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` decimal(9,2) NOT NULL,
  `is_gotten` tinyint(1) NOT NULL,
  `owner_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `owner_id` (`owner_id`),
  CONSTRAINT `app01_coin_owner_id_c48e845d_fk_app01_user_id` FOREIGN KEY (`owner_id`) REFERENCES `app01_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of app01_coin
-- ----------------------------
INSERT INTO `app01_coin` VALUES ('1', '100.00', '1', '1');
INSERT INTO `app01_coin` VALUES ('2', '-1700.00', '1', '2');

-- ----------------------------
-- Table structure for `app01_order`
-- ----------------------------
DROP TABLE IF EXISTS `app01_order`;
CREATE TABLE `app01_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(50) COLLATE utf8_bin NOT NULL,
  `product_id` varchar(50) COLLATE utf8_bin NOT NULL,
  `product_amount` int(11) NOT NULL,
  `address` longtext COLLATE utf8_bin NOT NULL,
  `phone` longtext COLLATE utf8_bin NOT NULL,
  `remarks` longtext COLLATE utf8_bin NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app01_order_user_id_2bad9964_fk_app01_user_id` (`user_id`),
  CONSTRAINT `app01_order_user_id_2bad9964_fk_app01_user_id` FOREIGN KEY (`user_id`) REFERENCES `app01_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of app01_order
-- ----------------------------
INSERT INTO `app01_order` VALUES ('1', '苹果SE手机', '1', '1', 0xE59B9BE5B79DE68890E983BDE68890E58D8EE58CBAE5BBBAE8AEBEE8B7AF, 0x3133393830383332393433, 0xE5BFABE782B9E58F91E8B4A7, '2');
INSERT INTO `app01_order` VALUES ('2', '小米手机8青春版', '3', '1', 0xE59B9BE5B79DE68890E983BDE68890E58D8EE58CBAE5BBBAE8AEBEE8B7AF3132E58FB7, 0x3133393830383234303833, 0xE58F91E8B4A7E69DA5E590A7EFBC8CE5BE88E6BF80E58AA8EFBC81, '2');

-- ----------------------------
-- Table structure for `app01_order_cart`
-- ----------------------------
DROP TABLE IF EXISTS `app01_order_cart`;
CREATE TABLE `app01_order_cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app01_order_cart_order_id_cart_id_7288ea6e_uniq` (`order_id`,`cart_id`),
  KEY `app01_order_cart_cart_id_ca9fd42f_fk_app01_cart_id` (`cart_id`),
  CONSTRAINT `app01_order_cart_cart_id_ca9fd42f_fk_app01_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `app01_cart` (`id`),
  CONSTRAINT `app01_order_cart_order_id_e972c182_fk_app01_order_id` FOREIGN KEY (`order_id`) REFERENCES `app01_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of app01_order_cart
-- ----------------------------

-- ----------------------------
-- Table structure for `app01_order_products`
-- ----------------------------
DROP TABLE IF EXISTS `app01_order_products`;
CREATE TABLE `app01_order_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app01_order_products_order_id_product_id_5e220f46_uniq` (`order_id`,`product_id`),
  KEY `app01_order_products_product_id_f3887451_fk_app01_product_id` (`product_id`),
  CONSTRAINT `app01_order_products_order_id_2fad1d3a_fk_app01_order_id` FOREIGN KEY (`order_id`) REFERENCES `app01_order` (`id`),
  CONSTRAINT `app01_order_products_product_id_f3887451_fk_app01_product_id` FOREIGN KEY (`product_id`) REFERENCES `app01_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of app01_order_products
-- ----------------------------
INSERT INTO `app01_order_products` VALUES ('1', '1', '1');
INSERT INTO `app01_order_products` VALUES ('2', '2', '3');

-- ----------------------------
-- Table structure for `app01_product`
-- ----------------------------
DROP TABLE IF EXISTS `app01_product`;
CREATE TABLE `app01_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin NOT NULL,
  `time` date DEFAULT NULL,
  `old_time` date DEFAULT NULL,
  `img` varchar(100) COLLATE utf8_bin NOT NULL,
  `description` varchar(500) COLLATE utf8_bin NOT NULL,
  `price` decimal(9,2) NOT NULL,
  `old_price` decimal(9,2) NOT NULL,
  `classification` varchar(50) COLLATE utf8_bin NOT NULL,
  `quantity` int(11) NOT NULL,
  `buy_quantity` int(11) NOT NULL,
  `remained` int(11) NOT NULL,
  `is_exist` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app01_product_user_id_d876145b_fk_app01_user_id` (`user_id`),
  CONSTRAINT `app01_product_user_id_d876145b_fk_app01_user_id` FOREIGN KEY (`user_id`) REFERENCES `app01_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of app01_product
-- ----------------------------
INSERT INTO `app01_product` VALUES ('1', '苹果SE手机', '2019-01-31', '2018-12-08', 'img/1.jpg', '64G内存很流畅哦', '1800.00', '2800.00', '9成新', '2', '1', '1', '1', '1');
INSERT INTO `app01_product` VALUES ('2', '西部数据硬盘500G', '2019-01-31', '2011-12-28', 'img/2.jpg', '硬盘质量好，缓存大，速度快！', '200.00', '300.00', '9.5成新', '1', '1', '1', '1', '1');
INSERT INTO `app01_product` VALUES ('3', '小米手机8青春版', '2019-01-31', '2019-01-01', 'img/3.jpg', '4G手机，64G内存，超大容量', '1000.00', '1308.00', '9.9成新', '1', '1', '0', '1', '1');

-- ----------------------------
-- Table structure for `app01_transaction`
-- ----------------------------
DROP TABLE IF EXISTS `app01_transaction`;
CREATE TABLE `app01_transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` decimal(9,2) NOT NULL,
  `buyer_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app01_transaction_buyer_id_b492da92_fk_app01_user_id` (`buyer_id`),
  KEY `app01_transaction_order_id_d262b8d3_fk_app01_order_id` (`order_id`),
  KEY `app01_transaction_product_id_f7d74c5b_fk_app01_product_id` (`product_id`),
  KEY `app01_transaction_seller_id_f0b851ef_fk_app01_user_id` (`seller_id`),
  CONSTRAINT `app01_transaction_buyer_id_b492da92_fk_app01_user_id` FOREIGN KEY (`buyer_id`) REFERENCES `app01_user` (`id`),
  CONSTRAINT `app01_transaction_order_id_d262b8d3_fk_app01_order_id` FOREIGN KEY (`order_id`) REFERENCES `app01_order` (`id`),
  CONSTRAINT `app01_transaction_product_id_f7d74c5b_fk_app01_product_id` FOREIGN KEY (`product_id`) REFERENCES `app01_product` (`id`),
  CONSTRAINT `app01_transaction_seller_id_f0b851ef_fk_app01_user_id` FOREIGN KEY (`seller_id`) REFERENCES `app01_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of app01_transaction
-- ----------------------------
INSERT INTO `app01_transaction` VALUES ('1', '1800.00', '2', '1', '1', '1');
INSERT INTO `app01_transaction` VALUES ('2', '1000.00', '2', '2', '3', '1');

-- ----------------------------
-- Table structure for `app01_user`
-- ----------------------------
DROP TABLE IF EXISTS `app01_user`;
CREATE TABLE `app01_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) COLLATE utf8_bin NOT NULL,
  `password` varchar(50) COLLATE utf8_bin NOT NULL,
  `email` varchar(254) COLLATE utf8_bin NOT NULL,
  `money` decimal(9,2) NOT NULL,
  `is_changed` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of app01_user
-- ----------------------------
INSERT INTO `app01_user` VALUES ('1', 'user1', '123', 'user1@163.com', '2850.00', '0');
INSERT INTO `app01_user` VALUES ('2', 'user2', '123', 'user2@163.com', '2200.00', '0');

-- ----------------------------
-- Table structure for `auth_group`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_group_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_permission`
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can add permission', '2', 'add_permission');
INSERT INTO `auth_permission` VALUES ('5', 'Can change permission', '2', 'change_permission');
INSERT INTO `auth_permission` VALUES ('6', 'Can delete permission', '2', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('7', 'Can add group', '3', 'add_group');
INSERT INTO `auth_permission` VALUES ('8', 'Can change group', '3', 'change_group');
INSERT INTO `auth_permission` VALUES ('9', 'Can delete group', '3', 'delete_group');
INSERT INTO `auth_permission` VALUES ('10', 'Can add user', '4', 'add_user');
INSERT INTO `auth_permission` VALUES ('11', 'Can change user', '4', 'change_user');
INSERT INTO `auth_permission` VALUES ('12', 'Can delete user', '4', 'delete_user');
INSERT INTO `auth_permission` VALUES ('13', 'Can add content type', '5', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('14', 'Can change content type', '5', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete content type', '5', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('16', 'Can add session', '6', 'add_session');
INSERT INTO `auth_permission` VALUES ('17', 'Can change session', '6', 'change_session');
INSERT INTO `auth_permission` VALUES ('18', 'Can delete session', '6', 'delete_session');
INSERT INTO `auth_permission` VALUES ('19', 'Can add cart', '7', 'add_cart');
INSERT INTO `auth_permission` VALUES ('20', 'Can change cart', '7', 'change_cart');
INSERT INTO `auth_permission` VALUES ('21', 'Can delete cart', '7', 'delete_cart');
INSERT INTO `auth_permission` VALUES ('22', 'Can add coin', '8', 'add_coin');
INSERT INTO `auth_permission` VALUES ('23', 'Can change coin', '8', 'change_coin');
INSERT INTO `auth_permission` VALUES ('24', 'Can delete coin', '8', 'delete_coin');
INSERT INTO `auth_permission` VALUES ('25', 'Can add order', '9', 'add_order');
INSERT INTO `auth_permission` VALUES ('26', 'Can change order', '9', 'change_order');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete order', '9', 'delete_order');
INSERT INTO `auth_permission` VALUES ('28', 'Can add product', '10', 'add_product');
INSERT INTO `auth_permission` VALUES ('29', 'Can change product', '10', 'change_product');
INSERT INTO `auth_permission` VALUES ('30', 'Can delete product', '10', 'delete_product');
INSERT INTO `auth_permission` VALUES ('31', 'Can add transaction', '11', 'add_transaction');
INSERT INTO `auth_permission` VALUES ('32', 'Can change transaction', '11', 'change_transaction');
INSERT INTO `auth_permission` VALUES ('33', 'Can delete transaction', '11', 'delete_transaction');
INSERT INTO `auth_permission` VALUES ('34', 'Can add user', '12', 'add_user');
INSERT INTO `auth_permission` VALUES ('35', 'Can change user', '12', 'change_user');
INSERT INTO `auth_permission` VALUES ('36', 'Can delete user', '12', 'delete_user');

-- ----------------------------
-- Table structure for `auth_user`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8_bin NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8_bin NOT NULL,
  `first_name` varchar(30) COLLATE utf8_bin NOT NULL,
  `last_name` varchar(30) COLLATE utf8_bin NOT NULL,
  `email` varchar(254) COLLATE utf8_bin NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES ('1', 'pbkdf2_sha256$20000$zpLuwLiIHtF4$u3pls8gby9tJab34gjPN5jnyUJVS+EDWhx9d+X1sluI=', '2019-01-31 07:53:43.837000', '1', 'admin', '', '', 'test@163.com', '1', '1', '2019-01-31 05:24:35.551000');

-- ----------------------------
-- Table structure for `auth_user_groups`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_user_user_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for `django_admin_log`
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8_bin,
  `object_repr` varchar(200) COLLATE utf8_bin NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext COLLATE utf8_bin NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for `django_content_type`
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8_bin NOT NULL,
  `model` varchar(100) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('7', 'app01', 'cart');
INSERT INTO `django_content_type` VALUES ('8', 'app01', 'coin');
INSERT INTO `django_content_type` VALUES ('9', 'app01', 'order');
INSERT INTO `django_content_type` VALUES ('10', 'app01', 'product');
INSERT INTO `django_content_type` VALUES ('11', 'app01', 'transaction');
INSERT INTO `django_content_type` VALUES ('12', 'app01', 'user');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('4', 'auth', 'user');
INSERT INTO `django_content_type` VALUES ('5', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('6', 'sessions', 'session');

-- ----------------------------
-- Table structure for `django_migrations`
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8_bin NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2019-01-31 04:34:41.656000');
INSERT INTO `django_migrations` VALUES ('2', 'auth', '0001_initial', '2019-01-31 04:34:42.446000');
INSERT INTO `django_migrations` VALUES ('3', 'admin', '0001_initial', '2019-01-31 04:34:42.637000');
INSERT INTO `django_migrations` VALUES ('4', 'admin', '0002_logentry_remove_auto_add', '2019-01-31 04:34:42.650000');
INSERT INTO `django_migrations` VALUES ('5', 'app01', '0001_initial', '2019-01-31 04:34:44.400000');
INSERT INTO `django_migrations` VALUES ('6', 'contenttypes', '0002_remove_content_type_name', '2019-01-31 04:34:44.538000');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0002_alter_permission_name_max_length', '2019-01-31 04:34:44.613000');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0003_alter_user_email_max_length', '2019-01-31 04:34:44.678000');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0004_alter_user_username_opts', '2019-01-31 04:34:44.711000');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0005_alter_user_last_login_null', '2019-01-31 04:34:44.785000');
INSERT INTO `django_migrations` VALUES ('11', 'auth', '0006_require_contenttypes_0002', '2019-01-31 04:34:44.793000');
INSERT INTO `django_migrations` VALUES ('12', 'auth', '0007_alter_validators_add_error_messages', '2019-01-31 04:34:44.808000');
INSERT INTO `django_migrations` VALUES ('13', 'auth', '0008_alter_user_username_max_length', '2019-01-31 04:34:44.896000');
INSERT INTO `django_migrations` VALUES ('14', 'sessions', '0001_initial', '2019-01-31 04:34:44.965000');

-- ----------------------------
-- Table structure for `django_session`
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8_bin NOT NULL,
  `session_data` longtext COLLATE utf8_bin NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('6olgnda0h1cios1wu2u1674i5yp22t1n', 0x4D32453459575268596A59304D6D497A5A4745774E3249785A544E694E546C69597A466D596D45304E546B7A4F575A6B5A6A6B784E6A7037496E567A5A584A755957316C496A6F6964584E6C636A45694C434A6659585630614639316332567958326C6B496A6F694D534973496C39686458526F5833567A5A584A66596D466A613256755A434936496D52715957356E6279356A62323530636D6C694C6D463164476775596D466A613256755A484D755457396B5A57784359574E725A57356B49697769583246316447686664584E6C636C396F59584E6F496A6F694D54677A4E4445354D5445794D444D304D6A4D315A545577596D4A6B5A47457A4D444D794E5445355A54526B5A57466A4F4467784E434A39, '2019-01-31 08:53:43.842000');
INSERT INTO `django_session` VALUES ('avbd3088c6o0w7q6ratkltuei8ze4oyg', 0x4E6A5A69596A4D33596D5A6C597A6B304D6D5132597A63344D6A6B324E7A4A6B4F445668597A646C4F54646C4F4751775A5463794F547037496E567A5A584A755957316C496A6F6964584E6C636A49694C434A6659585630614639316332567958326C6B496A6F694D534973496C39686458526F5833567A5A584A66596D466A613256755A434936496D52715957356E6279356A62323530636D6C694C6D463164476775596D466A613256755A484D755457396B5A57784359574E725A57356B49697769583246316447686664584E6C636C396F59584E6F496A6F694D54677A4E4445354D5445794D444D304D6A4D315A545577596D4A6B5A47457A4D444D794E5445355A54526B5A57466A4F4467784E434A39, '2019-01-31 06:24:54.865000');
