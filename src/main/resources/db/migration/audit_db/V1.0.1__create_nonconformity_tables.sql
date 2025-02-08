-- NonConformity table
CREATE TABLE NonConformity (
    nonconformity_id VARCHAR(36)   NOT NULL,
    audit_id         VARCHAR(36)   NOT NULL,
    requirement_id   VARCHAR(50)   NOT NULL,
    title            VARCHAR(200)  NOT NULL,
    description      TEXT         NULL,
    severity_code    VARCHAR(50)   NOT NULL,
    status_code      VARCHAR(50)   NOT NULL,
    created_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_NonConformity PRIMARY KEY (nonconformity_id),
    CONSTRAINT FK_NonConformity_Audit FOREIGN KEY (audit_id) REFERENCES Audit(audit_id)
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