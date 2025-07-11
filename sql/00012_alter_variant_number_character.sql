--liquibase formatted sql
--changeset liquibase:change-variantNumber-length

ALTER TABLE technical_record MODIFY COLUMN variantNumber VARCHAR(35);