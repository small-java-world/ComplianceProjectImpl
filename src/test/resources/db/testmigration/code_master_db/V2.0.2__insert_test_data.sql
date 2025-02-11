-- Insert test data for M_CODE table
INSERT INTO M_CODE (code_category, code, code_name, description, display_order, is_active, code_division)
VALUES
    ('TEST_CATEGORY', 'TEST_CODE_1', 'テストコード1', 'テスト用コード1', 1, true, 'TEST_CATEGORY_DIVISION1'),
    ('TEST_CATEGORY', 'TEST_CODE_2', 'テストコード2', 'テスト用コード2', 2, true, 'TEST_CATEGORY_DIVISION1'),
    ('TEST_CATEGORY', 'TEST_CODE_3', 'テストコード3', 'テスト用コード3', 3, true, 'TEST_CATEGORY_DIVISION2'),
    ('TEST_STATUS', 'TEST_STATUS_1', 'テストステータス1', 'テスト用ステータス1', 1, true, 'TEST_STATUS_DIVISION1'),
    ('TEST_STATUS', 'TEST_STATUS_2', 'テストステータス2', 'テスト用ステータス2', 2, true, 'TEST_STATUS_DIVISION2'),
    ('TEST_STATUS', 'TEST_STATUS_3', 'テストステータス3', 'テスト用ステータス3', 3, true, 'TEST_STATUS_DIVISION3'); 