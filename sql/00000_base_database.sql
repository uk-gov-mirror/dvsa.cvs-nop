--liquibase formatted sql
--changeset chris.peska:create-multiple-tables:1 splitStatements:true endDelimiter:; context:dev

SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE =
        'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Table `vehicle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vehicle`
(
    `id`            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `system_number` VARCHAR(30)  NOT NULL,
    `vin`           VARCHAR(21),
    `vrm_trm`       VARCHAR(9),
    `trailer_id`    VARCHAR(8),
    `createdAt`     DATETIME,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `idx_system_number_uq` (`system_number` ASC)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `make_model`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `make_model`
(
    `id`                   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `make`                 VARCHAR(30),
    `model`                VARCHAR(30),
    `chassisMake`          VARCHAR(20),
    `chassisModel`         VARCHAR(20),
    `bodyMake`             VARCHAR(20),
    `bodyModel`            VARCHAR(20),
    `modelLiteral`         VARCHAR(30),
    `bodyTypeCode`         CHAR(1),
    `bodyTypeDescription`  VARCHAR(17),
    `fuelPropulsionSystem` VARCHAR(12),
    `fingerprint`          VARCHAR(32)  NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `idx_fingerprint_uq` (`fingerprint` ASC)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vehicle_class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vehicle_class`
(
    `id`                   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `code`                 CHAR(1),
    `description`          VARCHAR(46),
    `vehicleType`          VARCHAR(10),
    `vehicleSize`          VARCHAR(5),
    `vehicleConfiguration` VARCHAR(20),
    `euVehicleCategory`    VARCHAR(5),
    `fingerprint`          VARCHAR(32)  NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `idx_fingerprint_uq` (`fingerprint` ASC)
)
    ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `vehicle_subclass`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vehicle_subclass`
(
    `id`               INT          NOT NULL AUTO_INCREMENT,
    `vehicle_class_id` INT UNSIGNED NOT NULL,
    `subclass`         VARCHAR(1),
    `fingerprint`      VARCHAR(32)  NOT NULL,
    PRIMARY KEY (`id`),

    UNIQUE INDEX `idx_fingerprint_uq` (`fingerprint` ASC),
    FOREIGN KEY (`vehicle_class_id`)
        REFERENCES `vehicle_class` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `identity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `identity`
(
    `id`          INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `identityId`  VARCHAR(36),
    `name`        VARCHAR(320),
    `fingerprint` VARCHAR(32)  NOT NULL,
    PRIMARY KEY (`id`),

    UNIQUE INDEX `idx_fingerprint_uq` (`fingerprint` ASC),
    INDEX `idx_name` (`name` ASC)
)
    ENGINE = InnoDB;



-- -- -----------------------------------------------------
-- -- Table `contact_details`
-- -- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `contact_details`
(
    `id`              INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`            VARCHAR(150),
    `address1`        VARCHAR(60),
    `address2`        VARCHAR(60),
    `postTown`        VARCHAR(60),
    `address3`        VARCHAR(60),
    `postCode`        VARCHAR(12),
    `emailAddress`    VARCHAR(255),
    `telephoneNumber` VARCHAR(25),
    `faxNumber`       VARCHAR(25),
    `fingerprint`     VARCHAR(32)  NOT NULL,
    PRIMARY KEY (`id`),

    UNIQUE INDEX `idx_fingerprint_uq` (`fingerprint` ASC)
)
    ENGINE = InnoDB;

-- -- -----------------------------------------------------
-- -- Table ``
-- -- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `brakes`
(
    `id`                    INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `brakeCodeOriginal`     VARCHAR(3),
    `brakeCode`             VARCHAR(6),
    `dataTrBrakeOne`        VARCHAR(60),
    `dataTrBrakeTwo`        VARCHAR(60),
    `dataTrBrakeThree`      VARCHAR(60),
    `retarderBrakeOne`      VARCHAR(9),
    `retarderBrakeTwo`      VARCHAR(9),
    `dtpNumber`             VARCHAR(6),
    `loadSensingValve`      TINYINT(1),
    `antilockBrakingSystem` TINYINT(1),
    `serviceBrakeForceA`    MEDIUMINT UNSIGNED,
    `secondaryBrakeForceA`  MEDIUMINT UNSIGNED,
    `parkingBrakeForceA`    MEDIUMINT UNSIGNED,
    `serviceBrakeForceB`    MEDIUMINT UNSIGNED,
    `secondaryBrakeForceB`  MEDIUMINT UNSIGNED,
    `parkingBrakeForceB`    MEDIUMINT UNSIGNED,
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `technical_record`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `technical_record`
(
    `id`                               INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `vehicle_id`                       INT UNSIGNED NOT NULL,
    `recordCompleteness`               VARCHAR(8),
    `createdAt`                        DATETIME,
    `lastUpdatedAt`                    DATETIME,
    `make_model_id`                    INT UNSIGNED NOT NULL,
    `functionCode`                     CHAR(1),
    `offRoad`                          TINYINT(1),
    `numberOfWheelsDriven`             INT,
    `emissionsLimit`                   VARCHAR(45),
    `departmentalVehicleMarker`        TINYINT(1),
    `alterationMarker`                 TINYINT(1),
    `vehicle_class_id`                 INT UNSIGNED NOT NULL,
    `variantVersionNumber`             VARCHAR(35),
    `grossEecWeight`                   MEDIUMINT UNSIGNED,
    `trainEecWeight`                   MEDIUMINT UNSIGNED,
    `maxTrainEecWeight`                MEDIUMINT UNSIGNED,
    `applicant_detail_id`              INT UNSIGNED NOT NULL,
    `purchaser_detail_id`              INT UNSIGNED NOT NULL,
    `manufacturer_detail_id`           INT UNSIGNED NOT NULL,
    `manufactureYear`                  YEAR,
    `regnDate`                         DATE,
    `firstUseDate`                     DATE,
    `coifDate`                         DATE,
    `ntaNumber`                        VARCHAR(40),
    `coifSerialNumber`                 VARCHAR(8),
    `coifCertifierName`                VARCHAR(20),
    `approvalType`                     VARCHAR(3),
    `approvalTypeNumber`               VARCHAR(25),
    `variantNumber`                    VARCHAR(25),
    `conversionRefNo`                  VARCHAR(10),
    `seatsLowerDeck`                   SMALLINT UNSIGNED,
    `seatsUpperDeck`                   TINYINT UNSIGNED,
    `standingCapacity`                 SMALLINT UNSIGNED,
    `speedRestriction`                 TINYINT UNSIGNED,
    `speedLimiterMrk`                  TINYINT(1),
    `tachoExemptMrk`                   TINYINT(1),
    `dispensations`                    VARCHAR(160),
    `remarks`                          VARCHAR(1024),
    `reasonForCreation`                VARCHAR(100),
    `statusCode`                       VARCHAR(11),
    `unladenWeight`                    MEDIUMINT UNSIGNED,
    `grossKerbWeight`                  MEDIUMINT UNSIGNED,
    `grossLadenWeight`                 MEDIUMINT UNSIGNED,
    `grossGbWeight`                    MEDIUMINT UNSIGNED,
    `grossDesignWeight`                MEDIUMINT UNSIGNED,
    `trainGbWeight`                    MEDIUMINT UNSIGNED,
    `trainDesignWeight`                MEDIUMINT UNSIGNED,
    `maxTrainGbWeight`                 MEDIUMINT UNSIGNED,
    `maxTrainDesignWeight`             MEDIUMINT UNSIGNED,
    `maxLoadOnCoupling`                MEDIUMINT UNSIGNED,
    `frameDescription`                 VARCHAR(15),
    `tyreUseCode`                      VARCHAR(2),
    `roadFriendly`                     TINYINT(1),
    `drawbarCouplingFitted`            TINYINT(1),
    `euroStandard`                     VARCHAR(9),
    `suspensionType`                   CHAR(1),
    `couplingType`                     CHAR(1),
    `length`                           MEDIUMINT UNSIGNED,
    `height`                           MEDIUMINT UNSIGNED,
    `width`                            MEDIUMINT UNSIGNED,
    `frontAxleTo5thWheelMin`           MEDIUMINT UNSIGNED,
    `frontAxleTo5thWheelMax`           MEDIUMINT UNSIGNED,
    `frontAxleTo5thWheelCouplingMin`   MEDIUMINT UNSIGNED,
    `frontAxleTo5thWheelCouplingMax`   MEDIUMINT UNSIGNED,
    `frontAxleToRearAxle`              MEDIUMINT UNSIGNED,
    `rearAxleToRearTrl`                MEDIUMINT UNSIGNED,
    `couplingCenterToRearAxleMin`      MEDIUMINT UNSIGNED,
    `couplingCenterToRearAxleMax`      MEDIUMINT UNSIGNED,
    `couplingCenterToRearTrlMin`       MEDIUMINT UNSIGNED,
    `couplingCenterToRearTrlMax`       MEDIUMINT UNSIGNED,
    `centreOfRearmostAxleToRearOfTrl`  MEDIUMINT UNSIGNED,
    `notes`                            VARCHAR(800),
    `purchaserNotes`                   VARCHAR(1024),
    `manufacturerNotes`                VARCHAR(1024),
    `noOfAxles`                        TINYINT(1),
    `brakeCode`                        VARCHAR(6),
    `createdBy_Id`                     INT UNSIGNED NOT NULL,
    `lastUpdatedBy_Id`                 INT UNSIGNED NOT NULL,
    `updateType`                       VARCHAR(16),
    `numberOfSeatbelts`                VARCHAR(99),
    `seatbeltInstallationApprovalDate` DATE,
    `brakes_id`                        INT UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),

    FOREIGN KEY (`vehicle_id`)
        REFERENCES `vehicle` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`applicant_detail_id`)
        REFERENCES `contact_details` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`purchaser_detail_id`)
        REFERENCES `contact_details` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`manufacturer_detail_id`)
        REFERENCES `contact_details` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`make_model_id`)
        REFERENCES `make_model` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`vehicle_class_id`)
        REFERENCES `vehicle_class` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`createdBy_Id`)
        REFERENCES `identity` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`lastUpdatedBy_Id`)
        REFERENCES `identity` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`brakes_id`)
        REFERENCES `brakes` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    INDEX `idx_vehicle_id` (`vehicle_id` ASC),
    INDEX `idx_make_model_id` (`make_model_id` ASC),
    INDEX `idx_vehicle_class_id` (`vehicle_class_id` ASC),
    INDEX `idx_createdBy_Id` (`createdBy_Id` ASC),
    INDEX `idx_lastUpdatedBy_Id` (`lastUpdatedBy_Id` ASC)
)
    ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `axle_spacing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `axle_spacing`
(
    `id`                  INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `technical_record_id` INT UNSIGNED NOT NULL,
    `axles`               VARCHAR(5),
    `value`               MEDIUMINT UNSIGNED,
    PRIMARY KEY (`id`),

    FOREIGN KEY (`technical_record_id`)
        REFERENCES `technical_record` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    INDEX `idx_technical_record_id` (`technical_record_id` ASC)
)
    ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `microfilm`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `microfilm`
(
    `id`                    INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `technical_record_id`   INT UNSIGNED NOT NULL,
    `microfilmDocumentType` VARCHAR(31),
    `microfilmRollNumber`   VARCHAR(5),
    `microfilmSerialNumber` VARCHAR(4),
    PRIMARY KEY (`id`),

    FOREIGN KEY (`technical_record_id`)
        REFERENCES `technical_record` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    INDEX `idx_technical_record_id` (`technical_record_id` ASC)
)
    ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `plate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plate`
(
    `id`                  INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `technical_record_id` INT UNSIGNED NOT NULL,
    `plateSerialNumber`   VARCHAR(12),
    `plateIssueDate`      DATE,
    `plateReasonForIssue` VARCHAR(16),
    `plateIssuer`         VARCHAR(150),
    PRIMARY KEY (`id`),
    FOREIGN KEY (`technical_record_id`)
        REFERENCES `technical_record` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    INDEX `idx_technical_record_id` (`technical_record_id` ASC)
)
    ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `fuel_emission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fuel_emission`
(
    `id`               INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `modTypeCode`      CHAR(1),
    `description`      VARCHAR(32),
    `emissionStandard` VARCHAR(21),
    `fuelType`         VARCHAR(13),
    `fingerprint`      VARCHAR(32)  NOT NULL,
    PRIMARY KEY (`id`),

    UNIQUE INDEX `idx_fingerprint_uq` (`fingerprint` ASC)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `test_station`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test_station`
(
    `id`          INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `pNumber`     VARCHAR(20),
    `name`        VARCHAR(1000),
    `type`        VARCHAR(4),
    `fingerprint` VARCHAR(32)  NOT NULL,
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tester`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tester`
(
    `id`            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `staffId`       VARCHAR(9),
    `name`          VARCHAR(60),
    `email_address` VARCHAR(254),
    `fingerprint`   VARCHAR(32)  NOT NULL,
    PRIMARY KEY (`id`),

    UNIQUE INDEX `idx_fingerprint_uq` (`fingerprint` ASC)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `preparer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `preparer`
(
    `id`          INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `preparerId`  VARCHAR(9),
    `name`        VARCHAR(60),
    `fingerprint` VARCHAR(32)  NOT NULL,
    PRIMARY KEY (`id`),

    UNIQUE INDEX `idx_fingerprint_uq` (`fingerprint` ASC)
)
    ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `test_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test_type`
(
    `id`                     INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `testTypeClassification` VARCHAR(23),
    `testTypeName`           VARCHAR(100),
    `fingerprint`            VARCHAR(32)  NOT NULL,
    PRIMARY KEY (`id`),

    UNIQUE INDEX `idx_fingerprint_uq` (`fingerprint` ASC)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `test_record`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test_record`
(
    `id`                                INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `technical_record_id`               INT UNSIGNED NOT NULL,
    `vehicle_id`                        INT UNSIGNED NOT NULL,
    `fuel_emission_id`                  INT UNSIGNED NOT NULL,
    `test_station_id`                   INT UNSIGNED NOT NULL,
    `tester_id`                         INT UNSIGNED NOT NULL,
    `preparer_id`                       INT UNSIGNED NOT NULL,
    `vehicle_class_id`                  INT UNSIGNED NOT NULL,
    `test_type_id`                      INT UNSIGNED NOT NULL,
    `testStatus`                        VARCHAR(9),
    `reasonForCancellation`             VARCHAR(500),
    `numberOfSeats`                     INT,
    `odometerReading`                   INT UNSIGNED,
    `odometerReadingUnits`              VARCHAR(10),
    `countryOfRegistration`             VARCHAR(56),
    `noOfAxles`                         TINYINT UNSIGNED,
    `regnDate`                          DATE,
    `firstUseDate`                      DATE,
    `createdAt`                         DATETIME,
    `lastUpdatedAt`                     DATETIME,
    `testCode`                          VARCHAR(3),
    `testNumber`                        VARCHAR(45),
    `certificateNumber`                 VARCHAR(9),
    `secondaryCertificateNumber`        VARCHAR(9),
    `testExpiryDate`                    DATE,
    `testAnniversaryDate`               DATE,
    `testTypeStartTimestamp`            DATETIME,
    `testTypeEndTimestamp`              DATETIME,
    `numberOfSeatbeltsFitted`           TINYINT UNSIGNED,
    `lastSeatbeltInstallationCheckDate` DATE,
    `seatbeltInstallationCheckDate`     TINYINT(1),
    `testResult`                        VARCHAR(9),
    `reasonForAbandoning`               VARCHAR(45),
    `additionalNotesRecorded`           VARCHAR(500),
    `additionalCommentsForAbandon`      VARCHAR(500),
    `particulateTrapFitted`             VARCHAR(100),
    `particulateTrapSerialNumber`       VARCHAR(100),
    `modificationTypeUsed`              VARCHAR(100),
    `smokeTestKLimitApplied`            VARCHAR(100),
    `createdBy_Id`                      INT UNSIGNED NOT NULL,
    `lastUpdatedBy_Id`                  INT UNSIGNED NOT NULL,

    PRIMARY KEY (`id`),
    INDEX `idx_technical_record_id` (`technical_record_id` ASC),
    INDEX `idx_vehicle_id` (`vehicle_id` ASC),
    INDEX `idx_fuel_emission_id` (`fuel_emission_id` ASC),
    INDEX `idx_test_station_id` (`test_station_id` ASC),
    INDEX `idx_tester_id` (`tester_id` ASC),
    INDEX `idx_vehicle_class_id` (`vehicle_class_id` ASC),
    INDEX `idx_preparer_id` (`preparer_id` ASC),

    FOREIGN KEY (`technical_record_id`)
        REFERENCES `technical_record` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`vehicle_id`)
        REFERENCES `vehicle` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`fuel_emission_id`)
        REFERENCES `fuel_emission` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`test_station_id`)
        REFERENCES `test_station` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`tester_id`)
        REFERENCES `tester` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`vehicle_class_id`)
        REFERENCES `vehicle_class` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`test_type_id`)
        REFERENCES `test_type` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`preparer_id`)
        REFERENCES `preparer` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`createdBy_Id`)
        REFERENCES `identity` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`lastUpdatedBy_Id`)
        REFERENCES `identity` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
)
    ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `custom_defect`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `custom_defect`
(
    `id`              INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `test_record_id`  INT UNSIGNED NOT NULL,
    `referenceNumber` VARCHAR(10),
    `defectName`      VARCHAR(200),
    `defectNotes`     VARCHAR(200),
    PRIMARY KEY (`id`),
    INDEX `idx_technical_record_id` (`test_record_id` ASC),

    FOREIGN KEY (`test_record_id`)
        REFERENCES `test_record` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
)
    ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `axles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `axles`
(
    `id`                  INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `technical_record_id` INT UNSIGNED NOT NULL,
    `tire_id`             INT UNSIGNED NOT NULL,
    `axleNumber`          INT          NOT NULL,
    `parkingBrakeMrk`     TINYINT(1),
    `kerbWeight`          INT UNSIGNED,
    `ladenWeight`         INT UNSIGNED,
    `gbWeight`            INT UNSIGNED,
    `eecWeight`           INT UNSIGNED,
    `designWeight`        INT UNSIGNED,
    `brakeActuator`       INT UNSIGNED,
    `leverLength`         INT UNSIGNED,
    `springBrakeParking`  INT UNSIGNED,
    PRIMARY KEY (`id`),
    INDEX `idx_technical_record_id` (`technical_record_id` ASC),

    FOREIGN KEY (`technical_record_id`)
        REFERENCES `technical_record` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`tire_id`)
        REFERENCES `tire` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION

)
    ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `tire`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tire`
(
    `id`                  INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `tyreSize`            VARCHAR(12),
    `plyRating`           VARCHAR(2),
    `fitmentCode`         VARCHAR(6),
    `dataTrAxles`         VARCHAR(45),
    `speedCategorySymbol` VARCHAR(2),
    `tyreCode`            INT UNSIGNED,
    `fingerprint`         VARCHAR(32)  NOT NULL,
    PRIMARY KEY (`id`),

    UNIQUE INDEX `idx_fingerprint_uq` (`fingerprint` ASC)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `defects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `defects`
(
    `id`                 INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `imNumber`           INT UNSIGNED,
    `imDescription`      VARCHAR(200),
    `itemNumber`         INT UNSIGNED,
    `itemDescription`    VARCHAR(200),
    `deficiencyRef`      VARCHAR(200),
    `deficiencyId`       CHAR(1),
    `deficiencySubId`    VARCHAR(7),
    `deficiencyCategory` VARCHAR(9),
    `deficiencyText`     VARCHAR(1950),
    `stdForProhibition`  TINYINT(1),
    `fingerprint`        VARCHAR(32)  NOT NULL,
    PRIMARY KEY (`id`),

    UNIQUE INDEX `idx_fingerprint_uq` (`fingerprint` ASC)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `location`
(
    `id`           INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `vertical`     VARCHAR(5),
    `horizontal`   VARCHAR(5),
    `lateral`      VARCHAR(8),
    `longitudinal` VARCHAR(5),
    `rowNumber`    TINYINT UNSIGNED,
    `seatNumber`   TINYINT UNSIGNED,
    `axleNumber`   TINYINT UNSIGNED,
    `fingerprint`  VARCHAR(32)  NOT NULL,
    PRIMARY KEY (`id`),

    UNIQUE INDEX `idx_fingerprint_uq` (`fingerprint` ASC)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `test_defect`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test_defect`
(
    `id`                INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `test_record_id`    INT UNSIGNED NOT NULL,
    `defect_id`         INT UNSIGNED NOT NULL,
    `location_id`       INT UNSIGNED NOT NULL,
    `notes`             VARCHAR(500),
    `prs`               TINYINT(1),
    `prohibitionIssued` TINYINT(1),
    PRIMARY KEY (`id`),
    INDEX `idx_test_record_id` (`test_record_id` ASC),
    INDEX `idx_defect_id` (`defect_id` ASC),
    INDEX `idx_location_id` (`location_id` ASC),

    FOREIGN KEY (`test_record_id`)
        REFERENCES `test_record` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`defect_id`)
        REFERENCES `defects` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`location_id`)
        REFERENCES `location` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `adr`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `adr`
(
    `id`                        INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `technical_record_id`       INT UNSIGNED NOT NULL,
    `type`                      VARCHAR(45),
    `approvalDate`              DATE,
    `listStatementApplicable`   TINYINT(1),
    `batteryListNumber`         VARCHAR(8),
    `declarationsSeen`          TINYINT(1),
    `brakeDeclarationsSeen`     TINYINT(1),
    `brakeDeclarationIssuer`    TINYINT(1),
    `brakeEndurance`            TINYINT(1),
    `weight`                    VARCHAR(8),
    `compatibilityGroupJ`       TINYINT(1),
    `additionalExaminerNotes`   VARCHAR(1024),
    `applicantDetailsName`      VARCHAR(150),
    `street`                    VARCHAR(150),
    `town`                      VARCHAR(100),
    `city`                      VARCHAR(100),
    `postcode`                  VARCHAR(25),
    `memosApply`                VARCHAR(45),
    `adrTypeApprovalNo`         VARCHAR(45),
    `adrCertificateNotes`       VARCHAR(1500),
    `tankManufacturer`          VARCHAR(70),
    `yearOfManufacture`         DATE,
    `tankCode`                  VARCHAR(30),
    `specialProvisions`         VARCHAR(1024),
    `tankManufacturerSerialNo`  VARCHAR(50),
    `tankTypeAppNo`             VARCHAR(30),
    `tc2Type`                   VARCHAR(45),
    `tc2IntermediateApprovalNo` VARCHAR(70),
    `tc2IntermediateExpiryDate` DATE,
    `substancesPermitted`       VARCHAR(45),
    `statement`                 VARCHAR(1500),
    `productListRefNo`          VARCHAR(45),
    `productList`               VARCHAR(1500),
    PRIMARY KEY (`id`),

    FOREIGN KEY (`technical_record_id`)
        REFERENCES `technical_record` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    INDEX `idx_fk_technical_record_id` (`technical_record_id` ASC)
)
    ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `additional_notes_number`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `additional_notes_number`
(
    `id`          INT UNSIGNED NOT NULL,
    `number`      VARCHAR(3)   NOT NULL,
    `fingerprint` VARCHAR(32)  NOT NULL,
    PRIMARY KEY (`id`),

    UNIQUE INDEX `idx_fingerprint_uq` (`fingerprint` ASC),

    FOREIGN KEY (`id`)
        REFERENCES `adr` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `additional_notes_guidance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `additional_notes_guidance`
(
    `id`            INT UNSIGNED NOT NULL,
    `guidanceNotes` VARCHAR(25)  NOT NULL,
    `fingerprint`   VARCHAR(32)  NOT NULL,
    PRIMARY KEY (`id`),

    UNIQUE INDEX `idx_fingerprint_uq` (`fingerprint` ASC),

    FOREIGN KEY (`id`)
        REFERENCES `adr` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
)
    ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `dangerous_goods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dangerous_goods`
(
    `id`          INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`        VARCHAR(32),
    `fingerprint` VARCHAR(32)  NOT NULL,
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `permitted_dangerous_goods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `permitted_dangerous_goods`
(
    `id`                 INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `adr_id`             INT UNSIGNED NOT NULL,
    `dangerous_goods_id` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `idx_adr_id` (`adr_id` ASC),
    INDEX `idx_dangerous_goods_id` (`dangerous_goods_id` ASC),

    FOREIGN KEY (`adr_id`)
        REFERENCES `adr` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`dangerous_goods_id`)
        REFERENCES `dangerous_goods` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `productListUnNo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productListUnNo`
(
    `id`          INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`        VARCHAR(45),
    `fingerprint` VARCHAR(32)  NOT NULL,
    PRIMARY KEY (`id`),

    UNIQUE INDEX `idx_fingerprint_uq` (`fingerprint` ASC)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `adr_productListUnNo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `adr_productListUnNo`
(
    `id`                 INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `adr_id`             INT UNSIGNED NULL,
    `productListUnNo_id` INT UNSIGNED NULL,
    PRIMARY KEY (`id`),
    INDEX `idx_productListUnNo` (`productListUnNo_id` ASC),
    INDEX `idx_adr` (`adr_id` ASC),

    FOREIGN KEY (`productListUnNo_id`)
        REFERENCES `productListUnNo` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`adr_id`)
        REFERENCES `adr` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
)
    ENGINE = InnoDB;

SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;