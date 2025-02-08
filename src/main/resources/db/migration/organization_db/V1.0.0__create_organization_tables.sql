-- Organization table
CREATE TABLE Organization (
    organization_id    VARCHAR(36)   NOT NULL,
    name              VARCHAR(100)   NOT NULL,
    organization_type_code VARCHAR(50) NOT NULL,
    created_at        TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Organization PRIMARY KEY (organization_id)
);

-- Department table
CREATE TABLE Department (
    department_id     VARCHAR(36)   NOT NULL,
    organization_id   VARCHAR(36)   NOT NULL,
    parent_id        VARCHAR(36)   NULL,
    name             VARCHAR(100)   NOT NULL,
    created_at       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Department PRIMARY KEY (department_id),
    CONSTRAINT FK_Department_Organization FOREIGN KEY (organization_id) REFERENCES Organization(organization_id),
    CONSTRAINT FK_Department_Parent FOREIGN KEY (parent_id) REFERENCES Department(department_id)
); 