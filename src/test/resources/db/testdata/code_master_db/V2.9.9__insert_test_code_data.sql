-- テストコードデータの挿入
INSERT INTO M_CODE (
    code_category,
    code,
    code_division,
    code_name,
    code_short_name,
    extension1,
    extension2,
    display_order,
    is_active,
    description
) VALUES
-- 部門種別コード
('DEPARTMENT_TYPE', 'SALES', 'DEPARTMENT', '営業部門', '営業', NULL, NULL, 1, true, '営業関連の部門'),
('DEPARTMENT_TYPE', 'IT', 'DEPARTMENT', '情報システム部門', 'IT', NULL, NULL, 2, true, 'IT関連の部門'),
('DEPARTMENT_TYPE', 'HR', 'DEPARTMENT', '人事部門', '人事', NULL, NULL, 3, true, '人事関連の部門'),

-- 権限種別コード
('PERMISSION_TYPE', 'READ', 'PERMISSION', '読み取り権限', '読取', NULL, NULL, 1, true, '読み取り専用の権限'),
('PERMISSION_TYPE', 'WRITE', 'PERMISSION', '書き込み権限', '書込', NULL, NULL, 2, true, '書き込み可能な権限'),
('PERMISSION_TYPE', 'ADMIN', 'PERMISSION', '管理者権限', '管理', NULL, NULL, 3, true, '管理者向けの権限'); 