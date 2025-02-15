-- Organization table
CREATE TABLE IF NOT EXISTS organization (
    organization_id    VARCHAR(36)   NOT NULL,
    name              VARCHAR(100)   NOT NULL,
    organization_code VARCHAR(50)    NOT NULL,
    description       TEXT          NULL,
    created_at        TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_organization PRIMARY KEY (organization_id)
);

-- Department table
CREATE TABLE IF NOT EXISTS department (
    department_id    VARCHAR(36)   NOT NULL,
    organization_id  VARCHAR(36)   NOT NULL,
    parent_id        VARCHAR(36)   NULL,
    name            VARCHAR(255)  NOT NULL,
    department_code  VARCHAR(50)   NOT NULL,
    created_at       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_department PRIMARY KEY (department_id),
    CONSTRAINT fk_department_organization FOREIGN KEY (organization_id) REFERENCES organization(organization_id)
);

-- Add self-referential foreign key for department
ALTER TABLE department
ADD CONSTRAINT fk_department_parent FOREIGN KEY (parent_id) REFERENCES department(department_id);

-- User table
CREATE TABLE IF NOT EXISTS user (
    user_id         VARCHAR(36)   NOT NULL,
    department_id   VARCHAR(36)   NOT NULL,
    username        VARCHAR(255)  NOT NULL,
    email          VARCHAR(255)  NOT NULL,
    password_hash   VARCHAR(255)  NOT NULL,
    role_code       VARCHAR(50)   NOT NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_user PRIMARY KEY (user_id),
    CONSTRAINT fk_user_department FOREIGN KEY (department_id) REFERENCES department(department_id)
);

-- PermissionDetail table
CREATE TABLE IF NOT EXISTS permission_detail (
    permission_detail_id BIGINT AUTO_INCREMENT NOT NULL,
    permission_id        VARCHAR(36)   NOT NULL,
    user_id             VARCHAR(36)   NOT NULL,
    permission_type     VARCHAR(50)   NOT NULL,
    target_id           VARCHAR(36)   NULL,
    access_level        VARCHAR(50)   NOT NULL,
    department_scope    VARCHAR(50)   NOT NULL,
    created_at          TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_permission_detail PRIMARY KEY (permission_detail_id),
    CONSTRAINT fk_permission_detail_user FOREIGN KEY (user_id) REFERENCES user(user_id)
);

-- PermissionDetail_Department table
CREATE TABLE IF NOT EXISTS permission_detail_department (
    permission_detail_id BIGINT       NOT NULL,
    department_id        VARCHAR(36)   NOT NULL,
    created_at           TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at           TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_permission_detail_department PRIMARY KEY (permission_detail_id, department_id),
    CONSTRAINT fk_permission_detail_department_permission 
        FOREIGN KEY (permission_detail_id) 
        REFERENCES permission_detail(permission_detail_id),
    CONSTRAINT fk_permission_detail_department_department
        FOREIGN KEY (department_id) 
        REFERENCES department(department_id)
);

-- Create indexes
CREATE INDEX idx_user_department_id ON user(department_id);
CREATE INDEX idx_department_organization_id ON department(organization_id);
CREATE INDEX idx_department_parent_id ON department(parent_id);
CREATE INDEX idx_permission_detail_user_id ON permission_detail(user_id);
CREATE INDEX idx_permission_detail_permission_id ON permission_detail(permission_id);
CREATE INDEX idx_permission_detail_department_permission_detail_id 
    ON permission_detail_department(permission_detail_id);
CREATE INDEX idx_permission_detail_department_department_id 
    ON permission_detail_department(department_id); 