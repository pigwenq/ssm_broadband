/*
SQLyog Ultimate v12.4.3 (64 bit)
MySQL - 5.7.36-log : Database - boradband
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`boradband` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `boradband`;

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `name` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `type` smallint(6) DEFAULT '2',
  `power` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `admin` */

insert  into `admin`(`name`,`password`,`type`,`power`) values 
('12','12',1,1),
('abc测试','123',2,1),
('刘三','11',2,0),
('张三','11',2,1),
('徐大树','11',2,0),
('朱文强','123',1,1),
('李四','11',2,1),
('猪猪','123',2,1);

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` varchar(30) NOT NULL,
  `userid` varchar(20) DEFAULT NULL,
  `startdate` date DEFAULT NULL,
  `cost` double DEFAULT NULL,
  `adminname` varchar(20) DEFAULT NULL,
  `tip` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `orders` */

insert  into `orders`(`id`,`userid`,`startdate`,`cost`,`adminname`,`tip`) values 
('202206071654568624844','zzz','2022-06-07',949,'12','开户'),
('202206071654573750005','111','2022-06-07',45,'12','开户'),
('202206071654573883234','11','2022-06-07',45,'12','开户'),
('202206071654606941576','111','2022-06-07',45,'12','续费'),
('202206071654607003523','111','2022-06-07',45,'12','续费'),
('202206071654607029074','111','2022-06-07',45,'12','续费'),
('202206071654607036175','111','2022-06-07',45,'12','续费'),
('202206071654610423019','456','2022-06-07',45,'12','续费'),
('202206071654610435713','1212','2022-06-07',949,'12','续费'),
('202206071654610440536','456','2022-06-07',949,'12','续费'),
('202206071654610462775','2','2022-06-07',949,'12','续费'),
('202206071654610466712','2','2022-06-07',949,'12','续费'),
('202206071654610481288','z','2022-06-07',949,'12','续费'),
('202206071654610488329','4','2022-06-07',45,'12','续费'),
('202206071654611108793','==','2022-06-07',45,'12','开户'),
('202206071654611154504','11111','2022-06-07',45,'12','开户'),
('202206071654611170696','312','2022-06-07',45,'12','开户'),
('202206071654611210139','1231','2022-06-07',45,'12','开户'),
('202206071654611254616','34','2022-06-07',45,'12','开户'),
('202206091654740338778','201915270102','2022-06-09',949,'12','续费'),
('202206091654780991275','001','2022-06-09',949,'12','开户'),
('202206091654781007823','002','2022-06-09',45,'12','开户'),
('202206091654781033915','003','2022-06-09',949,'12','开户');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `userid` varchar(20) NOT NULL,
  `username` varchar(20) NOT NULL,
  `dorm` varchar(11) DEFAULT NULL,
  `opendate` date DEFAULT NULL,
  `endingdate` date DEFAULT NULL,
  `type` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`userid`,`username`,`dorm`,`opendate`,`endingdate`,`type`) values 
('001','张三','1001','2022-06-09','2023-06-09',2),
('002','李四','1010','2022-06-09','2022-07-09',1),
('003','王五','1002','2022-06-09','2023-06-09',2),
('201915270102','朱文强','1090','2022-06-05','2023-07-01',1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
