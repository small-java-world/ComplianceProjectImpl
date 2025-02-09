-- RiskTemplate
INSERT INTO RiskTemplate (
    risk_template_id,
    template_name,
    description,
    severity,
    created_at,
    updated_at
) VALUES
('TPL001', '情報漏洩リスク', '機密情報の漏洩に関するリスク', 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('TPL002', 'システム障害リスク', 'システムの停止や障害に関するリスク', 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('TPL003', '不正アクセスリスク', '不正なアクセスによる被害に関するリスク', 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('TPL004', 'データ整合性リスク', 'データの整合性が損なわれるリスク', 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('TPL005', '権限設定ミスリスク', '権限設定の誤りによるリスク', 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- RiskTemplateCondition
INSERT INTO RiskTemplateCondition (
    risk_template_condition_id,
    risk_template_id,
    attribute_name,
    operator,
    compare_value,
    logical_operator,
    condition_order,
    created_at,
    updated_at
) VALUES
('COND001', 'TPL001', 'confidentiality', '>=', '4', 'AND', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('COND002', 'TPL001', 'personal_info', '=', 'true', 'AND', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('COND003', 'TPL002', 'availability', '>=', '4', 'AND', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('COND004', 'TPL003', 'confidentiality', '>=', '3', 'AND', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('COND005', 'TPL003', 'integrity', '>=', '3', 'OR', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('COND006', 'TPL004', 'integrity', '>=', '4', 'AND', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('COND007', 'TPL005', 'confidentiality', '>=', '3', 'AND', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP); 