-- Risk
INSERT INTO Risk (
    risk_id,
    risk_template_id,
    risk_name,
    description,
    severity,
    status,
    created_at,
    updated_at
) VALUES
('RISK001', 'TPL001', '顧客データ漏洩リスク', '顧客の個人情報が外部に漏洩するリスク', 5, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('RISK002', 'TPL002', '基幹システム障害リスク', '基幹システムが停止するリスク', 4, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('RISK003', 'TPL003', '不正アクセスリスク', '外部からの不正アクセスによる被害リスク', 5, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- RiskAssessment
INSERT INTO RiskAssessment (
    risk_assessment_id,
    risk_id,
    assessment_date,
    assessor_id,
    likelihood,
    impact,
    risk_level,
    notes,
    created_at,
    updated_at
) VALUES
('ASS001', 'RISK001', CURRENT_DATE, 'USER001', 4, 5, 'HIGH', '早急な対策が必要', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('ASS002', 'RISK002', CURRENT_DATE, 'USER001', 3, 4, 'MEDIUM', '定期的なモニタリングが必要', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('ASS003', 'RISK003', CURRENT_DATE, 'USER001', 4, 5, 'HIGH', '継続的な監視が必要', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- RiskTreatmentPlan
INSERT INTO RiskTreatmentPlan (
    treatment_plan_id,
    risk_id,
    plan_name,
    description,
    treatment_type,
    status,
    start_date,
    end_date,
    created_at,
    updated_at
) VALUES
('PLAN001', 'RISK001', '情報セキュリティ強化計画', 'アクセス制御の強化と暗号化の実装', 'MITIGATION', 'IN_PROGRESS', CURRENT_DATE, DATE_ADD(CURRENT_DATE, INTERVAL 3 MONTH), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PLAN002', 'RISK002', 'システム冗長化計画', 'バックアップシステムの構築', 'MITIGATION', 'PLANNED', CURRENT_DATE, DATE_ADD(CURRENT_DATE, INTERVAL 6 MONTH), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PLAN003', 'RISK003', 'セキュリティ監視強化', 'IDS/IPSの導入と24時間監視体制の確立', 'MITIGATION', 'IN_PROGRESS', CURRENT_DATE, DATE_ADD(CURRENT_DATE, INTERVAL 2 MONTH), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP); 