# ユニットテスト実装と実行の方針

## 1. 基本方針

### 1.1. テストコードの配置
- テストコードは `src/test/kotlin` 配下に配置
- テストリソース（SQL等）は `src/test/resources` 配下に配置
- プロダクションコードとテストコードは完全に分離

### 1.2. テストデータベースの取り扱い
- テストDBはテスト実行前に毎回クリーンアップ
- テストに必要なマイグレーションファイルは `src/test/resources/db/migration` で管理
- プロダクションのマイグレーションファイルは一切変更しない

## 2. Gradleタスク構成

### 2.1. テスト用データベース準備タスク
```kotlin
// build.gradle.kts

tasks.register("cleanTestDb") {
    group = "verification"
    description = "Cleans test database before running tests"
    doLast {
        flyway {
            url = "jdbc:mysql://localhost:3307/compliance_management_system_test"
            user = "root"
            password = "root"
            cleanDisabled = false
            clean()
        }
    }
}

tasks.register("migrateTestDb") {
    group = "verification"
    description = "Applies migrations to test database"
    dependsOn("cleanTestDb")
    doLast {
        flyway {
            url = "jdbc:mysql://localhost:3307/compliance_management_system_test"
            user = "root"
            password = "root"
            locations = arrayOf("classpath:db/migration", "classpath:db/migration/test")
            migrate()
        }
    }
}

tasks.test {
    dependsOn("migrateTestDb")
}
```

### 2.2. テスト実行の流れ
1. `cleanTestDb`: テストDB初期化
2. `migrateTestDb`: テスト用マイグレーション実行
3. `test`: ユニットテスト実行

## 3. マイグレーションファイル管理

### 3.1. テスト用マイグレーションファイルの配置
```
src/test/resources/
└── db/
    └── migration/
        ├── V1.0.1__insert_test_master_data.sql  # テスト用マスタデータ
        └── V1.0.2__insert_test_data.sql         # テストケース用データ
```

### 3.2. マイグレーションファイル管理の原則
1. テーブル定義
   - プロダクションのマイグレーションファイルを直接利用
   - Flywayの設定で、プロダクションとテストの両方のマイグレーションパスを指定
   ```kotlin
   flyway {
       locations = arrayOf(
           "classpath:db/migration",      // プロダクションのマイグレーション
           "classpath:db/migration/test"  // テスト用データ
       )
   }
   ```

2. テストデータ
   - テストに必要な最小限のデータのみを投入
   - データは各テストの意図が明確になるように設計
   - テストケース間で独立したデータセットを使用

3. マイグレーションファイルの命名規則
   - プレフィックス: `V`
   - バージョン番号: プロダクションの最終バージョンの後に続く番号から開始
   - 説明: アンダースコア2つで区切る
   - 拡張子: `.sql`

### 3.3. 禁止事項
- ✘ プロダクションのテーブル定義の複製
- ✘ テスト用のカラム追加
- ✘ テスト用のインデックスや制約の変更
- ✘ テスト用の型や長さの変更

### 3.4. 推奨プラクティス
1. テストデータの投入
   ```sql
   -- V1.0.1__insert_test_master_data.sql
   INSERT INTO M_CODE (code_category, code, name) VALUES
   ('USER_ROLE', 'ADMIN', '管理者'),
   ('USER_ROLE', 'USER', '一般ユーザー');
   ```

2. Gradleタスクの設定
   ```kotlin
   tasks.register("migrateTestDb") {
       group = "verification"
       description = "Applies migrations to test database"
       dependsOn("cleanTestDb")
       doLast {
           flyway {
               url = "jdbc:mysql://localhost:3307/compliance_management_system_test"
               user = "root"
               password = "root"
               locations = arrayOf(
                   "classpath:db/migration",      // プロダクションのマイグレーション
                   "classpath:db/migration/test"  // テスト用データ
               )
               migrate()
           }
       }
   }
   ```

## 4. テストデータ管理

### 4.1. テストデータの種類と配置
1. マスタデータ
   - 共通で使用する最小限のマスタデータ
   - `V1.0.1__insert_test_master_data.sql` で管理

2. テストケース固有データ
   - 各テストケースで必要なデータ
   - `V1.0.2__insert_test_data.sql` で管理
   - または、テストクラス内でセットアップ時に投入

### 4.2. テストデータ作成の原則
- 必要最小限のデータのみを作成
- テストの意図が明確になるようなデータ設計
- 他のテストケースに影響を与えない独立したデータ

## 5. 禁止事項

### 5.1. プロダクションコード関連
- ✘ プロダクションのマイグレーションファイルをテストのために変更
- ✘ テスト用の条件分岐をプロダクションコードに追加
- ✘ テスト用の設定をプロダクション設定ファイルに混在

### 5.2. テストコード関連
- ✘ プロダクションのマイグレーションファイルをテストから直接参照
- ✘ テスト間でデータを共有（テストの独立性を損なう）
- ✘ 実環境のDBに接続するテストの作成

## 6. テスト実装のベストプラクティス

### 6.1. テストクラスの構造
```kotlin
@SpringBootTest
class ExampleServiceTest {
    @Autowired
    private lateinit var exampleService: ExampleService

    @BeforeEach
    fun setup() {
        // テストデータのセットアップ
    }

    @Test
    fun `テストケースの説明`() {
        // テストコード
    }

    @AfterEach
    fun cleanup() {
        // 必要に応じてクリーンアップ
    }
}
```

### 6.2. テストケース設計
- 1テストにつき1つの検証項目
- テストの意図が明確な命名
- 適切なアサーション
- エッジケースの考慮

## 7. CI/CD環境での実行

### 7.1. テストデータベースの準備
```yaml
# docker-compose.test.yml
version: '3.8'
services:
  test-db:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: compliance_management_system_test
    ports:
      - "3307:3306"
```

### 7.2. CI実行手順
1. テストDB用コンテナ起動
2. `cleanTestDb` タスク実行
3. `migrateTestDb` タスク実行
4. `test` タスク実行
5. テスト結果の収集
6. カバレッジレポート生成

## 8. トラブルシューティング

### 8.1. よくある問題と対処法
1. テストDBへの接続エラー
   - Docker コンテナの起動確認
   - ポート番号の確認
   - 接続情報の確認

2. マイグレーションエラー
   - マイグレーションファイルの構文確認
   - バージョン番号の重複確認
   - 依存関係の確認

3. テストの失敗
   - テストデータの確認
   - トランザクション境界の確認
   - ロールバック処理の確認
