-- 既存のデータを削除
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM permission_detail_department;
DELETE FROM permission_detail;
DELETE FROM user;
DELETE FROM department;
DELETE FROM organization;
SET FOREIGN_KEY_CHECKS = 1;

-- 組織データの作成
INSERT INTO organization (
    organization_id,
    name,
    organization_code,
    description,
    created_at,
    updated_at
)
VALUES (
    'ORG001',
    'テスト組織1',
    'TEST_ORG_1',
    'テスト用組織1です。',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
);

-- 部門データの作成
INSERT INTO department (
    department_id,
    organization_id,
    name,
    department_code,
    created_at,
    updated_at
)
VALUES
('DEPT001', 'ORG001', '総務部', 'SOUMU', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('DEPT002', 'ORG001', '人事部', 'JINJI', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ユーザーデータの作成
INSERT INTO user (
    user_id,
    department_id,
    username,
    email,
    password_hash,
    role_code,
    created_at,
    updated_at
)
VALUES
('user1', 'DEPT001', 'テストユーザー1', 'test1@example.com', 'dummy_hash', 'ROLE_USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('user2', 'DEPT002', 'テストユーザー2', 'test2@example.com', 'dummy_hash', 'ROLE_USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- permission_detail test data
INSERT INTO permission_detail (
    permission_id,
    user_id,
    permission_type,
    target_id,
    access_level,
    department_scope,
    created_at,
    updated_at
)
VALUES
-- ANY_DEPT permissions for user1
('PERM_TEST_1', 'user1', 'DOCUMENT', 'TARGET1', 'READ', 'ANY_DEPT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PERM_TEST_2', 'user2', 'DOCUMENT', 'TARGET2', 'READ', 'SPECIFIC', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Get the permission_detail_id values
SET @perm_id_1 = LAST_INSERT_ID();
SET @perm_id_2 = @perm_id_1 + 1;

-- permission_detail_department test data
INSERT INTO permission_detail_department (
    permission_detail_id,
    department_id,
    created_at,
    updated_at
)
VALUES
(@perm_id_2, 'DEPT001', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(@perm_id_2, 'DEPT002', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP); 