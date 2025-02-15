-- ComplianceFramework test data
INSERT INTO ComplianceFramework (framework_id, framework_code, name, version, description)
VALUES 
('FW001', 'FRAMEWORK_001', 'テストフレームワーク1', '1.0', 'テスト用フレームワーク1です。'),
('FW002', 'FRAMEWORK_002', 'テストフレームワーク2', '1.0', 'テスト用フレームワーク2です。');

-- Requirement test data (with hierarchy)
INSERT INTO Requirement (requirement_id, framework_id, requirement_code, name, description, parent_id)
VALUES
-- Framework 1 requirements
('REQ001', 'FW001', 'REQ_001', '要件1', '最上位要件1', NULL),
('REQ002', 'FW001', 'REQ_002', '要件2', '最上位要件2', NULL),
('REQ003', 'FW001', 'REQ_003', '要件1.1', '要件1の子要件1', 'REQ001'),
('REQ004', 'FW001', 'REQ_004', '要件1.2', '要件1の子要件2', 'REQ001'),
('REQ005', 'FW001', 'REQ_005', '要件2.1', '要件2の子要件1', 'REQ002'),
-- Framework 2 requirements
('REQ006', 'FW002', 'REQ_006', '要件A', '最上位要件A', NULL),
('REQ007', 'FW002', 'REQ_007', '要件A.1', '要件Aの子要件1', 'REQ006'),
('REQ008', 'FW002', 'REQ_008', '要件A.2', '要件Aの子要件2', 'REQ006');

-- ImplementationTask test data
INSERT INTO ImplementationTask (task_id, requirement_id, task_name, description, status)
VALUES
('TASK001', 'REQ003', 'タスク1', '要件1.1の実装タスク1', 'IN_PROGRESS'),
('TASK002', 'REQ003', 'タスク2', '要件1.1の実装タスク2', 'NOT_STARTED'),
('TASK003', 'REQ004', 'タスク3', '要件1.2の実装タスク1', 'COMPLETED'),
('TASK004', 'REQ007', 'タスク4', '要件A.1の実装タスク1', 'IN_PROGRESS');

-- Evidence test data
INSERT INTO Evidence (evidence_id, task_id, evidence_type, name, description, file_path)
VALUES
('EV001', 'TASK001', 'DOCUMENT', '証跡1', 'タスク1の証跡1', '/evidence/task001/evidence1.pdf'),
('EV002', 'TASK001', 'SCREENSHOT', '証跡2', 'タスク1の証跡2', '/evidence/task001/evidence2.pdf'),
('EV003', 'TASK002', 'DOCUMENT', '証跡3', 'タスク2の証跡1', '/evidence/task002/evidence1.pdf'),
('EV004', 'TASK004', 'SCREENSHOT', '証跡4', 'タスク4の証跡1', '/evidence/task004/evidence1.pdf'); 