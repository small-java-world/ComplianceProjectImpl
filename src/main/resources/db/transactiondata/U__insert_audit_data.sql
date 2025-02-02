-- ------------------------------------------------------------
-- 監査データ
-- ------------------------------------------------------------

-- 内部監査
INSERT INTO Audit (
  audit_id, project_id, audit_type_code, audit_stage_code, scheduled_date, status_code
)
VALUES (
  'AUDIT001','PRJ001','INTERNAL','STAGE_INTERNAL','2025-05-01','COMPLETED'
);

INSERT INTO AuditScope (
  audit_scope_id, audit_id, scope_item_code
)
VALUES
('ASCP001','AUDIT001','HQ_OFFICE'),
('ASCP002','AUDIT001','DEV_DEPARTMENT')
;

INSERT INTO AssessmentReport (
  report_id, audit_id, report_type_code, issued_date, summary, conclusion_code
)
VALUES (
  'ARPT001','AUDIT001','INTERNAL_REPORT','2025-05-10',
  '内部監査実施。重大不適合なし、軽微不備あり',
  'CONCLUSION_OK'
);

INSERT INTO NonConformity (
  non_conformity_id, audit_id, description, severity_code, status_code
)
VALUES (
  'NCF001','AUDIT001','セキュリティ研修の受講記録が欠落','MINOR','OPEN'
);

INSERT INTO CorrectiveAction (
  corrective_action_id, non_conformity_id, description, owner_id, planned_completion_date, status_code
)
VALUES (
  'CA001','NCF001','研修管理システム導入＆履歴集約','USR003','2025-06-01','OPEN'
);

-- 一次審査
INSERT INTO Audit (
  audit_id, project_id, audit_type_code, audit_stage_code, scheduled_date, status_code
)
VALUES (
  'AUDIT002','PRJ001','EXTERNAL','STAGE1_DOCUMENT','2025-09-01','COMPLETED'
);

INSERT INTO AssessmentReport (
  report_id, audit_id, report_type_code, issued_date, summary, conclusion_code
)
VALUES (
  'ARPT002','AUDIT002','EXTERNAL_REPORT','2025-09-10',
  '一次審査(書類)で大きな不備なし',
  'CONCLUSION_OK'
);

-- 二次審査
INSERT INTO Audit (
  audit_id, project_id, audit_type_code, audit_stage_code, scheduled_date, status_code
)
VALUES (
  'AUDIT003','PRJ001','EXTERNAL','STAGE2_ONSITE','2025-11-01','COMPLETED'
);

-- 観察事項(OBSERVATION)
INSERT INTO NonConformity (
  non_conformity_id, audit_id, description, severity_code, status_code
)
VALUES
('NCF002','AUDIT003','派遣社員の教育記録が未管理','OBSERVATION','OPEN'),
('NCF003','AUDIT003','IoTファーム更新手順書が一部拠点未展開','OBSERVATION','OPEN'),
('NCF004','AUDIT003','SNSアカウント復旧手順が未文書化','OBSERVATION','OPEN');

-- プロジェクト完了
UPDATE ComplianceProject
SET status_code='CERTIFIED',
    end_date='2026-01-01'
WHERE project_id='PRJ001'
;

-- 古いドキュメントバージョンの削除
DELETE FROM DocumentVersion
WHERE document_version_id='DOCV_DRAFT_OLD'
  AND status_code='DRAFT'
  AND document_id='DOC001'
; 