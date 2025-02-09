-- RiskTemplate table
CREATE TABLE RiskTemplate (
    risk_template_id VARCHAR(36) NOT NULL,
    template_name    VARCHAR(200) NOT NULL,
    description      TEXT NOT NULL,
    severity         INT NOT NULL,
    created_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_RiskTemplate PRIMARY KEY (risk_template_id)
);

-- RiskTemplateCondition table
CREATE TABLE RiskTemplateCondition (
    risk_template_condition_id VARCHAR(36) NOT NULL,
    risk_template_id           VARCHAR(36) NOT NULL,
    attribute_name            VARCHAR(50) NOT NULL,
    operator                  VARCHAR(10) NOT NULL,
    compare_value            VARCHAR(100) NOT NULL,
    logical_operator         VARCHAR(5) NOT NULL DEFAULT 'AND',
    condition_order          INT NOT NULL DEFAULT 1,
    created_at               TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at               TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_RiskTemplateCondition PRIMARY KEY (risk_template_condition_id),
    CONSTRAINT FK_RiskTemplateCondition_RiskTemplate
        FOREIGN KEY (risk_template_id)
        REFERENCES RiskTemplate(risk_template_id)
); 

-- Risk table
CREATE TABLE Risk (
    risk_id          VARCHAR(36) NOT NULL,
    risk_template_id VARCHAR(36) NULL,
    risk_name        VARCHAR(200) NOT NULL,
    description      TEXT NULL,
    severity         INT NOT NULL,
    status          VARCHAR(20) NOT NULL,
    created_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Risk PRIMARY KEY (risk_id)
);

-- RiskRequirement table
CREATE TABLE RiskRequirement (
    risk_requirement_id VARCHAR(36) NOT NULL,
    risk_id            VARCHAR(36) NOT NULL,
    requirement_id     VARCHAR(50) NOT NULL,
    created_at         TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at         TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_RiskRequirement PRIMARY KEY (risk_requirement_id),
    CONSTRAINT FK_RiskRequirement_Risk 
        FOREIGN KEY (risk_id) 
        REFERENCES Risk(risk_id)
); 