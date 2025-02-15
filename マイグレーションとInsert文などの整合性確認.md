# マイグレーションとInsert文の整合性確認

## 1. マイグレーションファイルの構成

### データベース一覧
1. organization_db
2. code_master_db
3. document_db
4. framework_db
5. audit_db
6. training_db
7. risk_db
8. risk_transaction_db
9. reference_data_db
10. risk_master_db
11. compliance_db
12. asset_db

### 1.1 organization_db
#### マイグレーションファイル
- `src/main/resources/db/migration/organization_db/V1.0.0__create_organization_tables.sql`
  - Organization テーブル (PK: organization_id VARCHAR(36))
  - Department テーブル (PK: department_id VARCHAR(36), FK: organization_id -> Organization, parent_id -> Department)
  - User テーブル (PK: user_id VARCHAR(36), FK: department_id -> Department)
  - PermissionDetail テーブル (PK: permission_detail_id BIGINT AUTO_INCREMENT, FK: user_id -> User)
  - PermissionDetail_Department テーブル (PK: permission_detail_id + department_id, FK: permission_detail_id -> PermissionDetail, department_id -> Department)

- `src/main/resources/db/migration/organization_db/V1.0.1__create_project_tables.sql`
  - ComplianceProject テーブル (PK: project_id VARCHAR(36), FK: organization_id -> Organization)
  - ProjectFramework テーブル (PK: project_framework_id VARCHAR(36), FK: project_id -> ComplianceProject)

#### テストデータ
- `src/main/resources/db/migration/organization_db_test/V1.0.2__insert_test_data.sql`
  - Organization テストデータ
  - Department テストデータ
  - User テストデータ
  - PermissionDetail テストデータ
  - PermissionDetail_Department テストデータ

### 1.2 code_master_db
#### マイグレーションファイル
- `src/main/resources/db/migration/code_master_db/V2.0.0__create_m_code_table.sql`
  - M_CODE テーブル (PK: code_category + code)

#### テストデータ
- `src/test/resources/db/testmigration/code_master_db/V2.0.2__insert_test_data.sql`
  - M_CODE テストデータ

### 1.3 document_db
#### マイグレーションファイル
- `src/main/resources/db/migration/document_db/V1.0.0__create_document_tables.sql`
  - Document テーブル (PK: document_id VARCHAR(36))
  - DocumentVersion テーブル (PK: version_id VARCHAR(36), FK: document_id -> Document)
  - ApprovalWorkflow テーブル (PK: workflow_id VARCHAR(36), FK: document_id -> Document, version_id -> DocumentVersion)
  - Asset テーブル (PK: asset_id VARCHAR(36))
  - AssetOwner テーブル (PK: owner_id VARCHAR(36), FK: asset_id -> Asset)
  - Building テーブル (PK: building_id VARCHAR(36))
  - Floor テーブル (PK: floor_id VARCHAR(36), FK: building_id -> Building)
  - Room テーブル (PK: room_id VARCHAR(36), FK: floor_id -> Floor)

### 1.4 framework_db
#### マイグレーションファイル
- `src/main/resources/db/migration/framework_db/V1.0.0__create_framework_tables.sql`
  - ComplianceFramework テーブル (PK: framework_id VARCHAR(36))
  - Requirement テーブル (PK: requirement_id VARCHAR(36), FK: framework_id -> ComplianceFramework, parent_id -> Requirement)
  - ImplementationTask テーブル (PK: task_id VARCHAR(36), FK: requirement_id -> Requirement)
  - Evidence テーブル (PK: evidence_id VARCHAR(36), FK: task_id -> ImplementationTask)

### 1.5 audit_db
#### マイグレーションファイル
- `src/main/resources/db/migration/audit_db/V1.0.0__create_audit_tables.sql`
  - Audit テーブル (PK: audit_id VARCHAR(36))
  - AssessmentReport テーブル (PK: report_id VARCHAR(36), FK: audit_id -> Audit)
  - NonConformity テーブル (PK: nonconformity_id VARCHAR(36), FK: audit_id -> Audit)
  - CorrectiveAction テーブル (PK: action_id VARCHAR(36), FK: nonconformity_id -> NonConformity)

### 1.6 training_db
#### マイグレーションファイル
- `src/main/resources/db/migration/training_db/V1.0.0__create_training_tables.sql`
  - TrainingProgram テーブル (PK: program_id VARCHAR(36))
  - TrainingMaterial テーブル (PK: material_id VARCHAR(36), FK: program_id -> TrainingProgram)
  - TrainingSchedule テーブル (PK: schedule_id VARCHAR(36), FK: program_id -> TrainingProgram)
  - TrainingRecord テーブル (PK: record_id VARCHAR(36), FK: program_id -> TrainingProgram, schedule_id -> TrainingSchedule)
  - TrainingFeedback テーブル (PK: feedback_id VARCHAR(36), FK: record_id -> TrainingRecord)

### 1.7 risk_db
#### マイグレーションファイル
- `src/main/resources/db/migration/risk_db/V1.0.0__create_risk_tables.sql`
  - Risk テーブル (PK: risk_id VARCHAR(36))
  - RiskAssessment テーブル (PK: assessment_id VARCHAR(36), FK: risk_id -> Risk)
  - RiskTreatmentPlan テーブル (PK: plan_id VARCHAR(36), FK: risk_id -> Risk)

### 1.8 risk_transaction_db
#### マイグレーションファイル
- `src/main/resources/db/migration/risk_transaction_db/V1.0.0__create_risk_transaction_tables.sql`
  - Risk テーブル (PK: risk_id VARCHAR(36))
  - RiskAssessment テーブル (PK: risk_assessment_id VARCHAR(36), FK: risk_id -> Risk)
  - RiskTreatmentPlan テーブル (PK: treatment_plan_id VARCHAR(36), FK: risk_id -> Risk)
  - AssetRisk テーブル (PK: asset_risk_id VARCHAR(36), FK: risk_id -> Risk)

### 1.9 reference_data_db
#### マイグレーションファイル
- `src/main/resources/db/migration/reference_data_db/V9.0.0__create_reference_data_tables.sql`

### 1.10 risk_master_db
#### マイグレーションファイル
- `src/main/resources/db/migration/risk_master_db/V1.0.0__create_risk_master_tables.sql`
  - Risk テーブル (PK: risk_id VARCHAR(36))
  - RiskRequirement テーブル (PK: risk_requirement_id VARCHAR(36), FK: risk_id -> Risk)
  - RiskTemplate テーブル (PK: risk_template_id VARCHAR(36))
  - RiskTemplateCondition テーブル (PK: risk_template_condition_id VARCHAR(36), FK: risk_template_id -> RiskTemplate)

### 1.11 compliance_db
#### マイグレーションファイル
- `src/main/resources/db/migration/compliance_db/V7.0.0__create_compliance_tables.sql`
  - ComplianceProject テーブル (PK: project_id VARCHAR(36))
  - ProjectScope テーブル (PK: scope_id VARCHAR(36), FK: project_id -> ComplianceProject)
  - ComplianceFramework テーブル (PK: framework_id VARCHAR(36))
  - ProjectFramework テーブル (PK: project_framework_id VARCHAR(36), FK: project_id -> ComplianceProject, framework_id -> ComplianceFramework)
  - Requirement テーブル (PK: requirement_id VARCHAR(50), FK: framework_id -> ComplianceFramework, parent_id -> Requirement)
  - ImplementationTask テーブル (PK: task_id VARCHAR(36), FK: requirement_id -> Requirement, project_id -> ComplianceProject)
  - Evidence テーブル (PK: evidence_id VARCHAR(36), FK: task_id -> ImplementationTask)

### 1.12 asset_db
#### マイグレーションファイル
- `src/main/resources/db/migration/asset_db/V6.0.0__create_asset_tables.sql`
  - Building テーブル (PK: building_id VARCHAR(36))
  - Floor テーブル (PK: floor_id VARCHAR(36), FK: building_id -> Building)
  - Room テーブル (PK: room_id VARCHAR(36), FK: floor_id -> Floor)
  - Asset テーブル (PK: asset_id VARCHAR(36), FK: room_id -> Room)
  - AssetAttribute テーブル (PK: asset_attribute_id VARCHAR(36), FK: asset_id -> Asset)
  - AssetOwner テーブル (PK: asset_owner_id VARCHAR(36), FK: asset_id -> Asset)

## 2. Gradleタスクとマイグレーションファイルの関連

### 2.1 データベース作成タスク
```kotlin
tasks.register("recreateAllDatabases") {
    // 以下のデータベースを作成
    - code_master_db_test
    - organization_db_test
    - risk_db_test
    - framework_db_test
    - audit_db_test
    - document_db_test
    - training_db_test
}
```

### 2.2 マイグレーション実行タスク
```kotlin
tasks.register("flywayMigrateAll") {
    // 各データベースに対して以下のパスのマイグレーションを実行
    - classpath:db/migration/{database_name}  // メインのマイグレーション
    - classpath:db/testmigration/{database_name}  // テストデータのマイグレーション
}

tasks.register("flywayMigrateOrganization") {
    // organization_dbに対して以下のパスのマイグレーションを実行
    - filesystem:src/main/resources/db/migration/organization_db
    - filesystem:src/main/resources/db/migration/organization_db_test
}
```

## 3. 整合性チェックポイント

### 3.1 主キー・外部キーの整合性
1. organization_db
   - ✅ Organization -> Department (organization_id)
   - ✅ Department -> Department (parent_id)
   - ✅ Department -> User (department_id)
   - ✅ User -> PermissionDetail (user_id)
   - ✅ PermissionDetail -> PermissionDetail_Department (permission_detail_id)
   - ✅ Department -> PermissionDetail_Department (department_id)
   - ✅ Organization -> ComplianceProject (organization_id)
   - ✅ ComplianceProject -> ProjectFramework (project_id)

2. document_db
   - ✅ Document -> DocumentVersion (document_id)
   - ✅ Document -> ApprovalWorkflow (document_id)
   - ✅ DocumentVersion -> ApprovalWorkflow (version_id)
   - ✅ Asset -> AssetOwner (asset_id)
   - ✅ Building -> Floor (building_id)
   - ✅ Floor -> Room (floor_id)

3. framework_db
   - ✅ ComplianceFramework -> Requirement (framework_id)
   - ✅ Requirement -> Requirement (parent_id)
   - ✅ Requirement -> ImplementationTask (requirement_id)
   - ✅ ImplementationTask -> Evidence (task_id)

4. audit_db
   - ✅ Audit -> AssessmentReport (audit_id)
   - ✅ Audit -> NonConformity (audit_id)
   - ✅ NonConformity -> CorrectiveAction (nonconformity_id)

5. training_db
   - ✅ TrainingProgram -> TrainingMaterial (program_id)
   - ✅ TrainingProgram -> TrainingSchedule (program_id)
   - ✅ TrainingProgram -> TrainingRecord (program_id)
   - ✅ TrainingSchedule -> TrainingRecord (schedule_id)
   - ✅ TrainingRecord -> TrainingFeedback (record_id)

6. risk_db
   - ✅ Risk -> RiskAssessment (risk_id)
   - ✅ Risk -> RiskTreatmentPlan (risk_id)

7. risk_transaction_db
   - ✅ Risk -> RiskAssessment (risk_id)
   - ✅ Risk -> RiskTreatmentPlan (risk_id)
   - ✅ Risk -> AssetRisk (risk_id)

8. risk_master_db
   - ✅ Risk -> RiskRequirement (risk_id)
   - ✅ RiskTemplate -> RiskTemplateCondition (risk_template_id)
   - ✅ Risk.risk_template_id -> RiskTemplate (risk_template_id) [NULL許容]

9. compliance_db
   - ✅ ComplianceProject -> ProjectScope (project_id)
   - ✅ ComplianceProject -> ProjectFramework (project_id)
   - ✅ ComplianceFramework -> ProjectFramework (framework_id)
   - ✅ ComplianceFramework -> Requirement (framework_id)
   - ✅ Requirement -> Requirement (parent_id) [自己参照、NULL許容]
   - ✅ Requirement -> ImplementationTask (requirement_id)
   - ✅ ComplianceProject -> ImplementationTask (project_id)
   - ✅ ImplementationTask -> Evidence (task_id)

10. asset_db
    - ✅ Building -> Floor (building_id)
    - ✅ Floor -> Room (floor_id)
    - ✅ Room -> Asset (room_id) [NULL許容]
    - ✅ Asset -> AssetAttribute (asset_id)
    - ✅ Asset -> AssetOwner (asset_id)

### 3.2 データ型の整合性
1. organization_db
   - ⚠️ PermissionDetail.permission_detail_id (BIGINT) と PermissionDetail_Department.permission_detail_id (BIGINT) の型は一致
   - ⚠️ Organization.organization_id (VARCHAR(36)) と ComplianceProject.organization_id (VARCHAR(36)) の型は一致
   - ⚠️ Department.department_id (VARCHAR(36)) と User.department_id (VARCHAR(36)) の型は一致

2. document_db
   - ✅ すべてのIDカラムがVARCHAR(36)で統一されている

3. framework_db
   - ✅ すべてのIDカラムがVARCHAR(36)で統一されている
   - ✅ タイムスタンプカラムの型と初期値が統一されている

4. audit_db
   - ✅ すべてのIDカラムがVARCHAR(36)で統一されている
   - ✅ タイムスタンプカラムの型と初期値が統一されている
   - ✅ 日付カラムがDATE型で統一されている

5. training_db
   - ✅ すべてのIDカラムがVARCHAR(36)で統一されている
   - ✅ タイムスタンプカラムの型と初期値が統一されている
   - ✅ 日付カラムがDATE型で統一されている
   - ✅ 数値カラム（duration, passing_score, max_participants, score, rating）がINT型で統一されている
   - ✅ 真偽値カラム（is_mandatory, is_passed）がBOOLEAN型で統一されている

6. risk_db
   - ✅ すべてのIDカラムがVARCHAR(36)で統一されている
   - ✅ タイムスタンプカラムの型と初期値が統一されている
   - ✅ 日付カラムがDATE型で統一されている
   - ✅ ステータスカラムがVARCHAR(50)で統一されている
   - ✅ インパクトと確率のカラムがVARCHAR(50)で統一されている

7. risk_transaction_db
   - ✅ すべてのIDカラムがVARCHAR(36)で統一されている
   - ✅ タイムスタンプカラムの型と初期値が統一されている
   - ✅ 日付カラムがDATE型で統一されている
   - ✅ ステータスカラムがVARCHAR(20)またはVARCHAR(50)で統一されている
   - ✅ 数値カラム（severity, likelihood, impact）がINT型で統一されている

8. risk_master_db
   - ✅ すべてのIDカラムがVARCHAR(36)で統一されている
   - ✅ タイムスタンプカラムの型と初期値が統一されている
   - ✅ ステータスカラムがVARCHAR(20)で統一されている
   - ✅ 数値カラム（severity, condition_order）がINT型で統一されている
   - ✅ 名前カラムがVARCHAR(200)で統一されている

9. compliance_db
   - ✅ IDカラムの型が統一されている
     - project_id, scope_id, framework_id, project_framework_id, task_id, evidence_id: VARCHAR(36)
     - requirement_id: VARCHAR(50)
   - ✅ タイムスタンプカラムの型と初期値が統一されている
   - ✅ 日付カラムがDATE型で統一されている
   - ✅ ステータスカラムがVARCHAR(50)で統一されている
   - ✅ 名前・タイトルカラムの長さが統一されている
     - name: VARCHAR(100)
     - title: VARCHAR(200)

10. asset_db
    - ✅ すべてのIDカラムがVARCHAR(36)で統一されている
    - ✅ タイムスタンプカラムの型と初期値が統一されている
    - ✅ コードカラムがVARCHAR(50)で統一されている
    - ✅ 名前カラムがVARCHAR(100)で統一されている
    - ✅ 数値カラム（confidentiality_level, integrity_level, availability_level）がINT型で統一されている
    - ✅ 真偽値カラム（contains_personal_data）がBOOLEAN型で統一されている

### 3.3 テストデータの整合性
1. code_master_db
   - ✅ テストデータのバージョン番号が適切（V2.0.2）
   - ✅ コードカテゴリとコードの組み合わせが一意
   - ✅ 必須項目（code_category, code, code_name, code_division）が設定されている
   - ✅ display_orderが適切に設定されている
   - ✅ is_activeがデフォルトでtrueに設定されている

2. organization_db
   - ⚠️ テストデータファイルが存在しない
   - ⚠️ 以下のテストデータが必要：
     - Organization
     - Department（組織階層を考慮）
     - User（各部門に所属）
     - PermissionDetail（各種権限パターン）
     - PermissionDetail_Department（部門別権限）

3. framework_db
   - ⚠️ テストデータファイルが存在しない
   - ⚠️ 以下のテストデータが必要：
     - ComplianceFramework
     - Requirement（階層構造を考慮）
     - ImplementationTask
     - Evidence

## 4. テストデータ作成方針

#### 4.1 テストデータファイルの命名規則
1. バージョン番号の付け方
   - メインのマイグレーション: V{major}.{minor}.0
   - テストデータ: V{major}.{minor}.2
   - 例：
     - メイン: V1.0.0__create_tables.sql
     - テスト: V1.0.2__insert_test_data.sql

2. ファイル配置
   - 本番用マイグレーション: src/main/resources/db/migration/{database_name}/
   - テストデータ: src/test/resources/db/testmigration/{database_name}/

#### 4.2 テストデータ作成の優先順位
1. マスタデータ（code_master_db）
   - コード定義
   - ステータス定義
   - その他の基準値

2. 組織データ（organization_db）
   - Organization
   - Department
   - User
   - Permission関連

3. フレームワークデータ（framework_db）
   - ComplianceFramework
   - Requirement
   - 実装タスクと証跡

4. その他の業務データ
   - プロジェクト
   - 文書
   - 監査
   - トレーニング
   - リスク

#### 4.3 テストデータ作成時の注意点
1. データの関連性
   - 外部キー制約を考慮した順序でのデータ投入
   - 参照整合性の維持
   - NULL許容項目の適切な設定

2. テストケースのカバレッジ
   - 正常系のパターン
   - 代表的な異常系のパターン
   - 境界値のテスト

3. データの現実性
   - 実際の業務に即した値の設定
   - 適切なデータ量の設定
   - 日付や時刻の整合性

4. メンテナンス性
   - コメントによる説明の付与
   - テストの目的や想定シナリオの記載
   - データの依存関係の明確化

## 5. マイグレーション実行時の注意点

### 5.1 マイグレーションの実行順序
1. データベースの作成
```bash
./gradlew recreateAllDatabases
```

2. マイグレーションの実行
```bash
./gradlew flywayMigrateAll
```

3. 個別データベースのマイグレーション
```bash
./gradlew flywayMigrateOrganization  # organization_dbのみマイグレーション
```

### 5.2 マイグレーションファイルの命名規則
1. バージョン番号
   - メジャーバージョン: データベース構造の大きな変更
   - マイナーバージョン: テーブルの追加や変更
   - パッチバージョン: データの修正や小さな変更

2. ファイル名の形式
   - V{バージョン}__{説明}.sql
   - 例: V1.0.0__create_organization_tables.sql

3. バージョン番号の重複防止
   - 各データベース内でバージョン番号が重複しないよう注意
   - テストデータのマイグレーションファイルも含めて重複チェック

### 5.3 マイグレーションの実行環境
1. ローカル環境
   - データベース: MySQL 8.0
   - ポート: 3307
   - 文字コード: utf8mb4
   - 照合順序: utf8mb4_unicode_ci

2. テスト環境
   - 各データベースのテスト用インスタンスを使用
   - テストデータは自動的にロールバック

3. CI/CD環境
   - マイグレーションの自動実行
   - テストデータの自動投入
