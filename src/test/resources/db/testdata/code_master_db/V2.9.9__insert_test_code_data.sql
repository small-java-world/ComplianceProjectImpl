-- テストコードデータの挿入
INSERT INTO M_CODE (
    code_category,
    code,
    code_division,
    name,
    code_short_name,
    description,
    display_order,
    is_active,
    extension1,
    extension2,
    extension3,
    extension4,
    extension5,
    extension6,
    extension7,
    extension8,
    extension9,
    extension10,
    extension11,
    extension12,
    extension13,
    extension14,
    extension15,
    created_at,
    updated_at
) VALUES
-- 部門種別コード
('DEPARTMENT_TYPE', 'SALES', 'DEPARTMENT', '営業部門', '営業', '営業関連の部門', 1, true,
 NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('DEPARTMENT_TYPE', 'IT', 'DEPARTMENT', '情報システム部門', 'IT', 'IT関連の部門', 2, true,
 NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('DEPARTMENT_TYPE', 'HR', 'DEPARTMENT', '人事部門', '人事', '人事関連の部門', 3, true,
 NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- 権限種別コード
('PERMISSION_TYPE', 'READ', 'PERMISSION', '読み取り権限', '読取', '読み取り専用の権限', 1, true,
 NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PERMISSION_TYPE', 'WRITE', 'PERMISSION', '書き込み権限', '書込', '書き込み可能な権限', 2, true,
 NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PERMISSION_TYPE', 'ADMIN', 'PERMISSION', '管理者権限', '管理', '管理者向けの権限', 3, true,
 NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 CURRENT_TIMESTAMP, CURRENT_TIMESTAMP); 