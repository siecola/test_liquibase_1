USE testliquibase
DROP PROCEDURE IF EXISTS createUserTable;
DROP PROCEDURE IF EXISTS addColorInProduct;

CALL initializeDatabaseLockTable;

--  Changeset src/main/db/changelog.xml::1516704417378-1::paulo.cesar (generated)
CREATE TABLE IF NOT EXISTS testliquibase.product (
    id BIGINT AUTO_INCREMENT NOT NULL,
    model VARCHAR(30) NOT NULL,
    name VARCHAR(30) NOT NULL,
    price DOUBLE NOT NULL,
    CONSTRAINT PK_PRODUCT PRIMARY KEY (id)
);

DELIMITER //
CREATE PROCEDURE createUserTable()
    BEGIN
        SET @migrationId = '1516704417378-2';
        SET @migrationExists = 0;
        CALL checkIfMigrationExists(@migrationId, @migrationExists);

        IF @migrationExists = 0 THEN
            CALL lockDatabaseLockTable();

            CREATE TABLE IF NOT EXISTS testliquibase.user (
                id BIGINT AUTO_INCREMENT NOT NULL,
                name VARCHAR(30) NOT NULL,
                CONSTRAINT PK_PRODUCT PRIMARY KEY (id)
            );

            CALL releaseDatabaseLockTable();

            CALL saveMigrationLog(@migrationId, 'src/main/db/changelog.xml', '12345', 'createUserTable', 'Matilde');
        END IF;
    END;
//
DELIMITER //


DELIMITER //
CREATE PROCEDURE addColorInProduct()
    BEGIN
        SET @migrationId = '1516704417378-3';
        SET @migrationExists = 0;
        CALL checkIfMigrationExists(@migrationId, @migrationExists);

        IF @migrationExists = 0 THEN
            CALL lockDatabaseLockTable();

            ALTER TABLE testliquibase.product ADD COLUMN color VARCHAR(255) NOT NULL;
            ALTER TABLE testliquibase.product ADD CONSTRAINT UKl7f5cbhq679s0w0g3ig7p1a7a UNIQUE (model);

            CALL releaseDatabaseLockTable();

            CALL saveMigrationLog(@migrationId, 'src/main/db/changelog.xml', '12345', 'createUserTable', 'Matilde');
        END IF;
    END;
//
DELIMITER //


CALL createUserTable();
CALL addColorInProduct();