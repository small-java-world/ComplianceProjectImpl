-- リスクテンプレート
INSERT INTO RiskTemplate (risk_template_id, template_name, description, severity)
VALUES
('TPL001','サーバ機密リスク','サーバに機密データがある場合の漏えいリスク',3),
('TPL002','可用性重視リスク','可用性が高い資産に対する障害リスク',2),
('TPL003','データ改ざんリスク','完全性が重要な資産に対するデータ改ざんリスク',2),
('TPL004','物理侵入リスク','施設への不正侵入による資産破壊や盗難リスク',3),
('TPL005','開発プロセス脆弱性','セキュア開発が不十分な場合の脆弱性リスク',2),
('TPL006','ネットワーク過負荷','大量アクセスやDDoSによるシステムダウンリスク',3),
('TPL007','不正アクセス','認証・認可の不備でアカウント乗っ取りのリスク',3),
('TPL008','ログ監査不備','ログが十分でない場合の事故原因不明リスク',1),
('TPL009','LANセグメントリスク','LAN区分けが不十分な場合の侵入/感染拡大リスク',2),
('TPL010','クラウド設定ミスリスク','クラウドの権限設定や公開範囲のミスが招く漏えいリスク',3),
('TPL011','パッチ未適用リスク','サーバOSやアプリへの定期パッチ遅延による脆弱性リスク',2),
('TPL012','フィッシング攻撃リスク','従業員がフィッシングメールにより認証情報漏えいのリスク',3),
('TPL013','バックアップ遅延リスク','定期バックアップが実行されずにデータを失うリスク',1),
('TPL014','外部サプライヤリスク','外部委託先のセキュリティ不備で情報漏えいリスク',2),
('TPL015','SCADA制御リスク','工場SCADAシステムがサイバー攻撃受けるリスク',3),
('TPL016','内部不正 (Insider Threat)','従業員や内部関係者による意図的なデータ持ち出しリスク',3),
('TPL017','事業継続BCPリスク','災害やトラブル時に備えたBCP未整備リスク',3),
('TPL018','鍵管理不備リスク','暗号鍵や物理鍵の管理がずさんな場合の漏えいリスク',2),
('TPL019','IoTデバイス乱立リスク','無数のIoT端末が管理されず、脆弱性を放置するリスク',3),
('TPL020','マネロンリスク','資金洗浄（マネーロンダリング）を見逃すコンプライアンスリスク',3),
('TPL021','サプライチェーン断絶リスク','主要供給先が被災/倒産し、原材料や部品が途絶するリスク',2),
('TPL022','クラウドコスト増大リスク','クラウドリソースが無制限に増加し、予算を圧迫するリスク',2),
('TPL023','情報統制不備(組織ガバナンス)','部署ごとにITポリシーがバラバラで一貫した統制ができないリスク',3),
('TPL024','レガシーシステム移行リスク','古いシステムを放置し、サポート切れで重大障害を起こすリスク',3),
('TPL025','メールセキュリティリスク','Eメール関連のセキュリティ対策不備による情報漏えいリスク',2),
('TPL026','マルチクラウド混乱リスク','複数クラウドを運用しているがガバナンス不足で混乱が生じるリスク',3),
('TPL027','詐欺検知不備リスク','トランザクション監視の不十分さで詐欺を見逃すリスク',3),
('TPL028','データセンター障害リスク','大規模障害や自然災害でデータセンターがダウンするリスク',3),
('TPL029','データ分類不備リスク','機密度を決めずに全データを扱い漏えい時に深刻化するリスク',2),
('TPL030','暗号鍵ローテーションリスク','鍵の定期更新がなされず、長期間同一鍵を使用し続けるリスク',2),
('TPL031','リモートワーク環境リスク','在宅勤務の端末・ネットワークが脆弱で情報流出するリスク',3),
('TPL032','ソフトウェアサプライチェーンリスク','外部ライブラリや依存パッケージに潜む改ざんや脆弱性リスク',3);


-- リスクテンプレート条件
INSERT INTO RiskTemplateCondition (
  risk_template_condition_id,
  risk_template_id,
  attribute_name,
  operator,
  compare_value,
  logical_operator,
  condition_order
)
VALUES
-- TPL009
('COND017','TPL009','asset_type_code','=','NETWORK','AND',1),
('COND018','TPL009','integrity_level','>=','2','AND',2),

-- TPL010
('COND019','TPL010','asset_type_code','=','CLOUD','AND',1),
('COND020','TPL010','confidentiality_level','>=','2','AND',2),

-- TPL011
('COND021','TPL011','asset_type_code','=','SERVER','AND',1),
('COND022','TPL011','availability_level','>=','2','AND',2),

-- TPL012
('COND023','TPL012','asset_type_code','=','ENDPOINT','AND',1),
('COND024','TPL012','contains_personal_data','=','true','AND',2),

-- TPL013
('COND025','TPL013','asset_type_code','=','DATABASE','AND',1),
('COND026','TPL013','confidentiality_level','>=','1','AND',2),

-- TPL014
('COND027','TPL014','asset_type_code','=','EXTERNAL','AND',1),
('COND028','TPL014','contains_personal_data','=','true','AND',2),

-- TPL015
('COND029','TPL015','asset_type_code','=','SCADA','AND',1),
('COND030','TPL015','availability_level','>=','2','AND',2),

-- TPL016
('COND031','TPL016','asset_type_code','=','SERVER','AND',1),
('COND032','TPL016','integrity_level','>=','2','AND',2),
-- TPL017
('COND033','TPL017','asset_type_code','=','SERVER','AND',1),
('COND034','TPL017','availability_level','>=','2','AND',2),

-- TPL018
('COND035','TPL018','asset_type_code','=','SECURE','AND',1),
('COND036','TPL018','confidentiality_level','>=','3','AND',2),

-- TPL019
('COND037','TPL019','asset_type_code','=','IOT','AND',1),
('COND038','TPL019','contains_personal_data','=','true','AND',2),

-- TPL020
('COND039','TPL020','asset_type_code','=','FINANCE','AND',1),
('COND040','TPL020','integrity_level','>=','2','AND',2),

-- TPL021
('COND041','TPL021','asset_type_code','=','SUPPLY','AND',1),
('COND042','TPL021','availability_level','>=','2','AND',2),

-- TPL022
('COND043','TPL022','asset_type_code','=','CLOUD','AND',1),
('COND044','TPL022','availability_level','>=','1','AND',2),

-- TPL023
('COND045','TPL023','asset_type_code','=','ORGANIZATION','AND',1),
('COND046','TPL023','confidentiality_level','>=','2','AND',2),

-- TPL024
('COND047','TPL024','asset_type_code','=','LEGACY','AND',1),
('COND048','TPL024','integrity_level','>=','1','AND',2),

-- TPL025
('COND049','TPL025','asset_type_code','=','EMAIL','AND',1),
('COND050','TPL025','confidentiality_level','>=','2','AND',2),

-- TPL026
('COND051','TPL026','asset_type_code','=','CLOUD','AND',1),
('COND052','TPL026','availability_level','>=','2','AND',2),

-- TPL027
('COND053','TPL027','asset_type_code','=','FINANCE','AND',1),
('COND054','TPL027','integrity_level','>=','2','AND',2),

-- TPL028
('COND055','TPL028','asset_type_code','=','DATACENTER','AND',1),
('COND056','TPL028','availability_level','>=','3','AND',2),

-- TPL029
('COND057','TPL029','asset_type_code','=','GENERAL','AND',1),
('COND058','TPL029','confidentiality_level','>=','1','AND',2),

-- TPL030
('COND059','TPL030','asset_type_code','=','SECURE','AND',1),
('COND060','TPL030','integrity_level','>=','2','AND',2),

-- TPL031
('COND061','TPL031','asset_type_code','=','ENDPOINT','AND',1),
('COND062','TPL031','contains_personal_data','=','true','AND',2),

-- TPL032
('COND063','TPL032','asset_type_code','=','APPLICATION','AND',1),
('COND064','TPL032','integrity_level','>=','3','AND',2);

-- リスク
INSERT INTO Risk (risk_id, risk_template_id, title, description, impact_code, likelihood_code)
VALUES
('RSK001','TPL001','サーバ機密リスク検出#1','高機密サーバが認証不備','HIGH','MEDIUM'),
('RSK002','TPL001','サーバ機密リスク検出#2','DB内に個人情報あり','MEDIUM','MEDIUM'),
('RSK003','TPL001','サーバ機密リスク検出#3','暗号化されていない機密データ','HIGH','HIGH'),

('RSK004','TPL002','可用性リスク検出#1','DB高負荷で障害可能性','MEDIUM','HIGH'),
('RSK005','TPL002','可用性リスク検出#2','冗長化未設定でダウン時に影響大','HIGH','HIGH'),
('RSK006','TPL002','可用性リスク検出#3','クラスタ未構築','LOW','MEDIUM'),

('RSK007','TPL003','データ改ざんリスク#1','重要データ改ざん可能性','MEDIUM','LOW'),
('RSK008','TPL003','データ改ざんリスク#2','整合性レベル不足','HIGH','MEDIUM'),
('RSK009','TPL003','データ改ざんリスク#3','検証プロセスなし','MEDIUM','MEDIUM'),

('RSK010','TPL004','物理侵入リスク#1','施設セキュリティゲート不備','HIGH','MEDIUM'),
('RSK011','TPL004','物理侵入リスク#2','夜間警備無','HIGH','HIGH'),
('RSK012','TPL004','物理侵入リスク#3','施錠ルール形骸化','MEDIUM','MEDIUM'),

('RSK013','TPL005','開発プロセスリスク#1','レビュー不十分','MEDIUM','MEDIUM'),
('RSK014','TPL005','開発プロセスリスク#2','テスト工程省略','HIGH','HIGH'),
('RSK015','TPL005','開発プロセスリスク#3','外部ライブラリ無検証','MEDIUM','MEDIUM'),

('RSK016','TPL006','ネットワーク過負荷#1','DDoS対策なし','HIGH','HIGH'),
('RSK017','TPL006','ネットワーク過負荷#2','スケーラブル構成でない','MEDIUM','HIGH'),
('RSK018','TPL006','ネットワーク過負荷#3','回線冗長なし','MEDIUM','MEDIUM'),

('RSK019','TPL007','不正アクセスリスク#1','認証仕組み弱い','HIGH','MEDIUM'),
('RSK020','TPL008','ログ監査不備リスク#1','長期ログ保管なし','LOW','LOW'),

-- (TPL009を一部参照)
('RSK021','TPL009','LANセグメントリスク#1','部門間のネットワークが区分けされずウイルスが拡散する可能性','MEDIUM','MEDIUM'),
('RSK022','TPL009','LANセグメントリスク#2','同一セグメントで不正端末接続','HIGH','MEDIUM'),

-- (TPL010を参照)
('RSK023','TPL010','クラウド設定ミス#1','ストレージがpublic設定で誰でも閲覧可','HIGH','HIGH'),
('RSK024','TPL010','クラウド設定ミス#2','IAMロール誤設定で全員管理者権限','HIGH','HIGH'),
('RSK025','TPL010','クラウド設定ミス#3','未使用ポートが開放され攻撃を許容','MEDIUM','HIGH'),

-- (TPL011を参照)
('RSK026','TPL011','パッチ未適用#1','サーバOSが3ヶ月以上放置','MEDIUM','HIGH'),
('RSK027','TPL011','パッチ未適用#2','アプリケーション脆弱性修正が先延ばし','HIGH','HIGH'),

-- (TPL012を参照)
('RSK028','TPL012','フィッシング攻撃#1','従業員がフィッシングサイトでPW入力','HIGH','MEDIUM'),
('RSK029','TPL012','フィッシング攻撃#2','組織的な訓練不足で成功率高','HIGH','HIGH'),

-- (TPL013を参照)
('RSK030','TPL013','バックアップ遅延#1','週間バックアップが3週連続失敗','MEDIUM','LOW'),
('RSK031','TPL013','バックアップ遅延#2','バックアップスクリプト故障','MEDIUM','MEDIUM'),

-- (TPL014を参照)
('RSK032','TPL014','外部サプライヤリスク#1','海外拠点のセキュリティルール不明','HIGH','MEDIUM'),
('RSK033','TPL014','外部サプライヤリスク#2','ND契約結ばず機密データ委託','HIGH','HIGH'),

-- (TPL015を参照)
('RSK034','TPL015','SCADA制御リスク#1','制御NWがインターネット直結','HIGH','HIGH'),
('RSK035','TPL015','SCADA制御リスク#2','PLC認証が無効','HIGH','HIGH'),

-- (TPL016を参照)
('RSK036','TPL016','内部不正#1','管理者権限の職員が無制限操作','HIGH','MEDIUM'),
('RSK037','TPL016','内部不正#2','退職者アカウントを残存','HIGH','HIGH'),
('RSK038','TPL016','内部不正#3','高権限操作ログが未取得','MEDIUM','MEDIUM'),
('RSK039','TPL016','内部不正#4','暗号鍵を私物PCで保管','HIGH','LOW'),
('RSK040','TPL016','内部不正#5','同僚IDを共有し監査不能','HIGH','MEDIUM'),

('RSK041','TPL017','BCPリスク#1','災害発生時の代替拠点・手順が未策定','HIGH','MEDIUM'),
('RSK042','TPL017','BCPリスク#2','事業継続計画が形骸化','MEDIUM','MEDIUM'),
('RSK043','TPL017','BCPリスク#3','大規模停電を想定していない','HIGH','HIGH'),

('RSK044','TPL018','鍵管理リスク#1','物理鍵を無管理で放置','MEDIUM','LOW'),
('RSK045','TPL018','鍵管理リスク#2','暗号鍵を共有フォルダに保存','HIGH','HIGH'),
('RSK046','TPL018','鍵管理リスク#3','マスターキーの複製管理不備','HIGH','MEDIUM'),

('RSK047','TPL019','IoT乱立リスク#1','工場内センサーが勝手に追加され脆弱','HIGH','MEDIUM'),
('RSK048','TPL019','IoT乱立リスク#2','ファームウェア更新が行われない','HIGH','HIGH'),
('RSK049','TPL019','IoT乱立リスク#3','外部ネットワークに直結','MEDIUM','HIGH'),

('RSK050','TPL020','マネロンリスク#1','不正取引を検知する仕組みが不足','HIGH','HIGH'),
('RSK051','TPL020','マネロンリスク#2','顧客本人確認(KYC)が不徹底','HIGH','HIGH'),

('RSK052','TPL021','サプライチェーンリスク#1','主要ベンダへの一社依存','MEDIUM','MEDIUM'),
('RSK053','TPL021','サプライチェーンリスク#2','自然災害時にバックアップ手配なし','HIGH','MEDIUM'),

('RSK054','TPL022','クラウドコストリスク#1','不要インスタンス放置でコスト増','MEDIUM','HIGH'),
('RSK055','TPL022','クラウドコストリスク#2','監視未整備で膨大なリソース稼働','HIGH','MEDIUM'),

('RSK056','TPL023','情報統制不備#1','部署別にルールが異なり混乱','HIGH','LOW'),
('RSK057','TPL023','情報統制不備#2','全社ポリシー未策定','HIGH','HIGH'),

('RSK058','TPL024','レガシー移行リスク#1','サポート切れOSを運用継続','HIGH','HIGH'),
('RSK059','TPL024','レガシー移行リスク#2','移行計画が未定義','MEDIUM','MEDIUM'),
('RSK060','TPL024','レガシー移行リスク#3','互換テスト環境が用意されていない','HIGH','MEDIUM'),

('RSK061','TPL025','メールセキュリティリスク#1','添付ファイルのウイルス検出対策が不十分','MEDIUM','MEDIUM'),
('RSK062','TPL025','メールセキュリティリスク#2','外部メール誤送信で機密情報流出','HIGH','MEDIUM'),
('RSK063','TPL026','マルチクラウドリスク#1','AWSとAzureを併用するもIAM方針が未統一','HIGH','HIGH'),
('RSK064','TPL026','マルチクラウドリスク#2','コスト管理が煩雑化して追跡困難','MEDIUM','MEDIUM'),
('RSK065','TPL027','詐欺検知リスク#1','クレジット決済の不正利用を見逃す可能性','HIGH','HIGH'),
('RSK066','TPL027','詐欺検知リスク#2','個人融資スキームでリスクスコア未設定','HIGH','MEDIUM'),
('RSK067','TPL028','データセンター障害リスク#1','地震・洪水など大災害対応が不明確','HIGH','HIGH'),
('RSK068','TPL028','データセンター障害リスク#2','一極集中でDRサイトが用意されていない','HIGH','HIGH'),
('RSK069','TPL029','データ分類不備リスク#1','一律同じ管理で重要データが軽視','MEDIUM','MEDIUM'),
('RSK070','TPL029','データ分類不備リスク#2','開発環境に本番機密データを使用','HIGH','MEDIUM'),
('RSK071','TPL030','鍵ローテーションリスク#1','数年間キーを交換せず運用','MEDIUM','HIGH'),
('RSK072','TPL030','鍵ローテーションリスク#2','複数システムの鍵が混在管理','HIGH','MEDIUM'),
('RSK073','TPL031','リモートワークリスク#1','在宅端末にセキュリティパッチ未適用','HIGH','HIGH'),
('RSK074','TPL031','リモートワークリスク#2','Wi-Fi暗号化がWEPなど旧式','HIGH','HIGH'),
('RSK075','TPL031','リモートワークリスク#3','VPN接続ルールが曖昧','MEDIUM','MEDIUM'),
('RSK076','TPL032','サプライチェーンリスク#1','外部ライブラリに改ざんが仕掛けられた','HIGH','HIGH'),
('RSK077','TPL032','サプライチェーンリスク#2','OSSの脆弱性を自動検知していない','MEDIUM','MEDIUM'),
('RSK078','TPL032','サプライチェーンリスク#3','ビルド時の署名検証を省略','HIGH','HIGH'),
('RSK079','TPL025','メールセキュリティリスク#3','SPF/DMARC設定不備でなりすまし可能','HIGH','MEDIUM'),
('RSK080','TPL029','データ分類不備リスク#3','クラウド共有フォルダに一括保存','HIGH','LOW');


-- リスクアセスメント
INSERT INTO RiskAssessment (
  assessment_id, 
  risk_id, 
  assessor_id, 
  assessment_date, 
  impact_code,
  likelihood_code,
  risk_level_code,
  notes,
  created_at,
  updated_at
)
VALUES
-- --- 1) ASM001 ～ ASM010 ---
('ASM001','RSK001','ASR001','2025-01-01','HIGH','HIGH','HIGH','データ量が大きいため漏えい時の影響大',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM002','RSK002','ASR002','2025-01-02','MEDIUM','HIGH','HIGH','個人情報ありだが認証あり、被害範囲はやや大きい',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM003','RSK003','ASR003','2025-01-03','HIGH','HIGH','HIGH','暗号化が未実装で発生可能性が高い',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM004','RSK004','ASR004','2025-01-04','LOW','MEDIUM','LOW','冗長構成あり、影響は小さめ',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM005','RSK005','ASR005','2025-01-05','HIGH','HIGH','HIGH','停電時にダウン確実、BCP整備必須',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM006','RSK006','ASR001','2025-01-06','MEDIUM','LOW','LOW','クラスタなしだが負荷が低く現時点で重大度は低',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM007','RSK007','ASR002','2025-01-07','HIGH','MEDIUM','HIGH','改ざん対策不十分で発生確率が中程度',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM008','RSK008','ASR003','2025-01-08','MEDIUM','MEDIUM','MEDIUM','テスト未整備で整合性の確認不足',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM009','RSK009','ASR004','2025-01-09','LOW','LOW','LOW','検証済みで影響範囲は小',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM010','RSK010','ASR005','2025-01-10','HIGH','HIGH','HIGH','物理セキュリティ不足により重大インシデントの恐れ',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),

-- --- 2) ASM011 ～ ASM020 ---
('ASM011','RSK011','ASR001','2025-01-11','HIGH','MEDIUM','HIGH','ガード不在で侵入リスク大',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM012','RSK012','ASR002','2025-01-12','MEDIUM','LOW','LOW','施錠ルールがあり発生確率は低め',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM013','RSK013','ASR003','2025-01-13','MEDIUM','MEDIUM','MEDIUM','レビュー手順不十分で早急な改善が必要',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM014','RSK014','ASR004','2025-01-14','HIGH','HIGH','HIGH','テストを省略してリリースされており致命的',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM015','RSK015','ASR005','2025-01-15','MEDIUM','MEDIUM','MEDIUM','OSSライセンスチェック未完了で不備リスク有',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM016','RSK016','ASR001','2025-01-16','HIGH','LOW','MEDIUM','DDoS対策なし、被害は大きいが発生頻度は低め',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM017','RSK017','ASR002','2025-01-17','LOW','HIGH','MEDIUM','スケーラビリティ不足で繁忙期にダウン確率大',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM018','RSK018','ASR003','2025-01-18','MEDIUM','HIGH','HIGH','二重回線化なし、障害時の業務停止リスク高',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM019','RSK019','ASR004','2025-01-19','HIGH','MEDIUM','HIGH','認証が弱く不正アクセスされる可能性大',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM020','RSK020','ASR005','2025-01-20','LOW','LOW','LOW','影響度も確率も小さいため優先度低',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),

-- --- 3) ASM021 ～ ASM030 ---
('ASM021','RSK021','ASR001','2025-01-21','HIGH','MEDIUM','HIGH','サプライヤ依存が高く障害発生時の影響大',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM022','RSK022','ASR002','2025-01-22','MEDIUM','MEDIUM','MEDIUM','多重化一部導入だが改善余地あり',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM023','RSK023','ASR003','2025-01-23','LOW','HIGH','MEDIUM','冗長構成なし、停止確率が高い',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM024','RSK024','ASR004','2025-01-24','HIGH','HIGH','HIGH','クラウド設定ミス時に大規模被害の恐れ',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM025','RSK025','ASR005','2025-01-25','MEDIUM','LOW','LOW','暗号化未対応だが機微データは少ない',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM026','RSK026','ASR001','2025-01-26','MEDIUM','MEDIUM','MEDIUM','監査ログが一部不足し要改善',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM027','RSK027','ASR002','2025-01-27','HIGH','LOW','MEDIUM','外部公開APIの影響範囲は大だが発生頻度低',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM028','RSK028','ASR003','2025-01-28','LOW','MEDIUM','LOW','可用性を重視するが停止影響は中程度',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM029','RSK029','ASR004','2025-01-29','HIGH','HIGH','HIGH','ワーム型マルウェア対策なく致命的',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM030','RSK030','ASR005','2025-01-30','LOW','HIGH','MEDIUM','障害起きれば被害は小さいが確率は大',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),

-- --- 4) ASM031 ～ ASM040 ---
('ASM031','RSK031','ASR001','2025-01-31','HIGH','LOW','MEDIUM','鍵管理ガバナンスが弱く誤操作リスク有',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM032','RSK032','ASR002','2025-02-01','MEDIUM','HIGH','HIGH','マルチクラウドが混在し運用負担大',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM033','RSK033','ASR003','2025-02-02','LOW','HIGH','MEDIUM','可用性の低い旧式サーバを継続運用',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM034','RSK034','ASR004','2025-02-03','HIGH','HIGH','HIGH','ISO基準違反で重大指摘を受ける可能性',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM035','RSK035','ASR005','2025-02-04','HIGH','MEDIUM','HIGH','不正送金や詐欺が起きれば損失甚大',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM036','RSK036','ASR001','2025-02-05','LOW','LOW','LOW','一部対策済みで当面リスクは小',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM037','RSK037','ASR002','2025-02-06','MEDIUM','HIGH','HIGH','管理者権限が集中し誤操作時の混乱大',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM038','RSK038','ASR003','2025-02-07','MEDIUM','MEDIUM','MEDIUM','外部委託体制が不透明で評価は中程度',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM039','RSK039','ASR004','2025-02-08','HIGH','LOW','MEDIUM','オンプレ冗長化あり頻度は低いが影響大',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM040','RSK040','ASR005','2025-02-09','LOW','MEDIUM','LOW','代替策があり深刻度は低めだが要対応',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),

-- --- 5) ASM041 ～ ASM050 ---
('ASM041','RSK041','ASR001','2025-02-10','HIGH','HIGH','HIGH','BCP不足で災害時の被害が甚大',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM042','RSK042','ASR002','2025-02-11','MEDIUM','MEDIUM','MEDIUM','BCP訓練が少なく想定漏れあり',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM043','RSK043','ASR003','2025-02-12','LOW','HIGH','MEDIUM','暫定対策のみで根本対応未検討',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM044','RSK044','ASR004','2025-02-13','LOW','LOW','LOW','物理鍵管理はされており大きな問題は少',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM045','RSK045','ASR005','2025-02-14','HIGH','LOW','MEDIUM','暗号鍵をHSM化せず漏えい時ダメージ大',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM046','RSK046','ASR001','2025-02-15','MEDIUM','LOW','LOW','複製キー管理はある程度整備済み',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM047','RSK047','ASR002','2025-02-16','HIGH','MEDIUM','HIGH','IoTセンサー増設に認証なく危険度大',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM048','RSK048','ASR003','2025-02-17','MEDIUM','MEDIUM','MEDIUM','ファームウェア更新計画が未確定',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM049','RSK049','ASR004','2025-02-18','LOW','LOW','LOW','外部直結なし、影響度は低め',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM050','RSK050','ASR005','2025-02-19','HIGH','HIGH','HIGH','不正取引監視なしで重大被害リスク',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),

-- --- 6) ASM051 ～ ASM060 ---
('ASM051','RSK051','ASR001','2025-02-20','HIGH','MEDIUM','HIGH','KYC不備で金融当局から罰則の可能性',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM052','RSK052','ASR002','2025-02-21','MEDIUM','MEDIUM','MEDIUM','単一サプライヤ依存が続き安定性不安',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM053','RSK053','ASR003','2025-02-22','LOW','HIGH','MEDIUM','バックアップ取引先がなく災害時影響大',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM054','RSK054','ASR004','2025-02-23','HIGH','LOW','MEDIUM','不要クラウドリソース多数でコスト増大',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM055','RSK055','ASR005','2025-02-24','HIGH','HIGH','HIGH','監視なしでリソース膨張し大損失懸念',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM056','RSK056','ASR001','2025-02-25','MEDIUM','LOW','LOW','部署ごとにポリシー乱立、部分的に統合中',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM057','RSK057','ASR002','2025-02-26','HIGH','MEDIUM','HIGH','全社ポリシー未策定で統制不能リスク',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM058','RSK058','ASR003','2025-02-27','LOW','LOW','LOW','レガシーOSを放置しているが負荷は低い',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM059','RSK059','ASR004','2025-02-28','MEDIUM','MEDIUM','MEDIUM','移行計画不在、すぐには影響ないが長期的に危険',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM060','RSK060','ASR005','2025-03-01','HIGH','LOW','MEDIUM','互換テスト環境がなく本番障害の可能性大',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),

-- --- 7) ASM061 ～ ASM070 ---
('ASM061','RSK061','ASR001','2025-03-02','HIGH','HIGH','HIGH','メール添付のウイルス検知が不十分',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM062','RSK062','ASR002','2025-03-03','MEDIUM','HIGH','HIGH','外部メール誤送信で機密情報流出リスク',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM063','RSK063','ASR003','2025-03-04','LOW','HIGH','MEDIUM','マルチクラウドIAMが未整合で混乱発生',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM064','RSK064','ASR004','2025-03-05','LOW','MEDIUM','LOW','コスト監視ツール未導入で浪費の恐れ',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM065','RSK065','ASR005','2025-03-06','HIGH','LOW','MEDIUM','クレジット決済の不正検知体制が弱い',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM066','RSK066','ASR001','2025-03-07','MEDIUM','LOW','LOW','個人融資スキームは規模小さく影響限定',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM067','RSK067','ASR002','2025-03-08','HIGH','MEDIUM','HIGH','地震/洪水でデータセンター被災リスク大',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM068','RSK068','ASR003','2025-03-09','MEDIUM','MEDIUM','MEDIUM','DRサイト未設置で停止時間が長期化する恐れ',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM069','RSK069','ASR004','2025-03-10','LOW','LOW','LOW','データ分類が曖昧だが重要度は低い',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM070','RSK070','ASR005','2025-03-11','HIGH','HIGH','HIGH','開発環境で本番データを流用し漏えい懸念',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),

-- --- 8) ASM071 ～ ASM080 ---
('ASM071','RSK071','ASR001','2025-03-12','HIGH','MEDIUM','HIGH','長期間キーを交換せず流用しており被害大',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM072','RSK072','ASR002','2025-03-13','LOW','HIGH','MEDIUM','鍵がシステム毎にバラバラで管理困難',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM073','RSK073','ASR003','2025-03-14','MEDIUM','LOW','LOW','在宅端末へのセキュリティパッチ未適用',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM074','RSK074','ASR004','2025-03-15','HIGH','HIGH','HIGH','Wi-Fi暗号化がWEPで容易に侵入可能',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM075','RSK075','ASR005','2025-03-16','MEDIUM','MEDIUM','MEDIUM','VPN接続ルール曖昧で漏えいリスク',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM076','RSK076','ASR001','2025-03-17','HIGH','LOW','MEDIUM','外部ライブラリが改ざんされる被害懸念',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM077','RSK077','ASR002','2025-03-18','MEDIUM','HIGH','HIGH','OSS脆弱性検知がなく大きな欠陥を見逃す可能性',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM078','RSK078','ASR003','2025-03-19','HIGH','HIGH','HIGH','ビルド時の署名検証を省略しマルウェア混入の恐れ',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM079','RSK079','ASR004','2025-03-20','HIGH','LOW','MEDIUM','SPF/DMARC未設定でなりすましメール被害リスク',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('ASM080','RSK080','ASR005','2025-03-21','LOW','MEDIUM','LOW','クラウドフォルダに機密データが混在し誤公開の恐れ',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);



-- リスク対応計画
INSERT INTO RiskTreatmentPlan (
  plan_id,
  risk_id,
  requirement_id,
  title,
  description,
  treatment_type_code,
  status_code,
  due_date
)
VALUES
('PL001','RSK001',NULL,'暗号化実装','サーバ上のDBを暗号化する','MITIGATE','IN_PROGRESS','2025-03-01'),
('PL002','RSK002',NULL,'アクセス権見直し','個人情報フォルダへ権限設定','MITIGATE','OPEN','2025-06-15'),
('PL003','RSK003',NULL,'暗号化ライブラリ導入','強力暗号を適用','MITIGATE','IN_PROGRESS','2025-05-30'),
('PL004','RSK004',NULL,'負荷テスト実施','DB負荷テストを実施','MITIGATE','OPEN','2025-03-10'),
('PL005','RSK005',NULL,'冗長化構築','HAクラスタを構築','MITIGATE','IN_PROGRESS','2025-07-01'),
('PL006','RSK006',NULL,'クラウド移行検討','スケーラブルなクラウド環境へ移行','AVOID','OPEN','2025-05-01'),
('PL007','RSK007',NULL,'ログ監査強化','改ざん検知システム導入','MITIGATE','NEW','2025-04-20'),
('PL008','RSK008',NULL,'データ整合性ツール導入','定期チェックの導入','MITIGATE','IN_PROGRESS','2025-06-01'),
('PL009','RSK009',NULL,'プロセス確立','改ざん検証手順を整備','MITIGATE','OPEN','2025-05-15'),
('PL010','RSK010',NULL,'施設ゲート改修','夜間セキュリティ会社契約','MITIGATE','NEW','2025-04-10'),
('PL011','RSK011',NULL,'警備員配置','24時間警備体制を導入','MITIGATE','IN_PROGRESS','2025-08-01'),
('PL012','RSK012',NULL,'施錠ルール再教育','開閉ログも取得','MITIGATE','OPEN','2025-03-25'),
('PL013','RSK013',NULL,'コードレビュー導入','標準手順でレビュー必須化','MITIGATE','OPEN','2025-04-05'),
('PL014','RSK014',NULL,'テスト自動化','ユニット・結合・負荷テストを自動化','MITIGATE','IN_PROGRESS','2025-07-15'),
('PL015','RSK015',NULL,'ライブラリ脆弱性チェック','定期的に脆弱性情報を確認','MITIGATE','NEW','2025-06-30'),
('PL016','RSK016',NULL,'DDoS対策製品導入','WAF/CDNなど導入','MITIGATE','IN_PROGRESS','2025-03-15'),
('PL017','RSK017',NULL,'スケーラビリティ検討','負荷想定とオートスケール案作成','MITIGATE','OPEN','2025-09-01'),
('PL018','RSK018',NULL,'回線冗長化','2系統引き込み','MITIGATE','NEW','2025-05-01'),
('PL019','RSK019',NULL,'認証強化','MFAやパスワードポリシー導入','MITIGATE','IN_PROGRESS','2025-03-20'),
('PL020','RSK020',NULL,'ログ保存延長','ログを1年→3年に延長保管','MITIGATE','OPEN','2025-10-01'),
('PL021','RSK021',NULL,'VLAN再設計','部門ごとにVLAN分割','MITIGATE','OPEN','2025-05-01'),
('PL022','RSK022',NULL,'不正端末検知','NWアクセス制御システム導入','MITIGATE','NEW','2025-06-10'),
('PL023','RSK023',NULL,'公開範囲修正','ストレージ権限をPrivateへ','MITIGATE','IN_PROGRESS','2025-03-01'),
('PL024','RSK024',NULL,'IAMロール見直し','最小権限原則を設定','MITIGATE','OPEN','2025-04-15'),
('PL025','RSK025',NULL,'ポート制限','利用していないポート遮断','MITIGATE','NEW','2025-07-01'),
('PL026','RSK026',NULL,'パッチ計画策定','毎月の定期更新スケジュール化','MITIGATE','IN_PROGRESS','2025-03-05'),
('PL027','RSK027',NULL,'アプリ改修テスト','脆弱性修正後の回帰テスト強化','MITIGATE','OPEN','2025-03-30'),
('PL028','RSK028',NULL,'フィッシング訓練','従業員向け訓練メール送付','MITIGATE','NEW','2025-05-20'),
('PL029','RSK029',NULL,'研修マニュアル整備','セキュリティ意識向上','MITIGATE','IN_PROGRESS','2025-08-01'),
('PL030','RSK030',NULL,'バックアップスクリプト修正','週次ジョブ監視を導入','MITIGATE','NEW','2025-02-28'),
('PL031','RSK031',NULL,'手動バックアップ手順','自動失敗時の手動フロー確立','MITIGATE','OPEN','2025-03-10'),
('PL032','RSK032',NULL,'海外拠点セキュリティ監査','定期的に現地監査実施','MITIGATE','IN_PROGRESS','2025-06-15'),
('PL033','RSK033',NULL,'NDA締結交渉','機密保持契約を必須化','MITIGATE','OPEN','2025-03-25'),
('PL034','RSK034',NULL,'SCADAネット分離','VPNまたはDMZ経由に変更','MITIGATE','NEW','2025-04-20'),
('PL035','RSK035',NULL,'PLC認証設定','ファームウェア更新＋認証有効化','MITIGATE','OPEN','2025-05-05'),
('PL036','RSK036',NULL,'権限分掌導入','管理者と承認者ロールを分ける','MITIGATE','IN_PROGRESS','2025-06-01'),
('PL037','RSK037',NULL,'アカウント定期棚卸','退職者IDの自動無効化実装','MITIGATE','NEW','2025-07-01'),
('PL038','RSK038',NULL,'操作ログシステム導入','特権操作ログを必須化','MITIGATE','OPEN','2025-04-01'),
('PL039','RSK039',NULL,'私物端末利用禁止','社用PCで鍵管理＆監査','MITIGATE','IN_PROGRESS','2025-05-15'),
('PL040','RSK040',NULL,'ID共有廃止','個人ID発行と監査ログ拡充','MITIGATE','NEW','2025-06-20'),
('PL041','RSK041',NULL,'代替オフィス契約','BCP用のサブオフィスを確保','MITIGATE','NEW','2025-06-01'),
('PL042','RSK042',NULL,'BCP訓練実施','定期的な机上演習＆避難訓練','MITIGATE','OPEN','2025-07-10'),
('PL043','RSK043',NULL,'UPS/自家発電導入','停電時の運用継続策','MITIGATE','IN_PROGRESS','2025-09-01'),
('PL044','RSK044',NULL,'物理鍵管理台帳','持出し/返却を明確化','MITIGATE','OPEN','2025-04-05'),
('PL045','RSK045',NULL,'暗号鍵HSM化','鍵をHSMに格納しアクセス制限','MITIGATE','NEW','2025-05-20'),
('PL046','RSK046',NULL,'マスターキー金庫保管','複製は最小限＆管理者2名承認','MITIGATE','OPEN','2025-06-30'),
('PL047','RSK047',NULL,'工場センサー台帳化','IoT端末を一元管理し認証導入','MITIGATE','NEW','2025-05-15'),
('PL048','RSK048',NULL,'定期FW更新プロセス','ファームウェア更新スケジュール制定','MITIGATE','IN_PROGRESS','2025-08-01'),
('PL049','RSK049',NULL,'DMZ経由接続','外部直結を禁止し中間サーバ設置','MITIGATE','OPEN','2025-07-01'),
('PL050','RSK050',NULL,'不正取引監視システム','機械学習で怪しい送金を検知','MITIGATE','NEW','2025-04-10'),
('PL051','RSK051',NULL,'KYCプロセス強化','本人確認書類精査＆データベース化','MITIGATE','OPEN','2025-05-01'),
('PL052','RSK052',NULL,'複数サプライヤ契約','単一依存を回避する契約戦略','MITIGATE','IN_PROGRESS','2025-08-15'),
('PL053','RSK053',NULL,'災害時バックアップ取引','別地域のサプライヤと提携','MITIGATE','NEW','2025-09-01'),
('PL054','RSK054',NULL,'リソース削除フロー','不要インスタンス自動停止','MITIGATE','OPEN','2025-04-25'),
('PL055','RSK055',NULL,'コスト監視導入','メトリクス収集とアラート設定','MITIGATE','NEW','2025-05-30'),
('PL056','RSK056',NULL,'全社ポリシー整合会議','各部署ルールの統合＆整備','MITIGATE','IN_PROGRESS','2025-07-10'),
('PL057','RSK057',NULL,'セキュリティ基本方針策定','経営陣承認で全社周知','MITIGATE','OPEN','2025-05-05'),
('PL058','RSK058',NULL,'レガシーOSアップグレード','最新版OSへ移行計画推進','MITIGATE','NEW','2025-03-25'),
('PL059','RSK059',NULL,'移行計画プロジェクト','スケジュール＆予算を可視化','MITIGATE','OPEN','2025-06-15'),
('PL060','RSK060',NULL,'テスト環境整備','互換テストを行うステージング導入','MITIGATE','IN_PROGRESS','2025-09-10'),
('PL061','RSK061',NULL,'メールゲートウェイ強化','ウイルス/スパムチェックを強化','MITIGATE','OPEN','2025-08-01'),
('PL062','RSK062',NULL,'誤送信防止ツール導入','宛先チェック・添付暗号化ルール','MITIGATE','NEW','2025-05-30'),
('PL063','RSK063',NULL,'IAM統合プロジェクト','AWS/Azureのロール統一','MITIGATE','IN_PROGRESS','2025-09-01'),
('PL064','RSK064',NULL,'クラウドコストダッシュボード','支払い状況の可視化とアラート','MITIGATE','OPEN','2025-06-10'),
('PL065','RSK065',NULL,'不正決済監視システム','機械学習で異常スコア計算','MITIGATE','NEW','2025-04-25'),
('PL066','RSK066',NULL,'融資リスクスコア策定','個人属性と与信情報を基にスコア化','MITIGATE','OPEN','2025-07-15'),
('PL067','RSK067',NULL,'災害BCP策定','地震・洪水時の手順/連絡網整備','MITIGATE','IN_PROGRESS','2025-10-01'),
('PL068','RSK068',NULL,'DRサイト構築','別地域にデータセンター用意','MITIGATE','NEW','2025-12-01'),
('PL069','RSK069',NULL,'データ分類ポリシー','機密/社外秘/一般など区分定義','MITIGATE','OPEN','2025-06-30'),
('PL070','RSK070',NULL,'マスキングまたはモック使用','開発環境で実データ使わない方策','MITIGATE','NEW','2025-04-30'),
('PL071','RSK071',NULL,'定期キー更新手順','キーを年1回以上ローテ','MITIGATE','OPEN','2025-05-20'),
('PL072','RSK072',NULL,'鍵保管レポジトリ整理','GitOpsやVaultで一元管理','MITIGATE','IN_PROGRESS','2025-08-05'),
('PL073','RSK073',NULL,'在宅端末管理ガイドライン','EDR導入やOS更新徹底','MITIGATE','NEW','2025-05-15'),
('PL074','RSK074',NULL,'Wi-Fi暗号化更新','WPA2/WPA3に切替＋PSK強化','MITIGATE','OPEN','2025-07-01'),
('PL075','RSK075',NULL,'VPN利用手順確立','専用クライアントと認証強化','MITIGATE','NEW','2025-05-10'),
('PL076','RSK076',NULL,'ビルドチェーン監査','アップストリーム改ざんを検証','MITIGATE','IN_PROGRESS','2025-07-20'),
('PL077','RSK077',NULL,'OSS脆弱性チェックCI','CI上でDependencyスキャン実施','MITIGATE','NEW','2025-06-30'),
('PL078','RSK078',NULL,'署名検証フロー導入','すべての依存ライブラリを署名確認','MITIGATE','OPEN','2025-09-01'),
('PL079','RSK079',NULL,'SPF/DMARC設定実施','ドメインなりすましを阻止','MITIGATE','NEW','2025-05-25'),
('PL080','RSK080',NULL,'クラウドフォルダ権限設定','重要データは管理者限定アクセス','MITIGATE','OPEN','2025-08-15');


-- 資産リスク関連付け
INSERT INTO AssetRisk (asset_risk_id, asset_id, risk_id)
VALUES
('AR001','AST001','RSK001'),
('AR002','AST002','RSK002'),
('AR003','AST003','RSK003'),
('AR004','AST004','RSK004'),
('AR005','AST005','RSK005'),
('AR006','AST006','RSK006'),
('AR007','AST007','RSK007'),
('AR008','AST008','RSK008');
('AR017','AST021','RSK041'),
('AR018','AST022','RSK042'),
('AR019','AST023','RSK043'),
('AR020','AST024','RSK044'),
('AR021','AST025','RSK045'),
('AR022','AST026','RSK046'),
('AR023','AST027','RSK047'),
('AR024','AST028','RSK048'),
('AR025','AST031','RSK061'),
('AR026','AST032','RSK062'),
('AR027','AST033','RSK063'),
('AR028','AST034','RSK064'),
('AR029','AST035','RSK065'),
('AR030','AST036','RSK066'),
('AR031','AST037','RSK067'),
('AR032','AST038','RSK068');