-- Insert initial data for M_CODE table
INSERT INTO M_CODE (code_category, code, name, description, display_order, is_active)
VALUES
    ('AUDIT_STAGE', 'PLANNING', '計画', '監査計画段階', 1, true),
    ('AUDIT_STAGE', 'EXECUTION', '実施', '監査実施段階', 2, true),
    ('AUDIT_STAGE', 'REPORTING', '報告', '監査報告段階', 3, true),
    ('AUDIT_STAGE', 'FOLLOW_UP', 'フォローアップ', '監査フォローアップ段階', 4, true),
    ('RISK_LEVEL', 'HIGH', '高', '高リスク', 1, true),
    ('RISK_LEVEL', 'MEDIUM', '中', '中リスク', 2, true),
    ('RISK_LEVEL', 'LOW', '低', '低リスク', 3, true),
    ('STATUS', 'ACTIVE', '有効', '有効なステータス', 1, true),
    ('STATUS', 'INACTIVE', '無効', '無効なステータス', 2, true),
    ('STATUS', 'DRAFT', '下書き', '下書きステータス', 3, true); 