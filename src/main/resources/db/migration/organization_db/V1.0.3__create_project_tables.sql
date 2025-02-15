-- compliance_project table
CREATE TABLE compliance_project (
    project_id       VARCHAR(36)   NOT NULL,
    organization_id  VARCHAR(36)   NOT NULL,
    project_name     VARCHAR(100)  NOT NULL,
    status_code      VARCHAR(50)   NOT NULL,
    start_date       DATE         NOT NULL,
    end_date         DATE         NULL,
    created_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_compliance_project PRIMARY KEY (project_id),
    CONSTRAINT fk_compliance_project_organization FOREIGN KEY (organization_id) REFERENCES organization(organization_id)
);

-- project_framework table
CREATE TABLE project_framework (
    project_framework_id VARCHAR(36)   NOT NULL,
    project_id          VARCHAR(36)   NOT NULL,
    framework_code      VARCHAR(50)   NOT NULL,
    framework_version   VARCHAR(20)   NULL,
    created_at         TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at         TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_project_framework PRIMARY KEY (project_framework_id),
    CONSTRAINT fk_project_framework_project FOREIGN KEY (project_id) REFERENCES compliance_project(project_id)
); 