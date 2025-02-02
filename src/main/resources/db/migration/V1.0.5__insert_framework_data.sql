-- ComplianceFrameworkテーブルのマスターデータ
INSERT INTO ComplianceFramework (
    framework_code,
    name,
    description
) VALUES
('ISO27001_2022', 'ISO/IEC 27001:2022', 'Information Security Management System (2022年版)'),
('PMARK', 'プライバシーマーク', '個人情報保護マネジメントシステム - JIS Q 15001:2017'),
('PCI_DSS', 'PCI DSS 4.0', 'Payment Card Industry Data Security Standard'),
('ISO9001', 'ISO 9001:2015', 'Quality Management System'),
('ISO14001', 'ISO 14001:2015', 'Environmental Management System'),
('SOC2', 'SOC 2 Type2', 'Service Organization Control 2'),
('NIST_CSF', 'NIST Cybersecurity Framework 1.1', 'NISTサイバーセキュリティフレームワーク');

-- ISO27001:2022の要求事項データの挿入
INSERT INTO Requirement (requirement_id, framework_code, title, description)
VALUES
('REQ-ISO27001-A5.1.1', 'ISO27001_2022', '情報セキュリティポリシー', '組織の目的に対して適切な情報セキュリティポリシーを定義し、文書化すること'),
('REQ-ISO27001-A6.2.2', 'ISO27001_2022', 'テレワークのセキュリティ', 'テレワーク環境における情報のアクセス、処理、保存を保護するためのポリシーと対策を実装すること'),
('REQ-ISO27001-A7.2.2', 'ISO27001_2022', '情報セキュリティ意識向上', '組織の全ての要員が、情報セキュリティに関する意識向上のための適切な教育・訓練を受けること'),
('REQ-ISO27001-A7.3.1', 'ISO27001_2022', '雇用の終了または変更', '雇用の終了または変更時における情報セキュリティ上の責任と義務を定義し、伝達すること'),
('REQ-ISO27001-A8.2.3', 'ISO27001_2022', '資産の取扱い', '組織の資産の取扱いに関する手順を策定し、実施すること'),
('REQ-ISO27001-A8.3.1', 'ISO27001_2022', '資産の管理', '情報及び情報処理施設に関連する資産を特定し、管理すること'),
('REQ-ISO27001-A9.2.1', 'ISO27001_2022', 'アクセス制御方針', '業務及び情報セキュリティの要求事項に基づいてアクセス制御方針を確立し、文書化し、レビューすること'),
('REQ-ISO27001-A12.1.1', 'ISO27001_2022', '運用の手順', '運用手順を文書化し、維持し、利用可能にすること'),
('REQ-ISO27001-A12.2.1', 'ISO27001_2022', 'マルウェアからの保護', 'マルウェアからの保護のための検出、予防及び回復のための対策を実施すること'),
('REQ-ISO27001-A12.4.1', 'ISO27001_2022', 'イベントログ取得', 'ユーザ活動、例外、障害及び情報セキュリティ事象を記録するイベントログを取得し、保持し、定期的にレビューすること'),
('REQ-ISO27001-A12.6.1', 'ISO27001_2022', '技術的ぜい弱性管理', '利用中の情報システムの技術的ぜい弱性に関する情報を適時に獲得し、組織のそれらのぜい弱性に対する暴露を評価し、適切な対策を講じること'),
('REQ-ISO27001-A13.2.1', 'ISO27001_2022', '情報転送のポリシー', '情報転送に関するポリシー、手順及び管理策を定め、実施すること'),
('REQ-ISO27001-A14.1.1', 'ISO27001_2022', '情報セキュリティ要求事項の分析', '情報セキュリティに関連する要求事項を、新規の情報システム又は既存の情報システムの改善に関する要求事項に含めること'),
('REQ-ISO27001-A15.1.1', 'ISO27001_2022', 'サプライヤー関係のセキュリティ', 'サプライヤーとの関係における情報セキュリティを保護するための方針を合意し、文書化すること'),
('REQ-ISO27001-A17.1.1', 'ISO27001_2022', '事業継続計画', '情報セキュリティ継続を組織の事業継続マネジメントシステムに組み込むこと'),
('REQ-ISO27001-A18.1.1', 'ISO27001_2022', '法的要求事項の特定', '各情報システム及び組織について、関連する法令、規制及び契約上の要求事項、並びにこれらの要求事項を満たすための組織の取組みを明確に特定し、文書化し、最新に保つこと'),
('REQ-ISO27001-A18.1.4', 'ISO27001_2022', 'プライバシー保護', '個人情報保護及びプライバシー保護は、関連する法令及び規制の確実な遵守を図ること'),
```sql
INSERT INTO Requirement (requirement_id, framework_code, title, description)
VALUES
('REQ-ISO27001-A5.1.1', 'ISO27001_2022', '情報セキュリティポリシー', '組織の目的に対して適切な情報セキュリティポリシーを定義し、文書化すること'),
('REQ-ISO27001-A6.2.2', 'ISO27001_2022', 'テレワークのセキュリティ', 'テレワーク環境における情報のアクセス、処理、保存を保護するためのポリシーと対策を実装すること'),
('REQ-ISO27001-A7.2.2', 'ISO27001_2022', '情報セキュリティ意識向上', '組織の全ての要員が、情報セキュリティに関する意識向上のための適切な教育・訓練を受けること'),
('REQ-ISO27001-A7.3.1', 'ISO27001_2022', '雇用の終了または変更', '雇用の終了または変更時における情報セキュリティ上の責任と義務を定義し、伝達すること'),
('REQ-ISO27001-A8.2.3', 'ISO27001_2022', '資産の取扱い', '組織の資産の取扱いに関する手順を策定し、実施すること'),
('REQ-ISO27001-A8.3.1', 'ISO27001_2022', '資産の管理', '情報及び情報処理施設に関連する資産を特定し、管理すること'),
('REQ-ISO27001-A9.2.1', 'ISO27001_2022', 'アクセス制御方針', '業務及び情報セキュリティの要求事項に基づいてアクセス制御方針を確立し、文書化し、レビューすること'),
('REQ-ISO27001-A12.1.1', 'ISO27001_2022', '運用の手順', '運用手順を文書化し、維持し、利用可能にすること'),
('REQ-ISO27001-A12.2.1', 'ISO27001_2022', 'マルウェアからの保護', 'マルウェアからの保護のための検出、予防及び回復のための対策を実施すること'),
('REQ-ISO27001-A12.4.1', 'ISO27001_2022', 'イベントログ取得', 'ユーザ活動、例外、障害及び情報セキュリティ事象を記録するイベントログを取得し、保持し、定期的にレビューすること'),
('REQ-ISO27001-A12.6.1', 'ISO27001_2022', '技術的ぜい弱性管理', '利用中の情報システムの技術的ぜい弱性に関する情報を適時に獲得し、組織のそれらのぜい弱性に対する暴露を評価し、適切な対策を講じること'),
('REQ-ISO27001-A13.2.1', 'ISO27001_2022', '情報転送のポリシー', '情報転送に関するポリシー、手順及び管理策を定め、実施すること'),
('REQ-ISO27001-A14.1.1', 'ISO27001_2022', '情報セキュリティ要求事項の分析', '情報セキュリティに関連する要求事項を、新規の情報システム又は既存の情報システムの改善に関する要求事項に含めること'),
('REQ-ISO27001-A15.1.1', 'ISO27001_2022', 'サプライヤー関係のセキュリティ', 'サプライヤーとの関係における情報セキュリティを保護するための方針を合意し、文書化すること'),
('REQ-ISO27001-A17.1.1', 'ISO27001_2022', '事業継続計画', '情報セキュリティ継続を組織の事業継続マネジメントシステムに組み込むこと'),
('REQ-ISO27001-A18.1.1', 'ISO27001_2022', '法的要求事項の特定', '各情報システム及び組織について、関連する法令、規制及び契約上の要求事項、並びにこれらの要求事項を満たすための組織の取組みを明確に特定し、文書化し、最新に保つこと'),
('REQ-ISO27001-A18.1.4', 'ISO27001_2022', 'プライバシー保護', '個人情報保護及びプライバシー保護は、関連する法令及び規制の確実な遵守を図ること'),
('REQ-ISO27001-A5.2.1', 'ISO27001_2022', 'セキュリティ役割と責任の明確化', '情報セキュリティ管理の役割と責任を明文化し、周知すること'),
('REQ-ISO27001-A5.2.2', 'ISO27001_2022', '方針の入手可能性', '策定したセキュリティポリシーを全従業員が参照できる状態に維持すること'),
('REQ-ISO27001-A5.3.1', 'ISO27001_2022', '方針の承認と整合性', 'セキュリティポリシーを経営層が正式承認し、組織全体の方針や目的と整合させること'),
('REQ-ISO27001-A6.1.1', 'ISO27001_2022', 'リスクアセスメントプロセス', '組織のリスクアセスメント手順を定義し、ドキュメント化すること'),
('REQ-ISO27001-A6.1.2', 'ISO27001_2022', '情報セキュリティ目標', 'リスク対応計画に基づき、情報セキュリティ目標を定義し、モニタリングすること'),
('REQ-ISO27001-A6.1.3', 'ISO27001_2022', 'リスク対応計画の更新', 'リスク状況の変化に応じて、リスク対応計画を定期的に見直し、更新すること'),
('REQ-ISO27001-A7.1.1', 'ISO27001_2022', '従業員のセキュリティ責任', '雇用開始時にセキュリティ責任を明示し、誓約書等により認識を徹底すること'),
('REQ-ISO27001-A9.1.1', 'ISO27001_2022', 'アクセス制御要件の識別', '情報資産ごとに必要なアクセス制御要件を識別し、実装の根拠を文書化すること'),
('REQ-ISO27001-A9.1.2', 'ISO27001_2022', 'アクセス認可手続き', 'ユーザアカウントや権限付与の承認手続き・レビュープロセスを定義すること'),
('REQ-ISO27001-A9.2.2', 'ISO27001_2022', '特権的アクセスの管理', 'システム管理者アカウントなど特権的アクセス権限の付与・監視・取り消し手順を整備'),
('REQ-ISO27001-A9.2.3', 'ISO27001_2022', 'アクセス権限の定期レビュー', 'ユーザごとのアクセス権限を定期的にレビューし、不要権限を削除すること'),
('REQ-ISO27001-A10.1.1', 'ISO27001_2022', '暗号化方針の策定', '情報の機密性を維持するための暗号化の方針と使用ガイドラインを作成すること'),
('REQ-ISO27001-A10.2.1', 'ISO27001_2022', '鍵管理', '暗号鍵の生成、配布、廃棄を含む鍵管理手続きを定義し、実施すること'),
('REQ-ISO27001-A14.2.1', 'ISO27001_2022', '開発ライフサイクルのセキュリティ', 'ソフトウェア開発プロセスにセキュリティ要求を組み込み、レビューを実施すること'),
('REQ-ISO27001-A14.3.1', 'ISO27001_2022', 'テスト環境の保護', 'テスト環境での機密データ取り扱いを制限し、適切に保護すること'),
('REQ-ISO27001-A14.3.2', 'ISO27001_2022', '本番環境への移行制御', 'テスト済みコードや設定のみが本番環境へデプロイされるよう変更管理手順を確立すること'),
('REQ-ISO27001-A16.1.1', 'ISO27001_2022', '情報セキュリティインシデント管理方針', 'インシデントを検知・報告・分析し、対応するための方針を策定すること'),
('REQ-ISO27001-A16.1.2', 'ISO27001_2022', 'インシデント対応手順', 'セキュリティインシデント発生時の連絡体制、復旧手順を明文化し、定期訓練すること'),
('REQ-ISO27001-A16.1.3', 'ISO27001_2022', 'インシデント報告の検証', '報告されたインシデントの内容を検証・記録し、再発防止策を検討すること'),
('REQ-ISO27001-A16.1.4', 'ISO27001_2022', '教訓の共有', 'インシデントから得た知見を全組織で共有し、プロセス改善へ反映すること'),
('REQ-ISO27001-A17.2.1', 'ISO27001_2022', '冗長化・バックアップ方針', '重要情報資産の冗長化やバックアップ手順を定義し、定期的にテストすること'),
('REQ-ISO27001-A18.1.5', 'ISO27001_2022', '記録・ログの保護', '監査ログや記録を改ざんや不正アクセスから保護するための管理策を導入すること'),
('REQ-ISO27001-A18.2.3', 'ISO27001_2022', '情報破棄手順', '不要となった情報資産を安全に廃棄・削除するための手順を文書化し、実施すること'),
('REQ-ISO27001-A5.1.2', 'ISO27001_2022', '情報セキュリティポリシーの定期レビュー', '情報セキュリティポリシーを定期的にレビューし、組織の変化や新たな脅威に対応して更新すること'),
('REQ-ISO27001-A5.1.3', 'ISO27001_2022', '情報セキュリティポリシー遵守の監視', 'セキュリティポリシーの遵守状況を継続的に監視し、違反があれば是正措置を実施すること'),
('REQ-ISO27001-A5.3.2', 'ISO27001_2022', 'セキュリティポリシーの改訂プロセス', 'セキュリティポリシーの改訂手順を確立し、担当者と承認プロセスを明確化すること'),
('REQ-ISO27001-A5.4.1', 'ISO27001_2022', '統合セキュリティ方針のライフサイクル管理', '複数のセキュリティ方針を統合的に管理し、ライフサイクル全体を通じて整合性を維持すること');
('REQ-ISO27001-A6.2.1', 'ISO27001_2022', 'リスク評価基準の策定', 'リスクの重大度を一貫して評価するための基準を明文化し、周知すること'),
('REQ-ISO27001-A6.2.3', 'ISO27001_2022', 'リスクアセスメントの追跡管理', 'リスクアセスメント結果に基づく対応状況を追跡し、管理策の有効性を評価すること'),
('REQ-ISO27001-A6.3.1', 'ISO27001_2022', 'セキュリティプロジェクト管理', '情報セキュリティに関するプロジェクトの進捗・リスク・リソースを体系的に管理すること'),
('REQ-ISO27001-A6.3.2', 'ISO27001_2022', '外部利害関係者とのリスク共有', 'ビジネスパートナーや顧客など、外部利害関係者とリスクに関する情報を共有し、共同で対策を検討すること');
('REQ-ISO27001-A7.2.1', 'ISO27001_2022', '要員スクリーニング', '採用時に職務に応じたセキュリティ審査（身元・経歴確認など）を実施すること'),
('REQ-ISO27001-A7.3.2', 'ISO27001_2022', '継続的なセキュリティ教育', '雇用期間中に定期的な情報セキュリティ教育を実施し、新たな脅威や方針変更に対応すること'),
('REQ-ISO27001-A7.4.1', 'ISO27001_2022', '内部脅威への対処', '従業員や内部関係者からの不正行為や情報漏えいに対する監視・検知・対応策を確立すること');
('REQ-ISO27001-A8.1.1', 'ISO27001_2022', '資産目録の作成と維持', '組織の情報資産を特定し、最新の資産目録を維持すること'),
('REQ-ISO27001-A8.2.1', 'ISO27001_2022', '情報分類基準', '機密性や重要度に応じて情報を分類する基準を定義し、運用すること'),
('REQ-ISO27001-A8.3.2', 'ISO27001_2022', '資産廃棄の承認手順', '不要となった情報資産の廃棄方法を定義し、適切な承認プロセスを経て安全に処分すること');
('REQ-ISO27001-A9.3.1', 'ISO27001_2022', 'アクセスログの監視と追跡', 'アクセスログを定期的に監視し、異常なアクセスや権限濫用を追跡できるようにすること'),
('REQ-ISO27001-A9.3.2', 'ISO27001_2022', '多要素認証の導入', '機密度の高いシステムやデータへのアクセスには多要素認証を適用し、不正アクセスを防止すること'),
('REQ-ISO27001-A9.4.1', 'ISO27001_2022', '物理的アクセス制御との連携', '論理アクセス制御と物理アクセス制御を連携させ、総合的なセキュリティレベルを向上させること');
('REQ-ISO27001-A10.1.2', 'ISO27001_2022', '暗号化アルゴリズムの適正評価', '利用する暗号化方式・アルゴリズムの適正性を定期的に評価し、必要に応じて更新すること'),
('REQ-ISO27001-A10.2.2', 'ISO27001_2022', '鍵のライフサイクルレビュー', '鍵の生成、配布、保管、廃棄のライフサイクルを定期的にレビューし、改善すること'),
('REQ-ISO27001-A10.3.1', 'ISO27001_2022', '暗号化装置・ソフトウェアの安全利用', '暗号化に使用するハードウェア・ソフトウェアを安全に管理し、パッチ適用や更新を適切に行うこと');
('REQ-ISO27001-A11.1.1', 'ISO27001_2022', '物理セキュリティ境界の定義', '重要な情報資産を保管するエリアに物理的境界を設定し、侵入対策を講じること'),
('REQ-ISO27001-A11.1.2', 'ISO27001_2022', 'アクセス点の管理', '施設への出入口や受付などのアクセス点を統制し、権限がない者の立ち入りを防止すること'),
('REQ-ISO27001-A11.1.3', 'ISO27001_2022', 'オフィス・部屋・施設の防犯対策', '施設内の部屋やオフィススペースに対して監視カメラや施錠装置などの防犯対策を実装すること'),
('REQ-ISO27001-A11.2.1', 'ISO27001_2022', '機器設置と保護', 'サーバーやネットワーク機器などを適切な場所に設置し、環境リスク（温度、湿度、電源障害など）から保護すること'),
('REQ-ISO27001-A11.2.2', 'ISO27001_2022', 'ライフライン・設備の冗長性確保', '電源やネットワーク回線など重要設備に冗長構成を導入し、障害発生時の影響を最小化すること'),
('REQ-ISO27001-A12.3.1', 'ISO27001_2022', 'バックアップとリカバリテスト', '重要なデータのバックアップを定期的に実施し、復元テストを行って有効性を検証すること'),
('REQ-ISO27001-A12.7.1', 'ISO27001_2022', '監査ログの分析と不正検知', '監査ログを分析する仕組みを整備し、不正行為や不審な挙動を早期に検知できるようにすること'),
('REQ-ISO27001-A13.1.1', 'ISO27001_2022', 'ネットワークセキュリティ管理責任', 'ネットワークセキュリティに関する責任範囲を明確化し、運用チームや管理者に周知すること'),
('REQ-ISO27001-A13.2.2', 'ISO27001_2022', '外部ネットワークとの安全な接続', 'インターネットや外部組織との接続時に暗号化やファイアウォールなどのセキュリティ対策を適用すること'),
('REQ-ISO27001-A14.1.2', 'ISO27001_2022', 'セキュリティ要求事項の文書化', 'システム開発や導入時に必要なセキュリティ要求事項を文書化し、要件定義に組み込むこと'),
('REQ-ISO27001-A14.2.2', 'ISO27001_2022', 'ソフトウェア品質保証とセキュリティテスト', '開発中およびリリース前にソフトウェアの品質保証とセキュリティテストを実施し、脆弱性を特定・修正すること'),
('REQ-ISO27001-A15.1.2', 'ISO27001_2022', 'サプライヤーとの契約管理', 'サプライヤー契約時に明確なセキュリティ要件を盛り込み、継続的に契約内容をレビューすること'),
('REQ-ISO27001-A15.2.1', 'ISO27001_2022', 'サプライヤー監査と評価', 'セキュリティ要求事項の遵守を確認するため、サプライヤーに対する定期的な監査や評価を実施すること'),
('REQ-ISO27001-A16.1.5', 'ISO27001_2022', 'インシデント対応チームの能力評価', 'インシデント対応チームの専門知識や対応スキルを定期的に評価し、必要なトレーニングを実施すること'),
('REQ-ISO27001-A16.2.1', 'ISO27001_2022', 'セキュリティインシデントポータルの運用', '全社的にインシデントを報告・追跡・共有できるポータルサイトを設置し、対応の迅速化を図ること'),
('REQ-ISO27001-A17.1.2', 'ISO27001_2022', '災害対策手順の適切性検証', '自然災害や大規模障害時に対応するための手順書を作成し、シミュレーションや訓練で適切性を検証すること'),
('REQ-ISO27001-A17.2.2', 'ISO27001_2022', '事業継続時のデータ復旧演習', '事業継続計画に基づき、データの復旧手順を定期的にテストし、実効性を検証すること');
('REQ-ISO27001-A18.1.2', 'ISO27001_2022', '法的リスク評価と契約上の制約', '法令や規制、契約上の要求事項に対するリスクを評価し、違反がないよう管理策を講じること'),
('REQ-ISO27001-A18.1.3', 'ISO27001_2022', '著作権・ライセンス遵守', 'ソフトウェアやコンテンツのライセンス条件および著作権を遵守し、違反が発生しないよう管理すること'),
('REQ-ISO27001-A18.2.1', 'ISO27001_2022', '機密情報廃棄の監査', '機密情報の廃棄手順が正しく実行されているかを監査し、証跡を確保すること'),
 -- A5 (情報セキュリティポリシー関連)
    ('REQ-ISO27001-A5.1.2', 'ISO27001_2022', '情報セキュリティポリシーの定期レビュー', '情報セキュリティポリシーを定期的にレビューし、組織の変化や新たな脅威に対応して更新すること'),
    ('REQ-ISO27001-A5.1.3', 'ISO27001_2022', '情報セキュリティポリシー遵守の監視', 'セキュリティポリシーの遵守状況を継続的に監視し、違反があれば是正措置を実施すること'),
    ('REQ-ISO27001-A5.3.2', 'ISO27001_2022', 'セキュリティポリシーの改訂プロセス', 'セキュリティポリシーの改訂手順を確立し、担当者と承認プロセスを明確化すること'),
    ('REQ-ISO27001-A5.4.1', 'ISO27001_2022', '統合セキュリティ方針のライフサイクル管理', '複数のセキュリティ方針を統合的に管理し、ライフサイクル全体を通じて整合性を維持すること'),

    -- A6 (リスクマネジメント・セキュリティ組織)
    ('REQ-ISO27001-A6.2.1', 'ISO27001_2022', 'リスク評価基準の策定', 'リスクの重大度を一貫して評価するための基準を明文化し、周知すること'),
    ('REQ-ISO27001-A6.2.3', 'ISO27001_2022', 'リスクアセスメントの追跡管理', 'リスクアセスメント結果に基づく対応状況を追跡し、管理策の有効性を評価すること'),
    ('REQ-ISO27001-A6.3.1', 'ISO27001_2022', 'セキュリティプロジェクト管理', '情報セキュリティに関するプロジェクトの進捗・リスク・リソースを体系的に管理すること'),
    ('REQ-ISO27001-A6.3.2', 'ISO27001_2022', '外部利害関係者とのリスク共有', 'ビジネスパートナーや顧客など、外部利害関係者とリスクに関する情報を共有し、共同で対策を検討すること'),

    -- A7 (人的セキュリティ)
    ('REQ-ISO27001-A7.2.1', 'ISO27001_2022', '要員スクリーニング', '採用時に職務に応じたセキュリティ審査（身元・経歴確認など）を実施すること'),
    ('REQ-ISO27001-A7.3.2', 'ISO27001_2022', '継続的なセキュリティ教育', '雇用期間中に定期的な情報セキュリティ教育を実施し、新たな脅威や方針変更に対応すること'),
    ('REQ-ISO27001-A7.4.1', 'ISO27001_2022', '内部脅威への対処', '従業員や内部関係者からの不正行為や情報漏えいに対する監視・検知・対応策を確立すること'),

    -- A8 (資産管理)
    ('REQ-ISO27001-A8.1.1', 'ISO27001_2022', '資産目録の作成と維持', '組織の情報資産を特定し、最新の資産目録を維持すること'),
    ('REQ-ISO27001-A8.2.1', 'ISO27001_2022', '情報分類基準', '機密性や重要度に応じて情報を分類する基準を定義し、運用すること'),
    ('REQ-ISO27001-A8.3.2', 'ISO27001_2022', '資産廃棄の承認手順', '不要となった情報資産の廃棄方法を定義し、適切な承認プロセスを経て安全に処分すること'),

    -- A9 (アクセス制御)
    ('REQ-ISO27001-A9.3.1', 'ISO27001_2022', 'アクセスログの監視と追跡', 'アクセスログを定期的に監視し、異常なアクセスや権限濫用を追跡できるようにすること'),
    ('REQ-ISO27001-A9.3.2', 'ISO27001_2022', '多要素認証の導入', '機密度の高いシステムやデータへのアクセスには多要素認証を適用し、不正アクセスを防止すること'),
    ('REQ-ISO27001-A9.4.1', 'ISO27001_2022', '物理的アクセス制御との連携', '論理アクセス制御と物理アクセス制御を連携させ、総合的なセキュリティレベルを向上させること'),

    -- A10 (暗号化)
    ('REQ-ISO27001-A10.1.2', 'ISO27001_2022', '暗号化アルゴリズムの適正評価', '利用する暗号化方式・アルゴリズムの適正性を定期的に評価し、必要に応じて更新すること'),
    ('REQ-ISO27001-A10.2.2', 'ISO27001_2022', '鍵のライフサイクルレビュー', '鍵の生成、配布、保管、廃棄のライフサイクルを定期的にレビューし、改善すること'),
    ('REQ-ISO27001-A10.3.1', 'ISO27001_2022', '暗号化装置・ソフトウェアの安全利用', '暗号化に使用するハードウェア・ソフトウェアを安全に管理し、パッチ適用や更新を適切に行うこと'),

    -- A11 (物理的セキュリティと環境セキュリティ)
    ('REQ-ISO27001-A11.1.1', 'ISO27001_2022', '物理セキュリティ境界の定義', '重要な情報資産を保管するエリアに物理的境界を設定し、侵入対策を講じること'),
    ('REQ-ISO27001-A11.1.2', 'ISO27001_2022', 'アクセス点の管理', '施設への出入口や受付などのアクセス点を統制し、権限がない者の立ち入りを防止すること'),
    ('REQ-ISO27001-A11.1.3', 'ISO27001_2022', 'オフィス・部屋・施設の防犯対策', '施設内の部屋やオフィススペースに対して監視カメラや施錠装置などの防犯対策を実装すること'),
    ('REQ-ISO27001-A11.2.1', 'ISO27001_2022', '機器設置と保護', 'サーバーやネットワーク機器などを適切な場所に設置し、環境リスク（温度、湿度、電源障害など）から保護すること'),
    ('REQ-ISO27001-A11.2.2', 'ISO27001_2022', 'ライフライン・設備の冗長性確保', '電源やネットワーク回線など重要設備に冗長構成を導入し、障害発生時の影響を最小化すること'),

    -- A12 (運用のセキュリティ)
    ('REQ-ISO27001-A12.3.1', 'ISO27001_2022', 'バックアップとリカバリテスト', '重要なデータのバックアップを定期的に実施し、復元テストを行って有効性を検証すること'),
    ('REQ-ISO27001-A12.7.1', 'ISO27001_2022', '監査ログの分析と不正検知', '監査ログを分析する仕組みを整備し、不正行為や不審な挙動を早期に検知できるようにすること'),

    -- A13 (通信のセキュリティ)
    ('REQ-ISO27001-A13.1.1', 'ISO27001_2022', 'ネットワークセキュリティ管理責任', 'ネットワークセキュリティに関する責任範囲を明確化し、運用チームや管理者に周知すること'),
    ('REQ-ISO27001-A13.2.2', 'ISO27001_2022', '外部ネットワークとの安全な接続', 'インターネットや外部組織との接続時に暗号化やファイアウォールなどのセキュリティ対策を適用すること'),

    -- A14 (システム開発・調達・保守)
    ('REQ-ISO27001-A14.1.2', 'ISO27001_2022', 'セキュリティ要求事項の文書化', 'システム開発や導入時に必要なセキュリティ要求事項を文書化し、要件定義に組み込むこと'),
    ('REQ-ISO27001-A14.2.2', 'ISO27001_2022', 'ソフトウェア品質保証とセキュリティテスト', '開発中およびリリース前にソフトウェアの品質保証とセキュリティテストを実施し、脆弱性を特定・修正すること'),

    -- A15 (サプライヤー関係のセキュリティ)
    ('REQ-ISO27001-A15.1.2', 'ISO27001_2022', 'サプライヤーとの契約管理', 'サプライヤー契約時に明確なセキュリティ要件を盛り込み、継続的に契約内容をレビューすること'),
    ('REQ-ISO27001-A15.2.1', 'ISO27001_2022', 'サプライヤー監査と評価', 'セキュリティ要求事項の遵守を確認するため、サプライヤーに対する定期的な監査や評価を実施すること'),

    -- A16 (情報セキュリティインシデント管理)
    ('REQ-ISO27001-A16.1.5', 'ISO27001_2022', 'インシデント対応チームの能力評価', 'インシデント対応チームの専門知識や対応スキルを定期的に評価し、必要なトレーニングを実施すること'),
    ('REQ-ISO27001-A16.2.1', 'ISO27001_2022', 'セキュリティインシデントポータルの運用', '全社的にインシデントを報告・追跡・共有できるポータルサイトを設置し、対応の迅速化を図ること'),

    -- A17 (事業継続管理)
    ('REQ-ISO27001-A17.1.2', 'ISO27001_2022', '災害対策手順の適切性検証', '自然災害や大規模障害時に対応するための手順書を作成し、シミュレーションや訓練で適切性を検証すること'),
    ('REQ-ISO27001-A17.2.2', 'ISO27001_2022', '事業継続時のデータ復旧演習', '事業継続計画に基づき、データの復旧手順を定期的にテストし、実効性を検証すること'),

    -- A18 (適合性)
    ('REQ-ISO27001-A18.1.2', 'ISO27001_2022', '法的リスク評価と契約上の制約', '法令や規制、契約上の要求事項に対するリスクを評価し、違反がないよう管理策を講じること'),
    ('REQ-ISO27001-A18.1.3', 'ISO27001_2022', '著作権・ライセンス遵守', 'ソフトウェアやコンテンツのライセンス条件および著作権を遵守し、違反が発生しないよう管理すること'),
    ('REQ-ISO27001-A18.2.1', 'ISO27001_2022', '機密情報廃棄の監査', '機密情報の廃棄手順が正しく実行されているかを監査し、証跡を確保すること');
