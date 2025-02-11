-- Organization table
CREATE TABLE Organization (
    organization_id    VARCHAR(36)   NOT NULL,
    name              VARCHAR(100)   NOT NULL,
    organization_code VARCHAR(50)    NOT NULL,
    description       TEXT          NULL,
    created_at        TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Organization PRIMARY KEY (organization_id)
);

-- Department table
CREATE TABLE IF NOT EXISTS Department (
    department_id    VARCHAR(36)   NOT NULL,
    organization_id  VARCHAR(36)   NOT NULL,
    parent_id        VARCHAR(36)   NULL,
    name            VARCHAR(255)  NOT NULL,
    department_code  VARCHAR(50)   NOT NULL,
    created_at       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Department PRIMARY KEY (department_id),
    CONSTRAINT FK_Department_Organization FOREIGN KEY (organization_id) REFERENCES Organization(organization_id),
    CONSTRAINT FK_Department_Parent FOREIGN KEY (parent_id) REFERENCES Department(department_id)
);

-- User table
CREATE TABLE IF NOT EXISTS User (
    user_id         VARCHAR(36)   NOT NULL,
    department_id   VARCHAR(36)   NOT NULL,
    username        VARCHAR(255)  NOT NULL,
    email          VARCHAR(255)  NOT NULL,
    password_hash   VARCHAR(255)  NOT NULL,
    role_code       VARCHAR(50)   NOT NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_User PRIMARY KEY (user_id),
    CONSTRAINT FK_User_Department FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- PermissionDetail table
CREATE TABLE IF NOT EXISTS PermissionDetail (
    permission_detail_id BIGINT AUTO_INCREMENT NOT NULL,
    permission_id        VARCHAR(36)   NOT NULL,
    user_id             VARCHAR(36)   NOT NULL,
    permission_type     VARCHAR(50)   NOT NULL,
    target_id           VARCHAR(36)   NULL,
    access_level        VARCHAR(50)   NOT NULL,
    department_scope    VARCHAR(50)   NOT NULL,
    created_at          TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_PermissionDetail PRIMARY KEY (permission_detail_id),
    CONSTRAINT FK_PermissionDetail_User FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- PermissionDetail_Department table
CREATE TABLE IF NOT EXISTS PermissionDetail_Department (
    permission_detail_id BIGINT       NOT NULL,
    department_id        VARCHAR(36)   NOT NULL,
    created_at           TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at           TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_PermissionDetail_Department PRIMARY KEY (permission_detail_id, department_id),
    CONSTRAINT FK_PermissionDetail_Department_Permission 
        FOREIGN KEY (permission_detail_id) 
        REFERENCES PermissionDetail(permission_detail_id),
    CONSTRAINT FK_PermissionDetail_Department_Department
        FOREIGN KEY (department_id) 
        REFERENCES Department(department_id)
);

-- Indexes
CREATE INDEX IDX_User_DepartmentId ON User(department_id);
CREATE INDEX IDX_Department_OrganizationId ON Department(organization_id);
CREATE INDEX IDX_Department_ParentId ON Department(parent_id);
CREATE INDEX IDX_PermissionDetail_UserId ON PermissionDetail(user_id);
CREATE INDEX IDX_PermissionDetail_PermissionId ON PermissionDetail(permission_id);
CREATE INDEX IDX_PermissionDetail_Department_PermissionDetailId 
    ON PermissionDetail_Department(permission_detail_id);
CREATE INDEX IDX_PermissionDetail_Department_DepartmentId 
    ON PermissionDetail_Department(department_id); 