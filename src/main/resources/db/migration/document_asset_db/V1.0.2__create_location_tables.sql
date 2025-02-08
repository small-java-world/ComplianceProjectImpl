-- Building table
CREATE TABLE Building (
    building_id     VARCHAR(36)   NOT NULL,
    building_name   VARCHAR(100)  NOT NULL,
    address         VARCHAR(500)  NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Building PRIMARY KEY (building_id)
);

-- Floor table
CREATE TABLE Floor (
    floor_id        VARCHAR(36)   NOT NULL,
    building_id     VARCHAR(36)   NOT NULL,
    floor_number    VARCHAR(20)   NOT NULL,
    floor_name      VARCHAR(100)  NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Floor PRIMARY KEY (floor_id),
    CONSTRAINT FK_Floor_Building FOREIGN KEY (building_id) REFERENCES Building(building_id)
);

-- Room table
CREATE TABLE Room (
    room_id         VARCHAR(36)   NOT NULL,
    floor_id        VARCHAR(36)   NOT NULL,
    room_name       VARCHAR(100)  NOT NULL,
    room_number     VARCHAR(20)   NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Room PRIMARY KEY (room_id),
    CONSTRAINT FK_Room_Floor FOREIGN KEY (floor_id) REFERENCES Floor(floor_id)
); 