-- 監査
INSERT INTO Audit (audit_id, project_id, audit_name, description, audit_stage_code, start_date, end_date, status_code, created_at, updated_at)
VALUES
-- ISO27001認証取得プロジェクト2024
(1, 1, '内部監査1', 'ISO27001:2022認証取得に向けた内部監査', 'STAGE_INTERNAL', '2024-05-01', '2024-05-31', 'IN_PROGRESS', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 1, '文書審査', 'ISO27001:2022認証取得の文書審査', 'STAGE1_DOCUMENT', '2024-07-01', '2024-07-31', 'DRAFT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 1, '実地審査', 'ISO27001:2022認証取得の実地審査', 'STAGE2_ONSITE', '2024-09-01', '2024-09-30', 'DRAFT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- PCI DSS準拠プロジェクト2024
(4, 2, '内部監査1', 'PCI DSS v4.0準拠に向けた内部監査', 'STAGE_INTERNAL', '2024-05-01', '2024-05-31', 'IN_PROGRESS', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 2, '外部評価', 'PCI DSS v4.0準拠の外部評価', 'STAGE2_ONSITE', '2024-09-01', '2024-09-30', 'DRAFT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 評価報告書
INSERT INTO AssessmentReport (report_id, audit_id, report_name, description, status_code, created_at, updated_at)
VALUES
-- ISO27001認証取得プロジェクト2024
(1, 1, '内部監査報告書1', 'ISO27001:2022認証取得に向けた内部監査の報告書', 'DRAFT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 2, '文書審査報告書', 'ISO27001:2022認証取得の文書審査報告書', 'DRAFT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 3, '実地審査報告書', 'ISO27001:2022認証取得の実地審査報告書', 'DRAFT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- PCI DSS準拠プロジェクト2024
(4, 4, '内部監査報告書1', 'PCI DSS v4.0準拠に向けた内部監査の報告書', 'DRAFT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 5, '外部評価報告書', 'PCI DSS v4.0準拠の外部評価報告書', 'DRAFT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 不適合
INSERT INTO NonConformity (nonconformity_id, report_id, requirement_id, description, severity_level, status_code, created_at, updated_at)
VALUES
-- ISO27001認証取得プロジェクト2024
(1, 1, 2, '組織の外部・内部の課題が十分に特定されていない', 'MEDIUM', 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 1, 3, '一部の利害関係者のニーズが文書化されていない', 'LOW', 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 1, 4, 'ISMSの適用範囲が明確に定義されていない', 'HIGH', 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- PCI DSS準拠プロジェクト2024
(4, 4, 11, 'ファイアウォールの設定基準が不十分', 'HIGH', 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 4, 13, 'アクセス制御が一部未実装', 'MEDIUM', 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 是正処置
INSERT INTO CorrectiveAction (action_id, nonconformity_id, action_name, description, status_code, due_date, created_at, updated_at)
VALUES
-- ISO27001認証取得プロジェクト2024
(1, 1, '組織の状況分析の見直し', '外部・内部の課題を再分析し、文書化する', 'IN_PROGRESS', '2024-06-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 2, '利害関係者分析の完了', '未文書化の利害関係者のニーズを特定し、文書化する', 'IN_PROGRESS', '2024-06-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 3, 'ISMS適用範囲の再定義', 'ISMSの適用範囲を明確に定義し、文書化する', 'IN_PROGRESS', '2024-06-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- PCI DSS準拠プロジェクト2024
(4, 4, 'ファイアウォール設定基準の改定', 'ファイアウォールの設定基準を見直し、強化する', 'IN_PROGRESS', '2024-06-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 5, 'アクセス制御の実装完了', '未実装のアクセス制御を実装する', 'IN_PROGRESS', '2024-06-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP); 