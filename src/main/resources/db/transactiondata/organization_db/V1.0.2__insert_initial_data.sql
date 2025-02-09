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