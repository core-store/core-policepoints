
CREATE TABLE IF NOT EXISTS core_policepoints (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    license VARCHAR(50) DEFAULT NULL,
    citizenid VARCHAR(50) DEFAULT NULL,
    points INT(11) DEFAULT 0
);
