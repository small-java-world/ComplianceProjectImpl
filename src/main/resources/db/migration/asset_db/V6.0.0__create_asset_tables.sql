-- Building table
CREATE TABLE Building (
    building_id     VARCHAR(36)   NOT NULL,
    name           VARCHAR(100)   NOT NULL,
    address        VARCHAR(500)   NULL,
    created_at     TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Building PRIMARY KEY (building_id)
);

-- Floor table
CREATE TABLE Floor (
    floor_id       VARCHAR(36)   NOT NULL,
    building_id    VARCHAR(36)   NOT NULL,
    floor_number   VARCHAR(20)   NOT NULL,
    name          VARCHAR(100)   NULL,
    created_at     TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Floor PRIMARY KEY (floor_id),
    CONSTRAINT FK_Floor_Building FOREIGN KEY (building_id) REFERENCES Building(building_id)
);

-- Room table
CREATE TABLE Room (
    room_id        VARCHAR(36)   NOT NULL,
    floor_id       VARCHAR(36)   NOT NULL,
    name          VARCHAR(100)   NOT NULL,
    room_number    VARCHAR(20)   NULL,
    created_at     TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Room PRIMARY KEY (room_id),
    CONSTRAINT FK_Room_Floor FOREIGN KEY (floor_id) REFERENCES Floor(floor_id)
);

-- Asset table
CREATE TABLE Asset (
    asset_id        VARCHAR(36)   NOT NULL,
    name            VARCHAR(100)  NOT NULL,
    asset_type_code VARCHAR(50)   NOT NULL,
    classification_code VARCHAR(50) NOT NULL,
    room_id         VARCHAR(36)   NULL,
    description     TEXT         NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Asset PRIMARY KEY (asset_id),
    CONSTRAINT FK_Asset_Room FOREIGN KEY (room_id) REFERENCES Room(room_id)
);

-- AssetAttribute table
CREATE TABLE AssetAttribute (
    asset_attribute_id VARCHAR(36)   NOT NULL,
    asset_id          VARCHAR(36)   NOT NULL,
    confidentiality_level INT       NOT NULL,
    integrity_level   INT          NOT NULL,
    availability_level INT         NOT NULL,
    contains_personal_data BOOLEAN  NOT NULL,
    created_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_AssetAttribute PRIMARY KEY (asset_attribute_id),
    CONSTRAINT FK_AssetAttribute_Asset FOREIGN KEY (asset_id) REFERENCES Asset(asset_id)
);

-- AssetOwner table
CREATE TABLE AssetOwner (
    asset_owner_id  VARCHAR(36)   NOT NULL,
    asset_id        VARCHAR(36)   NOT NULL,
    owner_id        VARCHAR(36)   NOT NULL,
    responsibility_code VARCHAR(50) NOT NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_AssetOwner PRIMARY KEY (asset_owner_id),
    CONSTRAINT FK_AssetOwner_Asset FOREIGN KEY (asset_id) REFERENCES Asset(asset_id)
); 