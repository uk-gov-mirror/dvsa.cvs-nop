--liquibase formatted sql
--changeset liquibase:addTables -multiple-tables:1 splitStatements:true endDelimiter:; context:dev

CREATE TABLE IF NOT EXISTS `vehicle_load_status` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(30) NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `idx_vehicle_load_status_type_uq` (`type`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `unladen_body_type` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(27) NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `idx_unladen_body_type_type_uq` (`type`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `reason_for_not_loading` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(20) NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `idx_reason_for_not_loading_type_uq` (`type`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `load_status` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `test_result_id` BIGINT UNSIGNED NOT NULL,
    `vehicle_load_status_id` BIGINT UNSIGNED NULL,
    `unladen_body_type_id` BIGINT UNSIGNED NULL,
    `other_unladen_body_type` VARCHAR(200) NULL,
    `reason_for_not_loading_id` BIGINT UNSIGNED NULL,
    `other_reason_for_not_loading` VARCHAR(200) NULL,
    `partially_laden_reason` VARCHAR(200) NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`test_result_id`)
        REFERENCES test_result (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`vehicle_load_status_id`)
        REFERENCES vehicle_load_status (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`unladen_body_type_id`)
        REFERENCES unladen_body_type (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`reason_for_not_loading_id`)
        REFERENCES reason_for_not_loading (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    
    UNIQUE INDEX `idx_load_status_test_result_id_uq` (`test_result_id` ASC)

) ENGINE = InnoDB;
