-- Risk
INSERT INTO Risk (risk_id, risk_template_id, title, description, impact_code, likelihood_code)
VALUES
('R001', 'RT001', '顧客情報漏洩リスク', '顧客の個人情報が外部に漏洩するリスク', 'HIGH', 'MEDIUM'),
('R002', 'RT002', 'サーバー停止リスク', '主要サーバーが停止するリスク', 'HIGH', 'LOW'),
('R003', 'RT003', '不正アクセスリスク', '外部からの不正アクセスによるリスク', 'HIGH', 'MEDIUM');

-- RiskAssessment
INSERT INTO RiskAssessment (assessment_id, risk_id, assessor_id, assessment_date, risk_level_code, notes)
VALUES
('RA001', 'R001', 'USER001', '2024-02-01', 'HIGH', '顧客データベースのセキュリティ強化が必要'),
('RA002', 'R002', 'USER001', '2024-02-01', 'MEDIUM', 'バックアップシステムの導入を検討'),
('RA003', 'R003', 'USER001', '2024-02-01', 'HIGH', 'ファイアウォールの設定を見直し');

-- RiskTreatmentPlan
INSERT INTO RiskTreatmentPlan (plan_id, risk_id, requirement_id, title, description, treatment_type_code, status_code, due_date)
VALUES
('RTP001', 'R001', 'REQ001', '顧客データ暗号化', 'すべての顧客データを暗号化する', 'MITIGATION', 'IN_PROGRESS', '2024-03-31'),
('RTP002', 'R002', 'REQ002', 'バックアップシステム導入', '冗長化システムの導入', 'MITIGATION', 'PLANNED', '2024-04-30'),
('RTP003', 'R003', 'REQ003', 'セキュリティ監視強化', 'セキュリティ監視システムの導入', 'MITIGATION', 'IN_PROGRESS', '2024-03-15');

-- AssetRisk
INSERT INTO AssetRisk (asset_risk_id, asset_id, risk_id)
VALUES
('AR001', 'ASSET001', 'R001'),
('AR002', 'ASSET002', 'R002'),
('AR003', 'ASSET003', 'R003');

-- RiskRequirement
INSERT INTO RiskRequirement (risk_requirement_id, risk_id, requirement_id)
VALUES
('RR001', 'R001', 'REQ001'),
('RR002', 'R002', 'REQ002'),
('RR003', 'R003', 'REQ003'); 