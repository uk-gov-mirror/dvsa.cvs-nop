--liquibase formatted sql
--changeset liquibase:removeEvlInterim -multiple-tables:1 splitStatements:true endDelimiter:; context:dev runOnChange:true

DROP TABLE IF EXISTS vt_evl_00_cvs_system_numbers;
DROP TABLE IF EXISTS vt_evl_01_static_set;
DROP TABLE IF EXISTS vt_evl_02_cvs_removed;
DROP TABLE IF EXISTS vt_evl_03_failures_removed;
DROP TABLE IF EXISTS vt_evl_additions;