-- ImplementationTask table
CREATE TABLE ImplementationTask (
    task_id         VARCHAR(36)   NOT NULL,
    requirement_id  VARCHAR(50)   NOT NULL,
    assignee_id     VARCHAR(36)   NOT NULL,
    title           VARCHAR(200)  NOT NULL,
    description     TEXT         NULL,
    status_code     VARCHAR(50)   NOT NULL,
    due_date        DATE         NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_ImplementationTask PRIMARY KEY (task_id)
);

-- Evidence table
CREATE TABLE Evidence (
    evidence_id     VARCHAR(36)   NOT NULL,
    task_id         VARCHAR(36)   NOT NULL,
    title           VARCHAR(200)  NOT NULL,
    description     TEXT         NULL,
    reference_url   VARCHAR(500) NULL,
    file_path       VARCHAR(500) NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Evidence PRIMARY KEY (evidence_id),
    CONSTRAINT FK_Evidence_Task FOREIGN KEY (task_id) REFERENCES ImplementationTask(task_id)
); 