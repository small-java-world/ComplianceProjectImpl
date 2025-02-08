-- 文書
INSERT INTO Document (document_id, title, category_code, department_id, created_at, updated_at)
VALUES
-- 情報セキュリティ文書
(1, '情報セキュリティ基本方針', 'POLICY', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, '情報セキュリティ管理標準', 'STANDARD', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'アクセス制御手順', 'PROCEDURE', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 'インシデント対応手順', 'PROCEDURE', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 'リスクアセスメントガイドライン', 'GUIDELINE', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- コンプライアンス文書
(6, 'コンプライアンス基本方針', 'POLICY', 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(7, '法令遵守マニュアル', 'STANDARD', 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(8, '内部監査手順', 'PROCEDURE', 6, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(9, '是正処置手順', 'PROCEDURE', 6, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(10, '文書管理規程', 'STANDARD', 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 文書バージョン
INSERT INTO DocumentVersion (document_version_id, document_id, version_number, status_code, content_url, created_at, updated_at)
VALUES
(1, 1, '1.0', 'APPROVED', '/documents/1/1.0/content.pdf', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 2, '1.0', 'APPROVED', '/documents/2/1.0/content.pdf', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 3, '1.0', 'APPROVED', '/documents/3/1.0/content.pdf', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 4, '1.0', 'APPROVED', '/documents/4/1.0/content.pdf', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 5, '1.0', 'APPROVED', '/documents/5/1.0/content.pdf', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 6, '1.0', 'APPROVED', '/documents/6/1.0/content.pdf', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(7, 7, '1.0', 'APPROVED', '/documents/7/1.0/content.pdf', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(8, 8, '1.0', 'APPROVED', '/documents/8/1.0/content.pdf', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(9, 9, '1.0', 'APPROVED', '/documents/9/1.0/content.pdf', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(10, 10, '1.0', 'APPROVED', '/documents/10/1.0/content.pdf', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 承認ワークフロー
INSERT INTO ApprovalWorkflow (workflow_id, document_version_id, approver_id, status_code, comment, approved_at, created_at, updated_at)
VALUES
(1, 1, 1, 'APPROVED', '承認済み', '2024-03-31', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 2, 1, 'APPROVED', '承認済み', '2024-03-31', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 3, 1, 'APPROVED', '承認済み', '2024-03-31', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 4, 1, 'APPROVED', '承認済み', '2024-03-31', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 5, 1, 'APPROVED', '承認済み', '2024-03-31', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 6, 1, 'APPROVED', '承認済み', '2024-03-31', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(7, 7, 1, 'APPROVED', '承認済み', '2024-03-31', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(8, 8, 1, 'APPROVED', '承認済み', '2024-03-31', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(9, 9, 1, 'APPROVED', '承認済み', '2024-03-31', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(10, 10, 1, 'APPROVED', '承認済み', '2024-03-31', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP); 