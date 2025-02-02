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