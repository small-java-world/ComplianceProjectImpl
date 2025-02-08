-- ComplianceProject table
CREATE TABLE ComplianceProject (
    project_id       VARCHAR(36)   NOT NULL,
    organization_id  VARCHAR(36)   NOT NULL,
    project_name     VARCHAR(100)  NOT NULL,
    status_code      VARCHAR(50)   NOT NULL,
    start_date       DATE         NOT NULL,
    end_date         DATE         NULL,
    created_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_ComplianceProject PRIMARY KEY (project_id),
    CONSTRAINT FK_ComplianceProject_Organization FOREIGN KEY (organization_id) REFERENCES Organization(organization_id)
);

-- ProjectFramework table
CREATE TABLE ProjectFramework (
    project_framework_id VARCHAR(36)   NOT NULL,
    project_id          VARCHAR(36)   NOT NULL,
    framework_code      VARCHAR(50)   NOT NULL,
    framework_version   VARCHAR(20)   NULL,
    created_at         TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at         TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_ProjectFramework PRIMARY KEY (project_framework_id),
    CONSTRAINT FK_ProjectFramework_Project FOREIGN KEY (project_id) REFERENCES ComplianceProject(project_id)
); 