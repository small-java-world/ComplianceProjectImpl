-- --------------------------------------------------------------------------
-- M_CODEテーブルへの初期データ投入
-- --------------------------------------------------------------------------

INSERT INTO M_CODE (
  code_category, code, code_division, code_name, code_short_name,
  extension1, extension2, extension3, extension4, extension5,
  extension6, extension7, extension8, extension9, extension10
)
VALUES
-- ORGANIZATION_TYPE
('ORGANIZATION_TYPE','01','CLIENT','クライアント（被監査企業）','Client','1','1','1','0','2',NULL,NULL,NULL,NULL,NULL),
('ORGANIZATION_TYPE','02','CERTIFICATION_BODY','認証機関','CertBody','1','0','0','1','1',NULL,NULL,NULL,NULL,NULL),
('ORGANIZATION_TYPE','04','REGULATORY_AUTHORITY','規制当局','Regulator','1','0','0','2','0',NULL,NULL,NULL,NULL,NULL),
('ORGANIZATION_TYPE','05','INTERNAL_DEPARTMENT','社内部署','InternalDept','0','0','0','0','0',NULL,NULL,NULL,NULL,NULL),
('ORGANIZATION_TYPE','99','OTHER','その他','Other','0','0','0','0','0',NULL,NULL,NULL,NULL,NULL),

-- USER_ROLE (extension3=監査特権, extension4=規格名)
('USER_ROLE','01','ADMIN','システム管理者','Admin','1','4','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('USER_ROLE','02','PROJECT_MANAGER','プロジェクト管理者','PM','0','3','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('USER_ROLE','09','GENERAL_USER','一般ユーザー','General','0','2','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('USER_ROLE','10','READ_ONLY','閲覧専用ユーザー','ReadOnly','0','1','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('USER_ROLE','99','OTHER','その他','Other','0','1','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL),

----------------------------------------------------------------
-- ISMS関連のロール
----------------------------------------------------------------
('USER_ROLE','14','ISMS_TOP_MANAGEMENT','トップマネジメント(ISMS)','ISMS Top','0','4','0','ISMS',NULL),
('USER_ROLE','15','ISMS_MANAGER','ISMS責任者','ISMS Manager','0','3','0','ISMS',NULL),
('USER_ROLE','16','ISMS_STAFF','ISMS担当者','ISMS Staff','0','2','0','ISMS',NULL),
('USER_ROLE','17','ISMS_INT_AUDIT_LEADER','ISMS内部監査責任者','ISMS IntAudit','0','3','1','ISMS',NULL),
('USER_ROLE','18','ISMS_EXT_AUDIT_COORDINATOR','ISMS外部監査対応責任者','ISMS ExtAudit','0','3','2','ISMS',NULL),

----------------------------------------------------------------
-- (A) Pマーク (PMARK)
----------------------------------------------------------------
('USER_ROLE','19','PMARK_TOP_MANAGEMENT','トップマネジメント(Pマーク)','PMark Top','0','4','0','PMARK',NULL),
('USER_ROLE','20','PMARK_MANAGER','Pマーク責任者','PMark Manager','0','3','0','PMARK',NULL),
('USER_ROLE','21','PMARK_STAFF','Pマーク担当者','PMark Staff','0','2','0','PMARK',NULL),
('USER_ROLE','22','PMARK_INT_AUDIT_LEADER','Pマーク内部監査責任者','PMark IntAudit','0','3','1','PMARK',NULL),
('USER_ROLE','23','PMARK_EXT_AUDIT_COORDINATOR','Pマーク外部監査対応責任者','PMark ExtAudit','0','3','2','PMARK',NULL),

----------------------------------------------------------------
-- (B) QMS (ISO9001)
----------------------------------------------------------------
('USER_ROLE','24','QMS_TOP_MANAGEMENT','トップマネジメント(QMS)','QMS Top','0','4','0','QMS',NULL),
('USER_ROLE','25','QMS_MANAGER','QMS責任者','QMS Manager','0','3','0','QMS',NULL),
('USER_ROLE','26','QMS_STAFF','QMS担当者','QMS Staff','0','2','0','QMS',NULL),
('USER_ROLE','27','QMS_INT_AUDIT_LEADER','QMS内部監査責任者','QMS IntAudit','0','3','1','QMS',NULL),
('USER_ROLE','28','QMS_EXT_AUDIT_COORDINATOR','QMS外部監査対応責任者','QMS ExtAudit','0','3','2','QMS',NULL),

----------------------------------------------------------------
-- (A) SOC2 ロール (5種)
----------------------------------------------------------------
('USER_ROLE','29','SOC2_TOP_MANAGEMENT','トップマネジメント(SOC2)','SOC2 Top','0','4','0','SOC2',NULL),
('USER_ROLE','30','SOC2_MANAGER','SOC2責任者','SOC2 Manager','0','3','0','SOC2',NULL),
('USER_ROLE','31','SOC2_STAFF','SOC2担当者','SOC2 Staff','0','2','0','SOC2',NULL),
('USER_ROLE','32','SOC2_INT_AUDIT_LEADER','SOC2内部監査責任者','SOC2 IntAudit','0','3','1','SOC2',NULL),
('USER_ROLE','33','SOC2_EXT_AUDIT_COORDINATOR','SOC2外部監査対応責任者','SOC2 ExtAudit','0','3','2','SOC2',NULL),
-- (1) SOC2報告書取りまとめ役
('USER_ROLE','44','SOC2_REPORT_OWNER','SOC2 Reportオーナー','SOC2 ReportOwner','0','3','0','SOC2',NULL),

-- (2) TSC: Security
('USER_ROLE','45','SOC2_TSC_SECURITY_OWNER','SOC2 TSC(セキュリティ)オーナー','SOC2 Security','0','3','0','SOC2',NULL),

-- (3) TSC: Availability
('USER_ROLE','46','SOC2_TSC_AVAILABILITY_OWNER','SOC2 TSC(可用性)オーナー','SOC2 Availability','0','3','0','SOC2',NULL),

-- (4) TSC: Confidentiality
('USER_ROLE','47','SOC2_TSC_CONFIDENTIALITY_OWNER','SOC2 TSC(機密性)オーナー','SOC2 Confidentiality','0','3','0','SOC2',NULL),

-- (5) TSC: Processing Integrity
('USER_ROLE','48','SOC2_TSC_PROCESSING_INTEGRITY_OWNER','SOC2 TSC(処理完全性)オーナー','SOC2 ProcIntegrity','0','3','0','SOC2',NULL),

-- (6) TSC: Privacy
('USER_ROLE','49','SOC2_TSC_PRIVACY_OWNER','SOC2 TSC(プライバシー)オーナー','SOC2 Privacy','0','3','0','SOC2',NULL),

----------------------------------------------------------------
-- (B) AIMS ロール (5種)
--   AIMS が特定のマネジメントシステムを指す前提で同様に作成
----------------------------------------------------------------
('USER_ROLE','34','AIMS_TOP_MANAGEMENT','トップマネジメント(AIMS)','AIMS Top','0','4','0','AIMS',NULL),
('USER_ROLE','35','AIMS_MANAGER','AIMS責任者','AIMS Manager','0','3','0','AIMS',NULL),
('USER_ROLE','36','AIMS_STAFF','AIMS担当者','AIMS Staff','0','2','0','AIMS',NULL),
('USER_ROLE','37','AIMS_INT_AUDIT_LEADER','AIMS内部監査責任者','AIMS IntAudit','0','3','1','AIMS',NULL),
('USER_ROLE','38','AIMS_EXT_AUDIT_COORDINATOR','AIMS外部監査対応責任者','AIMS ExtAudit','0','3','2','AIMS',NULL),

----------------------------------------------------------------
-- (C) EMS ロール (5種)
--   EMS(ISO14001) 環境マネジメントシステムなどを想定
----------------------------------------------------------------
('USER_ROLE','39','EMS_TOP_MANAGEMENT','トップマネジメント(EMS)','EMS Top','0','4','0','EMS',NULL),
('USER_ROLE','40','EMS_MANAGER','EMS責任者','EMS Manager','0','3','0','EMS',NULL),
('USER_ROLE','41','EMS_STAFF','EMS担当者','EMS Staff','0','2','0','EMS',NULL),
('USER_ROLE','42','EMS_INT_AUDIT_LEADER','EMS内部監査責任者','EMS IntAudit','0','3','1','EMS',NULL),
('USER_ROLE','43','EMS_EXT_AUDIT_COORDINATOR','EMS外部監査対応責任者','EMS ExtAudit','0','3','2','EMS',NULL),

-- 環境側面管理責任者
('USER_ROLE','50','EMS_ENV_ASPECTS_MANAGER',
 'EMS環境側面管理責任者','EMS AspectsMgr',
 '0','3','0','EMS',NULL),

-- 法的要求事項管理者
('USER_ROLE','51','EMS_LEGAL_COMPLIANCE_MANAGER',
 'EMS法的要求事項管理者','EMS LegalMgr',
 '0','3','0','EMS',NULL),

-- 運用管理リーダー
('USER_ROLE','52','EMS_OPERATIONAL_CONTROL_LEADER',
 'EMS運用管理リーダー','EMS OpCtrl',
 '0','3','0','EMS',NULL),

-- 緊急対応責任者
('USER_ROLE','53','EMS_EMERGENCY_COORDINATOR',
 'EMS緊急対応責任者','EMS Emergency',
 '0','3','0','EMS',NULL),

-- 監視・測定・分析リーダー
('USER_ROLE','54','EMS_MONITORING_MEASUREMENT_LEAD',
 'EMS監視測定リーダー','EMS MonitorLead',
 '0','3','0','EMS',NULL),

-- 環境文書管理者
('USER_ROLE','55','EMS_DOCUMENT_RECORDS_MANAGER',
 'EMS文書管理者','EMS DocsMgr',
 '0','3','0','EMS',NULL),

-- 環境コミュニケーション担当
('USER_ROLE','56','EMS_COMMUNICATION_OFFICER',
 'EMSコミュニケーション担当','EMS Comm',
 '0','3','0','EMS',NULL),
 
-- PROJECT_STATUS
('PROJECT_STATUS','PREPARING','DEFAULT','準備中','Preparing','0','1','0','0','0',NULL,NULL,NULL,NULL,NULL),
('PROJECT_STATUS','IN_PROGRESS','DEFAULT','実行中','InProgress','1','1','0','0','0',NULL,NULL,NULL,NULL,NULL),
('PROJECT_STATUS','ON_HOLD','DEFAULT','保留中','OnHold','0','0','1','0','0',NULL,NULL,NULL,NULL,NULL),
('PROJECT_STATUS','SUSPENDED','DEFAULT','停止(中断)','Suspended','0','0','1','0','1',NULL,NULL,NULL,NULL,NULL),
('PROJECT_STATUS','COMPLETED','DEFAULT','完了','Completed','0','0','0','0','0',NULL,NULL,NULL,NULL,NULL),
('PROJECT_STATUS','CERTIFIED','DEFAULT','認証取得済み','Certified','0','0','0','1','0',NULL,NULL,NULL,NULL,NULL),
('PROJECT_STATUS','CLOSED','DEFAULT','クローズ','Closed','0','0','0','0','0',NULL,NULL,NULL,NULL,NULL),
('PROJECT_STATUS','CANCELED','DEFAULT','途中キャンセル','Canceled','0','0','0','0','0',NULL,NULL,NULL,NULL,NULL),
('PROJECT_STATUS','OTHER','DEFAULT','その他','Other','0','0','0','0','0',NULL,NULL,NULL,NULL,NULL),

-- AUDIT_TYPE
('AUDIT_TYPE','INTERNAL','DEFAULT','内部監査','InternalAudit','1','0','0','0','0',NULL,NULL,NULL,NULL,NULL),
('AUDIT_TYPE','EXTERNAL','DEFAULT','外部監査','ExternalAudit','2','1','0','0','0',NULL,NULL,NULL,NULL,NULL),
('AUDIT_TYPE','STAGE1','DEFAULT','初回審査(Stage1)','Stage1Audit','10','1','1','0','0',NULL,NULL,NULL,NULL,NULL),
('AUDIT_TYPE','STAGE2','DEFAULT','初回審査(Stage2)','Stage2Audit','11','1','2','0','0',NULL,NULL,NULL,NULL,NULL),
('AUDIT_TYPE','SURVEILLANCE','DEFAULT','サーベイランス','Surveillance','12','1','0','1','0',NULL,NULL,NULL,NULL,NULL),
('AUDIT_TYPE','RENEWAL','DEFAULT','更新監査','RenewalAudit','13','1','0','3','0',NULL,NULL,NULL,NULL,NULL),
('AUDIT_TYPE','SELF_ASSESS','DEFAULT','セルフアセスメント','SelfAssessment','15','0','0','0','1',NULL,NULL,NULL,NULL,NULL),
('AUDIT_TYPE','OTHER','DEFAULT','その他','OtherAudit','0','0','0','0','0',NULL,NULL,NULL,NULL,NULL),

-- AUDIT_STATUS
('AUDIT_STATUS','PLANNED','DEFAULT','計画済み','Planned','7','0','0','0','0',NULL,NULL,NULL,NULL,NULL),
('AUDIT_STATUS','SCHEDULED','DEFAULT','日程確定','Scheduled','7','0','0','0','0',NULL,NULL,NULL,NULL,NULL),
('AUDIT_STATUS','IN_PROGRESS','DEFAULT','実施中','InProgress','0','1','0','0','0',NULL,NULL,NULL,NULL,NULL),
('AUDIT_STATUS','REVIEWING','DEFAULT','レビュー中','Reviewing','0','2','0','0','0',NULL,NULL,NULL,NULL,NULL),
('AUDIT_STATUS','COMPLETED','DEFAULT','完了','Completed','0','0','1','0','0',NULL,NULL,NULL,NULL,NULL),
('AUDIT_STATUS','SUSPENDED','DEFAULT','中断','Suspended','0','0','0','1','0',NULL,NULL,NULL,NULL,NULL),
('AUDIT_STATUS','CANCELED','DEFAULT','キャンセル','Canceled','0','0','0','2','0',NULL,NULL,NULL,NULL,NULL),
('AUDIT_STATUS','CLOSED','DEFAULT','クローズ','Closed','0','0','0','0','1',NULL,NULL,NULL,NULL,NULL),

-- AUDIT_STAGE (ISO27001想定)
('AUDIT_STAGE','STAGE1_DOCUMENT','ISO27001_2022','Stage1(書類審査)','Stage1Doc','1','0','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AUDIT_STAGE','STAGE2_ONSITE','ISO27001_2022','Stage2(現地審査)','Stage2Onsite','2','1','2',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AUDIT_STAGE','SURVEILLANCE1','ISO27001_2022','サーベイランス(1年目)','Surveillance1','12','1','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AUDIT_STAGE','RENEWAL','ISO27001_2022','更新審査','Renewal','13','1','3',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('AUDIT_STAGE','STAGE_INTERNAL','ISO27001_2022','内部監査相当(カスタム)','IntAudit','0','1','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL),

-- NON_CONFORMITY_SEVERITY
('NON_CONFORMITY_SEVERITY','MINOR','DEFAULT','軽微不適合(Minor)','Minor','1','3','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('NON_CONFORMITY_SEVERITY','MAJOR','DEFAULT','重大不適合(Major)','Major','2','2','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('NON_CONFORMITY_SEVERITY','CRITICAL','DEFAULT','致命的不適合','Critical','3','1','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('NON_CONFORMITY_SEVERITY','OBSERVATION','DEFAULT','観察事項','Observation','1','3','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('NON_CONFORMITY_SEVERITY','OPPORTUNITY','DEFAULT','改善機会','Opportunity','1','0','2',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('NON_CONFORMITY_SEVERITY','OTHER','DEFAULT','その他','OtherSev','0','0','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL),

-- NON_CONFORMITY_STATUS
('NON_CONFORMITY_STATUS','OPEN','DEFAULT','未解決','Open',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('NON_CONFORMITY_STATUS','CLOSED','DEFAULT','解決済','Closed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),

-- CORRECTIVE_ACTION_STATUS
('CORRECTIVE_ACTION_STATUS','OPEN','DEFAULT','対応中','Open',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CORRECTIVE_ACTION_STATUS','DONE','DEFAULT','対応完了','Done',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),

-- RISK_STATUS
('RISK_STATUS','OPEN','DEFAULT','リスク未対応','Open','1','1','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('RISK_STATUS','IN_PROGRESS','DEFAULT','対応中','InProgress','1','1','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('RISK_STATUS','ACCEPTED','DEFAULT','受容','Accepted','0','1','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('RISK_STATUS','MITIGATED','DEFAULT','軽減済み','Mitigated','0','1','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('RISK_STATUS','TRANSFERRED','DEFAULT','転嫁(移転)','Transferred','0','1','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('RISK_STATUS','AVOIDED','DEFAULT','回避','Avoided','0','0','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('RISK_STATUS','CLOSED','DEFAULT','クローズ','Closed','0','0','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL),

-- RISK_IMPACT
('RISK_IMPACT','CRITICAL','DEFAULT','影響度 極大','Critical','4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('RISK_IMPACT','HIGH','DEFAULT','影響度 大','High','3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('RISK_IMPACT','MEDIUM','DEFAULT','影響度 中','Medium','2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('RISK_IMPACT','LOW','DEFAULT','影響度 小','Low','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('RISK_IMPACT','NEGLIGIBLE','DEFAULT','影響度 無視可能','Negligible','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),

-- RISK_LIKELIHOOD
('RISK_LIKELIHOOD','CERTAIN','DEFAULT','ほぼ確実','Certain','95',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('RISK_LIKELIHOOD','LIKELY','DEFAULT','高い','Likely','70',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('RISK_LIKELIHOOD','POSSIBLE','DEFAULT','中程度','Possible','50',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('RISK_LIKELIHOOD','UNLIKELY','DEFAULT','低い','Unlikely','20',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('RISK_LIKELIHOOD','RARE','DEFAULT','ごく稀','Rare','5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),

-- RISK_LEVEL
('RISK_LEVEL','HIGH_RISK','DEFAULT','高リスク','HighRisk',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('RISK_LEVEL','MEDIUM_RISK','DEFAULT','中リスク','MedRisk',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('RISK_LEVEL','LOW_RISK','DEFAULT','低リスク','LowRisk',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),

-- RISK_TREATMENT_STATUS
('RISK_TREATMENT_STATUS','OPEN','DEFAULT','未対応','Open',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('RISK_TREATMENT_STATUS','IN_PROGRESS','DEFAULT','対策実施中','InProgress',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('RISK_TREATMENT_STATUS','DONE','DEFAULT','対策完了','Done',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),

-- DOCUMENT_STATUS
('DOCUMENT_STATUS','DRAFT','DEFAULT','ドラフト','Draft','1','0','0','0','0',NULL,NULL,NULL,NULL,NULL),
('DOCUMENT_STATUS','REVIEW','DEFAULT','レビュー中','Review','0','2','0','0','0',NULL,NULL,NULL,NULL,NULL),
('DOCUMENT_STATUS','APPROVED','DEFAULT','承認済み','Approved','0','2','0','0','0',NULL,NULL,NULL,NULL,NULL),
('DOCUMENT_STATUS','REJECTED','DEFAULT','却下','Rejected','0','0','1','0','0',NULL,NULL,NULL,NULL,NULL),
('DOCUMENT_STATUS','PUBLISHED','DEFAULT','公開済み','Published','0','2','0','2','0',NULL,NULL,NULL,NULL,NULL),
('DOCUMENT_STATUS','ARCHIVED','DEFAULT','アーカイブ','Archived','0','0','0','0','1',NULL,NULL,NULL,NULL,NULL),
('DOCUMENT_STATUS','EXPIRED','DEFAULT','有効期限切れ','Expired','0','0','0','0','2',NULL,NULL,NULL,NULL,NULL),

-- EVIDENCE_TYPE
('EVIDENCE_TYPE','DOCUMENT','DEFAULT','文書ファイル','Document','1','1','0','3','0',NULL,NULL,NULL,NULL,NULL),
('EVIDENCE_TYPE','SCREENSHOT','DEFAULT','スクリーンショット','Screenshot','2','1','0','2','0',NULL,NULL,NULL,NULL,NULL),
('EVIDENCE_TYPE','SYSTEM_LOG','DEFAULT','システムログ','SystemLog','3','0','1','1','0',NULL,NULL,NULL,NULL,NULL),
('EVIDENCE_TYPE','VIDEO','DEFAULT','動画','Video','4','2','0','2','0',NULL,NULL,NULL,NULL,NULL),
('EVIDENCE_TYPE','URL_REFERENCE','DEFAULT','URLリファレンス','URL_Ref','0','0','0','0','1',NULL,NULL,NULL,NULL,NULL),

-- TRAINING_RECORD_STATUS
('TRAINING_RECORD_STATUS','REQUIRED','DEFAULT','受講必須','Required','70','0','0','0','0',NULL,NULL,NULL,NULL,NULL),
('TRAINING_RECORD_STATUS','IN_PROGRESS','DEFAULT','受講中(進行中)','InProgress','70','0','14','0','0',NULL,NULL,NULL,NULL,NULL),
('TRAINING_RECORD_STATUS','COMPLETED','DEFAULT','修了(合格)','Completed','70','0','365','1','0',NULL,NULL,NULL,NULL,NULL),
('TRAINING_RECORD_STATUS','FAILED','DEFAULT','不合格(再試験要)','Failed','70','1','30','0','0',NULL,NULL,NULL,NULL,NULL),
('TRAINING_RECORD_STATUS','WAIVED','DEFAULT','免除','Waived','0','0','0','0','1',NULL,NULL,NULL,NULL,NULL),
('TRAINING_RECORD_STATUS','EXPIRED','DEFAULT','有効期限切れ','Expired','70','0','0','0','0',NULL,NULL,NULL,NULL,NULL),

-- COMPLIANCE_FW_TYPE
('COMPLIANCE_FW_TYPE','ISO27001_2022','DEFAULT','ISMS (ISO 27001:2022)','ISO27001_2022','2022','1','1','0','1',NULL,NULL,NULL,NULL,NULL),
('COMPLIANCE_FW_TYPE','PMARK','DEFAULT','Pマーク (プライバシーマーク)','PMark','2022','0','1','0','2',NULL,NULL,NULL,NULL,NULL),
('COMPLIANCE_FW_TYPE','PCI_DSS','DEFAULT','PCI DSS (カード情報保護)','PCI-DSS','4.0','1','0','1','1',NULL,NULL,NULL,NULL,NULL),
('COMPLIANCE_FW_TYPE','OTHER','DEFAULT','その他','OtherFW','0','0','0','0','0',NULL,NULL,NULL,NULL,NULL),

-- CHANGE_TYPE
('CHANGE_TYPE','NORMAL_CHANGE','DEFAULT','通常変更','NormalChange','1','1','0','0',NULL,NULL,NULL,NULL,NULL,NULL),
('CHANGE_TYPE','EMERGENCY_CHANGE','DEFAULT','緊急変更','EmergencyChange','1','3','0','0',NULL,NULL,NULL,NULL,NULL,NULL),
('CHANGE_TYPE','MAJOR_CHANGE','DEFAULT','大規模変更','MajorChange','2','2','0','0',NULL,NULL,NULL,NULL,NULL,NULL),
('CHANGE_TYPE','SECURITY_PATCH','DEFAULT','セキュリティパッチ','SecurityPatch','1','3','1','0',NULL,NULL,NULL,NULL,NULL,NULL),
('CHANGE_TYPE','REGULATORY','DEFAULT','規制・法令変更','Regulatory','2','2','0','1',NULL,NULL,NULL,NULL,NULL,NULL),

-- INCIDENT_TYPE
('INCIDENT_TYPE','SECURITY_INCIDENT','DEFAULT','セキュリティインシデント','SecIncident','1','0','0','3',NULL,NULL,NULL,NULL,NULL,NULL),
('INCIDENT_TYPE','SYSTEM_OUTAGE','DEFAULT','システム障害','SystemOutage','0','1','0','3',NULL,NULL,NULL,NULL,NULL,NULL),
('INCIDENT_TYPE','DATA_BREACH','DEFAULT','データ漏洩','DataBreach','1','0','1','4',NULL,NULL,NULL,NULL,NULL,NULL); 