--liquibase formatted sql
--changeset liquibase:add-media-columns -multiple-tables:1 splitStatements:true endDelimiter:; context:dev

ALTER TABLE test_result ADD media_type VARCHAR(10) NULL;
ALTER TABLE test_result ADD media_path VARCHAR(120) NULL;
ALTER TABLE test_result ADD media_reason VARCHAR(200) NULL;

ALTER TABLE defect ADD media_type VARCHAR(10) NULL;
ALTER TABLE defect ADD media_path VARCHAR(120) NULL;
ALTER TABLE defect ADD media_reason VARCHAR(200) NULL;