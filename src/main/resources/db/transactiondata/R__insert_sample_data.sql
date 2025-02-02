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
('B003', 'データセンター1', '東京都江東区豊洲5-1-1', 'メインデータセンター', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('B004', '研究開発センター', '神奈川県川崎市幸区堀川町1-1-1', 'R&D施設', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('B005', '大阪支社', '大阪府大阪市中央区本町1-1-1', '関西拠点', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('B006', '福岡支社', '福岡県福岡市博多区博多駅前1-1-1', '九州拠点', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

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
('F005', 'B003', '2', '運用管理フロア', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('F006', 'B004', '1', '研究室フロア', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('F007', 'B004', '2', '実験室フロア', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('F008', 'B005', '1', '大阪オフィスフロア', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('F009', 'B006', '1', '福岡オフィスフロア', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
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
('R005', 'F004', 'サーバールーム2', 'SERVER_ROOM', 'バックアップサーバールーム', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('R006', 'F006', '研究室A', 'LAB', '基礎研究室', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('R007', 'F007', '実験室1', 'LAB', '化学実験室', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('R008', 'F008', '大阪会議室', 'MEETING_ROOM', '大阪支社会議室', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('R009', 'F009', '福岡オフィス', 'OFFICE', '福岡支社オフィス', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('R010', 'F006', '研究室B', 'LAB', '応用研究室', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP); 


INSERT INTO ComplianceProject (
  project_id, organization_id, project_name, status_code, start_date
)
VALUES (
  'PRJ001','ORG001','ISMS新規取得プロジェクト','IN_PROGRESS','2025-01-01'
);

INSERT INTO ProjectScope (
  project_scope_id, project_id, scope_item_code
)
VALUES
('PSCP001','PRJ001','HQ_OFFICE'),
('PSCP002','PRJ001','DEV_DEPARTMENT'),
('PSCP003','PRJ001','CLOUD_ENV')
;

INSERT INTO ProjectFramework (
  project_framework_id, project_id, framework_code
)
VALUES (
  'PFW001','PRJ001','ISO27001_2022'
  -- 「ISO27001」を「ISO27001_2022」へ変更
);



INSERT INTO Asset (
    asset_id, project_id, name,
    asset_type_code, classification_code,
    description
)
VALUES
-- [DEP001] 企画部 (4資産)
('AST001','PRJ001','企画用ファイルサーバ','SERVER','CONFIDENTIAL','[DEP001] 企画資料・アイデア管理'),
('AST002','PRJ001','ノートPC(3台+生成AI)','PHYSICAL','CONFIDENTIAL','[DEP001] 企画部PC+AIツール'),
('AST003','PRJ001','SNSマーケティングツール','CLOUD_SERVICE','RESTRICTED','[DEP001] 企画部で運用'),
('AST004','PRJ001','共有ホワイトボード(デジタルサイネージ)','PHYSICAL','RESTRICTED','[DEP001] 会議室利用'),

-- [DEP002] 情報セキュリティ室
('AST005','PRJ001','セキュリティ監視サーバ(SIEM)','SERVER','CONFIDENTIAL','[DEP002] 不正アクセス検知'),
('AST006','PRJ001','ノートPC(3台+AI脅威分析支援)','PHYSICAL','CONFIDENTIAL','[DEP002] 情報セキュリティ室PC'),
('AST007','PRJ001','ISMS管理台帳(物理・電子)','PHYSICAL','CONFIDENTIAL','[DEP002] ISMS文書・リスト'),
('AST008','PRJ001','不正アクセス検知(IDS/IPS)','SERVER','CONFIDENTIAL','[DEP002] ネットワーク防御'),

-- [DEP003] 品質保証部
('AST009','PRJ001','品質マニュアル保管システム','SERVER','CONFIDENTIAL','[DEP003] ISO9001文書'),
('AST010','PRJ001','ノートPC(3台+AIコードレビュー支援)','PHYSICAL','CONFIDENTIAL','[DEP003] 品質部PC'),
('AST011','PRJ001','テスト自動化サーバ(CI/CD)','SERVER','CONFIDENTIAL','[DEP003] 不具合管理連携'),
('AST012','PRJ001','顧客クレーム受付フォーム','CLOUD_SERVICE','RESTRICTED','[DEP003] 品質保証部'),

-- [DEP004] 開発第1部
('AST013','PRJ001','Gitリポジトリ(プロジェクトA)','SERVER','CONFIDENTIAL','[DEP004] 開発プロジェクトA'),
('AST014','PRJ001','ノートPC(3台+AIコーディング補助)','PHYSICAL','CONFIDENTIAL','[DEP004] 開発1部PC'),
('AST015','PRJ001','Dockerコンテナ環境(本番ミラー)','SERVER','RESTRICTED','[DEP004] テスト・検証'),
('AST016','PRJ001','部門専用ファイル共有(ドキュメント)','CLOUD_SERVICE','RESTRICTED','[DEP004] 開発仕様書'),

-- [DEP005] 開発第2部
('AST017','PRJ001','Gitリポジトリ(プロジェクトB)','SERVER','CONFIDENTIAL','[DEP005] 開発プロジェクトB'),
('AST018','PRJ001','ノートPC(3台+AIコードレビュー)','PHYSICAL','CONFIDENTIAL','[DEP005] 開発2部PC'),
('AST019','PRJ001','テストサーバ(オンプレ)','SERVER','RESTRICTED','[DEP005] システム検証用'),
('AST020','PRJ001','コンテナオーケストレーション(K8s)','SERVER','RESTRICTED','[DEP005] 開発基盤'),

-- [DEP006] 開発第3部
('AST021','PRJ001','Gitリポジトリ(プロジェクトC)','SERVER','CONFIDENTIAL','[DEP006] 開発プロジェクトC'),
('AST022','PRJ001','ノートPC(3台+AIドキュメント生成)','PHYSICAL','CONFIDENTIAL','[DEP006] 開発3部PC'),
('AST023','PRJ001','パフォーマンステスト用サーバ群','SERVER','RESTRICTED','[DEP006] 負荷試験'),
('AST024','PRJ001','コンパイル＆ビルド用CIサーバ','SERVER','CONFIDENTIAL','[DEP006] DevOps'),

-- [DEP007] コンサル第1部
('AST025','PRJ001','コンサル用クラウドストレージ(顧客資料)','CLOUD_SERVICE','CONFIDENTIAL','[DEP007] 案件資料管理'),
('AST026','PRJ001','ノートPC(3台+AIビジネス文書ツール)','PHYSICAL','CONFIDENTIAL','[DEP007] コンサル1部PC'),
('AST027','PRJ001','コンサル報告書管理システム','SERVER','CONFIDENTIAL','[DEP007] 成果物保管'),
('AST028','PRJ001','スマホ・タブレット端末(外出先用)','PHYSICAL','RESTRICTED','[DEP007] コンサル外訪'),

-- [DEP008] コンサル第2部
('AST029','PRJ001','コンサル案件管理ツール','CLOUD_SERVICE','CONFIDENTIAL','[DEP008] プロジェクト可視化'),
('AST030','PRJ001','ノートPC(3台+AI翻訳＆要約)','PHYSICAL','CONFIDENTIAL','[DEP008] コンサル2部PC'),
('AST031','PRJ001','Web会議ツール(録画保存)','CLOUD_SERVICE','RESTRICTED','[DEP008] オンラインMTG'),
('AST032','PRJ001','遠隔ホワイトボード(オンラインブレスト)','PHYSICAL','RESTRICTED','[DEP008] コンサル打合せ'),

-- [DEP009] 営業第1部
('AST033','PRJ001','営業契約書保管棚(紙)','PHYSICAL','CONFIDENTIAL','[DEP009] 鍵付きキャビネット'),
('AST034','PRJ001','ノートPC(3台+AI文章校正)','PHYSICAL','CONFIDENTIAL','[DEP009] 営業1部PC'),
('AST035','PRJ001','名刺管理アプリ','CLOUD_SERVICE','RESTRICTED','[DEP009] 名刺OCR'),
('AST036','PRJ001','SFA(営業支援システム)','CLOUD_SERVICE','CONFIDENTIAL','[DEP009] 商談進捗'),

-- [DEP010] 営業第2部
('AST037','PRJ001','営業顧客DB(地域/業種別)','CLOUD_SERVICE','CONFIDENTIAL','[DEP010] 顧客情報'),
('AST038','PRJ001','ノートPC(3台+AI営業トーク生成)','PHYSICAL','CONFIDENTIAL','[DEP010] 営業2部PC'),
('AST039','PRJ001','クラウドファイル共有(見積/提案書)','CLOUD_SERVICE','RESTRICTED','[DEP010] 営業資料'),
('AST040','PRJ001','誤送信防止ツール(端末連動)','PHYSICAL','RESTRICTED','[DEP010] メール対策'),

-- [DEP011] 営業第3部
('AST041','PRJ001','見積管理システム','CLOUD_SERVICE','CONFIDENTIAL','[DEP011] 営業3部'),
('AST042','PRJ001','ノートPC(3台+AI契約書レビュー)','PHYSICAL','CONFIDENTIAL','[DEP011] 営業3部PC'),
('AST043','PRJ001','紙資料スキャナ＆OCR(名刺/契約書)','PHYSICAL','RESTRICTED','[DEP011] デジタル化'),
('AST044','PRJ001','営業成績分析ツール(ダッシュボード)','CLOUD_SERVICE','RESTRICTED','[DEP011] 営業指標'),

-- [DEP012] 管理部
('AST045','PRJ001','人事・給与管理システム','SERVER','CONFIDENTIAL','[DEP012] 人事給与連携'),
('AST046','PRJ001','ノートPC(3台+AI文書仕分け)','PHYSICAL','CONFIDENTIAL','[DEP012] 管理部PC'),
('AST047','PRJ001','研修管理(LMS)','CLOUD_SERVICE','RESTRICTED','[DEP012] 教育履歴'),
('AST048','PRJ001','経費精算システム','CLOUD_SERVICE','RESTRICTED','[DEP012] 管理部運用'),

-- [DEP013] 人事部
('AST049','PRJ001','人事データベース(評価/採用/異動)','SERVER','CONFIDENTIAL','[DEP013] 人事情報'),
('AST050','PRJ001','ノートPC(3台+AI求人文作成)','PHYSICAL','CONFIDENTIAL','[DEP013] 人事部PC'),
('AST051','PRJ001','福利厚生ポータル','CLOUD_SERVICE','RESTRICTED','[DEP013] 社員向け情報'),
('AST052','PRJ001','入社/退社手続き管理','CLOUD_SERVICE','CONFIDENTIAL','[DEP013] オンボーディング'),

-- [DEP014] 法務部
('AST053','PRJ001','契約書管理データベース','SERVER','CONFIDENTIAL','[DEP014] 法務文書'),
('AST054','PRJ001','ノートPC(3台+AI法務チェック)','PHYSICAL','CONFIDENTIAL','[DEP014] 法務部PC'),
('AST055','PRJ001','法規制リサーチDB','CLOUD_SERVICE','RESTRICTED','[DEP014] 各種法律情報'),
('AST056','PRJ001','電子契約システム','CLOUD_SERVICE','CONFIDENTIAL','[DEP014] 電子署名'),

-- [DEP015] 経理部
('AST057','PRJ001','会計システム(財務/仕訳)','SERVER','CONFIDENTIAL','[DEP015] 財務データ'),
('AST058','PRJ001','ノートPC(3台+AI請求書OCR)','PHYSICAL','CONFIDENTIAL','[DEP015] 経理部PC'),
('AST059','PRJ001','予算管理システム','CLOUD_SERVICE','RESTRICTED','[DEP015] 年度予算/実績'),
('AST060','PRJ001','納税/税務申告ツール','CLOUD_SERVICE','CONFIDENTIAL','[DEP015] 税務管理'),

-- [DEP016] ITインフラ部
('AST061','PRJ001','社内ネットワーク機器(Firewall/VPN/ルータ)','PHYSICAL','CONFIDENTIAL','[DEP016] インフラ管理'),
('AST062','PRJ001','ノートPC(3台+AIインフラログ分析)','PHYSICAL','CONFIDENTIAL','[DEP016] インフラ部PC'),
('AST063','PRJ001','Active Directoryサーバ(社内認証)','SERVER','CONFIDENTIAL','[DEP016] ユーザ管理'),
('AST064','PRJ001','仮想化プラットフォーム(ESXi等)','SERVER','RESTRICTED','[DEP016] VM運用'),

-- [DEP017] RPA・AI推進室
('AST065','PRJ001','RPAシナリオ管理サーバ','SERVER','CONFIDENTIAL','[DEP017] UiPath等'),
('AST066','PRJ001','ノートPC(3台+ChatGPT法人ライセンス)','PHYSICAL','CONFIDENTIAL','[DEP017] RPA/AI部PC'),
('AST067','PRJ001','AIモデル開発環境(機械学習フレームワーク)','SERVER','CONFIDENTIAL','[DEP017] Python/TensorFlow'),
('AST068','PRJ001','テスト用ロボット(シミュレータ)','PHYSICAL','RESTRICTED','[DEP017] RPAテスト'),

-- [DEP018] IoTソリューション部
('AST069','PRJ001','IoTゲートウェイ装置(センサ連携)','PHYSICAL','RESTRICTED','[DEP018] センサー統合'),
('AST070','PRJ001','ノートPC(3台+AI画像認識モデル開発)','PHYSICAL','CONFIDENTIAL','[DEP018] IoT部PC'),
('AST071','PRJ001','MQTTサーバ(リアルタイム通信)','SERVER','CONFIDENTIAL','[DEP018] IoTデータ'),
('AST072','PRJ001','IoTダッシュボード(可視化ツール)','CLOUD_SERVICE','RESTRICTED','[DEP018] リアルタイム監視'),

-- [DEP019] DX推進室
('AST073','PRJ001','DXプロジェクト管理ツール(ガント/課題)','CLOUD_SERVICE','CONFIDENTIAL','[DEP019] 進捗可視化'),
('AST074','PRJ001','ノートPC(3台+AIデータ分析)','PHYSICAL','CONFIDENTIAL','[DEP019] DX室PC'),
('AST075','PRJ001','クラウドBIプラットフォーム','CLOUD_SERVICE','RESTRICTED','[DEP019] データ活用'),
('AST076','PRJ001','社内自動化ワークフロー(連携システム)','CLOUD_SERVICE','RESTRICTED','[DEP019] DX推進'),

-- [DEP020] BCM・リスク管理部
('AST077','PRJ001','BCP(事業継続計画)文書共有システム','CLOUD_SERVICE','CONFIDENTIAL','[DEP020] BCM関連'),
('AST078','PRJ001','ノートPC(3台+AI災害シミュレーション)','PHYSICAL','CONFIDENTIAL','[DEP020] BCM部PC'),
('AST079','PRJ001','リスク管理ダッシュボード','CLOUD_SERVICE','CONFIDENTIAL','[DEP020] 全社リスク'),
('AST080','PRJ001','監査証跡保管サーバ','SERVER','CONFIDENTIAL','[DEP020] ログ保管');

-- 全社共通 4資産
INSERT INTO Asset (
    asset_id, project_id, name,
    asset_type_code, classification_code,
    description
)
VALUES
('AST081','PRJ001','社内ポータルサイト／ナレッジベース','CLOUD_SERVICE','RESTRICTED','全社共通1'),
('AST082','PRJ001','メールサーバ・グループウェア','SERVER','CONFIDENTIAL','全社共通2'),
('AST083','PRJ001','インシデント管理システム(チケット)','SERVER','CONFIDENTIAL','全社共通3'),
('AST084','PRJ001','外部委託先管理台帳(サプライチェーン)','PHYSICAL','CONFIDENTIAL','全社共通4');

-- Risk(18)
INSERT INTO Risk
(risk_id, project_id, description, impact_code, likelihood_code, status_code)
VALUES
('RSK001','PRJ001','外部不正アクセス(顧客情報流出)','HIGH','MEDIUM','OPEN'),
('RSK002','PRJ001','社員ミス(メール誤送信等)','MEDIUM','MEDIUM','OPEN'),
('RSK003','PRJ001','モバイルPC盗難(データ紛失)','HIGH','MEDIUM','OPEN'),
('RSK004','PRJ001','サーバ障害(サービス停止)','HIGH','LOW','OPEN'),
('RSK005','PRJ001','アクセス権限管理不備(情報漏えい)','HIGH','MEDIUM','OPEN'),
('RSK006','PRJ001','災害・火災(データセンター被災)','HIGH','LOW','OPEN'),
('RSK007','PRJ001','内部不正(従業員持ち出し等)','HIGH','MEDIUM','OPEN'),
('RSK008','PRJ001','開発・テスト環境での個人情報漏えい','MEDIUM','MEDIUM','OPEN'),
('RSK009','PRJ001','パッチ適用漏れ(脆弱性悪用)','HIGH','MEDIUM','OPEN'),
('RSK010','PRJ001','IoT機器セキュリティ不備(踏み台攻撃)','MEDIUM','MEDIUM','OPEN'),
('RSK011','PRJ001','BYODウイルス感染拡大','MEDIUM','MEDIUM','OPEN'),
('RSK012','PRJ001','クラウド設定ミス(データ公開)','HIGH','MEDIUM','OPEN'),
('RSK013','PRJ001','不正プログラム(ランサムウェア)感染','HIGH','MEDIUM','OPEN'),
('RSK014','PRJ001','サプライチェーンリスク(外部委託不備)','MEDIUM','MEDIUM','OPEN'),
('RSK015','PRJ001','SNS公式アカウント乗っ取り・誤投稿','MEDIUM','MEDIUM','OPEN'),
('RSK016','PRJ001','従業員SNS利用(機密情報つぶやき)','MEDIUM','MEDIUM','OPEN'),
('RSK017','PRJ001','人為的エラー(データ削除等)大障害','HIGH','MEDIUM','OPEN'),
('RSK018','PRJ001','コンプライアンス違反(個人情報保護法等)','HIGH','MEDIUM','OPEN')
;

-- RiskAssessment
INSERT INTO RiskAssessment (risk_assessment_id, risk_id, assessment_date, level_code)
VALUES
('RSA001','RSK001','2025-02-01','HIGH_RISK'),
('RSA002','RSK002','2025-02-01','MEDIUM_RISK'),
('RSA003','RSK003','2025-02-01','HIGH_RISK'),
('RSA004','RSK004','2025-02-01','MEDIUM_RISK'),
('RSA005','RSK005','2025-02-01','HIGH_RISK'),
('RSA006','RSK006','2025-02-01','HIGH_RISK'),
('RSA007','RSK007','2025-02-01','HIGH_RISK'),
('RSA008','RSK008','2025-02-01','MEDIUM_RISK'),
('RSA009','RSK009','2025-02-01','HIGH_RISK'),
('RSA010','RSK010','2025-02-01','MEDIUM_RISK'),
('RSA011','RSK011','2025-02-01','MEDIUM_RISK'),
('RSA012','RSK012','2025-02-01','HIGH_RISK'),
('RSA013','RSK013','2025-02-01','HIGH_RISK'),
('RSA014','RSK014','2025-02-01','MEDIUM_RISK'),
('RSA015','RSK015','2025-02-01','MEDIUM_RISK'),
('RSA016','RSK016','2025-02-01','MEDIUM_RISK'),

('RSA017','RSK017','2025-02-01','HIGH_RISK'),
('RSA018','RSK018','2025-02-01','HIGH_RISK')
;

-- AssetRisk
INSERT INTO AssetRisk (asset_risk_id, asset_id, risk_id)
VALUES
('AR001','AST005','RSK001'),  -- セキュリティ監視サーバと外部不正アクセスリスク
('AR002','AST002','RSK002'),  -- ノートPC(企画部)と誤送信リスク
('AR003','AST003','RSK003'),  -- SNSマーケツールとモバイルPC盗難リスク(例示)
('AR004','AST004','RSK004'),
('AR005','AST008','RSK005'),
('AR006','AST082','RSK006'),  -- メールサーバ(全社共通)と災害火災リスク
('AR007','AST007','RSK007'),
('AR008','AST012','RSK008'),
('AR009','AST015','RSK009'),
('AR010','AST010','RSK010'),
('AR011','AST011','RSK011'),
('AR012','AST016','RSK012'),
('AR013','AST013','RSK013'),
('AR014','AST084','RSK014'),  -- 外部委託先管理台帳(全社共通)とサプライチェーンリスク
('AR015','AST003','RSK015'),   -- SNS公式アカウント乗っ取り - SNSマーケツール
('AR016','AST002','RSK016'),   -- 企画部PC(従業員SNS利用リスク)
('AR017','AST083','RSK017'),   -- インシデント管理システム(全社共通)と人為的エラー大障害リスク
('AR018','AST007','RSK018');  -- ISMS管理台帳とコンプライアンス違反リスク


INSERT INTO RiskRequirement (
    risk_requirement_id, risk_id, requirement_id
)
VALUES
('RR001','RSK001','REQ-ISO27001-A5.1.1'), -- 例: 情報セキュリティ方針
('RR002','RSK002','REQ-ISO27001-A7.2.2'),
('RR003','RSK003','REQ-ISO27001-A8.3.1'),
('RR004','RSK004','REQ-ISO27001-A12.1.1'),
('RR005','RSK005','REQ-ISO27001-A9.2.1'),
('RR006','RSK006','REQ-ISO27001-A17.1.1'),
('RR007','RSK007','REQ-ISO27001-A7.3.1'),
('RR008','RSK008','REQ-ISO27001-A18.1.4'),
('RR009','RSK009','REQ-ISO27001-A12.6.1'),
('RR010','RSK010','REQ-ISO27001-A13.2.1'),
('RR011','RSK011','REQ-ISO27001-A6.2.2'),
('RR012','RSK012','REQ-ISO27001-A14.1.1'),
('RR013','RSK013','REQ-ISO27001-A12.2.1'),
('RR014','RSK014','REQ-ISO27001-A15.1.1'),
('RR015','RSK015','REQ-ISO27001-A7.2.2'),
('RR016','RSK016','REQ-ISO27001-A8.2.3'),
('RR017','RSK017','REQ-ISO27001-A12.4.1'),
('RR018','RSK018','REQ-ISO27001-A18.1.1');

-- **5-4. 文書管理 + ApprovalWorkflow**

INSERT INTO Document (
  document_id, project_id, title, category_code, department_id
)
VALUES (
  'DOC001','PRJ001','情報セキュリティポリシー','SEC_POLICY','DEP002'
);

INSERT INTO DocumentVersion (
  document_version_id, document_id, version_number, status_code, content_url
)
VALUES (
  'DOCV001','DOC001','v1.0','DRAFT','http://intranet/docs/infosec_policy_v1_draft.pdf'
);

INSERT INTO ApprovalWorkflow (
  workflow_id, document_version_id, approver_id, status_code
)
VALUES
('AWF001','DOCV001','USR001','PENDING'),
('AWF002','DOCV001','USR002','PENDING')
;

-- **5-5. ImplementationTask, Evidence**

INSERT INTO ImplementationTask (
  task_id, project_id, requirement_id, description, status_code, due_date, assignee_id
)
VALUES (
  'TSK001','PRJ001','REQ-ISO27001-A5.1.1',
  '情報セキュリティ方針策定＆承認取得',
  'IN_PROGRESS','2025-04-01','USR001'
);

INSERT INTO Evidence (
  evidence_id, task_id, evidence_type_code, reference_url, description
)
VALUES (
  'EVD001','TSK001','DOC_LINK',
  'http://intranet/docs/infosec_policy_v1_approved.pdf',
  '承認済みポリシーPDF'
);

INSERT INTO RiskTreatmentPlan
(plan_id, risk_id, action, owner_id, due_date, status_code)
VALUES
('RTP001','RSK001','WAF/ファイアウォール強化、多要素認証導入','USR003','2025-03-15','OPEN'),
('RTP002','RSK002','誤送信防止ツール導入、メール暗号化、定期教育','USR003','2025-03-20','OPEN'),
('RTP003','RSK003','モバイルPCの暗号化、リモートワイプ運用','USR004','2025-03-31','OPEN'),
('RTP004','RSK004','RAID冗長+保守、DRサイト検討','USR004','2025-04-10','OPEN'),
('RTP005','RSK005','アカウント停止迅速化、RBAC、定期レビュー','USR003','2025-04-15','OPEN'),
('RTP006','RSK006','オフサイトバックアップ、耐震設備、DR計画','USR004','2025-05-01','OPEN'),
('RTP007','RSK007','ログ監視、内部通報制度整備','USR003','2025-05-05','OPEN'),
('RTP008','RSK008','テストデータマスキング、外部アクセス制限','USR003','2025-05-10','OPEN'),
('RTP009','RSK009','定期パッチ管理、脆弱性対応手順','USR004','2025-05-20','OPEN'),
('RTP010','RSK010','IoT機器PW変更、ファーム更新、ネット分離','USR004','2025-05-25','OPEN'),
('RTP011','RSK011','BYODポリシー、MDM導入、VPN接続スキャン','USR003','2025-06-01','OPEN'),
('RTP012','RSK012','S3権限監査、IaC管理、クラウド診断','USR004','2025-06-05','OPEN'),
('RTP013','RSK013','EDR導入、メール添付検疫、オフラインバックアップ','USR003','2025-06-10','OPEN'),
('RTP014','RSK014','外部委託契約にセキュリティ要件盛込、NDA厳格化','USR003','2025-06-15','OPEN'),
('RTP015','RSK015','SNS多要素認証、投稿前承認、緊急連絡体制','USR005','2025-06-20','OPEN'),
('RTP016','RSK016','SNSガイドライン、発信禁止ルール、懲戒規定','USR005','2025-06-25','OPEN'),
('RTP017','RSK017','重要操作多段承認、バックアップ頻度UP','USR004','2025-07-01','OPEN'),
('RTP018','RSK018','法規制チェックリスト、報告手順、プライバシーポリシー整備','USR003','2025-07-05','OPEN');