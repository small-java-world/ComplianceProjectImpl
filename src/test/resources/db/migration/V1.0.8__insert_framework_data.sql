-- ComplianceFrameworkテーブルのマスターデータ
INSERT INTO ComplianceFramework (
    framework_code,
    name,
    description
) VALUES
('ISO27001_2022_TEST', 'ISO/IEC 27001:2022 (Test)', 'Information Security Management System (2022年版) - テスト用'),
('PMARK_TEST', 'プライバシーマーク (Test)', '個人情報保護マネジメントシステム - JIS Q 15001:2017 - テスト用'),
('PCI_DSS_TEST', 'PCI DSS 4.0 (Test)', 'Payment Card Industry Data Security Standard - テスト用'),
('ISO9001_TEST', 'ISO 9001:2015 (Test)', 'Quality Management System - テスト用'),
('ISO14001_TEST', 'ISO 14001:2015 (Test)', 'Environmental Management System - テスト用'),
('SOC2_TEST', 'SOC 2 Type2 (Test)', 'Service Organization Control 2 - テスト用'),
('NIST_CSF_TEST', 'NIST Cybersecurity Framework 1.1 (Test)', 'NISTサイバーセキュリティフレームワーク - テスト用');

-- ISO27001:2022の要求事項データの挿入
INSERT INTO Requirement (requirement_id, framework_code, title, description)
VALUES
('REQ-ISO27001-A5.1.1-TEST', 'ISO27001_2022_TEST', '情報セキュリティポリシー', '組織の目的に対して適切な情報セキュリティポリシーを定義し、文書化すること'),
('REQ-ISO27001-A6.2.2-TEST', 'ISO27001_2022_TEST', 'テレワークのセキュリティ', 'テレワーク環境における情報のアクセス、処理、保存を保護するためのポリシーと対策を実装すること'),
('REQ-ISO27001-A7.2.2-TEST', 'ISO27001_2022_TEST', '情報セキュリティ意識向上', '組織の全ての要員が、情報セキュリティに関する意識向上のための適切な教育・訓練を受けること'),
('REQ-ISO27001-A7.3.1-TEST', 'ISO27001_2022_TEST', '雇用の終了または変更', '雇用の終了または変更時における情報セキュリティ上の責任と義務を定義し、伝達すること'),
('REQ-ISO27001-A8.2.3-TEST', 'ISO27001_2022_TEST', '資産の取扱い', '組織の資産の取扱いに関する手順を策定し、実施すること'),
('REQ-ISO27001-A8.3.1-TEST', 'ISO27001_2022_TEST', '資産の管理', '情報及び情報処理施設に関連する資産を特定し、管理すること'),
('REQ-ISO27001-A9.2.1-TEST', 'ISO27001_2022_TEST', 'アクセス制御方針', '業務及び情報セキュリティの要求事項に基づいてアクセス制御方針を確立し、文書化し、レビューすること'),
('REQ-ISO27001-A12.1.1-TEST', 'ISO27001_2022_TEST', '運用の手順', '運用手順を文書化し、維持し、利用可能にすること'),
('REQ-ISO27001-A12.2.1-TEST', 'ISO27001_2022_TEST', 'マルウェアからの保護', 'マルウェアからの保護のための検出、予防及び回復のための対策を実施すること'),
('REQ-ISO27001-A12.4.1-TEST', 'ISO27001_2022_TEST', 'イベントログ取得', 'ユーザ活動、例外、障害及び情報セキュリティ事象を記録するイベントログを取得し、保持し、定期的にレビューすること');

-- M_CODEテーブルのテストデータ
INSERT INTO M_CODE (
    code_category,
    code,
    code_division,
    code_name,
    code_short_name,
    extension1,
    extension2,
    extension3,
    extension4,
    extension5
) VALUES
('COMPLIANCE_FW_TYPE', 'ISO27001_2022', 'ISO27001', 'ISO27001:2022', 'ISO27001:2022', '2022', NULL, NULL, NULL, NULL),
('COMPLIANCE_FW_TYPE', 'ISO27001_2013', 'ISO27001', 'ISO27001:2013', 'ISO27001:2013', '2013', NULL, NULL, NULL, NULL); 