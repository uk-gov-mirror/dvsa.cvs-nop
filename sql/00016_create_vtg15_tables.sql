--liquibase formatted sql
--changeset liquibase:addTables -multiple-tables:1 splitStatements:true endDelimiter:; context:dev

CREATE TABLE IF NOT EXISTS `hazard_classification` (
    `id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `code` VARCHAR(3) NOT NULL,
    `description` VARCHAR(30) NOT NULL,
    `fingerprint` VARCHAR(32) GENERATED ALWAYS AS (md5(
            concat_ws('|', IFNULL(`code`, ''), IFNULL(`description`, '')))) STORED UNIQUE KEY NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `vtg15` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `test_result_id` BIGINT UNSIGNED NOT NULL,
    `vtg15Required` TINYINT(1) NOT NULL,
    `unNumber` SMALLINT UNSIGNED NULL,
    `primary_hazard_classification_id` TINYINT UNSIGNED NULL,
    `secondary_hazard_classification_id` TINYINT UNSIGNED NULL,
    `fingerprint` VARCHAR(32) GENERATED ALWAYS AS (md5(
            concat_ws('|', IFNULL(`test_result_id`, ''), IFNULL(`vtg15Required`, ''), IFNULL(`unNumber`, ''),
                      IFNULL(`primary_hazard_classification_id`, ''),
                      IFNULL(`secondary_hazard_classification_id`, '')))) STORED UNIQUE KEY NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`test_result_id`)
        REFERENCES test_result (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`primary_hazard_classification_id`)
        REFERENCES hazard_classification (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`secondary_hazard_classification_id`)
        REFERENCES hazard_classification (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    INDEX `idx_vtg15_test_result_id` (`test_result_id` ASC),
    INDEX `idx_vtg15_primary_hazard_classification_id` (`primary_hazard_classification_id` ASC),
    INDEX `idx_vtg15_secondary_hazard_classification_id` (`secondary_hazard_classification_id` ASC)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `vtg15_media` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `vtg15_id` BIGINT UNSIGNED NOT NULL,
    `path` VARCHAR(150) NOT NULL,
    `reason` VARCHAR(500) NULL,
    `media_type_id` BIGINT UNSIGNED NOT NULL,
    `fingerprint` VARCHAR(32) GENERATED ALWAYS AS (md5(
            concat_ws('|', IFNULL(`vtg15_id`, ''), IFNULL(`path`, ''), IFNULL(`reason`, ''),
                      IFNULL(`media_type_id`, '')))) STORED UNIQUE KEY NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`vtg15_id`)
        REFERENCES vtg15 (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`media_type_id`)
        REFERENCES media_type (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    INDEX `idx_vtg15_media_vtg15_id` (`vtg15_id` ASC),
    INDEX `idx_vtg15_media_type_id` (`media_type_id` ASC)
) ENGINE = InnoDB;
