-- Risk table
CREATE TABLE Risk (
    risk_id          VARCHAR(36) NOT NULL,
    risk_template_id VARCHAR(36) NULL,
    title            VARCHAR(200) NOT NULL,
    description      TEXT NULL,
    impact_code      VARCHAR(50) NOT NULL,
    likelihood_code  VARCHAR(50) NOT NULL,
    created_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Risk PRIMARY KEY (risk_id)
);

-- RiskAssessment table
CREATE TABLE RiskAssessment (
    assessment_id    VARCHAR(36) NOT NULL,
    risk_id          VARCHAR(36) NOT NULL,
    assessor_id      VARCHAR(36) NOT NULL,
    assessment_date  DATE NOT NULL,
    risk_level_code  VARCHAR(50) NOT NULL,
    notes            TEXT NULL,
    created_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_RiskAssessment PRIMARY KEY (assessment_id),
    CONSTRAINT FK_RiskAssessment_Risk
        FOREIGN KEY (risk_id)
        REFERENCES Risk(risk_id)
);

-- RiskTreatmentPlan table
CREATE TABLE RiskTreatmentPlan (
    plan_id           VARCHAR(36) NOT NULL,
    risk_id          VARCHAR(36) NOT NULL,
    requirement_id    VARCHAR(36) NULL,
    title            VARCHAR(200) NOT NULL,
    description      TEXT NULL,
    treatment_type_code VARCHAR(50) NOT NULL,
    status_code      VARCHAR(50) NOT NULL,
    due_date         DATE NULL,
    created_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_RiskTreatmentPlan PRIMARY KEY (plan_id),
    CONSTRAINT FK_RiskTreatmentPlan_Risk
        FOREIGN KEY (risk_id)
        REFERENCES Risk(risk_id)
);

-- AssetRisk table
CREATE TABLE AssetRisk (
    asset_risk_id    VARCHAR(36) NOT NULL,
    asset_id         VARCHAR(36) NOT NULL,
    risk_id          VARCHAR(36) NOT NULL,
    created_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_AssetRisk PRIMARY KEY (asset_risk_id),
    CONSTRAINT FK_AssetRisk_Risk
        FOREIGN KEY (risk_id)
        REFERENCES Risk(risk_id)
);

-- RiskRequirement table
CREATE TABLE RiskRequirement (
    risk_requirement_id VARCHAR(36)   NOT NULL,
    risk_id            VARCHAR(36)   NOT NULL,
    requirement_id     VARCHAR(50)   NOT NULL,
    created_at         TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at         TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_RiskRequirement PRIMARY KEY (risk_requirement_id),
    CONSTRAINT FK_RiskRequirement_Risk FOREIGN KEY (risk_id) REFERENCES Risk(risk_id)
); 