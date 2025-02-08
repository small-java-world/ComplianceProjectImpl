-- 教育プログラム
INSERT INTO TrainingProgram (training_program_id, title, description, program_type_code, valid_months, created_at, updated_at)
VALUES
-- 情報セキュリティ教育
(1, '情報セキュリティ基礎', '情報セキュリティの基礎知識', 'SECURITY', 12, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, '情報セキュリティインシデント対応', 'インシデント対応の基本と実践', 'SECURITY', 12, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'セキュアコーディング', 'セキュアなプログラミング手法', 'SECURITY', 12, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- コンプライアンス教育
(4, 'コンプライアンス基礎', 'コンプライアンスの基礎知識', 'COMPLIANCE', 12, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, '個人情報保護', '個人情報保護法と実務対応', 'PRIVACY', 12, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 'ISO27001基礎', 'ISO27001規格の概要理解', 'COMPLIANCE', 12, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(7, 'PCI DSS基礎', 'PCI DSS要件の概要理解', 'COMPLIANCE', 12, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- 品質管理教育
(8, '品質管理基礎', '品質管理の基礎知識', 'QUALITY', 12, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(9, '内部監査員養成', '内部監査の基礎と実践', 'QUALITY', 12, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(10, '是正処置の基礎', '是正処置の基本と実践', 'QUALITY', 12, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 教育記録
INSERT INTO TrainingRecord (training_record_id, training_program_id, user_id, completion_date, status_code, score, notes, created_at, updated_at)
VALUES
-- 情報セキュリティ教育
(1, 1, 1, '2024-03-31', 'COMPLETED', 90, '合格', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 2, 1, '2024-03-31', 'COMPLETED', 85, '合格', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 3, 1, '2024-03-31', 'COMPLETED', 88, '合格', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- コンプライアンス教育
(4, 4, 1, '2024-03-31', 'COMPLETED', 92, '合格', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 5, 1, '2024-03-31', 'COMPLETED', 87, '合格', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 6, 1, '2024-03-31', 'COMPLETED', 85, '合格', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(7, 7, 1, '2024-03-31', 'COMPLETED', 83, '合格', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- 品質管理教育
(8, 8, 1, '2024-03-31', 'COMPLETED', 88, '合格', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(9, 9, 1, '2024-03-31', 'COMPLETED', 90, '合格', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(10, 10, 1, '2024-03-31', 'COMPLETED', 86, '合格', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP); 