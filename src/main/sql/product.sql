USE testliquibase
DROP PROCEDURE IF EXISTS performProductTableMigration;

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
CREATE PROCEDURE performProductTableMigration(IN migrationId VARCHAR(255), IN filename VARCHAR(255), IN md5sum VARCHAR(255),
    IN description VARCHAR(255), IN comments VARCHAR(255))

    BEGIN
        SET @migrationExists = 0;
        CALL checkIfMigrationExists(migrationId, @migrationExists);

        IF @migrationExists = 0 THEN
            CALL lockDatabaseLockTable();

            --  Changeset src/main/db/changelog.xml::1516704417378-2::paulo.cesar (generated)
            IF migrationId = '1516704417378-2' THEN
                CREATE TABLE IF NOT EXISTS testliquibase.user (
                    id BIGINT AUTO_INCREMENT NOT NULL,
                    name VARCHAR(30) NOT NULL,
                    CONSTRAINT PK_PRODUCT PRIMARY KEY (id)
                );

            --  Changeset src/main/db/changelog.xml::1516704417378-3::paulo.cesar (generated)
            ELSEIF migrationId = '1516704417378-3' THEN
                ALTER TABLE testliquibase.product ADD COLUMN color VARCHAR(255) NOT NULL;
                ALTER TABLE testliquibase.product ADD CONSTRAINT UKl7f5cbhq679s0w0g3ig7p1a7a UNIQUE (model);

            END IF;

            CALL releaseDatabaseLockTable();

            CALL saveMigrationLog(migrationId, filename, md5sum, description, comments);
        END IF;
    END;
//
DELIMITER //

call performProductTableMigration('1516704417378-2', 'src/main/db/changelog.xml', '12345', 'createUserTable',
    'Matilde');
call performProductTableMigration('1516704417378-3', 'src/main/db/changelog.xml', '12345', 'addColorInProduct',
    'Matilde');