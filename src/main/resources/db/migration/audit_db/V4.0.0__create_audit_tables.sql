-- Audit table
CREATE TABLE Audit (
    audit_id        VARCHAR(36)   NOT NULL,
    project_id      VARCHAR(36)   NOT NULL,
    name           VARCHAR(200)  NOT NULL,
    description    TEXT         NULL,
    audit_type_code VARCHAR(50)   NOT NULL,
    audit_stage_code VARCHAR(50)  NOT NULL,
    start_date      DATE         NOT NULL,
    end_date        DATE         NULL,
    status_code     VARCHAR(50)   NOT NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Audit PRIMARY KEY (audit_id)
);

-- AuditScope table
CREATE TABLE AuditScope (
    scope_id        VARCHAR(36)   NOT NULL,
    audit_id        VARCHAR(36)   NOT NULL,
    department_id   VARCHAR(36)   NULL,
    description     TEXT         NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_AuditScope PRIMARY KEY (scope_id),
    CONSTRAINT FK_AuditScope_Audit FOREIGN KEY (audit_id) REFERENCES Audit(audit_id)
);

-- AssessmentReport table
CREATE TABLE AssessmentReport (
    report_id       VARCHAR(36)   NOT NULL,
    audit_id        VARCHAR(36)   NOT NULL,
    title           VARCHAR(200)  NOT NULL,
    content         TEXT         NULL,
    status_code     VARCHAR(50)   NOT NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_AssessmentReport PRIMARY KEY (report_id),
    CONSTRAINT FK_AssessmentReport_Audit FOREIGN KEY (audit_id) REFERENCES Audit(audit_id)
);

-- NonConformity table
CREATE TABLE NonConformity (
    nonconformity_id VARCHAR(36)   NOT NULL,
    report_id        VARCHAR(36)   NOT NULL,
    requirement_id   VARCHAR(50)   NOT NULL,
    title            VARCHAR(200)  NOT NULL,
    description      TEXT         NULL,
    severity_code    VARCHAR(50)   NOT NULL,
    status_code      VARCHAR(50)   NOT NULL,
    created_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_NonConformity PRIMARY KEY (nonconformity_id),
    CONSTRAINT FK_NonConformity_Report FOREIGN KEY (report_id) REFERENCES AssessmentReport(report_id)
);

-- CorrectiveAction table
CREATE TABLE CorrectiveAction (
    action_id        VARCHAR(36)   NOT NULL,
    nonconformity_id VARCHAR(36)   NOT NULL,
    owner_id         VARCHAR(36)   NOT NULL,
    title            VARCHAR(200)  NOT NULL,
    description      TEXT         NULL,
    due_date         DATE         NOT NULL,
    status_code      VARCHAR(50)   NOT NULL,
    created_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_CorrectiveAction PRIMARY KEY (action_id),
    CONSTRAINT FK_CorrectiveAction_NonConformity FOREIGN KEY (nonconformity_id) REFERENCES NonConformity(nonconformity_id)
); 