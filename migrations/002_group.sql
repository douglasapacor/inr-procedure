CREATE TABLE `group` (
    id INT auto_increment NOT NULL,
    password varchar(500) NOT NULL,
    color varchar(7) NULL,
    active BOOL DEFAULT true NOT NULL,
    super BOOL DEFAULT false NOT NULL,
    canonical varchar(100) NOT NULL,
    created_by_id INT NULL,
    updated_by_id INT NULL,
    deleted_by_id INT NULL,
    created_at DATETIME NULL,
    updated_at DATETIME NULL,
    deleted_at DATETIME NULL,
    CONSTRAINT group_PK PRIMARY KEY (id),
    CONSTRAINT group_FK_1 FOREIGN KEY (created_by_id) REFERENCES `user` (id),
    CONSTRAINT group_FK_2 FOREIGN KEY (updated_by_id) REFERENCES `user` (id),
    CONSTRAINT group_FK_3 FOREIGN KEY (deleted_by_id) REFERENCES `user` (id)
);