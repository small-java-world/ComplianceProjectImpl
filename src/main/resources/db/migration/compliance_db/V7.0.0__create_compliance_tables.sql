-- ComplianceProject table
CREATE TABLE IF NOT EXISTS ComplianceProject (
    project_id       VARCHAR(36)   NOT NULL,
    organization_id  VARCHAR(36)   NOT NULL,
    name            VARCHAR(100)  NOT NULL,
    description     TEXT         NULL,
    status_code     VARCHAR(50)   NOT NULL,
    start_date      DATE         NOT NULL,
    end_date        DATE         NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_ComplianceProject PRIMARY KEY (project_id)
);

-- ProjectScope table
CREATE TABLE IF NOT EXISTS ProjectScope (
    scope_id        VARCHAR(36)   NOT NULL,
    project_id      VARCHAR(36)   NOT NULL,
    department_id   VARCHAR(36)   NULL,
    description     TEXT         NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_ProjectScope PRIMARY KEY (scope_id),
    CONSTRAINT FK_ProjectScope_Project FOREIGN KEY (project_id) REFERENCES ComplianceProject(project_id)
);

-- ComplianceFramework table
CREATE TABLE IF NOT EXISTS ComplianceFramework (
    framework_id    VARCHAR(36)   NOT NULL,
    name           VARCHAR(100)  NOT NULL,
    version        VARCHAR(20)   NOT NULL,
    description    TEXT         NULL,
    created_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_ComplianceFramework PRIMARY KEY (framework_id)
);

-- ProjectFramework table
CREATE TABLE IF NOT EXISTS ProjectFramework (
    project_framework_id VARCHAR(36)   NOT NULL,
    project_id          VARCHAR(36)   NOT NULL,
    framework_id        VARCHAR(36)   NOT NULL,
    created_at         TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at         TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_ProjectFramework PRIMARY KEY (project_framework_id),
    CONSTRAINT FK_ProjectFramework_Project FOREIGN KEY (project_id) REFERENCES ComplianceProject(project_id),
    CONSTRAINT FK_ProjectFramework_Framework FOREIGN KEY (framework_id) REFERENCES ComplianceFramework(framework_id)
);

-- Requirement table
CREATE TABLE IF NOT EXISTS Requirement (
    requirement_id  VARCHAR(50)   NOT NULL,
    framework_id    VARCHAR(36)   NOT NULL,
    parent_id      VARCHAR(50)   NULL,
    title          VARCHAR(200)  NOT NULL,
    description    TEXT         NULL,
    created_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Requirement PRIMARY KEY (requirement_id),
    CONSTRAINT FK_Requirement_Framework FOREIGN KEY (framework_id) REFERENCES ComplianceFramework(framework_id),
    CONSTRAINT FK_Requirement_Parent FOREIGN KEY (parent_id) REFERENCES Requirement(requirement_id)
);

-- ImplementationTask table
CREATE TABLE IF NOT EXISTS ImplementationTask (
    task_id         VARCHAR(36)   NOT NULL,
    requirement_id  VARCHAR(50)   NOT NULL,
    project_id      VARCHAR(36)   NOT NULL,
    assignee_id     VARCHAR(36)   NOT NULL,
    title           VARCHAR(200)  NOT NULL,
    description     TEXT         NULL,
    status_code     VARCHAR(50)   NOT NULL,
    due_date        DATE         NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_ImplementationTask PRIMARY KEY (task_id),
    CONSTRAINT FK_ImplementationTask_Requirement FOREIGN KEY (requirement_id) REFERENCES Requirement(requirement_id),
    CONSTRAINT FK_ImplementationTask_Project FOREIGN KEY (project_id) REFERENCES ComplianceProject(project_id)
);

-- Evidence table
CREATE TABLE IF NOT EXISTS Evidence (
    evidence_id     VARCHAR(36)   NOT NULL,
    task_id         VARCHAR(36)   NOT NULL,
    title           VARCHAR(200)  NOT NULL,
    description     TEXT         NULL,
    document_id     VARCHAR(36)   NULL,
    file_path       VARCHAR(500) NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Evidence PRIMARY KEY (evidence_id),
    CONSTRAINT FK_Evidence_Task FOREIGN KEY (task_id) REFERENCES ImplementationTask(task_id)
); 