-- TrainingProgram table
CREATE TABLE TrainingProgram (
    program_id      VARCHAR(36)   NOT NULL,
    title           VARCHAR(200)  NOT NULL,
    description     TEXT         NULL,
    category_code   VARCHAR(50)   NOT NULL,
    status_code     VARCHAR(50)   NOT NULL,
    start_date      DATE         NOT NULL,
    end_date        DATE         NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_TrainingProgram PRIMARY KEY (program_id)
);

-- TrainingMaterial table
CREATE TABLE TrainingMaterial (
    material_id     VARCHAR(36)   NOT NULL,
    program_id      VARCHAR(36)   NOT NULL,
    title           VARCHAR(200)  NOT NULL,
    content_url     VARCHAR(500) NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_TrainingMaterial PRIMARY KEY (material_id),
    CONSTRAINT FK_TrainingMaterial_Program FOREIGN KEY (program_id) REFERENCES TrainingProgram(program_id)
);

-- TrainingParticipant table
CREATE TABLE TrainingParticipant (
    participant_id  VARCHAR(36)   NOT NULL,
    program_id      VARCHAR(36)   NOT NULL,
    user_id         VARCHAR(36)   NOT NULL,
    status_code     VARCHAR(50)   NOT NULL,
    completion_date DATE         NULL,
    score           INT          NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_TrainingParticipant PRIMARY KEY (participant_id),
    CONSTRAINT FK_TrainingParticipant_Program FOREIGN KEY (program_id) REFERENCES TrainingProgram(program_id)
);

-- TrainingFeedback table
CREATE TABLE TrainingFeedback (
    feedback_id     VARCHAR(36)   NOT NULL,
    participant_id  VARCHAR(36)   NOT NULL,
    rating          INT          NOT NULL,
    comment         TEXT         NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_TrainingFeedback PRIMARY KEY (feedback_id),
    CONSTRAINT FK_TrainingFeedback_Participant FOREIGN KEY (participant_id) REFERENCES TrainingParticipant(participant_id)
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
    CONSTRAINT FK_TrainingRecord_Program FOREIGN KEY (training_program_id) REFERENCES TrainingProgram(program_id)
); 