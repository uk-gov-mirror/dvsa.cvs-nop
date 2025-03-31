--liquibase formatted sql
--changeset liquibase:modifyTable -multiple-tables:1 splitStatements:true endDelimiter:; context:dev
ALTER TABLE test_result ADD vrm_trm VARCHAR(9) NULL;
