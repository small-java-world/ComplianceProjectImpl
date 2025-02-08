-- リスク
INSERT INTO Risk (risk_id, title, description, impact_code, likelihood_code, status_code, created_at, updated_at)
VALUES
-- ISO27001認証取得プロジェクト2024
('RISK001', '情報セキュリティインシデント', '情報セキュリティインシデントによる事業への影響', 'HIGH', 'MEDIUM', 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('RISK002', '法令違反', '情報セキュリティ関連法令への違反', 'HIGH', 'LOW', 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('RISK003', 'システム障害', '重要システムの障害による業務停止', 'HIGH', 'MEDIUM', 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('RISK004', '内部不正', '従業員による情報漏洩や不正アクセス', 'HIGH', 'LOW', 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('RISK005', '外部攻撃', 'サイバー攻撃による情報漏洩や業務停止', 'HIGH', 'MEDIUM', 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- PCI DSS準拠プロジェクト2024
('RISK006', 'カード情報漏洩', 'クレジットカード情報の漏洩', 'CRITICAL', 'LOW', 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('RISK007', 'システム脆弱性', 'セキュリティ脆弱性の悪用', 'HIGH', 'MEDIUM', 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('RISK008', '不正アクセス', '不正アクセスによるデータ改ざん', 'HIGH', 'MEDIUM', 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('RISK009', 'マルウェア感染', 'マルウェアによるシステム侵害', 'HIGH', 'MEDIUM', 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('RISK010', '委託先管理', '委託先でのカード情報の不適切な取扱い', 'HIGH', 'MEDIUM', 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- リスクアセスメント
INSERT INTO RiskAssessment (assessment_id, risk_id, assessor_id, assessment_date, risk_level_code, notes, created_at, updated_at)
VALUES
-- ISO27001認証取得プロジェクト2024
('ASSESS001', 'RISK001', 'USER001', '2024-04-01', 'HIGH', '過去のインシデント履歴から評価', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('ASSESS002', 'RISK002', 'USER001', '2024-04-01', 'MEDIUM', '法令動向から評価', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('ASSESS003', 'RISK003', 'USER001', '2024-04-01', 'HIGH', 'システム重要度から評価', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('ASSESS004', 'RISK004', 'USER001', '2024-04-01', 'MEDIUM', 'アクセス権限管理状況から評価', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('ASSESS005', 'RISK005', 'USER001', '2024-04-01', 'HIGH', '外部脅威動向から評価', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- PCI DSS準拠プロジェクト2024
('ASSESS006', 'RISK006', 'USER001', '2024-04-01', 'CRITICAL', 'カード情報取扱い状況から評価', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('ASSESS007', 'RISK007', 'USER001', '2024-04-01', 'HIGH', '脆弱性診断結果から評価', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('ASSESS008', 'RISK008', 'USER001', '2024-04-01', 'HIGH', 'アクセスログ分析から評価', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('ASSESS009', 'RISK009', 'USER001', '2024-04-01', 'HIGH', 'マルウェア対策状況から評価', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('ASSESS010', 'RISK010', 'USER001', '2024-04-01', 'HIGH', '委託先評価結果から評価', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- リスク対応計画
INSERT INTO RiskTreatmentPlan (plan_id, risk_id, requirement_id, title, description, treatment_type_code, status_code, due_date, created_at, updated_at)
VALUES
-- ISO27001認証取得プロジェクト2024
('PLAN001', 'RISK001', 'A.5.1', 'インシデント対応体制の強化', 'インシデント対応手順の整備と訓練の実施', 'MITIGATE', 'IN_PROGRESS', '2024-06-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PLAN002', 'RISK002', 'A.5.2', '法令遵守体制の強化', '法令要求事項の特定と遵守評価の実施', 'MITIGATE', 'IN_PROGRESS', '2024-06-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PLAN003', 'RISK003', 'A.5.3', 'システム可用性の向上', '冗長化とバックアップ体制の強化', 'MITIGATE', 'IN_PROGRESS', '2024-06-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PLAN004', 'RISK004', 'A.6.1', 'アクセス管理の強化', 'アクセス権限の定期見直しと監査の実施', 'MITIGATE', 'IN_PROGRESS', '2024-06-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PLAN005', 'RISK005', 'A.6.2', 'セキュリティ対策の強化', '多層防御の実装と監視の強化', 'MITIGATE', 'IN_PROGRESS', '2024-06-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- PCI DSS準拠プロジェクト2024
('PLAN006', 'RISK006', '1.1', 'カード情報保護の強化', '暗号化とアクセス制御の強化', 'MITIGATE', 'IN_PROGRESS', '2024-06-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PLAN007', 'RISK007', '1.2', '脆弱性管理の強化', '定期的な脆弱性診断と修正の実施', 'MITIGATE', 'IN_PROGRESS', '2024-06-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PLAN008', 'RISK008', '1.3', 'アクセス監視の強化', 'リアルタイム監視と異常検知の実装', 'MITIGATE', 'IN_PROGRESS', '2024-06-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PLAN009', 'RISK009', '1.4', 'マルウェア対策の強化', 'エンドポイント保護の強化', 'MITIGATE', 'IN_PROGRESS', '2024-06-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PLAN010', 'RISK010', '1.5', '委託先管理の強化', '委託先の定期評価と監査の実施', 'MITIGATE', 'IN_PROGRESS', '2024-06-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP); 