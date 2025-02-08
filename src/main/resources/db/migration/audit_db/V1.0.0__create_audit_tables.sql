-- Audit table
CREATE TABLE Audit (
    audit_id        VARCHAR(36)   NOT NULL,
    project_id      VARCHAR(36)   NOT NULL,
    audit_type_code VARCHAR(50)   NOT NULL,
    audit_stage_code VARCHAR(50)  NOT NULL,
    start_date      DATE         NOT NULL,
    end_date        DATE         NULL,
    status_code     VARCHAR(50)   NOT NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Audit PRIMARY KEY (audit_id)
);

-- AssessmentReport table
CREATE TABLE AssessmentReport (
    report_id       VARCHAR(36)   NOT NULL,
    audit_id        VARCHAR(36)   NOT NULL,
    title           VARCHAR(200)  NOT NULL,
    content         TEXT         NULL,
    conclusion_code VARCHAR(50)   NOT NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_AssessmentReport PRIMARY KEY (report_id),
    CONSTRAINT FK_AssessmentReport_Audit FOREIGN KEY (audit_id) REFERENCES Audit(audit_id)
); 