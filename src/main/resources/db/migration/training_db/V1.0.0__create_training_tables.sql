-- TrainingProgram table
CREATE TABLE TrainingProgram (
    training_program_id VARCHAR(36)   NOT NULL,
    title               VARCHAR(200)  NOT NULL,
    description         TEXT         NULL,
    program_type_code   VARCHAR(50)   NOT NULL,
    valid_months        INT          NULL,
    created_at          TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_TrainingProgram PRIMARY KEY (training_program_id)
);

-- TrainingRecord table
CREATE TABLE TrainingRecord (
    training_record_id  VARCHAR(36)   NOT NULL,
    training_program_id VARCHAR(36)   NOT NULL,
    user_id            VARCHAR(36)   NOT NULL,
    completion_date    DATE         NOT NULL,
    status_code        VARCHAR(50)   NOT NULL,
    score              INT          NULL,
    notes              TEXT         NULL,
    created_at         TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at         TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_TrainingRecord PRIMARY KEY (training_record_id),
    CONSTRAINT FK_TrainingRecord_Program FOREIGN KEY (training_program_id) REFERENCES TrainingProgram(training_program_id)
); 