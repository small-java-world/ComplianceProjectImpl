-- CodeCategory table
CREATE TABLE CodeCategory (
    category_id     VARCHAR(36)   NOT NULL,
    name           VARCHAR(100)  NOT NULL,
    description    TEXT         NULL,
    created_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_CodeCategory PRIMARY KEY (category_id)
);

-- CodeValue table
CREATE TABLE CodeValue (
    code_id        VARCHAR(36)   NOT NULL,
    category_id    VARCHAR(36)   NOT NULL,
    code_value     VARCHAR(50)   NOT NULL,
    display_name   VARCHAR(100)  NOT NULL,
    description    TEXT         NULL,
    sort_order     INT          NOT NULL DEFAULT 0,
    is_active      BOOLEAN      NOT NULL DEFAULT true,
    created_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_CodeValue PRIMARY KEY (code_id),
    CONSTRAINT FK_CodeValue_Category FOREIGN KEY (category_id) REFERENCES CodeCategory(category_id),
    CONSTRAINT UQ_CodeValue_CategoryValue UNIQUE (category_id, code_value)
);

-- SystemParameter table
CREATE TABLE SystemParameter (
    parameter_id   VARCHAR(36)   NOT NULL,
    name          VARCHAR(100)  NOT NULL,
    value         TEXT         NOT NULL,
    description   TEXT         NULL,
    created_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_SystemParameter PRIMARY KEY (parameter_id),
    CONSTRAINT UQ_SystemParameter_Name UNIQUE (name)
); 