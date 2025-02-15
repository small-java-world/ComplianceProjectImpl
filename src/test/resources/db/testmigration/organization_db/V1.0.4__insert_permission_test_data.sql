-- 既存のデータを削除
DELETE FROM permission_detail_department;
DELETE FROM permission_detail;

-- permission_detail test data
INSERT INTO permission_detail (
    permission_detail_id,
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
-- ANY_DEPT permissions for 経理部長
(201, 'PERM_FINANCE_1', 'USER002', 'FINANCE', NULL, 'READ', 'ANY_DEPT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(202, 'PERM_FINANCE_2', 'USER002', 'FINANCE', NULL, 'WRITE', 'ANY_DEPT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- OWN_DEPT permissions for 人事課長
(203, 'PERM_HR_1', 'USER004', 'HR', NULL, 'READ', 'OWN_DEPT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(204, 'PERM_HR_2', 'USER004', 'HR', NULL, 'WRITE', 'OWN_DEPT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- SPECIFIC permissions for 開発1課長
(205, 'PERM_DEV_1', 'USER006', 'DEVELOPMENT', NULL, 'READ', 'SPECIFIC', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(206, 'PERM_DEV_2', 'USER006', 'DEVELOPMENT', NULL, 'WRITE', 'SPECIFIC', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- permission_detail_department test data
INSERT INTO permission_detail_department (
    permission_detail_id,
    department_id,
    created_at,
    updated_at
)
VALUES
-- Specific department permissions for 開発1課長
(205, 'DEPT007', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(205, 'DEPT008', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(206, 'DEPT007', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP); 