-- Create table
CREATE TABLE IF NOT EXISTS M_CODE (
    code_category      VARCHAR(50)  NOT NULL, 
    code               VARCHAR(50)  NOT NULL, 
    code_division      VARCHAR(50)  NOT NULL, 
    name               VARCHAR(100) NOT NULL, 
    code_short_name    VARCHAR(50)  NULL,
    extension1         VARCHAR(100) NULL,
    extension2         VARCHAR(100) NULL,
    extension3         VARCHAR(100) NULL,
    extension4         VARCHAR(100) NULL,
    extension5         VARCHAR(100) NULL,
    extension6         VARCHAR(100) NULL,
    extension7         VARCHAR(100) NULL,
    extension8         VARCHAR(100) NULL,
    extension9         VARCHAR(100) NULL,
    extension10        VARCHAR(100) NULL,
    extension11        VARCHAR(100) NULL,
    extension12        VARCHAR(100) NULL,
    extension13        VARCHAR(100) NULL,
    extension14        VARCHAR(100) NULL,
    extension15        VARCHAR(100) NULL,
    display_order      INT          NOT NULL DEFAULT 0,
    is_active         BOOLEAN      NOT NULL DEFAULT true,
    description       TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    created_at        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT PK_M_CODE PRIMARY KEY (code_category, code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create indexes
CREATE INDEX idx_m_code_code_category ON M_CODE(code_category);
CREATE INDEX idx_m_code_code ON M_CODE(code);
CREATE INDEX idx_m_code_code_division ON M_CODE(code_division); 