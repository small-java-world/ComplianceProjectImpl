-- コンプライアンスフレームワーク
INSERT INTO ComplianceFramework (framework_code, name, description, created_at, updated_at)
VALUES
('ISO27001_2022', 'ISO/IEC 27001:2022', 'ISO/IEC 27001:2022規格', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PCI_DSS_4', 'PCI DSS v4.0', 'PCI DSS v4.0規格', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 要求事項
INSERT INTO Requirement (requirement_id, framework_code, title, description, created_at, updated_at)
VALUES
-- ISO27001:2022
('A.5', 'ISO27001_2022', '組織のコンテキスト', '組織のコンテキストに関する要求事項', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('A.5.1', 'ISO27001_2022', '情報セキュリティのための組織の状況の理解', '組織の状況の理解に関する要求事項', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('A.5.2', 'ISO27001_2022', '情報セキュリティのための利害関係者のニーズ及び期待の理解', '利害関係者のニーズと期待の理解に関する要求事項', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('A.5.3', 'ISO27001_2022', '情報セキュリティマネジメントシステムの適用範囲の決定', 'ISMSの適用範囲の決定に関する要求事項', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('A.5.4', 'ISO27001_2022', '情報セキュリティマネジメントシステム', 'ISMSの確立・実施・維持・継続的改善に関する要求事項', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

('A.6', 'ISO27001_2022', 'リーダーシップ', 'リーダーシップに関する要求事項', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('A.6.1', 'ISO27001_2022', 'リーダーシップ及びコミットメント', 'トップマネジメントのリーダーシップとコミットメントに関する要求事項', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('A.6.2', 'ISO27001_2022', '情報セキュリティポリシー', '情報セキュリティポリシーの確立に関する要求事項', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('A.6.3', 'ISO27001_2022', '組織の役割、責任及び権限', '組織の役割・責任・権限の割り当てに関する要求事項', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- PCI DSS v4.0
('1', 'PCI_DSS_4', 'セキュアなネットワークとシステムの構築と維持', 'セキュアなネットワークとシステムの要求事項', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('1.1', 'PCI_DSS_4', 'ネットワークセキュリティコントロール', 'ネットワークセキュリティコントロールの実装に関する要求事項', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('1.2', 'PCI_DSS_4', 'ネットワーク接続の制御', 'ネットワーク接続の制御に関する要求事項', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('1.3', 'PCI_DSS_4', 'ネットワークアクセスの制御', 'ネットワークアクセスの制御に関する要求事項', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('1.4', 'PCI_DSS_4', 'カード会員データ環境の保護', 'カード会員データ環境の保護に関する要求事項', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('1.5', 'PCI_DSS_4', 'セグメンテーション', 'ネットワークセグメンテーションに関する要求事項', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 実装タスク
INSERT INTO ImplementationTask (task_id, requirement_id, assignee_id, title, description, status_code, due_date, created_at, updated_at)
VALUES
-- ISO27001:2022
('TASK001', 'A.5.1', 'USER001', '組織の外部・内部の課題の特定', '組織の目的に関連する外部・内部の課題を特定する', 'IN_PROGRESS', '2024-04-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('TASK002', 'A.5.2', 'USER002', '利害関係者の特定とニーズの把握', '利害関係者を特定し、その要求事項を文書化する', 'IN_PROGRESS', '2024-04-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('TASK003', 'A.5.3', 'USER003', 'ISMSの適用範囲の文書化', 'ISMSの適用範囲を決定し、文書化する', 'IN_PROGRESS', '2024-04-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('TASK004', 'A.6.1', 'USER004', '情報セキュリティ方針の策定', 'トップマネジメントによる情報セキュリティ方針の策定', 'IN_PROGRESS', '2024-04-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('TASK005', 'A.6.3', 'USER005', 'ISMSの役割と責任の定義', 'ISMSに関連する役割と責任を定義し、割り当てる', 'IN_PROGRESS', '2024-04-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- PCI DSS v4.0
('TASK006', '1.1', 'USER006', 'ファイアウォールの設定', 'ファイアウォールの設定基準の策定と実装', 'IN_PROGRESS', '2024-04-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('TASK007', '1.2', 'USER007', 'ネットワーク接続の管理', '承認されたネットワーク接続の文書化と管理', 'IN_PROGRESS', '2024-04-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('TASK008', '1.3', 'USER008', 'アクセス制御の実装', 'ネットワークアクセス制御の実装と管理', 'IN_PROGRESS', '2024-04-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('TASK009', '1.4', 'USER009', 'カード会員データの保護', 'カード会員データ環境の保護対策の実装', 'IN_PROGRESS', '2024-04-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('TASK010', '1.5', 'USER010', 'ネットワークセグメンテーション', 'ネットワークセグメンテーションの設計と実装', 'IN_PROGRESS', '2024-04-30', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- エビデンス
INSERT INTO Evidence (evidence_id, task_id, title, description, reference_url, file_path, created_at, updated_at)
VALUES
-- ISO27001:2022
('EV001', 'TASK001', '組織の状況分析書', '組織の外部・内部の課題を分析した文書', 'https://example.com/docs/context-analysis', '/documents/context-analysis.pdf', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('EV002', 'TASK002', '利害関係者分析書', '利害関係者とその要求事項を分析した文書', 'https://example.com/docs/stakeholder-analysis', '/documents/stakeholder-analysis.pdf', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('EV003', 'TASK003', 'ISMS適用範囲定義書', 'ISMSの適用範囲を定義した文書', 'https://example.com/docs/isms-scope', '/documents/isms-scope.pdf', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('EV004', 'TASK004', '情報セキュリティ基本方針', '組織の情報セキュリティ基本方針', 'https://example.com/docs/security-policy', '/documents/security-policy.pdf', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('EV005', 'TASK005', 'ISMS組織体制図', 'ISMSの役割・責任を定義した文書', 'https://example.com/docs/isms-organization', '/documents/isms-organization.pdf', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- PCI DSS v4.0
('EV006', 'TASK006', 'ファイアウォール設定基準書', 'ファイアウォールの設定基準を定めた文書', 'https://example.com/docs/firewall-config', '/documents/firewall-config.pdf', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('EV007', 'TASK007', 'ネットワーク接続管理台帳', '承認されたネットワーク接続の一覧', 'https://example.com/docs/network-connections', '/documents/network-connections.pdf', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('EV008', 'TASK008', 'アクセス制御ポリシー', 'ネットワークアクセス制御の方針を定めた文書', 'https://example.com/docs/access-control', '/documents/access-control.pdf', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('EV009', 'TASK009', 'カード会員データ保護基準', 'カード会員データの保護基準を定めた文書', 'https://example.com/docs/cardholder-data', '/documents/cardholder-data.pdf', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('EV010', 'TASK010', 'ネットワークセグメント設計書', 'ネットワークセグメンテーションの設計書', 'https://example.com/docs/network-segmentation', '/documents/network-segmentation.pdf', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP); 