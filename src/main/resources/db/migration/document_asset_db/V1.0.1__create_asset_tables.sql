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
    CONSTRAINT PK_Asset PRIMARY KEY (asset_id)
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