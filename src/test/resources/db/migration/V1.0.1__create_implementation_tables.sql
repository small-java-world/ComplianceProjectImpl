-- --------------------------------------------------------------------------
-- 実装タスク: ImplementationTask
-- --------------------------------------------------------------------------
CREATE TABLE ImplementationTask (
    task_id         VARCHAR(36)  NOT NULL,
    project_id      VARCHAR(36)  NOT NULL,
    requirement_id  VARCHAR(36)  NOT NULL,
    description     TEXT         NOT NULL,
    status_code     VARCHAR(50)  NOT NULL,
    due_date        DATE         NULL,
    assignee_id     VARCHAR(36)  NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_ImplementationTask PRIMARY KEY (task_id),
    CONSTRAINT FK_ImplementationTask_Project FOREIGN KEY (project_id) REFERENCES ComplianceProject(project_id),
    CONSTRAINT FK_ImplementationTask_Requirement FOREIGN KEY (requirement_id) REFERENCES Requirement(requirement_id),
    CONSTRAINT FK_ImplementationTask_User FOREIGN KEY (assignee_id) REFERENCES User(user_id)
);

-- --------------------------------------------------------------------------
-- 証拠: Evidence
-- --------------------------------------------------------------------------
CREATE TABLE Evidence (
    evidence_id         VARCHAR(36)  NOT NULL,
    task_id             VARCHAR(36)  NOT NULL,
    evidence_type_code  VARCHAR(50)  NOT NULL,
    reference_url       TEXT         NULL,
    description         TEXT         NULL,
    created_at          TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Evidence PRIMARY KEY (evidence_id),
    CONSTRAINT FK_Evidence_Task FOREIGN KEY (task_id) REFERENCES ImplementationTask(task_id)
);

-- --------------------------------------------------------------------------
-- 監査: Audit
-- --------------------------------------------------------------------------
CREATE TABLE Audit (
    audit_id            VARCHAR(36)  NOT NULL,
    project_id          VARCHAR(36)  NOT NULL,
    audit_type_code     VARCHAR(50)  NOT NULL,
    audit_stage_category VARCHAR(50) NOT NULL,
    audit_stage_code    VARCHAR(50)  NOT NULL,
    scheduled_date      DATE         NOT NULL,
    status_code         VARCHAR(50)  NOT NULL,
    created_at          TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Audit PRIMARY KEY (audit_id),
    CONSTRAINT FK_Audit_Project FOREIGN KEY (project_id) REFERENCES ComplianceProject(project_id)
);

-- --------------------------------------------------------------------------
-- 監査対象範囲: AuditScope
-- --------------------------------------------------------------------------
CREATE TABLE AuditScope (
    audit_scope_id  VARCHAR(36) NOT NULL,
    audit_id        VARCHAR(36) NOT NULL,
    scope_item_code VARCHAR(50) NOT NULL,
    created_at      TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_AuditScope PRIMARY KEY (audit_scope_id),
    CONSTRAINT FK_AuditScope_Audit FOREIGN KEY (audit_id) REFERENCES Audit(audit_id)
);

-- --------------------------------------------------------------------------
-- 評価レポート: AssessmentReport
-- --------------------------------------------------------------------------
CREATE TABLE AssessmentReport (
    report_id       VARCHAR(36)  NOT NULL,
    audit_id        VARCHAR(36)  NOT NULL,
    report_type_code VARCHAR(50) NOT NULL,
    issued_date     DATE         NOT NULL,
    summary         TEXT         NULL,
    conclusion_code VARCHAR(50)  NOT NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_AssessmentReport PRIMARY KEY (report_id),
    CONSTRAINT FK_AssessmentReport_Audit FOREIGN KEY (audit_id) REFERENCES Audit(audit_id)
);

-- --------------------------------------------------------------------------
-- 不適合: NonConformity
-- --------------------------------------------------------------------------
CREATE TABLE NonConformity (
    non_conformity_id VARCHAR(36) NOT NULL,
    audit_id          VARCHAR(36) NOT NULL,
    description       TEXT         NOT NULL,
    severity_code     VARCHAR(50)  NOT NULL,
    status_code       VARCHAR(50)  NOT NULL,
    created_at        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_NonConformity PRIMARY KEY (non_conformity_id),
    CONSTRAINT FK_NonConformity_Audit FOREIGN KEY (audit_id) REFERENCES Audit(audit_id)
);

-- --------------------------------------------------------------------------
-- 是正措置: CorrectiveAction
-- --------------------------------------------------------------------------
CREATE TABLE CorrectiveAction (
    corrective_action_id VARCHAR(36) NOT NULL,
    non_conformity_id    VARCHAR(36) NOT NULL,
    description          TEXT        NOT NULL,
    owner_id             VARCHAR(36) NOT NULL,
    planned_completion_date DATE     NOT NULL,
    status_code          VARCHAR(50) NOT NULL,
    created_at           TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at           TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_CorrectiveAction PRIMARY KEY (corrective_action_id),
    CONSTRAINT FK_CorrectiveAction_NonConformity FOREIGN KEY (non_conformity_id) REFERENCES NonConformity(non_conformity_id),
    CONSTRAINT FK_CorrectiveAction_User FOREIGN KEY (owner_id) REFERENCES User(user_id)
); 