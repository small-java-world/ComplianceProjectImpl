-- --------------------------------------------------------------------------
-- リスク: Risk
-- --------------------------------------------------------------------------
CREATE TABLE Risk (
    risk_id         VARCHAR(36)  NOT NULL,
    project_id      VARCHAR(36)  NOT NULL,
    description     TEXT         NOT NULL,
    impact_code     VARCHAR(50)  NOT NULL,
    likelihood_code VARCHAR(50)  NOT NULL,
    status_code     VARCHAR(50)  NOT NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Risk PRIMARY KEY (risk_id),
    CONSTRAINT FK_Risk_Project FOREIGN KEY (project_id) REFERENCES ComplianceProject(project_id)
);

-- --------------------------------------------------------------------------
-- リスクアセスメント: RiskAssessment
-- --------------------------------------------------------------------------
CREATE TABLE RiskAssessment (
    risk_assessment_id VARCHAR(36) NOT NULL,
    risk_id            VARCHAR(36) NOT NULL,
    assessment_date    DATE        NOT NULL,
    level_code         VARCHAR(50) NOT NULL,
    created_at         TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at         TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_RiskAssessment PRIMARY KEY (risk_assessment_id),
    CONSTRAINT FK_RiskAssessment_Risk FOREIGN KEY (risk_id) REFERENCES Risk(risk_id)
);

-- --------------------------------------------------------------------------
-- 【概念レベルリンク】リスク-要求事項対応: RiskRequirement
--   「このリスクには標準的にこのRequirementが有効」という概念的マッピングを保持
--   大規模環境やISO 27001のコントロール適用根拠を整理する際に有効
-- --------------------------------------------------------------------------
CREATE TABLE RiskRequirement (
    risk_requirement_id VARCHAR(36) NOT NULL,
    risk_id            VARCHAR(36)  NOT NULL,
    requirement_id     VARCHAR(36)  NOT NULL,

    created_at         TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at         TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT PK_RiskRequirement PRIMARY KEY (risk_requirement_id),
    CONSTRAINT FK_RiskRequirement_Risk FOREIGN KEY (risk_id) REFERENCES Risk(risk_id),
    CONSTRAINT FK_RiskRequirement_Requirement FOREIGN KEY (requirement_id) REFERENCES Requirement(requirement_id)
);

-- --------------------------------------------------------------------------
-- リスク対応計画: RiskTreatmentPlan
--   ・リスクに対する具体的対策（回避/移転/低減/受容 etc.）
--   ・ここで「どのRequirementを実際に採用するか」(requirement_id)を登録可能
--   ・owner_id: ユーザ(責任者)
--   ・status_code → M_CODE("RISK_TREATMENT_STATUS")
-- --------------------------------------------------------------------------
CREATE TABLE RiskTreatmentPlan (
    plan_id         VARCHAR(36)  NOT NULL,
    risk_id         VARCHAR(36)  NOT NULL,
    requirement_id  VARCHAR(36)  NULL,  -- 実際に適用するコントロール(Requirement)
    action          TEXT         NOT NULL,
    owner_id        VARCHAR(36)  NOT NULL,
    due_date        DATE         NOT NULL,
    status_code     VARCHAR(50)  NOT NULL, -- M_CODE: "RISK_TREATMENT_STATUS"

    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT PK_RiskTreatmentPlan PRIMARY KEY (plan_id),
    CONSTRAINT FK_RiskTreatmentPlan_Risk FOREIGN KEY (risk_id) REFERENCES Risk(risk_id),
    CONSTRAINT FK_RiskTreatmentPlan_Requirement FOREIGN KEY (requirement_id) REFERENCES Requirement(requirement_id),
    CONSTRAINT FK_RiskTreatmentPlan_User FOREIGN KEY (owner_id) REFERENCES User(user_id)
);
-- --------------------------------------------------------------------------
-- 文書: Document
-- --------------------------------------------------------------------------
CREATE TABLE Document (
    document_id     VARCHAR(36)  NOT NULL,
    project_id      VARCHAR(36)  NOT NULL,
    title           VARCHAR(200) NOT NULL,
    category_code   VARCHAR(50)  NOT NULL,
    department_id   VARCHAR(36)  NOT NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Document PRIMARY KEY (document_id),
    CONSTRAINT FK_Document_Project FOREIGN KEY (project_id) REFERENCES ComplianceProject(project_id),
    CONSTRAINT FK_Document_Department FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- --------------------------------------------------------------------------
-- 文書バージョン: DocumentVersion
-- --------------------------------------------------------------------------
CREATE TABLE DocumentVersion (
    document_version_id VARCHAR(36) NOT NULL,
    document_id         VARCHAR(36) NOT NULL,
    version_number      VARCHAR(50) NOT NULL,
    status_code         VARCHAR(50) NOT NULL,
    content_url         TEXT        NULL,
    created_at          TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_DocumentVersion PRIMARY KEY (document_version_id),
    CONSTRAINT FK_DocumentVersion_Document FOREIGN KEY (document_id) REFERENCES Document(document_id)
);

-- --------------------------------------------------------------------------
-- 承認ワークフロー: ApprovalWorkflow
-- --------------------------------------------------------------------------
CREATE TABLE ApprovalWorkflow (
    workflow_id         VARCHAR(36)  NOT NULL,
    document_version_id VARCHAR(36)  NOT NULL,
    approver_id         VARCHAR(36)  NOT NULL,
    status_code         VARCHAR(50)  NOT NULL,
    approved_at         TIMESTAMP    NULL,
    created_at          TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_ApprovalWorkflow PRIMARY KEY (workflow_id),
    CONSTRAINT FK_ApprovalWorkflow_DocumentVersion FOREIGN KEY (document_version_id) REFERENCES DocumentVersion(document_version_id),
    CONSTRAINT FK_ApprovalWorkflow_User FOREIGN KEY (approver_id) REFERENCES User(user_id)
);

-- --------------------------------------------------------------------------
-- 文書カテゴリ×部署×承認者マッピング: DocCategoryDeptMapping
-- --------------------------------------------------------------------------
CREATE TABLE DocCategoryDeptMapping (
    mapping_id          VARCHAR(36)  NOT NULL,
    doc_category_code   VARCHAR(50)  NOT NULL,
    department_id       VARCHAR(36)  NOT NULL,
    approver_role_code  VARCHAR(50)  NOT NULL,
    approval_order      INT          NOT NULL,
    created_at          TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_DocCategoryDeptMapping PRIMARY KEY (mapping_id),
    CONSTRAINT UQ_DocCategoryDeptMapping UNIQUE (doc_category_code, department_id, approval_order),
    CONSTRAINT FK_DocCategoryDeptMapping_Department FOREIGN KEY (department_id) REFERENCES Department(department_id)
); 