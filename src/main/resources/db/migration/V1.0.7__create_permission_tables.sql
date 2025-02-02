-- --------------------------------------------------------------------------
-- 権限詳細: PermissionDetail
-- --------------------------------------------------------------------------
CREATE TABLE PermissionDetail (
    permission_detail_id  VARCHAR(36)  NOT NULL,
    user_id              VARCHAR(36)  NOT NULL,
    permission_type_code VARCHAR(50)  NOT NULL,
    target_resource_type VARCHAR(50)  NOT NULL,
    target_resource_id   VARCHAR(36)  NOT NULL,
    created_at           TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at           TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_PermissionDetail PRIMARY KEY (permission_detail_id),
    CONSTRAINT FK_PermissionDetail_User FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- --------------------------------------------------------------------------
-- 部署スコープ: DepartmentScope
-- --------------------------------------------------------------------------
CREATE TABLE DepartmentScope (
    department_scope_id   VARCHAR(36)  NOT NULL,
    permission_detail_id  VARCHAR(36)  NOT NULL,
    department_id        VARCHAR(36)  NOT NULL,
    created_at           TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at           TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_DepartmentScope PRIMARY KEY (department_scope_id),
    CONSTRAINT FK_DepartmentScope_PermissionDetail FOREIGN KEY (permission_detail_id) REFERENCES PermissionDetail(permission_detail_id),
    CONSTRAINT FK_DepartmentScope_Department FOREIGN KEY (department_id) REFERENCES Department(department_id)
); 