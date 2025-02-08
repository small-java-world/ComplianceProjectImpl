-- コンプライアンスフレームワーク
INSERT INTO ComplianceFramework (framework_id, framework_type_code, framework_name, version, description, created_at, updated_at)
VALUES
(1, 'ISO27001_2022', 'ISO/IEC 27001:2022', '2022', 'ISO/IEC 27001:2022規格', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'PCI_DSS_4', 'PCI DSS', '4.0', 'PCI DSS v4.0規格', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 要求事項
INSERT INTO Requirement (requirement_id, framework_id, requirement_code, requirement_name, description, parent_requirement_id, created_at, updated_at)
VALUES
-- ISO27001:2022
(1, 1, 'A.5', '組織のコンテキスト', '組織のコンテキストに関する要求事項', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 1, 'A.5.1', '情報セキュリティのための組織の状況の理解', '組織の状況の理解に関する要求事項', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 1, 'A.5.2', '情報セキュリティのための利害関係者のニーズ及び期待の理解', '利害関係者のニーズと期待の理解に関する要求事項', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 1, 'A.5.3', '情報セキュリティマネジメントシステムの適用範囲の決定', 'ISMSの適用範囲の決定に関する要求事項', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 1, 'A.5.4', '情報セキュリティマネジメントシステム', 'ISMSの確立・実施・維持・継続的改善に関する要求事項', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

(6, 1, 'A.6', 'リーダーシップ', 'リーダーシップに関する要求事項', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(7, 1, 'A.6.1', 'リーダーシップ及びコミットメント', 'トップマネジメントのリーダーシップとコミットメントに関する要求事項', 6, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(8, 1, 'A.6.2', '情報セキュリティポリシー', '情報セキュリティポリシーの確立に関する要求事項', 6, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(9, 1, 'A.6.3', '組織の役割、責任及び権限', '組織の役割・責任・権限の割り当てに関する要求事項', 6, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- PCI DSS v4.0
(10, 2, '1', 'セキュアなネットワークとシステムの構築と維持', 'セキュアなネットワークとシステムの要求事項', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(11, 2, '1.1', 'ネットワークセキュリティコントロール', 'ネットワークセキュリティコントロールの実装に関する要求事項', 10, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(12, 2, '1.2', 'ネットワーク接続の制御', 'ネットワーク接続の制御に関する要求事項', 10, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(13, 2, '1.3', 'ネットワークアクセスの制御', 'ネットワークアクセスの制御に関する要求事項', 10, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(14, 2, '1.4', 'カード会員データ環境の保護', 'カード会員データ環境の保護に関する要求事項', 10, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(15, 2, '1.5', 'セグメンテーション', 'ネットワークセグメンテーションに関する要求事項', 10, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 実装タスク
INSERT INTO ImplementationTask (task_id, requirement_id, task_name, description, status_code, start_date, end_date, created_at, updated_at)
VALUES
-- ISO27001:2022
(1, 2, '組織の外部・内部の課題の特定', '組織の目的に関連する外部・内部の課題を特定する', 'IN_PROGRESS', '2024-04-01', '2024-04-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 3, '利害関係者の特定とニーズの把握', '利害関係者を特定し、その要求事項を文書化する', 'IN_PROGRESS', '2024-04-01', '2024-04-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 4, 'ISMSの適用範囲の文書化', 'ISMSの適用範囲を決定し、文書化する', 'IN_PROGRESS', '2024-04-01', '2024-04-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 7, '情報セキュリティ方針の策定', 'トップマネジメントによる情報セキュリティ方針の策定', 'IN_PROGRESS', '2024-04-01', '2024-04-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 9, 'ISMSの役割と責任の定義', 'ISMSに関連する役割と責任を定義し、割り当てる', 'IN_PROGRESS', '2024-04-01', '2024-04-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- PCI DSS v4.0
(6, 11, 'ファイアウォールの設定', 'ファイアウォールの設定基準の策定と実装', 'IN_PROGRESS', '2024-04-01', '2024-04-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(7, 12, 'ネットワーク接続の管理', '承認されたネットワーク接続の文書化と管理', 'IN_PROGRESS', '2024-04-01', '2024-04-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(8, 13, 'アクセス制御の実装', 'ネットワークアクセス制御の実装と管理', 'IN_PROGRESS', '2024-04-01', '2024-04-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(9, 14, 'カード会員データの保護', 'カード会員データ環境の保護対策の実装', 'IN_PROGRESS', '2024-04-01', '2024-04-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(10, 15, 'ネットワークセグメンテーション', 'ネットワークセグメンテーションの設計と実装', 'IN_PROGRESS', '2024-04-01', '2024-04-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- エビデンス
INSERT INTO Evidence (evidence_id, task_id, evidence_name, description, document_id, status_code, created_at, updated_at)
VALUES
-- ISO27001:2022
(1, 1, '組織の状況分析書', '組織の外部・内部の課題を分析した文書', 1, 'DRAFT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 2, '利害関係者分析書', '利害関係者とその要求事項を分析した文書', 2, 'DRAFT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 3, 'ISMS適用範囲定義書', 'ISMSの適用範囲を定義した文書', 3, 'DRAFT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 4, '情報セキュリティ基本方針', '組織の情報セキュリティ基本方針', 4, 'DRAFT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 5, 'ISMS組織体制図', 'ISMSの役割・責任を定義した文書', 5, 'DRAFT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- PCI DSS v4.0
(6, 6, 'ファイアウォール設定基準書', 'ファイアウォールの設定基準を定めた文書', 6, 'DRAFT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(7, 7, 'ネットワーク接続管理台帳', '承認されたネットワーク接続の一覧', 7, 'DRAFT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(8, 8, 'アクセス制御ポリシー', 'ネットワークアクセス制御の方針を定めた文書', 8, 'DRAFT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(9, 9, 'カード会員データ保護基準', 'カード会員データの保護基準を定めた文書', 9, 'DRAFT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(10, 10, 'ネットワークセグメント設計書', 'ネットワークセグメンテーションの設計書', 10, 'DRAFT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP); 