-- ComplianceFramework table
CREATE TABLE IF NOT EXISTS ComplianceFramework (
    framework_id     VARCHAR(36)   NOT NULL,
    framework_code   VARCHAR(50)   NOT NULL,
    name            VARCHAR(100)  NOT NULL,
    version         VARCHAR(20)   NOT NULL,
    description     TEXT          NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_ComplianceFramework PRIMARY KEY (framework_id)
);

-- Requirement table
CREATE TABLE IF NOT EXISTS Requirement (
    requirement_id   VARCHAR(36)   NOT NULL,
    framework_id     VARCHAR(36)   NOT NULL,
    requirement_code VARCHAR(50)   NOT NULL,
    name            VARCHAR(255)  NOT NULL,
    description     TEXT          NOT NULL,
    parent_id       VARCHAR(36)   NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Requirement PRIMARY KEY (requirement_id),
    CONSTRAINT FK_Requirement_Framework FOREIGN KEY (framework_id) REFERENCES ComplianceFramework(framework_id),
    CONSTRAINT FK_Requirement_Parent FOREIGN KEY (parent_id) REFERENCES Requirement(requirement_id)
);

-- ImplementationTask table
CREATE TABLE IF NOT EXISTS ImplementationTask (
    task_id         VARCHAR(36)   NOT NULL,
    requirement_id   VARCHAR(36)   NOT NULL,
    task_name       VARCHAR(255)  NOT NULL,
    description     TEXT          NULL,
    status          VARCHAR(50)   NOT NULL,
    due_date        DATE          NULL,
    assignee_id     VARCHAR(36)   NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_ImplementationTask PRIMARY KEY (task_id),
    CONSTRAINT FK_ImplementationTask_Requirement FOREIGN KEY (requirement_id) REFERENCES Requirement(requirement_id)
);

-- Evidence table
CREATE TABLE IF NOT EXISTS Evidence (
    evidence_id     VARCHAR(36)   NOT NULL,
    task_id         VARCHAR(36)   NOT NULL,
    evidence_type   VARCHAR(50)   NOT NULL,
    name            VARCHAR(255)  NOT NULL,
    description     TEXT          NULL,
    file_path       VARCHAR(255)  NULL,
    url            VARCHAR(255)  NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Evidence PRIMARY KEY (evidence_id),
    CONSTRAINT FK_Evidence_Task FOREIGN KEY (task_id) REFERENCES ImplementationTask(task_id)
);

-- Create indexes
CREATE INDEX IDX_Requirement_FrameworkId ON Requirement(framework_id);
CREATE INDEX IDX_Requirement_ParentId ON Requirement(parent_id);
CREATE INDEX IDX_ImplementationTask_RequirementId ON ImplementationTask(requirement_id);
CREATE INDEX IDX_ImplementationTask_AssigneeId ON ImplementationTask(assignee_id);
CREATE INDEX IDX_Evidence_TaskId ON Evidence(task_id); 