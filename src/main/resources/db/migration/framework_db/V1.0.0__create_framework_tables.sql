-- ComplianceFramework table
CREATE TABLE ComplianceFramework (
    framework_code   VARCHAR(50)   NOT NULL,
    name            VARCHAR(100)   NOT NULL,
    description     TEXT          NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_ComplianceFramework PRIMARY KEY (framework_code)
);

-- Requirement table
CREATE TABLE Requirement (
    requirement_id   VARCHAR(50)   NOT NULL,
    framework_code   VARCHAR(50)   NOT NULL,
    title           VARCHAR(200)   NOT NULL,
    description     TEXT          NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Requirement PRIMARY KEY (requirement_id),
    CONSTRAINT FK_Requirement_Framework FOREIGN KEY (framework_code) REFERENCES ComplianceFramework(framework_code)
); 