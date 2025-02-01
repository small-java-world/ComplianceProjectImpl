-- --------------------------------------------------------------------------
-- 建物: Building
-- --------------------------------------------------------------------------
CREATE TABLE Building (
    building_id    VARCHAR(36)  NOT NULL,
    building_name  VARCHAR(100) NOT NULL,
    address        VARCHAR(255) NOT NULL,
    description    TEXT         NULL,
    created_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Building PRIMARY KEY (building_id)
);

-- --------------------------------------------------------------------------
-- フロア: Floor
-- --------------------------------------------------------------------------
CREATE TABLE Floor (
    floor_id      VARCHAR(36)  NOT NULL,
    building_id   VARCHAR(36)  NOT NULL,
    floor_number  VARCHAR(50)  NOT NULL,
    description   TEXT         NULL,
    created_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Floor PRIMARY KEY (floor_id),
    CONSTRAINT FK_Floor_Building FOREIGN KEY (building_id) REFERENCES Building(building_id)
);

-- --------------------------------------------------------------------------
-- 部屋: Room
-- --------------------------------------------------------------------------
CREATE TABLE Room (
    room_id       VARCHAR(36)  NOT NULL,
    floor_id      VARCHAR(36)  NOT NULL,
    room_name     VARCHAR(100) NOT NULL,
    room_type_code VARCHAR(50) NOT NULL,
    description   TEXT         NULL,
    created_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Room PRIMARY KEY (room_id),
    CONSTRAINT FK_Room_Floor FOREIGN KEY (floor_id) REFERENCES Floor(floor_id)
);

-- --------------------------------------------------------------------------
-- 資産管理: Asset
-- --------------------------------------------------------------------------
CREATE TABLE Asset (
    asset_id            VARCHAR(36)  NOT NULL,
    project_id          VARCHAR(36)  NOT NULL,
    name                VARCHAR(100) NOT NULL,
    asset_type_code     VARCHAR(50)  NOT NULL,
    classification_code VARCHAR(50)  NOT NULL,
    room_id             VARCHAR(36)  NULL,
    description         TEXT         NULL,
    created_at          TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Asset PRIMARY KEY (asset_id),
    CONSTRAINT FK_Asset_Project FOREIGN KEY (project_id) REFERENCES ComplianceProject(project_id),
    CONSTRAINT FK_Asset_Room FOREIGN KEY (room_id) REFERENCES Room(room_id)
);

-- --------------------------------------------------------------------------
-- 資産所有者: AssetOwner
-- --------------------------------------------------------------------------
CREATE TABLE AssetOwner (
    asset_owner_id     VARCHAR(36)  NOT NULL,
    asset_id           VARCHAR(36)  NOT NULL,
    owner_id           VARCHAR(36)  NOT NULL,
    responsibility_code VARCHAR(50) NOT NULL,
    created_at         TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at         TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_AssetOwner PRIMARY KEY (asset_owner_id),
    CONSTRAINT FK_AssetOwner_Asset FOREIGN KEY (asset_id) REFERENCES Asset(asset_id),
    CONSTRAINT FK_AssetOwner_User FOREIGN KEY (owner_id) REFERENCES User(user_id)
);

-- --------------------------------------------------------------------------
-- 教育プログラム: TrainingProgram
-- --------------------------------------------------------------------------
CREATE TABLE TrainingProgram (
    training_program_id VARCHAR(36) NOT NULL,
    project_id          VARCHAR(36) NOT NULL,
    title               VARCHAR(200) NOT NULL,
    description         TEXT        NULL,
    start_date          DATE        NOT NULL,
    end_date            DATE        NOT NULL,
    created_at          TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_TrainingProgram PRIMARY KEY (training_program_id),
    CONSTRAINT FK_TrainingProgram_Project FOREIGN KEY (project_id) REFERENCES ComplianceProject(project_id)
);

-- --------------------------------------------------------------------------
-- 教育記録: TrainingRecord
-- --------------------------------------------------------------------------
CREATE TABLE TrainingRecord (
    training_record_id   VARCHAR(36) NOT NULL,
    training_program_id  VARCHAR(36) NOT NULL,
    user_id              VARCHAR(36) NOT NULL,
    completion_date      DATE        NULL,
    score                INT         NULL,
    status_code          VARCHAR(50) NOT NULL,
    created_at           TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at           TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_TrainingRecord PRIMARY KEY (training_record_id),
    CONSTRAINT FK_TrainingRecord_TrainingProgram FOREIGN KEY (training_program_id) REFERENCES TrainingProgram(training_program_id),
    CONSTRAINT FK_TrainingRecord_User FOREIGN KEY (user_id) REFERENCES User(user_id)
); 