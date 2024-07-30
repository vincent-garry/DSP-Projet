CREATE DATABASE IF NOT EXISTS applications;
USE applications;

-- Allow root to connect from any IP
CREATE USER 'root'@'%' IDENTIFIED BY 'DSPProject2024';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

INSERT INTO users (name) VALUES ('John Doe'), ('Jane Doe');
