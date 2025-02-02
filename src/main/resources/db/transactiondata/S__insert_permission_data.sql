-- ------------------------------------------------------------
-- 権限詳細データ
-- ------------------------------------------------------------

-- PermissionDetail
INSERT INTO PermissionDetail (
    permission_detail_id,
    user_id,
    permission_type_code,
    target_resource_type,
    target_resource_id,
    created_at,
    updated_at
) VALUES
-- プロジェクトマネージャー（山本）の権限
('PD001', 'USR001', 'READ_WRITE', 'PROJECT', 'PRJ001', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PD002', 'USR001', 'READ_WRITE', 'DOCUMENT', 'DOC001', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- トップマネジメント（佐藤）の権限
('PD003', 'USR002', 'READ_WRITE', 'PROJECT', 'PRJ001', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PD004', 'USR002', 'APPROVE', 'DOCUMENT', 'DOC001', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- CISO（鈴木）の権限
('PD005', 'USR003', 'READ_WRITE', 'RISK', 'RSK001', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PD006', 'USR003', 'READ_WRITE', 'REQUIREMENT', 'REQ-ISO27001-A5.1.1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- IT管理者（田中）の権限
('PD007', 'USR004', 'READ_WRITE', 'ASSET', 'AST061', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PD008', 'USR004', 'READ_WRITE', 'ASSET', 'AST062', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- 事業部門長（渡辺）の権限
('PD009', 'USR005', 'READ', 'PROJECT', 'PRJ001', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('PD010', 'USR005', 'READ', 'DOCUMENT', 'DOC001', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- DepartmentScope
INSERT INTO DepartmentScope (
    department_scope_id,
    permission_detail_id,
    department_id,
    created_at,
    updated_at
) VALUES
-- プロジェクトマネージャー（山本）のスコープ
('DS001', 'PD001', 'DEP001', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('DS002', 'PD001', 'DEP002', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- トップマネジメント（佐藤）のスコープ
('DS003', 'PD003', 'DEP001', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('DS004', 'PD003', 'DEP002', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('DS005', 'PD003', 'DEP003', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- CISO（鈴木）のスコープ
('DS006', 'PD005', 'DEP002', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('DS007', 'PD005', 'DEP016', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- IT管理者（田中）のスコープ
('DS008', 'PD007', 'DEP016', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- 事業部門長（渡辺）のスコープ
('DS009', 'PD009', 'DEP004', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('DS010', 'PD009', 'DEP005', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('DS011', 'PD009', 'DEP006', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP); 