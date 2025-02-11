-- Insert initial data for M_CODE table
-- カラム定義:
-- code_category: コード分類
-- code_division: コード区分
-- code: コード値
-- code_name: コード名称
-- code_short_name: コード略称
-- extension1: 拡張項目1
-- extension2: 拡張項目2
-- extension3: 拡張項目3
-- extension4: 拡張項目4
-- extension5: 拡張項目5

INSERT INTO M_CODE (
  code_category, code_division, code, code_name, code_short_name,
  extension1, extension2, extension3, extension4, extension5
)
VALUES
-- ORGANIZATION_TYPE
('ORGANIZATION_TYPE','CLIENT','01','クライアント（被監査企業）','Client','1','1','1','0','2'),
('ORGANIZATION_TYPE','CERTIFICATION_BODY','02','認証機関','CertBody','1','0','0','1','1'),
('ORGANIZATION_TYPE','REGULATORY_AUTHORITY','04','規制当局','Regulator','1','0','0','2','0'),
('ORGANIZATION_TYPE','INTERNAL_DEPARTMENT','05','社内部署','InternalDept','0','0','0','0','0'),
('ORGANIZATION_TYPE','OTHER','99','その他','Other','0','0','0','0','0');

-- USER_ROLE (extension3=監査特権)
INSERT INTO M_CODE (code_category, code_division, code, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('USER_ROLE','ADMIN','01','システム管理者','Admin','1','4','0',NULL,NULL),
('USER_ROLE','PROJECT_MANAGER','02','プロジェクト管理者','PM','0','3','0',NULL,NULL),
('USER_ROLE','AUDITOR','03','監査員(内部/外部)','Auditor','0','2','1',NULL,NULL),
('USER_ROLE','GENERAL_USER','09','一般ユーザー','General','0','2','0',NULL,NULL),
('USER_ROLE','READ_ONLY','10','閲覧専用ユーザー','ReadOnly','0','1','0',NULL,NULL),
('USER_ROLE','INTERNAL_AUDIT_LEADER','12','内部監査責任者','IntAuditLeader','0','3','1',NULL,NULL),
('USER_ROLE','EXTERNAL_AUDIT_COORDINATOR','13','外部監査対応責任者','ExtAuditCoord','0','3','2',NULL,NULL),
('USER_ROLE','OTHER','99','その他','Other','0','1','0',NULL,NULL);

-- PROJECT_STATUS
INSERT INTO M_CODE (code_category, code_division, code, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('PROJECT_STATUS','PREPARING','01','準備中','Preparing','0','1','0','0','0'),
('PROJECT_STATUS','IN_PROGRESS','02','実行中','InProgress','1','1','0','0','0'),
('PROJECT_STATUS','ON_HOLD','03','保留中','OnHold','0','0','1','0','0'),
('PROJECT_STATUS','SUSPENDED','04','停止(中断)','Suspended','0','0','1','0','1'),
('PROJECT_STATUS','COMPLETED','05','完了','Completed','0','0','0','0','0'),
('PROJECT_STATUS','CERTIFIED','06','認証取得済み','Certified','0','0','0','1','0'),
('PROJECT_STATUS','CLOSED','07','クローズ','Closed','0','0','0','0','0'),
('PROJECT_STATUS','CANCELED','08','途中キャンセル','Canceled','0','0','0','0','0'),
('PROJECT_STATUS','OTHER','99','その他','Other','0','0','0','0','0');

-- AUDIT_TYPE
INSERT INTO M_CODE (code_category, code_division, code, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('AUDIT_TYPE','INTERNAL','01','内部監査','InternalAudit','1','0','0','0','0'),
('AUDIT_TYPE','EXTERNAL','02','外部監査','ExternalAudit','2','1','0','0','0'),
('AUDIT_TYPE','STAGE1','05','初回審査(Stage1)','Stage1Audit','10','1','1','0','0'),
('AUDIT_TYPE','STAGE2','06','初回審査(Stage2)','Stage2Audit','11','1','2','0','0'),
('AUDIT_TYPE','SURVEILLANCE','07','サーベイランス','Surveillance','12','1','0','1','0'),
('AUDIT_TYPE','RENEWAL','08','更新監査','RenewalAudit','13','1','0','3','0'),
('AUDIT_TYPE','SELF_ASSESS','10','セルフアセスメント','SelfAssessment','15','0','0','0','1'),
('AUDIT_TYPE','OTHER','99','その他','OtherAudit','0','0','0','0','0');

-- AUDIT_STATUS
INSERT INTO M_CODE (code_category, code_division, code, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('AUDIT_STATUS','PLANNED','01','計画済み','Planned','7','0','0','0','0'),
('AUDIT_STATUS','SCHEDULED','02','日程確定','Scheduled','7','0','0','0','0'),
('AUDIT_STATUS','IN_PROGRESS','03','実施中','InProgress','0','1','0','0','0'),
('AUDIT_STATUS','REVIEWING','04','レビュー中','Reviewing','0','2','0','0','0'),
('AUDIT_STATUS','COMPLETED','06','完了','Completed','0','0','1','0','0'),
('AUDIT_STATUS','SUSPENDED','07','中断','Suspended','0','0','0','1','0'),
('AUDIT_STATUS','CANCELED','08','キャンセル','Canceled','0','0','0','2','0'),
('AUDIT_STATUS','CLOSED','09','クローズ','Closed','0','0','0','0','1');

-- AUDIT_STAGE (ISO27001想定)
INSERT INTO M_CODE (code_category, code_division, code, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('AUDIT_STAGE','ISO27001','STAGE1_DOCUMENT','Stage1(書類審査)','Stage1Doc','1','0','1',NULL,NULL),
('AUDIT_STAGE','ISO27001','STAGE2_ONSITE','Stage2(現地審査)','Stage2Onsite','2','1','2',NULL,NULL),
('AUDIT_STAGE','ISO27001','SURVEILLANCE1','サーベイランス(1年目)','Surveillance1','12','1','0',NULL,NULL),
('AUDIT_STAGE','ISO27001','RENEWAL','更新審査','Renewal','13','1','3',NULL,NULL),
('AUDIT_STAGE','ISO27001','STAGE_INTERNAL','内部監査相当(カスタム)','IntAudit','0','1','0',NULL,NULL);

-- NON_CONFORMITY_SEVERITY
INSERT INTO M_CODE (code_category, code_division, code, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('NON_CONFORMITY_SEVERITY','MINOR','01','軽微不適合(Minor)','Minor','1','3','0',NULL,NULL),
('NON_CONFORMITY_SEVERITY','MAJOR','02','重大不適合(Major)','Major','2','2','0',NULL,NULL),
('NON_CONFORMITY_SEVERITY','CRITICAL','03','致命的不適合','Critical','3','1','0',NULL,NULL),
('NON_CONFORMITY_SEVERITY','OBSERVATION','04','観察事項','Observation','1','3','1',NULL,NULL),
('NON_CONFORMITY_SEVERITY','OPPORTUNITY','05','改善機会','Opportunity','1','0','2',NULL,NULL),
('NON_CONFORMITY_SEVERITY','OTHER','99','その他','OtherSev','0','0','0',NULL,NULL);

-- NON_CONFORMITY_STATUS
INSERT INTO M_CODE (code_category, code_division, code, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('NON_CONFORMITY_STATUS','DEFAULT','OPEN','未解決','Open',NULL,NULL,NULL,NULL,NULL),
('NON_CONFORMITY_STATUS','DEFAULT','CLOSED','解決済','Closed',NULL,NULL,NULL,NULL,NULL);

-- CORRECTIVE_ACTION_STATUS
INSERT INTO M_CODE (code_category, code_division, code, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('CORRECTIVE_ACTION_STATUS','DEFAULT','OPEN','対応中','Open',NULL,NULL,NULL,NULL,NULL),
('CORRECTIVE_ACTION_STATUS','DEFAULT','DONE','対応完了','Done',NULL,NULL,NULL,NULL,NULL);

-- RISK_STATUS
INSERT INTO M_CODE (code_category, code_division, code, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('RISK_STATUS','DEFAULT','OPEN','リスク未対応','Open','1','1','0',NULL,NULL),
('RISK_STATUS','DEFAULT','IN_PROGRESS','対応中','InProgress','1','1','0',NULL,NULL),
('RISK_STATUS','DEFAULT','ACCEPTED','受容','Accepted','0','1','0',NULL,NULL),
('RISK_STATUS','DEFAULT','MITIGATED','軽減済み','Mitigated','0','1','0',NULL,NULL),
('RISK_STATUS','DEFAULT','TRANSFERRED','転嫁(移転)','Transferred','0','1','1',NULL,NULL),
('RISK_STATUS','DEFAULT','AVOIDED','回避','Avoided','0','0','0',NULL,NULL),
('RISK_STATUS','DEFAULT','CLOSED','クローズ','Closed','0','0','0',NULL,NULL);

-- RISK_IMPACT
INSERT INTO M_CODE (code_category, code_division, code, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('RISK_IMPACT','CRITICAL','01','影響度 極大','Critical','4',NULL,NULL,NULL,NULL),
('RISK_IMPACT','HIGH','02','影響度 大','High','3',NULL,NULL,NULL,NULL),
('RISK_IMPACT','MEDIUM','03','影響度 中','Medium','2',NULL,NULL,NULL,NULL),
('RISK_IMPACT','LOW','04','影響度 小','Low','1',NULL,NULL,NULL,NULL),
('RISK_IMPACT','NEGLIGIBLE','05','影響度 無視可能','Negligible','0',NULL,NULL,NULL,NULL);

-- RISK_LIKELIHOOD
INSERT INTO M_CODE (code_category, code_division, code, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('RISK_LIKELIHOOD','CERTAIN','01','ほぼ確実','Certain','95',NULL,NULL,NULL,NULL),
('RISK_LIKELIHOOD','LIKELY','02','高い','Likely','70',NULL,NULL,NULL,NULL),
('RISK_LIKELIHOOD','POSSIBLE','03','中程度','Possible','50',NULL,NULL,NULL,NULL),
('RISK_LIKELIHOOD','UNLIKELY','04','低い','Unlikely','20',NULL,NULL,NULL,NULL),
('RISK_LIKELIHOOD','RARE','05','ごく稀','Rare','5',NULL,NULL,NULL,NULL);

-- RISK_LEVEL
INSERT INTO M_CODE (code_category, code_division, code, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('RISK_LEVEL','DEFAULT','HIGH_RISK','高リスク','HighRisk',NULL,NULL,NULL,NULL,NULL),
('RISK_LEVEL','DEFAULT','MEDIUM_RISK','中リスク','MedRisk',NULL,NULL,NULL,NULL,NULL),
('RISK_LEVEL','DEFAULT','LOW_RISK','低リスク','LowRisk',NULL,NULL,NULL,NULL,NULL);

-- RISK_TREATMENT_STATUS
INSERT INTO M_CODE (code_category, code_division, code, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('RISK_TREATMENT_STATUS','DEFAULT','OPEN','未対応','Open',NULL,NULL,NULL,NULL,NULL),
('RISK_TREATMENT_STATUS','DEFAULT','IN_PROGRESS','対策実施中','InProgress',NULL,NULL,NULL,NULL,NULL),
('RISK_TREATMENT_STATUS','DEFAULT','DONE','対策完了','Done',NULL,NULL,NULL,NULL,NULL);

-- DOCUMENT_STATUS
INSERT INTO M_CODE (code_category, code_division, code, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('DOCUMENT_STATUS','DEFAULT','DRAFT','ドラフト','Draft','1','0','0','0','0'),
('DOCUMENT_STATUS','DEFAULT','REVIEW','レビュー中','Review','0','2','0','0','0'),
('DOCUMENT_STATUS','DEFAULT','APPROVED','承認済み','Approved','0','2','0','0','0'),
('DOCUMENT_STATUS','DEFAULT','REJECTED','却下','Rejected','0','0','1','0','0'),
('DOCUMENT_STATUS','DEFAULT','PUBLISHED','公開済み','Published','0','2','0','2','0'),
('DOCUMENT_STATUS','DEFAULT','ARCHIVED','アーカイブ','Archived','0','0','0','0','1'),
('DOCUMENT_STATUS','DEFAULT','EXPIRED','有効期限切れ','Expired','0','0','0','0','2');

-- EVIDENCE_TYPE
INSERT INTO M_CODE (code_category, code_division, code, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('EVIDENCE_TYPE','DOCUMENT','01','文書ファイル','Document','1','1','0','3','0'),
('EVIDENCE_TYPE','SCREENSHOT','02','スクリーンショット','Screenshot','2','1','0','2','0'),
('EVIDENCE_TYPE','SYSTEM_LOG','03','システムログ','SystemLog','3','0','1','1','0'),
('EVIDENCE_TYPE','VIDEO','04','動画','Video','4','2','0','2','0'),
('EVIDENCE_TYPE','URL_REFERENCE','06','URLリファレンス','URL_Ref','0','0','0','0','1');

-- TRAINING_RECORD_STATUS
INSERT INTO M_CODE (code_category, code_division, code, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('TRAINING_RECORD_STATUS','DEFAULT','REQUIRED','受講必須','Required','70','0','0','0','0'),
('TRAINING_RECORD_STATUS','DEFAULT','IN_PROGRESS','受講中(進行中)','InProgress','70','0','14','0','0'),
('TRAINING_RECORD_STATUS','DEFAULT','COMPLETED','修了(合格)','Completed','70','0','365','1','0'),
('TRAINING_RECORD_STATUS','DEFAULT','FAILED','不合格(再試験要)','Failed','70','1','30','0','0'),
('TRAINING_RECORD_STATUS','DEFAULT','WAIVED','免除','Waived','0','0','0','0','1'),
('TRAINING_RECORD_STATUS','DEFAULT','EXPIRED','有効期限切れ','Expired','70','0','0','0','0');

-- COMPLIANCE_FW_TYPE
INSERT INTO M_CODE (code_category, code_division, code, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('COMPLIANCE_FW_TYPE','ISO27001_2022','01','ISMS (ISO 27001:2022)','ISO27001_2022','2022','1','1','0','1'),
('COMPLIANCE_FW_TYPE','PMARK','02','Pマーク (プライバシーマーク)','PMark','2022','0','1','0','2'),
('COMPLIANCE_FW_TYPE','PCI_DSS','07','PCI DSS (カード情報保護)','PCI-DSS','4.0','1','0','1','1'),
('COMPLIANCE_FW_TYPE','OTHER','99','その他','OtherFW','0','0','0','0','0');

-- CHANGE_TYPE
INSERT INTO M_CODE (code_category, code_division, code, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('CHANGE_TYPE','DEFAULT','NORMAL_CHANGE','通常変更','NormalChange','1','1','0','0','0'),
('CHANGE_TYPE','DEFAULT','EMERGENCY_CHANGE','緊急変更','EmergencyChange','1','3','0','0','0'),
('CHANGE_TYPE','DEFAULT','MAJOR_CHANGE','大規模変更','MajorChange','2','2','0','0','0'),
('CHANGE_TYPE','DEFAULT','SECURITY_PATCH','セキュリティパッチ','SecurityPatch','1','3','1','0','0'),
('CHANGE_TYPE','DEFAULT','REGULATORY','規制・法令変更','Regulatory','2','2','0','1','0');

-- INCIDENT_TYPE
INSERT INTO M_CODE (code_category, code_division, code, code_name, code_short_name, extension1, extension2, extension3, extension4, extension5)
VALUES
('INCIDENT_TYPE','DEFAULT','SECURITY_INCIDENT','セキュリティインシデント','SecIncident','1','0','0','3','0'),
('INCIDENT_TYPE','DEFAULT','SYSTEM_OUTAGE','システム障害','SystemOutage','0','1','0','3','0'),
('INCIDENT_TYPE','DEFAULT','DATA_BREACH','データ漏洩','DataBreach','1','0','1','4','0');
