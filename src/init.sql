CREATE DATABASE IF NOT EXISTS applications;
USE applications;

CREATE TABLE IF NOT EXISTS your_table_name (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Insert some test data
INSERT INTO your_table_name (name) VALUES ('Test Name 1'), ('Test Name 2');

-- Create user if not exists and grant privileges
CREATE USER IF NOT EXISTS 'webuser'@'%' IDENTIFIED BY 'webpass';
GRANT ALL PRIVILEGES ON applications.* TO 'webuser'@'%';
FLUSH PRIVILEGES;