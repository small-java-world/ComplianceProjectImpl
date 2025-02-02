-- --------------------------------------------------------------------------
-- 汎用コードマスタ(M_CODE)
-- --------------------------------------------------------------------------
CREATE TABLE M_CODE (
    code_category      VARCHAR(50)  NOT NULL, 
    code_division      VARCHAR(50)  NOT NULL, 
    code               VARCHAR(50)  NOT NULL, 
    code_name          VARCHAR(100) NOT NULL, 
    code_short_name    VARCHAR(50)  NULL,
    extension1         VARCHAR(100) NULL,
    extension2         VARCHAR(100) NULL,
    extension3         VARCHAR(100) NULL,
    extension4         VARCHAR(100) NULL,
    extension5         VARCHAR(100) NULL,
    extension6         VARCHAR(100) NULL,
    extension7         VARCHAR(100) NULL,
    extension8         VARCHAR(100) NULL,
    extension9         VARCHAR(100) NULL,
    extension10        VARCHAR(100) NULL,
    created_at         TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at         TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_M_CODE PRIMARY KEY (code_category, code_division, code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------------------------
-- 組織管理: Organization
-- --------------------------------------------------------------------------
CREATE TABLE Organization (
    organization_id        VARCHAR(36)  NOT NULL,
    name                   VARCHAR(100) NOT NULL,
    organization_type_code VARCHAR(50)  NOT NULL,
    address                TEXT         NULL,
    contact_info          TEXT         NULL,
    created_at            TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at            TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Organization PRIMARY KEY (organization_id)
);

-- --------------------------------------------------------------------------
-- 部署: Department
-- --------------------------------------------------------------------------
CREATE TABLE Department (
    department_id    VARCHAR(36)  NOT NULL,
    department_name  VARCHAR(100) NOT NULL,
    parent_id        VARCHAR(36)  NULL,
    organization_id  VARCHAR(36)  NOT NULL,
    created_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Department PRIMARY KEY (department_id),
    CONSTRAINT FK_Department_Organization FOREIGN KEY (organization_id) REFERENCES Organization(organization_id),
    CONSTRAINT FK_Department_Parent FOREIGN KEY (parent_id) REFERENCES Department(department_id)
);

-- --------------------------------------------------------------------------
-- ユーザ管理: User
-- --------------------------------------------------------------------------
CREATE TABLE User (
    user_id          VARCHAR(36)  NOT NULL,
    organization_id  VARCHAR(36)  NOT NULL,
    department_id    VARCHAR(36)  NOT NULL,
    name             VARCHAR(100) NOT NULL,
    email            VARCHAR(255) NOT NULL,
    role_code        VARCHAR(50)  NOT NULL,
    password_hash    VARCHAR(255) NOT NULL,
    created_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_User PRIMARY KEY (user_id),
    CONSTRAINT FK_User_Organization FOREIGN KEY (organization_id) REFERENCES Organization(organization_id),
    CONSTRAINT FK_User_Department FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- --------------------------------------------------------------------------
-- コンプライアンスフレームワーク: ComplianceFramework
-- --------------------------------------------------------------------------
CREATE TABLE ComplianceFramework (
    framework_code   VARCHAR(50)  NOT NULL,
    name             VARCHAR(100) NOT NULL,
    description      TEXT         NULL,
    created_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_ComplianceFramework PRIMARY KEY (framework_code)
);

-- --------------------------------------------------------------------------
-- 要求事項: Requirement
-- --------------------------------------------------------------------------
CREATE TABLE Requirement (
    requirement_id   VARCHAR(36)  NOT NULL,
    framework_code   VARCHAR(50)  NOT NULL,
    title            VARCHAR(200) NOT NULL,
    description      TEXT         NULL,
    created_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Requirement PRIMARY KEY (requirement_id),
    CONSTRAINT FK_Requirement_Framework FOREIGN KEY (framework_code) REFERENCES ComplianceFramework(framework_code)
);

-- --------------------------------------------------------------------------
-- コンプライアンスプロジェクト: ComplianceProject
-- --------------------------------------------------------------------------
CREATE TABLE ComplianceProject (
    project_id      VARCHAR(36)  NOT NULL,
    organization_id VARCHAR(36)  NOT NULL,
    project_name    VARCHAR(100) NOT NULL,
    status_code     VARCHAR(50)  NOT NULL,
    start_date      DATE         NOT NULL,
    end_date        DATE         NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_ComplianceProject PRIMARY KEY (project_id),
    CONSTRAINT FK_ComplianceProject_Organization FOREIGN KEY (organization_id) REFERENCES Organization(organization_id)
);

-- --------------------------------------------------------------------------
-- プロジェクト適用範囲: ProjectScope
-- --------------------------------------------------------------------------
CREATE TABLE ProjectScope (
    project_scope_id VARCHAR(36) NOT NULL,
    project_id       VARCHAR(36) NOT NULL,
    scope_item_code  VARCHAR(50) NOT NULL,
    created_at       TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_ProjectScope PRIMARY KEY (project_scope_id),
    CONSTRAINT FK_ProjectScope_Project FOREIGN KEY (project_id) REFERENCES ComplianceProject(project_id)
);

-- --------------------------------------------------------------------------
-- プロジェクトフレームワーク: ProjectFramework
-- --------------------------------------------------------------------------
CREATE TABLE ProjectFramework (
    project_framework_id VARCHAR(36)  NOT NULL,
    project_id           VARCHAR(36)  NOT NULL,
    framework_code       VARCHAR(50)  NOT NULL,
    framework_version    VARCHAR(50)  NULL,
    created_at           TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at           TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_ProjectFramework PRIMARY KEY (project_framework_id),
    CONSTRAINT FK_ProjectFramework_Project FOREIGN KEY (project_id) REFERENCES ComplianceProject(project_id),
    CONSTRAINT FK_ProjectFramework_Framework FOREIGN KEY (framework_code) REFERENCES ComplianceFramework(framework_code)
); 