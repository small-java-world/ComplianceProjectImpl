-- Risk table
CREATE TABLE Risk (
    risk_id         VARCHAR(36)   NOT NULL,
    project_id      VARCHAR(36)   NOT NULL,
    risk_name       VARCHAR(255)  NOT NULL,
    description     TEXT          NULL,
    risk_level      VARCHAR(50)   NOT NULL,
    status          VARCHAR(50)   NOT NULL,
    impact         VARCHAR(50)   NOT NULL,
    likelihood     VARCHAR(50)   NOT NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Risk PRIMARY KEY (risk_id)
);

-- RiskAssessment table
CREATE TABLE RiskAssessment (
    assessment_id   VARCHAR(36)   NOT NULL,
    risk_id         VARCHAR(36)   NOT NULL,
    assessor_id     VARCHAR(36)   NOT NULL,
    assessment_date DATE          NOT NULL,
    impact         VARCHAR(50)   NOT NULL,
    likelihood     VARCHAR(50)   NOT NULL,
    notes          TEXT          NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_RiskAssessment PRIMARY KEY (assessment_id),
    CONSTRAINT FK_RiskAssessment_Risk FOREIGN KEY (risk_id) REFERENCES Risk(risk_id)
);

-- RiskTreatmentPlan table
CREATE TABLE RiskTreatmentPlan (
    plan_id         VARCHAR(36)   NOT NULL,
    risk_id         VARCHAR(36)   NOT NULL,
    treatment_type  VARCHAR(50)   NOT NULL,
    description     TEXT          NOT NULL,
    status          VARCHAR(50)   NOT NULL,
    due_date        DATE          NULL,
    responsible_id  VARCHAR(36)   NOT NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_RiskTreatmentPlan PRIMARY KEY (plan_id),
    CONSTRAINT FK_RiskTreatmentPlan_Risk FOREIGN KEY (risk_id) REFERENCES Risk(risk_id)
);

-- Indexes
CREATE INDEX IDX_Risk_ProjectId ON Risk(project_id);
CREATE INDEX IDX_RiskAssessment_RiskId ON RiskAssessment(risk_id);
CREATE INDEX IDX_RiskAssessment_AssessorId ON RiskAssessment(assessor_id);
CREATE INDEX IDX_RiskTreatmentPlan_RiskId ON RiskTreatmentPlan(risk_id);
CREATE INDEX IDX_RiskTreatmentPlan_ResponsibleId ON RiskTreatmentPlan(responsible_id); 