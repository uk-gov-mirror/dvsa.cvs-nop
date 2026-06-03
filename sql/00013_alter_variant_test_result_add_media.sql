--liquibase formatted sql
--changeset liquibase:add-media-columns -multiple-tables:1 splitStatements:true endDelimiter:; context:dev

CREATE TABLE IF NOT EXISTS `media_type`
(
    `id`          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `type`        VARCHAR(10) NOT NULL,
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `defect_media`
(
    `id`             BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `test_defect_id` BIGINT UNSIGNED NOT NULL,
    `path`           VARCHAR(150) NOT NULL,
    `reason`         VARCHAR(500) NULL,
    `media_type_id`  BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`test_defect_id`)
        REFERENCES test_defect (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`media_type_id`)
        REFERENCES media_type (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    UNIQUE INDEX `idx_defect_media_uq` (`test_defect_id` ASC, `path` ASC, `reason` ASC, `media_type_id` ASC)
    
)
    ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `test_result_media`
(
    `id`             BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `test_result_id` BIGINT UNSIGNED NOT NULL,
    `path`           VARCHAR(150) NOT NULL,
    `reason`         VARCHAR(500) NULL,
    `media_type_id`  BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`test_result_id`)
        REFERENCES test_result (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (`media_type_id`)
        REFERENCES media_type (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    
    UNIQUE INDEX `idx_test_result_media_uq` (`test_result_id` ASC, `path` ASC, `reason` ASC, `media_type_id` ASC)

)
    ENGINE = InnoDB;