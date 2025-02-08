-- AssetAttributeデータの投入
INSERT INTO AssetAttribute (
    asset_attribute_id,
    asset_id,
    confidentiality_level,
    integrity_level,
    availability_level,
    contains_personal_data
)
VALUES
-- 企画用ファイルサーバ (AST001)
('AA001','AST001',2,2,2,true),

-- ノートPC(企画部:3台+AI) (AST002)
('AA002','AST002',2,2,2,true),

-- SNSマーケティングツール (AST003)
('AA003','AST003',1,1,2,false),

-- 共有ホワイトボード(デジタルサイネージ) (AST004)
('AA004','AST004',1,1,1,false),

-- セキュリティ監視サーバ(SIEM) (AST005)
('AA005','AST005',2,2,2,false),

-- ノートPC(セキュリティ室:3台+AI) (AST006)
('AA006','AST006',2,2,2,true),

-- ISMS管理台帳(物理・電子) (AST007)
('AA007','AST007',2,2,1,true),

-- 不正アクセス検知(IDS/IPS) (AST008)
('AA008','AST008',2,2,2,false),

-- 品質マニュアル保管システム (AST009)
('AA009','AST009',2,2,2,false),

-- ノートPC(品質部:3台+AI) (AST010)
('AA010','AST010',2,2,2,true),

-- その他の資産
('AA011','AST011',2,2,2,false),
('AA012','AST012',2,2,2,false),
('AA013','AST013',2,2,2,false),
('AA014','AST014',2,2,2,true),
('AA015','AST015',2,2,2,false),
('AA016','AST016',2,2,2,false),

-- 外部委託先管理台帳
('AA084','AST084',2,2,1,true); 