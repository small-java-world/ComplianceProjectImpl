-- 監査ステージ
INSERT INTO M_CODE (code_category, code, code_division, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('AUDIT_STAGE', 'STAGE_INTERNAL', 'INTERNAL', '内部監査', 'Internal Audit', '1', '0', '1', NULL, NULL),
('AUDIT_STAGE', 'STAGE1_DOCUMENT', 'ISO27001', '文書審査', 'Document Review', '2', '1', '2', NULL, NULL),
('AUDIT_STAGE', 'STAGE2_ONSITE', 'ISO27001', '実地審査', 'Onsite Audit', '3', '2', '3', NULL, NULL),
('AUDIT_STAGE', 'SURVEILLANCE1', 'ISO27001', 'サーベイランス1', 'Surveillance 1', '4', '3', '4', NULL, NULL),
('AUDIT_STAGE', 'RENEWAL', 'ISO27001', '更新審査', 'Renewal Audit', '5', '4', '5', NULL, NULL);

-- ロール
INSERT INTO M_CODE (code_category, code, code_division, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('ROLE', 'ADMIN', 'SYSTEM', '管理者', 'Admin', 'ALL', NULL, 'true', 'true', 'true'),
('ROLE', 'AUDITOR', 'AUDIT', '監査員', 'Auditor', 'AUDIT', NULL, 'true', 'false', 'false'),
('ROLE', 'USER', 'SYSTEM', '一般ユーザー', 'User', 'LIMITED', NULL, 'false', 'false', 'false');

-- コンプライアンスフレームワークタイプ
INSERT INTO M_CODE (code_category, code, code_division, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('COMPLIANCE_FW_TYPE', 'ISO27001_2022', 'ISO27001', 'ISO27001:2022', 'ISO27001:2022', '2022', NULL, NULL, NULL, NULL),
('COMPLIANCE_FW_TYPE', 'ISO27001_2013', 'ISO27001', 'ISO27001:2013', 'ISO27001:2013', '2013', NULL, NULL, NULL, NULL),
('COMPLIANCE_FW_TYPE', 'PCI_DSS_4', 'PCI_DSS', 'PCI DSS v4.0', 'PCI DSS v4.0', '4.0', NULL, NULL, NULL, NULL),
('COMPLIANCE_FW_TYPE', 'PCI_DSS_3_2_1', 'PCI_DSS', 'PCI DSS v3.2.1', 'PCI DSS v3.2.1', '3.2.1', NULL, NULL, NULL, NULL);

-- インシデントタイプ
INSERT INTO M_CODE (code_category, code, code_division, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('INCIDENT_TYPE', 'SYSTEM_OUTAGE', 'SYSTEM', 'システム障害', 'System Outage', 'HIGH', NULL, NULL, NULL, NULL),
('INCIDENT_TYPE', 'SECURITY_BREACH', 'SECURITY', 'セキュリティ侵害', 'Security Breach', 'HIGH', NULL, NULL, NULL, NULL),
('INCIDENT_TYPE', 'DATA_LEAK', 'SECURITY', '情報漏洩', 'Data Leak', 'HIGH', NULL, NULL, NULL, NULL),
('INCIDENT_TYPE', 'MALWARE', 'SECURITY', 'マルウェア', 'Malware', 'HIGH', NULL, NULL, NULL, NULL),
('INCIDENT_TYPE', 'UNAUTHORIZED_ACCESS', 'SECURITY', '不正アクセス', 'Unauthorized Access', 'HIGH', NULL, NULL, NULL, NULL);

-- リスクレベル
INSERT INTO M_CODE (code_category, code, code_division, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('RISK_LEVEL', 'CRITICAL', 'RISK', '重大', 'Critical', '4', NULL, NULL, NULL, NULL),
('RISK_LEVEL', 'HIGH', 'RISK', '高', 'High', '3', NULL, NULL, NULL, NULL),
('RISK_LEVEL', 'MEDIUM', 'RISK', '中', 'Medium', '2', NULL, NULL, NULL, NULL),
('RISK_LEVEL', 'LOW', 'RISK', '低', 'Low', '1', NULL, NULL, NULL, NULL);

-- リスク対応タイプ
INSERT INTO M_CODE (code_category, code, code_division, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('RISK_TREATMENT_TYPE', 'MITIGATE', 'TREATMENT', '低減', 'Mitigate', '1', NULL, NULL, NULL, NULL),
('RISK_TREATMENT_TYPE', 'TRANSFER', 'TREATMENT', '移転', 'Transfer', '2', NULL, NULL, NULL, NULL),
('RISK_TREATMENT_TYPE', 'AVOID', 'TREATMENT', '回避', 'Avoid', '3', NULL, NULL, NULL, NULL),
('RISK_TREATMENT_TYPE', 'ACCEPT', 'TREATMENT', '受容', 'Accept', '4', NULL, NULL, NULL, NULL);

-- ステータス
INSERT INTO M_CODE (code_category, code, code_division, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('STATUS', 'DRAFT', 'COMMON', '下書き', 'Draft', '1', NULL, NULL, NULL, NULL),
('STATUS', 'IN_REVIEW', 'COMMON', 'レビュー中', 'In Review', '2', NULL, NULL, NULL, NULL),
('STATUS', 'APPROVED', 'COMMON', '承認済み', 'Approved', '3', NULL, NULL, NULL, NULL),
('STATUS', 'REJECTED', 'COMMON', '却下', 'Rejected', '4', NULL, NULL, NULL, NULL),
('STATUS', 'IN_PROGRESS', 'COMMON', '進行中', 'In Progress', '5', NULL, NULL, NULL, NULL),
('STATUS', 'COMPLETED', 'COMMON', '完了', 'Completed', '6', NULL, NULL, NULL, NULL),
('STATUS', 'CANCELLED', 'COMMON', 'キャンセル', 'Cancelled', '7', NULL, NULL, NULL, NULL);

-- 文書カテゴリ
INSERT INTO M_CODE (code_category, code, code_division, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('DOCUMENT_CATEGORY', 'POLICY', 'DOCUMENT', 'ポリシー', 'Policy', '1', NULL, NULL, NULL, NULL),
('DOCUMENT_CATEGORY', 'STANDARD', 'DOCUMENT', '標準', 'Standard', '2', NULL, NULL, NULL, NULL),
('DOCUMENT_CATEGORY', 'PROCEDURE', 'DOCUMENT', '手順', 'Procedure', '3', NULL, NULL, NULL, NULL),
('DOCUMENT_CATEGORY', 'GUIDELINE', 'DOCUMENT', 'ガイドライン', 'Guideline', '4', NULL, NULL, NULL, NULL),
('DOCUMENT_CATEGORY', 'FORM', 'DOCUMENT', '様式', 'Form', '5', NULL, NULL, NULL, NULL),
('DOCUMENT_CATEGORY', 'RECORD', 'DOCUMENT', '記録', 'Record', '6', NULL, NULL, NULL, NULL);

-- 資産タイプ
INSERT INTO M_CODE (code_category, code, code_division, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('ASSET_TYPE', 'SERVER', 'HARDWARE', 'サーバー', 'Server', '1', NULL, NULL, NULL, NULL),
('ASSET_TYPE', 'NETWORK', 'HARDWARE', 'ネットワーク機器', 'Network Equipment', '2', NULL, NULL, NULL, NULL),
('ASSET_TYPE', 'PC', 'HARDWARE', 'PC', 'PC', '3', NULL, NULL, NULL, NULL),
('ASSET_TYPE', 'MOBILE', 'HARDWARE', 'モバイル機器', 'Mobile Device', '4', NULL, NULL, NULL, NULL),
('ASSET_TYPE', 'SOFTWARE', 'SOFTWARE', 'ソフトウェア', 'Software', '5', NULL, NULL, NULL, NULL),
('ASSET_TYPE', 'DATABASE', 'SOFTWARE', 'データベース', 'Database', '6', NULL, NULL, NULL, NULL);

-- 資産分類
INSERT INTO M_CODE (code_category, code, code_division, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('ASSET_CLASSIFICATION', 'CONFIDENTIAL', 'SECURITY', '機密', 'Confidential', '3', NULL, NULL, NULL, NULL),
('ASSET_CLASSIFICATION', 'INTERNAL', 'SECURITY', '社内', 'Internal', '2', NULL, NULL, NULL, NULL),
('ASSET_CLASSIFICATION', 'PUBLIC', 'SECURITY', '公開', 'Public', '1', NULL, NULL, NULL, NULL);

-- 教育プログラムタイプ
INSERT INTO M_CODE (code_category, code, code_division, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('TRAINING_PROGRAM_TYPE', 'SECURITY', 'TRAINING', '情報セキュリティ', 'Security', '1', NULL, NULL, NULL, NULL),
('TRAINING_PROGRAM_TYPE', 'COMPLIANCE', 'TRAINING', 'コンプライアンス', 'Compliance', '2', NULL, NULL, NULL, NULL),
('TRAINING_PROGRAM_TYPE', 'PRIVACY', 'TRAINING', 'プライバシー', 'Privacy', '3', NULL, NULL, NULL, NULL),
('TRAINING_PROGRAM_TYPE', 'QUALITY', 'TRAINING', '品質管理', 'Quality', '4', NULL, NULL, NULL, NULL); 