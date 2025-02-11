-- TrainingProgram table
CREATE TABLE TrainingProgram (
    program_id      VARCHAR(36)   NOT NULL,
    name            VARCHAR(255)  NOT NULL,
    description     TEXT          NULL,
    program_type    VARCHAR(50)   NOT NULL,
    duration        INT           NOT NULL,  -- in minutes
    passing_score   INT           NULL,      -- percentage
    is_mandatory    BOOLEAN       NOT NULL DEFAULT false,
    valid_months    INT           NULL,      -- validity period in months
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_TrainingProgram PRIMARY KEY (program_id)
);

-- TrainingMaterial table
CREATE TABLE TrainingMaterial (
    material_id     VARCHAR(36)   NOT NULL,
    program_id      VARCHAR(36)   NOT NULL,
    title           VARCHAR(255)  NOT NULL,
    description     TEXT          NULL,
    material_type   VARCHAR(50)   NOT NULL,
    file_path       VARCHAR(255)  NULL,
    url             VARCHAR(255)  NULL,
    version         VARCHAR(20)   NOT NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_TrainingMaterial PRIMARY KEY (material_id),
    CONSTRAINT FK_TrainingMaterial_Program FOREIGN KEY (program_id) REFERENCES TrainingProgram(program_id)
);

-- TrainingSchedule table
CREATE TABLE TrainingSchedule (
    schedule_id     VARCHAR(36)   NOT NULL,
    program_id      VARCHAR(36)   NOT NULL,
    start_date      DATE          NOT NULL,
    end_date        DATE          NOT NULL,
    max_participants INT          NULL,
    instructor_id   VARCHAR(36)   NULL,
    location        VARCHAR(255)  NULL,
    status          VARCHAR(50)   NOT NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_TrainingSchedule PRIMARY KEY (schedule_id),
    CONSTRAINT FK_TrainingSchedule_Program FOREIGN KEY (program_id) REFERENCES TrainingProgram(program_id)
);

-- TrainingRecord table
CREATE TABLE TrainingRecord (
    record_id       VARCHAR(36)   NOT NULL,
    user_id         VARCHAR(36)   NOT NULL,
    program_id      VARCHAR(36)   NOT NULL,
    schedule_id     VARCHAR(36)   NULL,
    status          VARCHAR(50)   NOT NULL,
    start_date      DATE          NOT NULL,
    completion_date DATE          NULL,
    score           INT           NULL,
    is_passed       BOOLEAN       NULL,
    certificate_id  VARCHAR(36)   NULL,
    expiry_date     DATE          NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_TrainingRecord PRIMARY KEY (record_id),
    CONSTRAINT FK_TrainingRecord_Program FOREIGN KEY (program_id) REFERENCES TrainingProgram(program_id),
    CONSTRAINT FK_TrainingRecord_Schedule FOREIGN KEY (schedule_id) REFERENCES TrainingSchedule(schedule_id)
);

-- TrainingFeedback table
CREATE TABLE TrainingFeedback (
    feedback_id     VARCHAR(36)   NOT NULL,
    record_id       VARCHAR(36)   NOT NULL,
    rating          INT           NOT NULL,  -- 1-5 scale
    comments        TEXT          NULL,
    created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_TrainingFeedback PRIMARY KEY (feedback_id),
    CONSTRAINT FK_TrainingFeedback_Record FOREIGN KEY (record_id) REFERENCES TrainingRecord(record_id)
);

-- Indexes
CREATE INDEX IDX_TrainingMaterial_ProgramId ON TrainingMaterial(program_id);
CREATE INDEX IDX_TrainingSchedule_ProgramId ON TrainingSchedule(program_id);
CREATE INDEX IDX_TrainingSchedule_InstructorId ON TrainingSchedule(instructor_id);
CREATE INDEX IDX_TrainingRecord_UserId ON TrainingRecord(user_id);
CREATE INDEX IDX_TrainingRecord_ProgramId ON TrainingRecord(program_id);
CREATE INDEX IDX_TrainingRecord_ScheduleId ON TrainingRecord(schedule_id);
CREATE INDEX IDX_TrainingFeedback_RecordId ON TrainingFeedback(record_id); 