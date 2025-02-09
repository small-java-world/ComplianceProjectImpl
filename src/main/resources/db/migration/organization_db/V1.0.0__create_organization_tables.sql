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
CREATE TABLE Department (
    department_id     VARCHAR(36)   NOT NULL,
    organization_id   VARCHAR(36)   NOT NULL,
    parent_id         VARCHAR(36)   NULL,
    name             VARCHAR(100)   NOT NULL,
    department_code  VARCHAR(50)    NOT NULL,
    description      TEXT          NULL,
    created_at       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Department PRIMARY KEY (department_id),
    CONSTRAINT FK_Department_Organization FOREIGN KEY (organization_id) REFERENCES Organization(organization_id),
    CONSTRAINT FK_Department_Parent FOREIGN KEY (parent_id) REFERENCES Department(department_id)
);

-- User table
CREATE TABLE User (
    user_id          VARCHAR(36)   NOT NULL,
    department_id    VARCHAR(36)   NOT NULL,
    username        VARCHAR(100)   NOT NULL,
    email           VARCHAR(200)   NOT NULL,
    password_hash   VARCHAR(200)   NOT NULL,
    role_code       VARCHAR(50)    NOT NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_User PRIMARY KEY (user_id),
    CONSTRAINT FK_User_Department FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- PermissionDetail table
CREATE TABLE PermissionDetail (
    permission_id    VARCHAR(36)   NOT NULL,
    user_id         VARCHAR(36)   NOT NULL,
    permission_type VARCHAR(50)    NOT NULL,
    target_id       VARCHAR(36)   NULL,
    access_level    VARCHAR(50)    NOT NULL,
    department_scope VARCHAR(50)    NOT NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_PermissionDetail PRIMARY KEY (permission_id),
    CONSTRAINT FK_PermissionDetail_User FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- PermissionDetail_Department table
CREATE TABLE PermissionDetail_Department (
    permission_id    VARCHAR(36)   NOT NULL,
    department_id    VARCHAR(36)   NOT NULL,
    created_at       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_PermissionDetail_Department PRIMARY KEY (permission_id, department_id),
    CONSTRAINT FK_PermissionDetail_Department_Permission 
        FOREIGN KEY (permission_id) 
        REFERENCES PermissionDetail(permission_id),
    CONSTRAINT FK_PermissionDetail_Department_Department
        FOREIGN KEY (department_id) 
        REFERENCES Department(department_id)
); 