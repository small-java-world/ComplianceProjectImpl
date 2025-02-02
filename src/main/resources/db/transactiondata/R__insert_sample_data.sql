-- ------------------------------------------------------------
-- サンプルデータ投入
-- ------------------------------------------------------------

-- 組織データ
INSERT INTO Organization (
    organization_id,
    name,
    organization_type_code,
    address,
    contact_info,
    created_at,
    updated_at
) VALUES
('ORG001', 'サンプル株式会社', 'INTERNAL_DEPARTMENT', '東京都千代田区丸の内1-1-1', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('ORG002', '監査法人A', 'CERTIFICATION_BODY', '東京都千代田区丸の内1-1-2', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('ORG003', '規制当局X', 'REGULATORY_AUTHORITY', '東京都千代田区霞が関1-1-1', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 部署データ
INSERT INTO Department (
    department_id, department_name, organization_id
)
VALUES
('DEP001','企画部','ORG001'),
('DEP002','情報セキュリティ室','ORG001'),
('DEP003','品質保証部','ORG001'),
('DEP004','開発第1部','ORG001'),
('DEP005','開発第2部','ORG001'),
('DEP006','開発第3部','ORG001'),
('DEP007','コンサル第1部','ORG001'),
('DEP008','コンサル第2部','ORG001'),
('DEP009','営業第1部','ORG001'),
('DEP010','営業第2部','ORG001'),
('DEP011','営業第3部','ORG001'),
('DEP012','管理部','ORG001'),
('DEP013','人事部','ORG001'),
('DEP014','法務部','ORG001'),
('DEP015','経理部','ORG001'),
('DEP016','ITインフラ部','ORG001'),
('DEP017','RPA・AI推進室','ORG001'),
('DEP018','IoTソリューション部','ORG001'),
('DEP019','DX推進室','ORG001'),
('DEP020','BCM・リスク管理部','ORG001');

-- ユーザーデータ
INSERT INTO User (
  user_id, organization_id, department_id, name, email, role_code, password_hash
)
VALUES
('USR001','ORG001','DEP001','山本(A)','yamamoto@abc-solution.jp','PROJECT_MANAGER','hashed_pw_yamamoto'),
('USR002','ORG001','DEP001','佐藤(B)','sato@abc-solution.jp','TOP_MANAGEMENT','hashed_pw_sato'),
('USR003','ORG001','DEP002','鈴木(C)','suzuki@abc-solution.jp','CISO','hashed_pw_suzuki'),
('USR004','ORG001','DEP002','田中(D)','tanaka@abc-solution.jp','IT_ADMIN','hashed_pw_tanaka'),
('USR005','ORG001','DEP004','渡辺(E)','watanabe@abc-solution.jp','BUSINESS_OWNER','hashed_pw_watanabe'),
('USR006','ORG001','DEP002','遠藤(F)','endo@abc-solution.jp','INTERNAL_AUDIT_LEADER','hashed_pw_endo'),
('USR007','ORG001','DEP003','小川(G)','ogawa@consultant.com','EXTERNAL_AUDIT_COORDINATOR','hashed_pw_ogawa');

-- 建物データ
INSERT INTO Building (
    building_id,
    building_name,
    address,
    description,
    created_at,
    updated_at
) VALUES
('B001', '本社ビル', '東京都千代田区丸の内1-1-1', '本社オフィス', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('B002', '第2ビル', '東京都千代田区丸の内1-1-2', '開発拠点', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('B003', 'データセンター1', '東京都江東区豊洲5-1-1', 'メインデータセンター', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- フロアデータ
INSERT INTO Floor (
    floor_id,
    building_id,
    floor_number,
    description,
    created_at,
    updated_at
) VALUES
('F001', 'B001', '1', '受付・会議室フロア', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('F002', 'B001', '2', 'オフィスフロア', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('F003', 'B001', '3', '経営層フロア', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('F004', 'B003', '1', 'サーバールームフロア', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('F005', 'B003', '2', '運用管理フロア', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 部屋データ
INSERT INTO Room (
    room_id,
    floor_id,
    room_name,
    room_type_code,
    description,
    created_at,
    updated_at
) VALUES
('R001', 'F001', '受付', 'OFFICE', '1階受付', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('R002', 'F001', '会議室101', 'MEETING_ROOM', '1階会議室', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('R003', 'F002', 'オフィス201', 'OFFICE', '2階オフィス', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('R004', 'F004', 'サーバールーム1', 'SERVER_ROOM', 'メインサーバールーム', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('R005', 'F004', 'サーバールーム2', 'SERVER_ROOM', 'バックアップサーバールーム', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 追加の建物データ
INSERT INTO Building (
    building_id,
    building_name,
    address,
    description,
    created_at,
    updated_at
) VALUES
('B004', '研究開発センター', '神奈川県川崎市幸区堀川町1-1-1', 'R&D施設', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('B005', '大阪支社', '大阪府大阪市中央区本町1-1-1', '関西拠点', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('B006', '福岡支社', '福岡県福岡市博多区博多駅前1-1-1', '九州拠点', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 追加のフロアデータ
INSERT INTO Floor (
    floor_id,
    building_id,
    floor_number,
    description,
    created_at,
    updated_at
) VALUES
('F006', 'B004', '1', '研究室フロア', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('F007', 'B004', '2', '実験室フロア', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('F008', 'B005', '1', '大阪オフィスフロア', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('F009', 'B006', '1', '福岡オフィスフロア', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 追加の部屋データ
INSERT INTO Room (
    room_id,
    floor_id,
    room_name,
    room_type_code,
    description,
    created_at,
    updated_at
) VALUES
('R006', 'F006', '研究室A', 'LAB', '基礎研究室', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('R007', 'F007', '実験室1', 'LAB', '化学実験室', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('R008', 'F008', '大阪会議室', 'MEETING_ROOM', '大阪支社会議室', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('R009', 'F009', '福岡オフィス', 'OFFICE', '福岡支社オフィス', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('R010', 'F006', '研究室B', 'LAB', '応用研究室', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP); 