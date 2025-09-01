CREATE TABLE IF NOT EXISTS `Image`
(
    `id`                                BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `imageFileData`                     MEDIUMBLOB NOT NULl,
    PRIMARY KEY (`id`),
    UNIQUE (id)
);
    ENGINE = InnoDB;