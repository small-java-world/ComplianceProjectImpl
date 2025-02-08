# データベース分割設計書

## 1. 概要
コンプライアンス管理システムのデータベースを以下の7つのDBに分割し、それぞれの責務を明確化します。

## 2. データベース構成

### 2.1 コードマスタDB (code_master_db)
- 目的：システム全体で使用する共通コードの管理
- テーブル：
  - M_CODE

### 2.2 組織管理DB (organization_db)
- 目的：組織構造とプロジェクト管理
- テーブル：
  - Organization
  - Department
  - ComplianceProject
  - ProjectFramework

### 2.3 フレームワーク管理DB (framework_db)
- 目的：コンプライアンスフレームワークと要求事項の管理
- テーブル：
  - ComplianceFramework
  - Requirement
  - ImplementationTask
  - Evidence

### 2.4 監査管理DB (audit_db)
- 目的：監査関連情報の管理
- テーブル：
  - Audit
  - AssessmentReport
  - NonConformity
  - CorrectiveAction

### 2.5 リスク管理DB (risk_db)
- 目的：リスク評価と対策の管理
- テーブル：
  - Risk
  - RiskAssessment
  - RiskTreatmentPlan

### 2.6 文書・資産管理DB (document_asset_db)
- 目的：文書管理と資産管理の統合
- テーブル：
  - Document
  - DocumentVersion
  - ApprovalWorkflow
  - Asset
  - AssetOwner
  - Building
  - Floor
  - Room

### 2.7 教育管理DB (training_db)
- 目的：教育プログラムと受講記録の管理
- テーブル：
  - TrainingProgram
  - TrainingRecord

## 3. マイグレーションファイル分割案

### 3.1 コードマスタDB
- V1.0.0__create_m_code_table.sql
- V1.0.1__insert_initial_m_code_data.sql

### 3.2 組織管理DB
- V1.0.0__create_organization_tables.sql
  - Organization
  - Department
- V1.0.1__create_project_tables.sql
  - ComplianceProject
  - ProjectFramework

### 3.3 フレームワーク管理DB
- V1.0.0__create_framework_tables.sql
  - ComplianceFramework
  - Requirement
- V1.0.1__create_implementation_tables.sql
  - ImplementationTask
  - Evidence
- V1.0.2__insert_framework_data.sql
- V1.0.3__insert_requirement_data.sql

### 3.4 監査管理DB
- V1.0.0__create_audit_tables.sql
  - Audit
  - AssessmentReport
- V1.0.1__create_nonconformity_tables.sql
  - NonConformity
  - CorrectiveAction

### 3.5 リスク管理DB
- V1.0.0__create_risk_tables.sql
  - Risk
  - RiskAssessment
  - RiskTreatmentPlan

### 3.6 文書・資産管理DB
- V1.0.0__create_document_tables.sql
  - Document
  - DocumentVersion
  - ApprovalWorkflow
- V1.0.1__create_asset_tables.sql
  - Asset
  - AssetOwner
- V1.0.2__create_location_tables.sql
  - Building
  - Floor
  - Room

### 3.7 教育管理DB
- V1.0.0__create_training_tables.sql
  - TrainingProgram
  - TrainingRecord

## 4. データベース間の参照関係

### 4.1 外部キー制約の扱い
DBを分割することにより、以下の外部キー制約は論理的な参照として扱います：

1. ProjectFramework → ComplianceFramework
   - 物理的な外部キー制約は削除
   - アプリケーション層でデータ整合性を確保

2. ImplementationTask → Requirement
   - requirement_idによる論理的な参照
   - アプリケーション層でバリデーション

3. Asset → Room
   - room_idによる論理的な参照
   - アプリケーション層でバリデーション

### 4.2 データ整合性の確保
- アプリケーション層でのバリデーション強化
- 定期的な整合性チェックバッチの実装
- 監査ログによる変更追跡

## 5. 移行手順

1. 既存のデータをエクスポート
2. 新DBごとにテーブルを作成
3. データを適切なDBに振り分けて投入
4. アプリケーションの接続先を更新
5. 整合性チェックの実施

## 6. 注意点

1. トランザクション管理
   - 複数DB間のトランザクションは2相コミットを検討
   - または、最終的な整合性を重視したパターンを採用

2. パフォーマンス
   - JOIN操作が必要な場合はアプリケーション層でのキャッシュを活用
   - 必要に応じてレプリケーションを検討

3. バックアップ
   - 各DBの整合性を保ったバックアップスケジュールの設定
   - リストア手順の整備

4. 監視
   - 各DBの状態監視
   - クロスDB参照の整合性チェック
