# cvs-nop

Create NO-OP database locally

## Script setup for Ubuntu distributions:
A setup script is provided `nop-setup.sh` to install all dependencies, start a docker container, and run the liquibase changesets.


## Manual setup:

### Prerequisites :

- installed Liquibase
- installed MySQL Database Software
- installed MySQL Connector/J (https://dev.mysql.com/doc/connectors/en/connector-j-binary-installation.html)


### 0. Database setup
We rely on having a local database setup to run our liquibase changesets against. 

This can be done using mysql directly or can be done with docker like so:
`docker run --name local-mysql -e MYSQL_ROOT_PASSWORD=password -p3306:3306 -d mysql:8`

The following known issues exist with this approach:
1. The container spins up without error but you cannot connect to it.
2. The container fails to start due to another process using port 3306 on your machine.

Both of these issues have a common fix. That is to use another port for our database.
The below command is identical to the one above except we use the **host** port 3307 as opposed to 3306.
`docker run --name local-mysql -e MYSQL_ROOT_PASSWORD=password -p3307:3306 -d mysql:8`

When then connecting to this database, be that with MySQL workbench or liquibase itself you will need to change the port used there from 3306 to 3307.
- If this does not resolve the issue and you are still having issues with port's clashing then you can run `sudo lsof -i :<PORT>` to see what procees(es) are using port <PORT>.

### 1. Liquibase Steps

A. Create configuration file
   `liquibase.properties`, provide database name (default: CVSBNOP), database username and password and class path to
   MySQL J/Connector.

```properties
driver: com.mysql.cj.jdbc.Driver
url: jdbc:mysql://localhost:3306/CVSBNOP?createDatabaseIfNotExist=true
username: root
password: password
classpath: mysql-connector-java-8.0.23.jar
```
Note that if you had previously changed the port that the database listens on in section 0. then you will need to reflect this change in your liquibase.properties file.

B. Once database is up and running(database user needs to have privileges in order to create database objects)

Run: ``liquibase --defaultsFile liquibase.properties --changeLogFile changelog-master.xml update``

Running without configuration file (provide missing paths / user credentials):

`liquibase --url=jdbc:mysql://localhost:3306/CVSB19155?createDatabaseIfNotExist=true --driver=com.mysql.cj.jdbc.Driver --classpath=mysql-connector-java-8.0.23.jar --username=root --password=password --changeLogFile changelog-master.xml update`

Quick step to instantiate database in Docker:


### 2. Schema Inventory

Tables

2.1. Common for Technical Record And Test Result

* `vehicle_class (fg)`
* `vehicle_subclass (fg)`
* `identity (fg)`

Technical Record

*  `contact_details (fg)`
*  `make_model (fg)`
*  `tyre (fg)`

Test Result

*  `fuel_emission (fg)`
*  `location (fg)`
*  `preparer (fg)`
*  `tester (fg)`
*  `test_station (fg)`
*  `test_type (fg)`

2.2. Subsets

*  `vehicle`

Technical Record

*  `axles`
*  `axle_spacing`
*  `microfilm (fg)`
*  `plate (fg)`
*  `psv_brakes`
*  `technical_record`

Test Result

*  `custom_defect`
*  `defect (fg)`
*  `defect_media`
*  `hazard_classification (fg)`
*  `load_status`
*  `media_type`
*  `reason_for_not_loading`
*  `test_defect`
*  `test_result`
*  `test_result_media`
*  `unladen_body_type`
*  `vehicle_load_status`
*  `vtg15 (fg)`
*  `vtg15_media (fg)`

*(fg) - tables with `fingerprint` virtual column

VTG15 data is linked to `test_result`. `hazard_classification` stores the classification `code` and `description`, and `vtg15_media` links VTG15 records to existing `media_type` entries.
Media data is stored in `defect_media`, `test_result_media`, and `vtg15_media`, with `media_type` holding the shared media type lookup values.
Load status data is linked to `test_result` through `load_status`, with lookup values held in `vehicle_load_status`, `unladen_body_type`, and `reason_for_not_loading`.

2.3. Fingerprints 

Tables marked (fg) contain a function-based stored virtual column, the function derives a hash key for
all records (based on concatenated value of all columns without `id` ) that are inserted or updated. The column's value is stored and indexed with unique constraint.
Nullable columns are normalised with `IFNULL` when generating fingerprints, so duplicate records with `NULL` values are still detected.
This allows native database support for upsert syntax `INSERT INTO ... ON DUPLICATE KEY UPDATE`.

4. ADR data set 

This set is not a part of MVP, tables serve as a reference for a future development.  

Tables :
* `adr`
* `additional_notes_number`
* `additional_notes_guidance`
* `dangerous_goods`
* `permitted_dangerous_goods`
* `productListUnNo`
* `adr_productListUnNo`
