CREATE USER 'db_cardinal_desarrollador_'@'localhost' IDENTIFIED BY 'cardinal123';
GRANT ALL PRIVILEGES ON db_cardinal.* TO 'db_cardinal_desarrollador'@'localhost';
FLUSH PRIVILEGES;