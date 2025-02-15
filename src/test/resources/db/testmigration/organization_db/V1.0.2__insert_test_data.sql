-- organization test data
INSERT INTO organization (organization_id, name, organization_code, description)
VALUES 
('ORG001', 'テスト組織1', 'TEST_ORG_1', 'テスト用組織1です。'),
('ORG002', 'テスト組織2', 'TEST_ORG_2', 'テスト用組織2です。');

-- department test data (with hierarchy)
INSERT INTO department (department_id, organization_id, parent_id, name, department_code)
VALUES
-- Organization 1 departments
('DEPT001', 'ORG001', NULL, '総務部', 'SOUMU'),
('DEPT002', 'ORG001', NULL, '経理部', 'KEIRI'),
('DEPT003', 'ORG001', 'DEPT001', '総務課', 'SOUMU_KA'),
('DEPT004', 'ORG001', 'DEPT001', '人事課', 'JINJI_KA'),
-- Organization 2 departments
('DEPT005', 'ORG002', NULL, '営業部', 'EIGYOU'),
('DEPT006', 'ORG002', NULL, '開発部', 'KAIHATSU'),
('DEPT007', 'ORG002', 'DEPT006', '開発1課', 'KAIHATSU_1'),
('DEPT008', 'ORG002', 'DEPT006', '開発2課', 'KAIHATSU_2');

-- user test data
INSERT INTO user (user_id, department_id, username, email, password_hash, role_code)
VALUES
-- Organization 1 users
('USER001', 'DEPT001', '総務部長', 'soumu_buchou@example.com', 'dummy_hash', 'ROLE_MANAGER'),
('USER002', 'DEPT003', '総務課長', 'soumu_kachou@example.com', 'dummy_hash', 'ROLE_MANAGER'),
('USER003', 'DEPT003', '総務担当1', 'soumu1@example.com', 'dummy_hash', 'ROLE_USER'),
('USER004', 'DEPT004', '人事課長', 'jinji_kachou@example.com', 'dummy_hash', 'ROLE_MANAGER'),
-- Organization 2 users
('USER005', 'DEPT006', '開発部長', 'dev_buchou@example.com', 'dummy_hash', 'ROLE_MANAGER'),
('USER006', 'DEPT007', '開発1課長', 'dev1_kachou@example.com', 'dummy_hash', 'ROLE_MANAGER'),
('USER007', 'DEPT007', '開発担当1', 'dev1@example.com', 'dummy_hash', 'ROLE_USER');

-- permission_detail test data
INSERT INTO permission_detail (
    permission_detail_id,
    permission_id,
    user_id,
    permission_type,
    target_id,
    access_level,
    department_scope
)
VALUES
-- ANY_DEPT permissions
(1, 'PERM001', 'USER001', 'DOCUMENT', NULL, 'READ', 'ANY_DEPT'),
(2, 'PERM002', 'USER001', 'DOCUMENT', NULL, 'WRITE', 'ANY_DEPT'),
-- OWN_DEPT permissions
(3, 'PERM003', 'USER002', 'DOCUMENT', NULL, 'READ', 'OWN_DEPT'),
(4, 'PERM004', 'USER002', 'DOCUMENT', NULL, 'WRITE', 'OWN_DEPT'),
-- SPECIFIC permissions
(5, 'PERM005', 'USER005', 'DOCUMENT', NULL, 'READ', 'SPECIFIC'),
(6, 'PERM006', 'USER005', 'DOCUMENT', NULL, 'WRITE', 'SPECIFIC');

-- permission_detail_department test data
INSERT INTO permission_detail_department (permission_detail_id, department_id)
VALUES
-- Specific department permissions for USER005
(5, 'DEPT007'),
(5, 'DEPT008'),
(6, 'DEPT007'),
(6, 'DEPT008'); 