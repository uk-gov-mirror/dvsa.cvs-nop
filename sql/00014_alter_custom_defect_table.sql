--liquibase formatted sql
--changeset liquibase:modifyDataType -multiple-tables:1 splitStatements:true endDelimiter:; context:dev

ALTER TABLE custom_defect MODIFY defectNotes VARCHAR(500), ALGORITHM=INPLACE, LOCK=NONE;