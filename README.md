# コンプライアンス管理システム

## 概要
このプロジェクトは、組織のコンプライアンス管理を効率化するためのシステムです。

## 技術スタック
- Java 21
- Kotlin 2.1.0
- Spring Boot 3.2.2
- Spring Framework 6.2.x
- jOOQ 3.19.1
- MySQL 8.0
- Flyway 9.22.3
- Gradle 8.12.x

## 開発環境のセットアップ

### 必要条件
- JDK 21
- MySQL 8.0
- Docker（オプション）

### データベースの設定
1. MySQLサーバーを起動
2. 以下のデータベースとユーザーを作成：
```sql
CREATE DATABASE compliance_management_system;
CREATE USER 'compliance_user'@'localhost' IDENTIFIED BY 'compliance_pass';
GRANT ALL PRIVILEGES ON compliance_management_system.* TO 'compliance_user'@'localhost';
FLUSH PRIVILEGES;
```

## Gradleタスク

### データベース関連

#### データベース接続テスト
```bash
./gradlew testDatabaseConnection
```
データベースへの接続をテストします。接続情報が正しく設定されているか確認できます。

#### マイグレーション状態の確認
```bash
./gradlew flywayInfo
```
現在のデータベースマイグレーションの状態を表示します。

#### マイグレーションの実行
```bash
./gradlew flywayMigrate
```
データベースマイグレーションを実行します。

#### マイグレーションのクリーンアップ
```bash
./gradlew flywayClean
```
注意：すべてのデータベースオブジェクトを削除します。開発環境でのみ使用してください。

### コード生成

#### jOOQコードの生成
```bash
./gradlew generateJooq
```
データベーススキーマからjOOQのコードを生成します。

### データベース初期化（マイグレーション + jOOQ生成）
```bash
./gradlew initDatabase
```
データベースのマイグレーションを実行し、jOOQコードを生成します。

### ビルドとテスト

#### プロジェクトのビルド
```bash
./gradlew build
```

#### テストの実行
```bash
./gradlew test
```

#### アプリケーションの実行
```bash
./gradlew bootRun
```

## 開発フロー

1. データベースの準備
```bash
./gradlew testDatabaseConnection  # DB接続確認
./gradlew flywayMigrate          # マイグレーション実行
./gradlew generateJooq           # jOOQコード生成
```

2. アプリケーションの実行
```bash
./gradlew bootRun
```

## 環境変数
プロジェクトルートに`.env`ファイルを作成し、以下の環境変数を設定してください：

```properties
DB_HOST=localhost
DB_PORT=3306
DB_NAME=compliance_management_system
DB_USER=compliance_user
DB_PASSWORD=compliance_pass
```

## プロジェクト構成
プロジェクトはDDD（ドメイン駆動設計）の原則に従って構成されています：

```
src/
├── main/
│   ├── kotlin/
│   │   └── com/example/project/
│   │       ├── user/           # ユーザー集約
│   │       ├── order/          # 注文集約
│   │       └── shared/         # 共有コンポーネント
│   └── resources/
│       ├── application.yml
│       └── db/migration/       # Flywayマイグレーション
└── test/
    └── kotlin/
```

## 注意事項
- 本番環境では`flywayClean`を使用しないでください。
- 環境変数は`.env`ファイルで管理し、バージョン管理システムにコミットしないでください。
- マイグレーションファイルは一度コミットした後、変更しないでください。

## データベース操作

### Gradleタスク一覧

#### データベース初期化
```bash
# データベースの初期化（マイグレーションとjOOQ生成）
./gradlew initDatabase
```

#### マイグレーション
```bash
# マイグレーションの実行
./gradlew flywayMigrate

# マイグレーション状態の確認
./gradlew flywayInfo

# マイグレーションのクリーン（全テーブル削除）
./gradlew flywayClean
```

#### データ操作
```bash
# 全テーブルのデータをクリアし、マイグレーションを再実行
./gradlew clearAllData

# サンプルデータの投入
./gradlew loadTransactionData
```

#### 接続テスト
```bash
# データベース接続テスト
./gradlew testDatabaseConnection
```

### タスクの説明

1. `initDatabase`
   - データベースの初期化を行います
   - マイグレーションの実行とjOOQクラスの生成を行います

2. `clearAllData`
   - 全テーブルのデータをクリアします
   - 外部キー制約を考慮した安全なクリア処理を行います
   - マイグレーションを自動的に再実行します

3. `loadTransactionData`
   - サンプルデータをデータベースに投入します
   - `src/main/resources/db/transactiondata`配下のSQLを実行します

4. `testDatabaseConnection`
   - データベースへの接続テストを行います
   - JDBCドライバーの登録状態も確認できます

### 使用例

#### 開発環境のリセット
```bash
# 1. 全データのクリア＆マイグレーション
./gradlew clearAllData

# 2. サンプルデータの投入
./gradlew loadTransactionData
```

#### 接続確認
```bash
# データベース接続の確認
./gradlew testDatabaseConnection
```

### 注意事項

1. `clearAllData`は全てのデータを削除します。実行前に必要なデータのバックアップを確認してください。
2. 本番環境では`cleanDisabled = true`に設定し、誤ってデータを削除しないよう注意してください。
3. サンプルデータの投入は開発環境でのみ使用してください。 

## データベース構成

システムは以下の7つのデータベースで構成されています：

1. コードマスタDB (code_master_db)
2. 組織管理DB (organization_db)
3. フレームワーク管理DB (framework_db)
4. 監査管理DB (audit_db)
5. リスク管理DB (risk_db)
6. 文書・資産管理DB (document_asset_db)
7. 教育管理DB (training_db)

## Flywayマイグレーションコマンド

### 全DBのマイグレーション実行
```bash
./gradlew flywayMigrateAll
```

### 個別DBのマイグレーション

#### コードマスタDB
```bash
./gradlew flywayMigrateCodeMaster
```

#### 組織管理DB
```bash
./gradlew flywayMigrateOrganization
```

#### フレームワーク管理DB
```bash
./gradlew flywayMigrateFramework
```

#### 監査管理DB
```bash
./gradlew flywayMigrateAudit
```

#### リスク管理DB
```bash
./gradlew flywayMigrateRisk
```

#### 文書・資産管理DB
```bash
./gradlew flywayMigrateDocumentAsset
```

#### 教育管理DB
```bash
./gradlew flywayMigrateTraining
```

### マイグレーションファイルの配置

各DBのマイグレーションファイルは以下のディレクトリに配置します：

```
src/main/resources/db/migration/
├── code_master_db/
├── organization_db/
├── framework_db/
├── audit_db/
├── risk_db/
├── document_asset_db/
└── training_db/
```

### マイグレーションファイルの命名規則

- バージョン番号は `V1.0.0` のような形式を使用
- ファイル名は `V{バージョン}__{説明}.sql` の形式
- 例: `V1.0.0__create_m_code_table.sql`

### データベース接続情報

各DBは以下の接続情報で設定されています：

- ホスト: localhost
- ポート: 3306
- ユーザー: root
- パスワード: root
- 文字コード: utf8mb4
- 照合順序: utf8mb4_unicode_ci

### 注意事項

1. マイグレーション実行前に、必要なデータベースが作成されていることを確認してください。
2. 各DBは独立して管理され、クロスDB参照は論理的な参照として扱われます。
3. アプリケーション層でデータの整合性を確保します。

## データベースの初期化とデータ投入手順

### 1. データベースの作成
以下のコマンドでMySQLに必要なデータベースを作成します：

```sql
CREATE DATABASE code_master_db;
CREATE DATABASE organization_db;
CREATE DATABASE framework_db;
CREATE DATABASE audit_db;
CREATE DATABASE risk_db;
CREATE DATABASE document_asset_db;
CREATE DATABASE training_db;
```

### 2. マイグレーションの実行
以下の順序でマイグレーションを実行します：

```bash
# 全データベースのマイグレーション実行
./gradlew flywayMigrateAll

# エラーが発生した場合は、個別にクリーンとマイグレーションを実行
./gradlew flywayCleanAudit flywayMigrateAudit        # 監査管理DB
./gradlew flywayCleanCodeMaster flywayMigrateCodeMaster  # コードマスタDB
```

### 3. サンプルデータの投入
マイグレーション完了後、以下のコマンドでサンプルデータを投入します：

```bash
./gradlew loadAllData
```

このコマンドは以下のデータを順次投入します：
- コードマスタデータ
- 組織データ
- フレームワークデータ
- 監査データ
- リスクデータ
- 文書・資産データ
- 教育データ

### 注意事項
- マイグレーションやデータ投入中にエラーが発生した場合は、エラーメッセージを確認し、必要に応じて個別のデータベースに対してクリーンとマイグレーションを実行してください。
- 本番環境では、`flywayClean`コマンドを使用しないでください。
- データ投入は開発環境でのみ実行してください。