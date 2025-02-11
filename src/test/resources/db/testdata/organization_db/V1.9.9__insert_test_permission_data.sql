-- テスト部門の作成
INSERT INTO Department (department_id, organization_id, parent_id, name, department_code)
VALUES
('DEPT_A', 'ORG001', NULL, 'Department A', 'DEPT_A'),
('DEPT_B', 'ORG001', NULL, 'Department B', 'DEPT_B'),
('DEPT_C', 'ORG001', NULL, 'Department C', 'DEPT_C'),
('DEPT_A_1', 'ORG001', 'DEPT_A', 'Department A-1', 'DEPT_A_1'),
('DEPT_B_1', 'ORG001', 'DEPT_B', 'Department B-1', 'DEPT_B_1');

-- テストユーザーの作成
INSERT INTO User (user_id, department_id, username, email, password_hash, role_code)
VALUES 
('USER001', 'DEPT_A', 'test_user1', 'test1@example.com', 'dummy_hash', 'ROLE_USER'),
('USER002', 'DEPT_B', 'test_user2', 'test2@example.com', 'dummy_hash', 'ROLE_USER');

-- テスト権限の作成
INSERT INTO PermissionDetail (
    permission_detail_id,
    permission_id,
    user_id,
    permission_type,
    target_id,
    access_level,
    department_scope
) VALUES
(1, 'PERM001', 'USER001', 'DOCUMENT', NULL, 'READ', 'ANY_DEPT'),
(2, 'PERM002', 'USER001', 'DOCUMENT', NULL, 'WRITE', 'OWN_DEPT'),
(3, 'PERM003', 'USER001', 'DOCUMENT', NULL, 'READ', 'SPECIFIC'),
(4, 'PERM004', 'USER002', 'DOCUMENT', NULL, 'READ', 'SPECIFIC');

-- 特定部門への権限マッピング
INSERT INTO PermissionDetail_Department (permission_detail_id, department_id)
VALUES
(3, 'DEPT_A'),
(3, 'DEPT_B'),
(4, 'DEPT_C'); 