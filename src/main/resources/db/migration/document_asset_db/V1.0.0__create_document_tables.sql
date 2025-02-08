-- Document table
CREATE TABLE Document (
    document_id     VARCHAR(36)   NOT NULL,
    title           VARCHAR(200)  NOT NULL,
    category_code   VARCHAR(50)   NOT NULL,
    department_id   VARCHAR(36)   NOT NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Document PRIMARY KEY (document_id)
);

-- DocumentVersion table
CREATE TABLE DocumentVersion (
    document_version_id VARCHAR(36)   NOT NULL,
    document_id        VARCHAR(36)   NOT NULL,
    version_number    VARCHAR(20)   NOT NULL,
    status_code       VARCHAR(50)   NOT NULL,
    content_url       VARCHAR(500)  NULL,
    created_at        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_DocumentVersion PRIMARY KEY (document_version_id),
    CONSTRAINT FK_DocumentVersion_Document FOREIGN KEY (document_id) REFERENCES Document(document_id)
);

-- ApprovalWorkflow table
CREATE TABLE ApprovalWorkflow (
    workflow_id      VARCHAR(36)   NOT NULL,
    document_version_id VARCHAR(36) NOT NULL,
    approver_id      VARCHAR(36)   NOT NULL,
    status_code      VARCHAR(50)   NOT NULL,
    comment          TEXT         NULL,
    approved_at      TIMESTAMP    NULL,
    created_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_ApprovalWorkflow PRIMARY KEY (workflow_id),
    CONSTRAINT FK_ApprovalWorkflow_DocumentVersion FOREIGN KEY (document_version_id) REFERENCES DocumentVersion(document_version_id)
); 