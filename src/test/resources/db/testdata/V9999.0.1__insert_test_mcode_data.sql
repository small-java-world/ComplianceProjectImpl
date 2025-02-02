-- ------------------------------------------------------------
-- M_CODEテーブルへのテストデータ投入
-- ------------------------------------------------------------

INSERT INTO M_CODE (
  code_category, code, code_division, code_name, code_short_name,
  extension1, extension2, extension3, extension4, extension5,
  extension6, extension7, extension8, extension9, extension10
)
VALUES
-- AUDIT_STAGE (テスト用カスタムステージ)
('AUDIT_STAGE','CUSTOM_STAGE1','TEST','カスタムステージ1','CustomStage1','1','0','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AUDIT_STAGE','CUSTOM_STAGE2','TEST','カスタムステージ2','CustomStage2','2','1','2',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
