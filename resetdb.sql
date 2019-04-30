drop user 'root'@'localhost';
CREATE USER 'root'@'localhost' IDENTIFIED BY 'mutillidae';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost';
flush privileges;