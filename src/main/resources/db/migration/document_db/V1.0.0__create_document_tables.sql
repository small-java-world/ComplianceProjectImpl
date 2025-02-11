-- Document table
CREATE TABLE IF NOT TABLE Document (
    document_id     VARCHAR(36)   NOT NULL,
    project_id      VARCHAR(36)   NOT NULL,
    document_type   VARCHAR(50)   NOT NULL,
    title           VARCHAR(255)  NOT NULL,
    description     TEXT          NULL,
    status          VARCHAR(50)   NOT NULL,
    version         VARCHAR(20)   NOT NULL,
    author_id       VARCHAR(36)   NOT NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Document PRIMARY KEY (document_id)
);

-- DocumentVersion table
CREATE TABLE IF NOT TABLE  DocumentVersion (
    version_id      VARCHAR(36)   NOT NULL,
    document_id     VARCHAR(36)   NOT NULL,
    version_number  VARCHAR(20)   NOT NULL,
    file_path       VARCHAR(255)  NOT NULL,
    comment         TEXT          NULL,
    created_by      VARCHAR(36)   NOT NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_DocumentVersion PRIMARY KEY (version_id),
    CONSTRAINT FK_DocumentVersion_Document FOREIGN KEY (document_id) REFERENCES Document(document_id)
);

-- ApprovalWorkflow table
CREATE TABLE IF NOT TABLE  ApprovalWorkflow (
    workflow_id     VARCHAR(36)   NOT NULL,
    document_id     VARCHAR(36)   NOT NULL,
    version_id      VARCHAR(36)   NOT NULL,
    approver_id     VARCHAR(36)   NOT NULL,
    status          VARCHAR(50)   NOT NULL,
    comment         TEXT          NULL,
    approval_date   TIMESTAMP     NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_ApprovalWorkflow PRIMARY KEY (workflow_id),
    CONSTRAINT FK_ApprovalWorkflow_Document FOREIGN KEY (document_id) REFERENCES Document(document_id),
    CONSTRAINT FK_ApprovalWorkflow_Version FOREIGN KEY (version_id) REFERENCES DocumentVersion(version_id)
);

-- Asset table
CREATE TABLE IF NOT TABLE  Asset (
    asset_id        VARCHAR(36)   NOT NULL,
    asset_type      VARCHAR(50)   NOT NULL,
    name            VARCHAR(255)  NOT NULL,
    description     TEXT          NULL,
    status          VARCHAR(50)   NOT NULL,
    location_id     VARCHAR(36)   NULL,
    owner_id        VARCHAR(36)   NOT NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Asset PRIMARY KEY (asset_id)
);

-- AssetOwner table
CREATE TABLE IF NOT TABLE  AssetOwner (
    owner_id        VARCHAR(36)   NOT NULL,
    asset_id        VARCHAR(36)   NOT NULL,
    user_id         VARCHAR(36)   NOT NULL,
    role            VARCHAR(50)   NOT NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_AssetOwner PRIMARY KEY (owner_id),
    CONSTRAINT FK_AssetOwner_Asset FOREIGN KEY (asset_id) REFERENCES Asset(asset_id)
);

-- Building table
CREATE TABLE IF NOT TABLE  Building (
    building_id     VARCHAR(36)   NOT NULL,
    name            VARCHAR(100)  NOT NULL,
    address         TEXT          NOT NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Building PRIMARY KEY (building_id)
);

-- Floor table
CREATE TABLE IF NOT TABLE  Floor (
    floor_id        VARCHAR(36)   NOT NULL,
    building_id     VARCHAR(36)   NOT NULL,
    floor_number    INT           NOT NULL,
    name            VARCHAR(100)  NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Floor PRIMARY KEY (floor_id),
    CONSTRAINT FK_Floor_Building FOREIGN KEY (building_id) REFERENCES Building(building_id)
);

-- Room table
CREATE TABLE IF NOT TABLE  Room (
    room_id         VARCHAR(36)   NOT NULL,
    floor_id        VARCHAR(36)   NOT NULL,
    room_number     VARCHAR(50)   NOT NULL,
    name            VARCHAR(100)  NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Room PRIMARY KEY (room_id),
    CONSTRAINT FK_Room_Floor FOREIGN KEY (floor_id) REFERENCES Floor(floor_id)
);

-- Indexes
CREATE INDEX IDX_Document_ProjectId ON Document(project_id);
CREATE INDEX IDX_Document_AuthorId ON Document(author_id);
CREATE INDEX IDX_DocumentVersion_DocumentId ON DocumentVersion(document_id);
CREATE INDEX IDX_DocumentVersion_CreatedBy ON DocumentVersion(created_by);
CREATE INDEX IDX_ApprovalWorkflow_DocumentId ON ApprovalWorkflow(document_id);
CREATE INDEX IDX_ApprovalWorkflow_VersionId ON ApprovalWorkflow(version_id);
CREATE INDEX IDX_ApprovalWorkflow_ApproverId ON ApprovalWorkflow(approver_id);
CREATE INDEX IDX_Asset_LocationId ON Asset(location_id);
CREATE INDEX IDX_Asset_OwnerId ON Asset(owner_id);
CREATE INDEX IDX_AssetOwner_AssetId ON AssetOwner(asset_id);
CREATE INDEX IDX_AssetOwner_UserId ON AssetOwner(user_id);
CREATE INDEX IDX_Floor_BuildingId ON Floor(building_id);
CREATE INDEX IDX_Room_FloorId ON Room(floor_id); 