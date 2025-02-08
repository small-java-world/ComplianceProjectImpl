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