/*
SQLyog Ultimate v10.00 Beta1
MySQL - 5.7.15-log : Database - ebioservernew
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ebioservernew` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `ebioservernew`;

/*Table structure for table `attendanceregister` */

DROP TABLE IF EXISTS `attendanceregister`;

CREATE TABLE `attendanceregister` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `EmployeeId` int(11) DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `ApprovedDuration` varchar(50) DEFAULT NULL,
  `ApprovedOverTime` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `ix_AttendanceRegister` (`EmployeeId`,`Date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `attendanceregister` */

/*Table structure for table `compoffs` */

DROP TABLE IF EXISTS `compoffs`;

CREATE TABLE `compoffs` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `EmployeeId` int(11) DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `Duration` varchar(50) DEFAULT NULL,
  `Remarks` varchar(50) DEFAULT NULL,
  `AppliedDate` datetime DEFAULT NULL,
  `ApprovedById` int(11) DEFAULT NULL,
  `ApprovedDate` datetime DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `ix_CompOffs` (`EmployeeId`,`Date`,`Status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `compoffs` */

/*Table structure for table `devicecommands` */

DROP TABLE IF EXISTS `devicecommands`;

CREATE TABLE `devicecommands` (
  `DeviceCommandId` int(11) NOT NULL AUTO_INCREMENT,
  `DeviceId` int(11) DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `DeviceCommand` text,
  `Status` varchar(255) DEFAULT NULL,
  `Type` varchar(255) DEFAULT NULL,
  `CreationDate` datetime DEFAULT NULL,
  `ExecutionDate` datetime DEFAULT NULL,
  `DeviceCommandFace` text,
  PRIMARY KEY (`DeviceCommandId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `devicecommands` */

/*Table structure for table `deviceemployees` */

DROP TABLE IF EXISTS `deviceemployees`;

CREATE TABLE `deviceemployees` (
  `DeviceId` int(11) DEFAULT NULL,
  `EmployeeId` int(11) DEFAULT NULL,
  `Role` varchar(50) DEFAULT NULL,
  `Command` varchar(50) DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  `SyncDate` varchar(50) DEFAULT NULL,
  `EmployeeCode` varchar(50) DEFAULT NULL,
  `IsDirtyDateTime` datetime DEFAULT NULL,
  `DeviceEmployeeId` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`DeviceEmployeeId`),
  KEY `deviceemployees` (`DeviceId`,`EmployeeId`),
  KEY `deviceemployees1` (`DeviceId`),
  KEY `deviceemployees_employeeid` (`EmployeeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `deviceemployees` */

/*Table structure for table `devicegroups` */

DROP TABLE IF EXISTS `devicegroups`;

CREATE TABLE `devicegroups` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `DeviceId` int(11) NOT NULL,
  `GroupId` int(11) NOT NULL,
  `Name` varchar(250) DEFAULT NULL,
  `VerificationTypeCode` varchar(250) DEFAULT NULL,
  `IsHolidayApplicable` char(1) DEFAULT NULL,
  `TimePeriod1` int(11) DEFAULT NULL,
  `TimePeriod2` int(11) DEFAULT NULL,
  `TimePeriod3` int(11) DEFAULT NULL,
  `Status` varchar(250) DEFAULT NULL,
  `SyncDate` varchar(250) DEFAULT NULL,
  `IsDirtyDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `idx_deviceId` (`DeviceId`),
  KEY `idx_deviceId_GroupId` (`DeviceId`,`GroupId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `devicegroups` */

/*Table structure for table `deviceillegallogs` */

DROP TABLE IF EXISTS `deviceillegallogs`;

CREATE TABLE `deviceillegallogs` (
  `DeviceId` int(11) NOT NULL,
  `EmployeeCode` varchar(50) NOT NULL,
  `LogDate` datetime NOT NULL,
  `AttPhoto` longtext,
  `DeviceIllegallLogId` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`DeviceIllegallLogId`),
  KEY `indx_all` (`DeviceId`,`EmployeeCode`,`LogDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `deviceillegallogs` */

/*Table structure for table `devicelogs` */

DROP TABLE IF EXISTS `devicelogs`;

CREATE TABLE `devicelogs` (
  `DeviceLogId` bigint(20) NOT NULL AUTO_INCREMENT,
  `DeviceId` int(11) NOT NULL,
  `EmployeeCode` varchar(50) NOT NULL,
  `LogDate` datetime NOT NULL,
  `VerificationType` varchar(2) DEFAULT NULL,
  `GPS` varchar(100) DEFAULT NULL,
  `Direction` varchar(50) DEFAULT NULL,
  `WorkCode` varchar(50) DEFAULT NULL,
  `ParalellSyncStatus` char(1) DEFAULT NULL,
  `IsAttPhoto` char(1) DEFAULT NULL,
  `AttPhoto` longtext,
  `WebhookSyncStatus` char(1) DEFAULT NULL,
  `DownloadDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `AttDirectionCode` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`DeviceLogId`),
  KEY `devicelogs` (`LogDate`),
  KEY `devicelogs_employeecode` (`EmployeeCode`),
  KEY `indx_All` (`DeviceId`,`EmployeeCode`,`LogDate`),
  KEY `indx_code_date` (`EmployeeCode`,`LogDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `devicelogs` */

/*Table structure for table `deviceoplogs` */

DROP TABLE IF EXISTS `deviceoplogs`;

CREATE TABLE `deviceoplogs` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `DeviceId` int(11) DEFAULT NULL,
  `OPCode` varchar(50) DEFAULT NULL,
  `OPLogDate` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_DeviceOPLogs_DId_OPDate` (`DeviceId`,`OPLogDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `deviceoplogs` */

/*Table structure for table `devices` */

DROP TABLE IF EXISTS `devices`;

CREATE TABLE `devices` (
  `DeviceId` int(11) NOT NULL AUTO_INCREMENT,
  `DeviceName` varchar(255) NOT NULL,
  `DeviceDirection` varchar(255) DEFAULT NULL,
  `SerialNumber` varchar(255) DEFAULT NULL,
  `TransactionStamp` varchar(50) DEFAULT '0',
  `LastPing` datetime DEFAULT NULL,
  `OpStamp` varchar(255) DEFAULT NULL,
  `Timezone` varchar(50) DEFAULT NULL,
  `ActivationCode` varchar(250) DEFAULT NULL,
  `LastReset` datetime DEFAULT NULL,
  `DeviceType` varchar(255) DEFAULT NULL,
  `IsAttendanceDevice` char(1) DEFAULT NULL,
  `LocationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`DeviceId`),
  KEY `devices` (`DeviceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `devices` */

/*Table structure for table `devicetimeperiods` */

DROP TABLE IF EXISTS `devicetimeperiods`;

CREATE TABLE `devicetimeperiods` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `DeviceId` int(11) NOT NULL,
  `TimePeriodId` int(11) NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Sunday` char(11) DEFAULT NULL,
  `Monday` char(11) DEFAULT NULL,
  `Tuesday` char(11) DEFAULT NULL,
  `Wednesday` char(11) DEFAULT NULL,
  `Thursday` char(11) DEFAULT NULL,
  `Friday` char(11) DEFAULT NULL,
  `Saturday` char(11) DEFAULT NULL,
  `Status` varchar(250) DEFAULT NULL,
  `SyncDate` varchar(250) DEFAULT NULL,
  `IsDirtyDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `idx_deviceId` (`DeviceId`),
  KEY `idx_deviceId_TimePeriodId` (`DeviceId`,`TimePeriodId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `devicetimeperiods` */

/*Table structure for table `devicevisitorcards` */

DROP TABLE IF EXISTS `devicevisitorcards`;

CREATE TABLE `devicevisitorcards` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `DeviceId` int(11) DEFAULT NULL,
  `VisitorCardId` int(11) DEFAULT NULL,
  `Command` varchar(50) DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  `SyncDate` varchar(50) DEFAULT NULL,
  `VisitorCardCode` varchar(50) DEFAULT NULL,
  `IsDirtyDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `ix_DeviceVisitorCards_DId_VId_Status` (`DeviceId`,`VisitorCardId`,`Status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `devicevisitorcards` */

/*Table structure for table `employeeleavelimits` */

DROP TABLE IF EXISTS `employeeleavelimits`;

CREATE TABLE `employeeleavelimits` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `EmployeeId` int(11) DEFAULT NULL,
  `Year` int(11) DEFAULT NULL,
  `LeaveTypeId` int(11) DEFAULT NULL,
  `AllowedLimit` float DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `ixEmployeeLeaveLimits` (`Year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `employeeleavelimits` */

/*Table structure for table `employeemanagers` */

DROP TABLE IF EXISTS `employeemanagers`;

CREATE TABLE `employeemanagers` (
  `EmployeeId` int(11) NOT NULL,
  `ManagerId` int(11) NOT NULL,
  PRIMARY KEY (`EmployeeId`,`ManagerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `employeemanagers` */

/*Table structure for table `employees` */

DROP TABLE IF EXISTS `employees`;

CREATE TABLE `employees` (
  `EmployeeId` int(11) NOT NULL AUTO_INCREMENT,
  `EmployeeName` varchar(250) NOT NULL,
  `EmployeeCode` varchar(250) NOT NULL,
  `StringCode` varchar(250) NOT NULL,
  `NumericCode` int(11) NOT NULL,
  `EmployeeRFIDNumber` varchar(255) DEFAULT NULL,
  `EmployeeDevicePassword` varchar(250) DEFAULT NULL,
  `VerificationType` varchar(2) DEFAULT NULL,
  `Role` varchar(15) DEFAULT NULL,
  `Department` varchar(50) DEFAULT NULL,
  `LastPunch` datetime DEFAULT NULL,
  `LastPunchDeviceId` int(11) DEFAULT NULL,
  `LastPunchDirection` varchar(50) DEFAULT NULL,
  `ExpiryFrom` varchar(20) DEFAULT NULL,
  `ExpiryTo` varchar(20) DEFAULT NULL,
  `GroupId` varchar(50) DEFAULT NULL,
  `AttendanceLocation` varchar(50) DEFAULT NULL,
  `Designation` varchar(50) DEFAULT NULL,
  `DefaultShiftCode` varchar(50) DEFAULT NULL,
  `ReportingTo` varchar(500) DEFAULT NULL,
  `WeeklyOff1` varchar(50) DEFAULT NULL,
  `WeeklyOff2` varchar(50) DEFAULT NULL,
  `WeeklyOffDays` varchar(50) DEFAULT NULL,
  `AllPunchConsideration` varchar(50) DEFAULT NULL,
  `WorkStatus` varchar(50) DEFAULT NULL,
  `Password` varchar(250) DEFAULT NULL,
  `OverTimeApplicable` varchar(1) DEFAULT NULL,
  `AttendanceLocationId` int(11) DEFAULT NULL,
  `Location` text,
  PRIMARY KEY (`EmployeeId`),
  KEY `employees` (`EmployeeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `employees` */

/*Table structure for table `employeesbio` */

DROP TABLE IF EXISTS `employeesbio`;

CREATE TABLE `employeesbio` (
  `EmployeeCode` varchar(50) DEFAULT NULL,
  `BioName` varchar(50) DEFAULT NULL,
  `BioDescription` varchar(50) DEFAULT NULL,
  `Bio` longtext,
  `MinorVer` varchar(50) DEFAULT NULL,
  `MajorVer` varchar(50) DEFAULT NULL,
  `EmployeeBioId` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`EmployeeBioId`),
  KEY `EmployeesBio` (`EmployeeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `employeesbio` */

/*Table structure for table `holidays` */

DROP TABLE IF EXISTS `holidays`;

CREATE TABLE `holidays` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Date` datetime DEFAULT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `LocationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `ix_Holidays` (`Date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `holidays` */

/*Table structure for table `leaves` */

DROP TABLE IF EXISTS `leaves`;

CREATE TABLE `leaves` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `EmployeeId` int(11) DEFAULT NULL,
  `FromDate` datetime DEFAULT NULL,
  `ToDate` datetime DEFAULT NULL,
  `LeaveTypeId` int(11) DEFAULT NULL,
  `Duration` varchar(50) DEFAULT NULL,
  `Remarks` varchar(50) DEFAULT NULL,
  `AppliedDate` datetime DEFAULT NULL,
  `ApprovedById` int(11) DEFAULT NULL,
  `ApprovedDate` datetime DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `ix_leaves` (`EmployeeId`,`FromDate`,`ToDate`,`Status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `leaves` */

/*Table structure for table `leavetypes` */

DROP TABLE IF EXISTS `leavetypes`;

CREATE TABLE `leavetypes` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Code` varchar(50) DEFAULT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `YearlyLimit` float DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `leavetypes` */

/*Table structure for table `locationemployees` */

DROP TABLE IF EXISTS `locationemployees`;

CREATE TABLE `locationemployees` (
  `LocationId` int(11) NOT NULL,
  `EmployeeId` int(11) NOT NULL,
  `Settings` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`LocationId`,`EmployeeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `locationemployees` */

/*Table structure for table `locations` */

DROP TABLE IF EXISTS `locations`;

CREATE TABLE `locations` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Code` varchar(50) DEFAULT NULL,
  `Description` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `ix_Locations_Code` (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `locations` */

/*Table structure for table `locationvisitorcards` */

DROP TABLE IF EXISTS `locationvisitorcards`;

CREATE TABLE `locationvisitorcards` (
  `LocationId` int(11) NOT NULL,
  `VisitorCardId` int(11) NOT NULL,
  PRIMARY KEY (`LocationId`,`VisitorCardId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `locationvisitorcards` */

/*Table structure for table `mastersettings` */

DROP TABLE IF EXISTS `mastersettings`;

CREATE TABLE `mastersettings` (
  `Name` varchar(50) NOT NULL,
  `Value` text,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mastersettings` */

insert  into `mastersettings`(`Name`,`Value`) values ('AttendanceDay','01'),('AttendanceMonth','01'),('DuplicatePunchSeconds','1'),('FileUploadDate','2025-11-10'),('FullDayDuration','540'),('Logo',''),('Name','eSSL Pvt Ltd'),('PunchBeginBefore','120'),('PunchEndAfter','480'),('Version','eBio 2.9'),('WorkBeginTime','09:30'),('WorkEndTime','18:30');

/*Table structure for table `opcodes` */

DROP TABLE IF EXISTS `opcodes`;

CREATE TABLE `opcodes` (
  `Code` varchar(50) NOT NULL,
  `Description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `opcodes` */

insert  into `opcodes`(`Code`,`Description`) values ('0','Power On'),('1','Power Off'),('10','Delete a FingerPrint'),('100','Modify RF card information'),('101','Enroll face'),('102','Modify personnel permissions'),('103','Delete personnel permissions'),('104','Add personnel permissions'),('105','Delete access control records'),('106','Delete face'),('107','Delete personnel photo'),('108','Modify parameters'),('109','Select WIFISSID'),('11','Delete a Password'),('110','proxy enable'),('111','proxyip modification'),('112','Proxy port modification'),('113','Change personnel password'),('114','Modify face information'),('115','Change operators password'),('116','Restore access control settings'),('117','The operator password is entered incorrectly'),('118','operator password lock'),('12','Delete a RFID Card'),('120','Modify the data length of the Legic card'),('121','Register finger vein'),('122','Modify finger vein'),('123','Delete finger vein'),('124','Register palmprint'),('125','Modify palmprint'),('126','Delete palmprint'),('13','Clear the Data'),('14','Create a MF Card'),('15','Enroll a MF Card'),('16','Register  a MF Card'),('17','Delete The Registration of MF Card'),('18','Clear the MF Cards Content'),('19','Move The Enroll Data into Card'),('2','The Authentication is Failed'),('20','Copy The Data in The Card to The Machine'),('21','Set The Time'),('22','Factory Setting'),('23','Delete The In And Out Record'),('24','Clear The Administrator Privilege'),('25','Modify The Setting of Access Control Group'),('26','Modify The Setting Of User Access Control'),('27','Modify The Time Field Of Access Control'),('28','Modify The Setting Of Unclock Combination'),('29','Unclock'),('3','Alarm'),('30','Enroll a User'),('31','Change The Finger Prints Attribute'),('32','Duress Alarm'),('34','Anti-passback'),('35','Delete attendance photo'),('36','Modify other user information'),('37','Holidays'),('38','Restore data'),('39 ','Backup data'),('4','Enter into the Main Menu'),('40','U-disk upload'),('41','U-disk download'),('42','U-disk attendance record encryption'),('43','Delete records after successful download'),('5','Change The Setting'),('53','Exit button'),('54','Door sensor'),('55','Alarm'),('56','Recovery parameters'),('6','Enroll a FingerPrint'),('68','Register user photo'),('69','Edit user photo'),('7','Enroll a Password'),('70','Modify user name'),('71','Modify user permissions'),('76','Modify network settings IP'),('77','Modify network settings mask'),('78','Modify network settings gateway'),('79','Modify network settings DNS'),('8','Enroll a HID Card'),('80','Modify connection settings password'),('81','Modify connection settings device ID'),('82','Modify cloud server address'),('83','Modify cloud server port'),('87','Modify access control record settings'),('88','Modify face parameter icon'),('89','Modify fingerprint parameter icon'),('9','Delete a User'),('90','Modify finger vein parameter icon'),('91','Modify palmprint parameter icon'),('92','U-disk upgrade icon');

/*Table structure for table `outduties` */

DROP TABLE IF EXISTS `outduties`;

CREATE TABLE `outduties` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `EmployeeId` int(11) DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `Duration` int(11) DEFAULT NULL,
  `Remarks` varchar(500) DEFAULT NULL,
  `AppliedDate` datetime DEFAULT NULL,
  `ApprovedById` int(11) DEFAULT NULL,
  `ApprovedDate` datetime DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `ix_OutDuties` (`EmployeeId`,`Date`,`Status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `outduties` */

/*Table structure for table `paycomponents` */

DROP TABLE IF EXISTS `paycomponents`;

CREATE TABLE `paycomponents` (
  `Id` int(11) NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Type` varchar(50) DEFAULT NULL,
  `SortOrder` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `paycomponents` */

insert  into `paycomponents`(`Id`,`Name`,`Type`,`SortOrder`) values (1,'Basic','Addition',1),(2,'HRA','Addition',2),(3,'DA','Addition',3),(4,'PT','Deduction',4),(5,'PF','Deduction',5),(6,'EPF','Deduction',6),(7,'ESIC','Deduction',7),(8,'LOP','Deduction',8),(9,'OT','Addition',9),(10,'Bouns','Addition',10),(11,'TDS','Deduction',11),(12,'','',0),(13,'','',0),(14,'','',0),(15,'','',0),(16,'','',0),(17,'','',0),(18,'','',0),(19,'','',0),(20,'','',0),(21,'','',0),(22,'','',0),(23,'','',0),(24,'','',0),(25,'','',0),(26,'','',0),(27,'','',0),(28,'','',0),(29,'','',0),(30,'','',0),(31,'','',0),(32,'','',0),(33,'','',0),(34,'','',0),(35,'','',0),(36,'','',0),(37,'','',0),(38,'','',0),(39,'','',0),(40,'','',0),(41,'','',0),(42,'','',0),(43,'','',0),(44,'','',0),(45,'','',0),(46,'','',0),(47,'','',0),(48,'','',0),(49,'','',0),(50,'','',0);

/*Table structure for table `paycycles` */

DROP TABLE IF EXISTS `paycycles`;

CREATE TABLE `paycycles` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) DEFAULT NULL,
  `PayDate` datetime DEFAULT NULL,
  `FromDate` datetime DEFAULT NULL,
  `ToDate` datetime DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `paycycles` */

/*Table structure for table `payslips` */

DROP TABLE IF EXISTS `payslips`;

CREATE TABLE `payslips` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `EmployeeId` int(11) DEFAULT NULL,
  `PayCycleId` int(11) DEFAULT NULL,
  `GrossSalary` varchar(50) DEFAULT NULL,
  `NetSalary` varchar(50) DEFAULT NULL,
  `Remarks` varchar(250) DEFAULT NULL,
  `1` varchar(50) DEFAULT NULL,
  `2` varchar(50) DEFAULT NULL,
  `3` varchar(50) DEFAULT NULL,
  `4` varchar(50) DEFAULT NULL,
  `5` varchar(50) DEFAULT NULL,
  `6` varchar(50) DEFAULT NULL,
  `7` varchar(50) DEFAULT NULL,
  `8` varchar(50) DEFAULT NULL,
  `9` varchar(50) DEFAULT NULL,
  `10` varchar(50) DEFAULT NULL,
  `11` varchar(50) DEFAULT NULL,
  `12` varchar(50) DEFAULT NULL,
  `13` varchar(50) DEFAULT NULL,
  `14` varchar(50) DEFAULT NULL,
  `15` varchar(50) DEFAULT NULL,
  `16` varchar(50) DEFAULT NULL,
  `17` varchar(50) DEFAULT NULL,
  `18` varchar(50) DEFAULT NULL,
  `19` varchar(50) DEFAULT NULL,
  `20` varchar(50) DEFAULT NULL,
  `21` varchar(50) DEFAULT NULL,
  `22` varchar(50) DEFAULT NULL,
  `23` varchar(50) DEFAULT NULL,
  `24` varchar(50) DEFAULT NULL,
  `25` varchar(50) DEFAULT NULL,
  `26` varchar(50) DEFAULT NULL,
  `27` varchar(50) DEFAULT NULL,
  `28` varchar(50) DEFAULT NULL,
  `29` varchar(50) DEFAULT NULL,
  `30` varchar(50) DEFAULT NULL,
  `31` varchar(50) DEFAULT NULL,
  `32` varchar(50) DEFAULT NULL,
  `33` varchar(50) DEFAULT NULL,
  `34` varchar(50) DEFAULT NULL,
  `35` varchar(50) DEFAULT NULL,
  `36` varchar(50) DEFAULT NULL,
  `37` varchar(50) DEFAULT NULL,
  `38` varchar(50) DEFAULT NULL,
  `39` varchar(50) DEFAULT NULL,
  `40` varchar(50) DEFAULT NULL,
  `41` varchar(50) DEFAULT NULL,
  `42` varchar(50) DEFAULT NULL,
  `43` varchar(50) DEFAULT NULL,
  `44` varchar(50) DEFAULT NULL,
  `45` varchar(50) DEFAULT NULL,
  `46` varchar(50) DEFAULT NULL,
  `47` varchar(50) DEFAULT NULL,
  `48` varchar(50) DEFAULT NULL,
  `49` varchar(50) DEFAULT NULL,
  `50` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `payslips` */

/*Table structure for table `salarystructures` */

DROP TABLE IF EXISTS `salarystructures`;

CREATE TABLE `salarystructures` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `EmployeeId` int(11) DEFAULT NULL,
  `EffectiveDate` datetime DEFAULT NULL,
  `GrossSalary` varchar(50) DEFAULT NULL,
  `NetSalary` varchar(50) DEFAULT NULL,
  `Remarks` varchar(250) DEFAULT NULL,
  `1` varchar(50) DEFAULT NULL,
  `2` varchar(50) DEFAULT NULL,
  `3` varchar(50) DEFAULT NULL,
  `4` varchar(50) DEFAULT NULL,
  `5` varchar(50) DEFAULT NULL,
  `6` varchar(50) DEFAULT NULL,
  `7` varchar(50) DEFAULT NULL,
  `8` varchar(50) DEFAULT NULL,
  `9` varchar(50) DEFAULT NULL,
  `10` varchar(50) DEFAULT NULL,
  `11` varchar(50) DEFAULT NULL,
  `12` varchar(50) DEFAULT NULL,
  `13` varchar(50) DEFAULT NULL,
  `14` varchar(50) DEFAULT NULL,
  `15` varchar(50) DEFAULT NULL,
  `16` varchar(50) DEFAULT NULL,
  `17` varchar(50) DEFAULT NULL,
  `18` varchar(50) DEFAULT NULL,
  `19` varchar(50) DEFAULT NULL,
  `20` varchar(50) DEFAULT NULL,
  `21` varchar(50) DEFAULT NULL,
  `22` varchar(50) DEFAULT NULL,
  `23` varchar(50) DEFAULT NULL,
  `24` varchar(50) DEFAULT NULL,
  `25` varchar(50) DEFAULT NULL,
  `26` varchar(50) DEFAULT NULL,
  `27` varchar(50) DEFAULT NULL,
  `28` varchar(50) DEFAULT NULL,
  `29` varchar(50) DEFAULT NULL,
  `30` varchar(50) DEFAULT NULL,
  `31` varchar(50) DEFAULT NULL,
  `32` varchar(50) DEFAULT NULL,
  `33` varchar(50) DEFAULT NULL,
  `34` varchar(50) DEFAULT NULL,
  `35` varchar(50) DEFAULT NULL,
  `36` varchar(50) DEFAULT NULL,
  `37` varchar(50) DEFAULT NULL,
  `38` varchar(50) DEFAULT NULL,
  `39` varchar(50) DEFAULT NULL,
  `40` varchar(50) DEFAULT NULL,
  `41` varchar(50) DEFAULT NULL,
  `42` varchar(50) DEFAULT NULL,
  `43` varchar(50) DEFAULT NULL,
  `44` varchar(50) DEFAULT NULL,
  `45` varchar(50) DEFAULT NULL,
  `46` varchar(50) DEFAULT NULL,
  `47` varchar(50) DEFAULT NULL,
  `48` varchar(50) DEFAULT NULL,
  `49` varchar(50) DEFAULT NULL,
  `50` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_SalaryStructures_EId` (`EmployeeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `salarystructures` */

/*Table structure for table `shiftschedule` */

DROP TABLE IF EXISTS `shiftschedule`;

CREATE TABLE `shiftschedule` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Date` datetime DEFAULT NULL,
  `EmployeeId` int(11) DEFAULT NULL,
  `Day1` varchar(5) DEFAULT NULL,
  `Day2` varchar(5) DEFAULT NULL,
  `Day3` varchar(5) DEFAULT NULL,
  `Day4` varchar(5) DEFAULT NULL,
  `Day5` varchar(5) DEFAULT NULL,
  `Day6` varchar(5) DEFAULT NULL,
  `Day7` varchar(5) DEFAULT NULL,
  `Day8` varchar(5) DEFAULT NULL,
  `Day9` varchar(5) DEFAULT NULL,
  `Day10` varchar(5) DEFAULT NULL,
  `Day11` varchar(5) DEFAULT NULL,
  `Day12` varchar(5) DEFAULT NULL,
  `Day13` varchar(5) DEFAULT NULL,
  `Day14` varchar(5) DEFAULT NULL,
  `Day15` varchar(5) DEFAULT NULL,
  `Day16` varchar(5) DEFAULT NULL,
  `Day17` varchar(5) DEFAULT NULL,
  `Day18` varchar(5) DEFAULT NULL,
  `Day19` varchar(5) DEFAULT NULL,
  `Day20` varchar(5) DEFAULT NULL,
  `Day21` varchar(5) DEFAULT NULL,
  `Day22` varchar(5) DEFAULT NULL,
  `Day23` varchar(5) DEFAULT NULL,
  `Day24` varchar(5) DEFAULT NULL,
  `Day25` varchar(5) DEFAULT NULL,
  `Day26` varchar(5) DEFAULT NULL,
  `Day27` varchar(5) DEFAULT NULL,
  `Day28` varchar(5) DEFAULT NULL,
  `Day29` varchar(5) DEFAULT NULL,
  `Day30` varchar(5) DEFAULT NULL,
  `Day31` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `ix_ShiftSchedule` (`EmployeeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `shiftschedule` */

/*Table structure for table `shifttypes` */

DROP TABLE IF EXISTS `shifttypes`;

CREATE TABLE `shifttypes` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Code` varchar(50) DEFAULT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `BeginTime` varchar(50) DEFAULT NULL,
  `EndTime` varchar(50) DEFAULT NULL,
  `PartialDay` varchar(1) DEFAULT NULL,
  `PartialDayBeginTime` varchar(50) DEFAULT NULL,
  `PartialDayEndTime` varchar(50) DEFAULT NULL,
  `FullDayDuration` int(11) DEFAULT NULL,
  `PartialDayDuration` int(11) DEFAULT NULL,
  `PunchBeginBefore` int(11) DEFAULT NULL,
  `PunchEndAfter` int(11) DEFAULT NULL,
  `LocationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `shifttypes` */

/*Table structure for table `userlocations` */

DROP TABLE IF EXISTS `userlocations`;

CREATE TABLE `userlocations` (
  `LocationId` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  PRIMARY KEY (`LocationId`,`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `userlocations` */

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `UserId` int(11) NOT NULL AUTO_INCREMENT,
  `LoginName` varchar(250) NOT NULL,
  `LoginPassword` varchar(250) DEFAULT NULL,
  `RoleName` varchar(255) DEFAULT NULL,
  `Permissions` varchar(2000) DEFAULT NULL,
  `Locations` longtext,
  `Blocked` varchar(50) DEFAULT NULL,
  `StrongPassword` char(1) DEFAULT NULL,
  `BlockInvalidLogin` char(1) DEFAULT NULL,
  `AuthToken` varchar(50) DEFAULT NULL,
  `Expiry` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8;

/*Data for the table `users` */

insert  into `users`(`UserId`,`LoginName`,`LoginPassword`,`RoleName`,`Permissions`,`Locations`,`Blocked`,`StrongPassword`,`BlockInvalidLogin`,`AuthToken`,`Expiry`) values (110,'essl','cktXWWdRclRDR2M9','Admin','1,ViewUsers,AddUsers,EditUsers,DeleteUsers,3,ViewLocations,AddLocations,EditLocations,DeleteLocations,6,ViewEmployeesAC,AddEmployeesAC,EditEmployeesAC,DeleteEmployeesAC,EmployeeBiometrics,EmployeeTimePeriods,12,ViewDevices,AddDevices,EditDevices,DeleteDevices,DeviceEmployees,DeviceVisitors,DeviceGroups,DeviceTimePeriods,DeviceCommands,DeviceLogs,DeviceOPLogs,CompanySettings,21,ViewEmployeesAT,AddEmployeesAT,EditEmployeesAT,DeleteEmployeesAT,LeaveLimits,EditLeaveLimits,25,ViewHolidays,AddHolidays,EditHolidays,DeleteHolidays,30,ViewLeaveTypes,AddLeaveTypes,EditLeaveTypes,DeleteLeaveTypes,35,ViewShiftTypes,AddShiftTypes,EditShiftTypes,DeleteShiftTypes,40,ViewShiftSchedule,EditShiftSchedule,PeriodSettings,45,ViewLeaveRocords,AddLeaveRocords,EditLeaveRocords,DeleteLeaveRocords,50,ViewOutDutyRocords,AddOutDutyRocords,EditOutDutyRocords,DeleteOutDutyRocords,55,ViewCompOffRocords,AddCompOffRocords,EditCompOffRocords,DeleteCompOffRocords,60,ViewAttendanceRegister,EditAttendanceRegister,62,ViewPayComponents,AddPayComponents,EditPayComponents,DeletePayComponents,64,ViewSalaryStructures,AddSalaryStructures,EditSalaryStructures,DeleteSalaryStructures,66,ViewPayCycles,AddPayCycles,EditPayCycles,DeletePayCycles,ViewPayslips,EditPayslips,ExportSalaryStructures,ExportPaySlips,PayslipReport,Reports,VisitorLogs,9,ViewVisitorCards,AddVisitorCards,EditVisitorCards,DeleteVisitorCards,11,ViewVisitorDesks,AddVisitorDesks,EditVisitorDesks,DeleteVisitorDesks,13,ImportEmployees,ExportEmployees,ImportEmployeesA,ExportEmployeesA,ImportEmployeesShiftSchedule,ExportEmployeesShiftSchedule,ImportLeaveLimits,ExportLeaveLimits,ImportDevices,ExportDevices,ExportLogs,ParalellLogsExport,Webhook,FileUpload,DatabaseSettings,APISettings,License','','0','0','0','10d131b2-9b17-4212-80d0-bc6fac294b37','0|2025-08-04');

/*Table structure for table `verificationtype` */

DROP TABLE IF EXISTS `verificationtype`;

CREATE TABLE `verificationtype` (
  `Code` int(11) DEFAULT NULL,
  `Name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `verificationtype` */

insert  into `verificationtype`(`Code`,`Name`) values (0,'Finger or Face or Card or Password'),(1,'Finger'),(2,'User ID'),(3,'Password'),(4,'Card'),(5,'Finger or Password'),(6,'Finger or Card'),(7,'Card or Password'),(8,'User ID and Finger'),(9,'Finger and Password'),(10,'Card and Finger'),(11,'Card and Password'),(11,'Card and Password'),(12,'Finger and Card and Password'),(13,'User ID and Finger and Password'),(14,'User ID and Finger or Card and Finger'),(14,'User ID and Finger or Card and Finger'),(15,'Face'),(16,'Face and Finge'),(17,'Face and Password'),(18,'Face and Card'),(19,'Face and Finger and Card'),(20,'Face and Finger and Password'),(25,'Palm'),(26,'Palm and Card'),(27,'Palm and Face'),(28,'Palm and Finger'),(29,'Palm and Finger and Face'),(200,'Other'),(-1,'Apply Group Mode');

/*Table structure for table `visitorcards` */

DROP TABLE IF EXISTS `visitorcards`;

CREATE TABLE `visitorcards` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) DEFAULT NULL,
  `ExpiryFrom` varchar(50) DEFAULT NULL,
  `ExpiryTo` varchar(50) DEFAULT NULL,
  `LocationId` int(11) DEFAULT NULL,
  `CardNumber` varchar(50) DEFAULT NULL,
  `Location` longtext,
  PRIMARY KEY (`Id`),
  KEY `ix_VisitorCards_LocationId` (`LocationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `visitorcards` */

/*Table structure for table `visitordesks` */

DROP TABLE IF EXISTS `visitordesks`;

CREATE TABLE `visitordesks` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) DEFAULT NULL,
  `LoginName` varchar(500) DEFAULT NULL,
  `Password` varchar(500) DEFAULT NULL,
  `LocationId` int(11) DEFAULT NULL,
  `UUID` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `ix_VisitorDesks_UUID` (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `visitordesks` */

/*Table structure for table `visitorlogs` */

DROP TABLE IF EXISTS `visitorlogs`;

CREATE TABLE `visitorlogs` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) DEFAULT NULL,
  `ContactNumber` varchar(50) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `LocationId` int(11) DEFAULT NULL,
  `Purpose` varchar(250) DEFAULT NULL,
  `ToMeetId` int(11) DEFAULT NULL,
  `VisitorDeskId` int(11) DEFAULT NULL,
  `VisitorCardId` int(11) DEFAULT NULL,
  `Company` varchar(250) DEFAULT NULL,
  `Designation` varchar(50) DEFAULT NULL,
  `InDate` datetime DEFAULT NULL,
  `OutDate` datetime DEFAULT NULL,
  `Remarks` varchar(500) DEFAULT NULL,
  `Status` varchar(3) DEFAULT NULL,
  `Photo` longtext,
  PRIMARY KEY (`Id`),
  KEY `ix_VisitorLogs_LId_IDate_ODate` (`InDate`,`OutDate`,`LocationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `visitorlogs` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
