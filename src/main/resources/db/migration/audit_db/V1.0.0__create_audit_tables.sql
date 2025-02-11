-- Audit table
CREATE TABLE Audit (
    audit_id        VARCHAR(36)   NOT NULL,
    project_id      VARCHAR(36)   NOT NULL,
    audit_type      VARCHAR(50)   NOT NULL,
    audit_stage     VARCHAR(50)   NOT NULL,
    status          VARCHAR(50)   NOT NULL,
    start_date      DATE          NOT NULL,
    end_date        DATE          NULL,
    lead_auditor_id VARCHAR(36)   NOT NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Audit PRIMARY KEY (audit_id)
);

-- AssessmentReport table
CREATE TABLE AssessmentReport (
    report_id       VARCHAR(36)   NOT NULL,
    audit_id        VARCHAR(36)   NOT NULL,
    report_type     VARCHAR(50)   NOT NULL,
    status          VARCHAR(50)   NOT NULL,
    summary         TEXT          NOT NULL,
    recommendations TEXT          NULL,
    author_id       VARCHAR(36)   NOT NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_AssessmentReport PRIMARY KEY (report_id),
    CONSTRAINT FK_AssessmentReport_Audit FOREIGN KEY (audit_id) REFERENCES Audit(audit_id)
);

-- NonConformity table
CREATE TABLE NonConformity (
    nonconformity_id VARCHAR(36)   NOT NULL,
    audit_id         VARCHAR(36)   NOT NULL,
    requirement_id   VARCHAR(36)   NOT NULL,
    severity         VARCHAR(50)   NOT NULL,
    description      TEXT          NOT NULL,
    status           VARCHAR(50)   NOT NULL,
    due_date         DATE          NULL,
    responsible_id   VARCHAR(36)   NOT NULL,
    created_at       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_NonConformity PRIMARY KEY (nonconformity_id),
    CONSTRAINT FK_NonConformity_Audit FOREIGN KEY (audit_id) REFERENCES Audit(audit_id)
);

-- CorrectiveAction table
CREATE TABLE CorrectiveAction (
    action_id           VARCHAR(36)   NOT NULL,
    nonconformity_id    VARCHAR(36)   NOT NULL,
    action_description  TEXT          NOT NULL,
    status              VARCHAR(50)   NOT NULL,
    due_date            DATE          NOT NULL,
    completion_date     DATE          NULL,
    responsible_id      VARCHAR(36)   NOT NULL,
    verifier_id         VARCHAR(36)   NULL,
    verification_date   DATE          NULL,
    verification_result VARCHAR(50)   NULL,
    created_at          TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_CorrectiveAction PRIMARY KEY (action_id),
    CONSTRAINT FK_CorrectiveAction_NonConformity FOREIGN KEY (nonconformity_id) REFERENCES NonConformity(nonconformity_id)
);

-- Indexes
CREATE INDEX IDX_Audit_ProjectId ON Audit(project_id);
CREATE INDEX IDX_Audit_LeadAuditorId ON Audit(lead_auditor_id);
CREATE INDEX IDX_AssessmentReport_AuditId ON AssessmentReport(audit_id);
CREATE INDEX IDX_AssessmentReport_AuthorId ON AssessmentReport(author_id);
CREATE INDEX IDX_NonConformity_AuditId ON NonConformity(audit_id);
CREATE INDEX IDX_NonConformity_RequirementId ON NonConformity(requirement_id);
CREATE INDEX IDX_NonConformity_ResponsibleId ON NonConformity(responsible_id);
CREATE INDEX IDX_CorrectiveAction_NonConformityId ON CorrectiveAction(nonconformity_id);
CREATE INDEX IDX_CorrectiveAction_ResponsibleId ON CorrectiveAction(responsible_id);
CREATE INDEX IDX_CorrectiveAction_VerifierId ON CorrectiveAction(verifier_id); 