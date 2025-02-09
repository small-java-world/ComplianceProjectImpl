-- RiskTemplate
INSERT INTO RiskTemplate (risk_template_id, template_name, description, severity)
VALUES
('RT001', '情報漏洩リスク', '機密情報の漏洩に関するリスク', 5),
('RT002', 'システム障害リスク', 'システムの停止や障害に関するリスク', 4),
('RT003', '不正アクセスリスク', '不正なアクセスによる被害に関するリスク', 5);

-- RiskTemplateCondition
INSERT INTO RiskTemplateCondition (risk_template_condition_id, risk_template_id, attribute_name, operator, compare_value, logical_operator, condition_order)
VALUES
('RTC001', 'RT001', 'confidentiality', '>=', '4', 'AND', 1),
('RTC002', 'RT001', 'personal_info', '=', 'true', 'AND', 2),
('RTC003', 'RT002', 'availability', '>=', '4', 'AND', 1),
('RTC004', 'RT003', 'confidentiality', '>=', '3', 'AND', 1),
('RTC005', 'RT003', 'integrity', '>=', '3', 'OR', 2); 