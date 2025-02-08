-- リスクテンプレート
INSERT INTO RiskTemplate (risk_template_id, template_name, description, severity)
VALUES
('TEMPLATE001', '機密情報を含むサーバーのリスク', '機密情報を含むサーバーに関連するリスクテンプレート', 3),
('TEMPLATE002', '個人情報を含むシステムのリスク', '個人情報を含むシステムに関連するリスクテンプレート', 3),
('TEMPLATE003', '可用性要件の高いシステムのリスク', '可用性要件の高いシステムに関連するリスクテンプレート', 3),
('TEMPLATE004', 'インターネット公開サーバーのリスク', 'インターネットに公開されているサーバーに関連するリスク', 3),
('TEMPLATE005', 'データベースサーバーのリスク', 'データベースサーバーに関連するリスクテンプレート', 3);

-- リスクテンプレート条件
INSERT INTO RiskTemplateCondition (risk_template_condition_id, risk_template_id, attribute_name, operator, compare_value, logical_operator, condition_order)
VALUES
-- 機密情報を含むサーバーのリスク
('COND001', 'TEMPLATE001', 'asset_type_code', '=', 'SERVER', 'AND', 1),
('COND002', 'TEMPLATE001', 'confidentiality_level', '>=', '3', 'AND', 2),

-- 個人情報を含むシステムのリスク
('COND003', 'TEMPLATE002', 'contains_personal_data', '=', 'true', 'AND', 1),
('COND004', 'TEMPLATE002', 'confidentiality_level', '>=', '2', 'AND', 2),

-- 可用性要件の高いシステムのリスク
('COND005', 'TEMPLATE003', 'availability_level', '>=', '3', 'AND', 1),

-- インターネット公開サーバーのリスク
('COND006', 'TEMPLATE004', 'asset_type_code', '=', 'SERVER', 'AND', 1),
('COND007', 'TEMPLATE004', 'is_internet_facing', '=', 'true', 'AND', 2),

-- データベースサーバーのリスク
('COND008', 'TEMPLATE005', 'asset_type_code', '=', 'DATABASE', 'AND', 1),
('COND009', 'TEMPLATE005', 'confidentiality_level', '>=', '2', 'AND', 2);

-- リスク
INSERT INTO Risk (risk_id, risk_template_id, title, description, impact_code, likelihood_code, status_code, created_at, updated_at)
VALUES
-- 自動生成されたリスク
('RISK001', 'TEMPLATE001', '機密サーバーへの不正アクセス', '機密情報を含むサーバーへの不正アクセスのリスク', 'HIGH', 'MEDIUM', 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('RISK002', 'TEMPLATE002', '個人情報漏洩', '個人情報を含むシステムからの情報漏洩リスク', 'HIGH', 'LOW', 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('RISK003', 'TEMPLATE003', 'システム停止', '重要システムの停止によるビジネス影響', 'HIGH', 'MEDIUM', 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('RISK004', 'TEMPLATE004', 'Webサーバー攻撃', 'インターネット公開サーバーへの攻撃', 'HIGH', 'HIGH', 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('RISK005', 'TEMPLATE005', 'DB情報漏洩', 'データベースからの情報漏洩リスク', 'HIGH', 'MEDIUM', 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- 手動で追加されたリスク
('RISK006', NULL, 'カード情報漏洩', 'クレジットカード情報の漏洩', 'CRITICAL', 'LOW', 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('RISK007', NULL, 'システム脆弱性', 'セキュリティ脆弱性の悪用', 'HIGH', 'MEDIUM', 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('RISK008', NULL, '不正アクセス', '不正アクセスによるデータ改ざん', 'HIGH', 'MEDIUM', 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('RISK009', NULL, 'マルウェア感染', 'マルウェアによるシステム侵害', 'HIGH', 'MEDIUM', 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('RISK010', NULL, '委託先管理', '委託先でのカード情報の不適切な取扱い', 'HIGH', 'MEDIUM', 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

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
('PLAN001', 'RISK001', 'A.5.1', 'アクセス制御の強化', 'アクセス制御ポリシーの見直しと実装', 'MITIGATE', 'IN_PROGRESS', '2024-06-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PLAN002', 'RISK002', 'A.5.2', '個人情報保護対策', '個人情報の暗号化と管理強化', 'MITIGATE', 'IN_PROGRESS', '2024-06-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PLAN003', 'RISK003', 'A.5.3', '可用性対策', '冗長化とバックアップの強化', 'MITIGATE', 'IN_PROGRESS', '2024-06-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PLAN004', 'RISK004', 'A.6.1', 'Webサーバー保護', 'WAFの導入とセキュリティ強化', 'MITIGATE', 'IN_PROGRESS', '2024-06-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PLAN005', 'RISK005', 'A.6.2', 'DB保護対策', 'データベースのセキュリティ強化', 'MITIGATE', 'IN_PROGRESS', '2024-06-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- PCI DSS準拠プロジェクト2024
('PLAN006', 'RISK006', '1.1', 'カード情報保護', '暗号化とアクセス制御の強化', 'MITIGATE', 'IN_PROGRESS', '2024-06-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PLAN007', 'RISK007', '1.2', '脆弱性管理', '定期的な脆弱性診断と修正', 'MITIGATE', 'IN_PROGRESS', '2024-06-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PLAN008', 'RISK008', '1.3', 'アクセス監視', 'リアルタイム監視と異常検知', 'MITIGATE', 'IN_PROGRESS', '2024-06-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PLAN009', 'RISK009', '1.4', 'マルウェア対策', 'エンドポイント保護の強化', 'MITIGATE', 'IN_PROGRESS', '2024-06-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PLAN010', 'RISK010', '1.5', '委託先管理', '委託先の定期評価と監査', 'MITIGATE', 'IN_PROGRESS', '2024-06-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 資産リスク関連付け
INSERT INTO AssetRisk (asset_risk_id, asset_id, risk_id)
VALUES
('AR001', '1', 'RISK001'),
('AR002', '2', 'RISK002'),
('AR003', '3', 'RISK003'),
('AR004', '1', 'RISK004'),
('AR005', '2', 'RISK005'),
('AR006', '3', 'RISK006'),
('AR007', '1', 'RISK007'),
('AR008', '2', 'RISK008'),
('AR009', '3', 'RISK009'),
('AR010', '1', 'RISK010'); 