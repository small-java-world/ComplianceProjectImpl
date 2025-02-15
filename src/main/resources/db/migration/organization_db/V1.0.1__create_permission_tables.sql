-- Drop tables in correct order
DROP TABLE IF EXISTS permission_detail_department;
DROP TABLE IF EXISTS permission_detail;

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

-- permission_detail_department table
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

-- Indexes
CREATE INDEX idx_permission_detail_user_id ON permission_detail(user_id);
CREATE INDEX idx_permission_detail_permission_id ON permission_detail(permission_id);
CREATE INDEX idx_permission_detail_department_permission_detail_id 
    ON permission_detail_department(permission_detail_id);
CREATE INDEX idx_permission_detail_department_department_id 
    ON permission_detail_department(department_id); 