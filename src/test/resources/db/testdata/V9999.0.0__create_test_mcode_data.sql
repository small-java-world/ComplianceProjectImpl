SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;
SET character_set_client = utf8mb4;
SET character_set_connection = utf8mb4;
SET character_set_results = utf8mb4;

-- テスト用のM_CODEデータ
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
    extension5,
    extension6,
    extension7,
    extension8,
    extension9,
    extension10,
    created_at,
    updated_at
) VALUES
('ROLE', 'ADMIN', 'SYSTEM', '管理者', 'ADMIN', NULL, NULL, 'true', NULL, NULL, NULL, NULL, NULL, NULL, NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('ROLE', 'USER', 'SYSTEM', '一般ユーザー', 'USER', NULL, NULL, 'false', NULL, NULL, NULL, NULL, NULL, NULL, NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('COMPLIANCE_FW_TYPE', 'ISO27001_2022', 'ISO27001', 'ISO27001:2022', 'ISO27001:2022', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('COMPLIANCE_FW_TYPE', 'ISO27001_2013', 'ISO27001', 'ISO27001:2013', 'ISO27001:2013', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP); 