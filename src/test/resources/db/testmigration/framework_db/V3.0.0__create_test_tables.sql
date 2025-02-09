-- Implementation table for testing
CREATE TABLE Implementation (
    implementation_id VARCHAR(36)   NOT NULL,
    requirement_id    VARCHAR(50)   NOT NULL,
    title            VARCHAR(200)  NOT NULL,
    description      TEXT         NULL,
    status_code      VARCHAR(50)   NOT NULL,
    created_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Implementation PRIMARY KEY (implementation_id)
);

CREATE TABLE IF NOT EXISTS Framework (
    framework_id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    version VARCHAR(50) NOT NULL,
    status_code VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (framework_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci; 