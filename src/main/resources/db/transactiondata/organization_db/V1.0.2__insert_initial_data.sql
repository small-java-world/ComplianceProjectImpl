-- 組織
INSERT INTO Organization (organization_id, name, organization_code, description, created_at, updated_at)
VALUES
(1, '株式会社テスト', 'TEST_CORP', 'テスト用組織', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'テスト子会社1', 'TEST_SUB1', 'テスト用子会社1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'テスト子会社2', 'TEST_SUB2', 'テスト用子会社2', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 部門
INSERT INTO Department (department_id, organization_id, name, department_code, description, parent_id, created_at, updated_at)
VALUES
-- 株式会社テスト
(1, 1, '経営管理部', 'MANAGEMENT', '経営管理部門', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 1, '情報システム部', 'IT_SYSTEM', '情報システム部門', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 1, '人事部', 'HR', '人事部門', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 1, '総務部', 'GENERAL_AFFAIRS', '総務部門', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 1, '法務部', 'LEGAL', '法務部門', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 1, '内部監査室', 'INTERNAL_AUDIT', '内部監査部門', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- テスト子会社1
(7, 2, '管理部', 'SUB1_ADMIN', '管理部門', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(8, 2, '営業部', 'SUB1_SALES', '営業部門', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(9, 2, '開発部', 'SUB1_DEV', '開発部門', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- テスト子会社2
(10, 3, '管理部', 'SUB2_ADMIN', '管理部門', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(11, 3, '製造部', 'SUB2_MANUFACTURING', '製造部門', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(12, 3, '品質管理部', 'SUB2_QA', '品質管理部門', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ユーザー
INSERT INTO User (user_id, department_id, username, email, password_hash, role_code, created_at, updated_at)
VALUES
('U001', 1, 'admin_user', 'admin@test.com', 'hashed_password_1', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U002', 2, 'it_user', 'it@test.com', 'hashed_password_2', 'IT_MANAGER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U003', 6, 'audit_user', 'audit@test.com', 'hashed_password_3', 'AUDITOR', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U004', 1, 'admin_user2', 'admin1@test.com', 'hashed_password_4', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U005', 2, 'it_manager1', 'it_manager1@test.com', 'hashed_password_5', 'IT_MANAGER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U006', 6, 'auditor1', 'auditor1@test.com', 'hashed_password_6', 'AUDITOR', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U007', 3, 'hr_specialist1', 'hr_specialist1@test.com', 'hashed_password_7', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U008', 4, 'office_manager1', 'office_manager1@test.com', 'hashed_password_8', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U009', 5, 'legal_user1', 'legal_user1@test.com', 'hashed_password_9', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U010', 7, 'subsidiary1_admin', 'subsidiary1_admin@test.com', 'hashed_password_10', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U011', 8, 'sales_rep1', 'sales_rep1@test.com', 'hashed_password_11', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U012', 9, 'dev_lead1', 'dev_lead1@test.com', 'hashed_password_12', 'IT_MANAGER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U013', 10, 'subsidiary2_admin', 'subsidiary2_admin@test.com', 'hashed_password_13', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U014', 11, 'manufacturing_user1', 'manufacturing_user1@test.com', 'hashed_password_14', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U015', 12, 'qa_inspector1', 'qa_inspector1@test.com', 'hashed_password_15', 'AUDITOR', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U016', 1, 'finance_user1', 'finance_user1@test.com', 'hashed_password_16', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U017', 2, 'network_admin1', 'network_admin1@test.com', 'hashed_password_17', 'IT_MANAGER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U018', 3, 'hr_specialist2', 'hr_specialist2@test.com', 'hashed_password_18', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U019', 4, 'office_manager2', 'office_manager2@test.com', 'hashed_password_19', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U020', 5, 'legal_consultant1', 'legal_consultant1@test.com', 'hashed_password_20', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U021', 6, 'internal_auditor1', 'internal_auditor1@test.com', 'hashed_password_21', 'AUDITOR', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U022', 7, 'subsidiary1_admin2', 'subsidiary1_admin2@test.com', 'hashed_password_22', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U023', 8, 'sales_rep2', 'sales_rep2@test.com', 'hashed_password_23', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U024', 9, 'dev_lead2', 'dev_lead2@test.com', 'hashed_password_24', 'IT_MANAGER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U025', 10, 'subsidiary2_manager', 'subsidiary2_manager@test.com', 'hashed_password_25', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U026', 11, 'manufacturing_supervisor', 'manufacturing_supervisor@test.com', 'hashed_password_26', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U027', 12, 'qa_inspector2', 'qa_inspector2@test.com', 'hashed_password_27', 'AUDITOR', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U028', 1, 'ceo_user', 'ceo_user@test.com', 'hashed_password_28', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U029', 2, 'it_support1', 'it_support1@test.com', 'hashed_password_29', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U030', 3, 'hr_manager1', 'hr_manager1@test.com', 'hashed_password_30', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U031', 4, 'admin_assistant1', 'admin_assistant1@test.com', 'hashed_password_31', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U032', 5, 'legal_aide1', 'legal_aide1@test.com', 'hashed_password_32', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U033', 6, 'audit_manager1', 'audit_manager1@test.com', 'hashed_password_33', 'AUDITOR', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U034', 7, 'subsidiary1_sales', 'subsidiary1_sales@test.com', 'hashed_password_34', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U035', 8, 'subsidiary1_support', 'subsidiary1_support@test.com', 'hashed_password_35', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U036', 9, 'dev_engineer1', 'dev_engineer1@test.com', 'hashed_password_36', 'IT_MANAGER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U037', 10, 'subsidiary2_hr1', 'subsidiary2_hr1@test.com', 'hashed_password_37', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U038', 11, 'plant_operator1', 'plant_operator1@test.com', 'hashed_password_38', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U039', 12, 'quality_specialist1', 'quality_specialist1@test.com', 'hashed_password_39', 'AUDITOR', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U040', 1, 'finance_manager1', 'finance_manager1@test.com', 'hashed_password_40', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U041', 2, 'it_consultant1', 'it_consultant1@test.com', 'hashed_password_41', 'IT_MANAGER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U042', 3, 'recruiter1', 'recruiter1@test.com', 'hashed_password_42', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U043', 4, 'office_admin1', 'office_admin1@test.com', 'hashed_password_43', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U044', 5, 'compliance_officer1', 'compliance_officer1@test.com', 'hashed_password_44', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U045', 6, 'senior_auditor1', 'senior_auditor1@test.com', 'hashed_password_45', 'AUDITOR', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U046', 7, 'subsidiary1_hr2', 'subsidiary1_hr2@test.com', 'hashed_password_46', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U047', 8, 'subsidiary1_engineer1', 'subsidiary1_engineer1@test.com', 'hashed_password_47', 'IT_MANAGER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U048', 9, 'software_developer1', 'software_developer1@test.com', 'hashed_password_48', 'IT_MANAGER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U049', 10, 'subsidiary2_marketing1', 'subsidiary2_marketing1@test.com', 'hashed_password_49', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('U050', 11, 'production_supervisor1', 'production_supervisor1@test.com', 'hashed_password_50', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- PermissionDetail
INSERT INTO PermissionDetail (
    permission_id,
    user_id,
    permission_type,
    target_id,
    access_level,
    department_scope,
    created_at,
    updated_at
) VALUES
-- 基本権限（81-90）
('PERM081', 'U001', 'QUALITY', NULL, 'READ_WRITE', 'ANY_DEPT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PERM082', 'U001', 'QUALITY', NULL, 'EXECUTE', 'OWN_DEPT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PERM083', 'U001', 'QUALITY', NULL, 'READ_WRITE', 'DEPT_QMS', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PERM084', 'U001', 'SAFETY', NULL, 'CREATE', 'ANY_DEPT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PERM085', 'U001', 'SAFETY', NULL, 'READ_ONLY', 'SPECIFIC', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PERM086', 'U001', 'SAFETY', NULL, 'READ_WRITE', 'OWN_DEPT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PERM087', 'U001', 'ENVIRONMENT', NULL, 'READ_WRITE', 'ANY_DEPT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PERM088', 'U001', 'ENVIRONMENT', NULL, 'EXECUTE', 'DEPT_ENV', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PERM089', 'U001', 'ENVIRONMENT', NULL, 'READ_ONLY', 'OWN_DEPT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PERM090', 'U001', 'SOCIAL', NULL, 'APPROVE', 'ANY_DEPT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PERM091', 'U014', 'SECURITY',    NULL, 'READ_ONLY',  'SPECIFIC', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PERM092', 'U014', 'CLOUD',       NULL, 'EXECUTE',    'SPECIFIC', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PERM093', 'U014', 'DATA',        NULL, 'READ_WRITE', 'SPECIFIC', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PERM094', 'U014', 'COMPLIANCE',  NULL, 'REVIEW',     'SPECIFIC', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PERM095', 'U050', 'GOVERNANCE',  NULL, 'APPROVE',    'SPECIFIC', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- PermissionDetail_Department
INSERT INTO PermissionDetail_Department (permission_id, department_id, created_at, updated_at)
VALUES
-- PERM085の複数部門設定
('PERM085', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),  -- 経営管理部
('PERM085', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),  -- 情報システム部
('PERM091', 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PERM091', 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PERM091', 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PERM091', 6, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PERM092', 7, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PERM092', 8, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PERM092', 9, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PERM092', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
-- コンプライアンスプロジェクト
INSERT INTO ComplianceProject (project_id, organization_id, project_name, start_date, end_date, status_code, created_at, updated_at)
VALUES
(1, 1, 'ISO27001認証取得プロジェクト2024', '2024-04-01', '2025-03-31', 'IN_PROGRESS', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 1, 'PCI DSS準拠プロジェクト2024', '2024-04-01', '2025-03-31', 'IN_PROGRESS', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 2, 'ISO27001認証取得プロジェクト2024（子会社1）', '2024-04-01', '2025-03-31', 'IN_PROGRESS', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- プロジェクトフレームワーク
INSERT INTO ProjectFramework (project_framework_id, project_id, framework_code, framework_version, created_at, updated_at)
VALUES
(1, 1, 'ISO27001_2022', '1.0', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 2, 'PCI_DSS_4', '1.0', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 3, 'ISO27001_2022', '1.0', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP); 