CREATE DATABASE AlphaOnlineStore;

USE AlphaOnlineStore;
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(120) NOT NULL, -- Define the column
    password VARCHAR(255) NOT NULL,
    name VARCHAR(120) NOT NULL,
    email VARCHAR(255) NOT NULL,
    address TEXT NOT NULL,
    phone_number VARCHAR(15),
    user_role ENUM('Admin', 'Staff', 'Customer') NOT NULL,
    account_status ENUM('Active', 'Inactive', 'Suspended') DEFAULT 'Active',
    account_created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    login_attempts INT DEFAULT 0,
    last_login_at DATETIME DEFAULT NULL,
    UNIQUE KEY (username(50)), -- Add partial index for username
    UNIQUE KEY (email(100)) -- Add partial index for email
);

-- Create the 'UsersLog' table
CREATE TABLE UsersLog (
    log_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique log entry ID
    user_id INT NOT NULL, -- Foreign key linking to the `users` table
    activity TEXT NOT NULL, -- Details of the activity performed
    ip_address VARCHAR(45), -- IP address of the user (IPv4/IPv6 compatible)
    user_agent TEXT, -- Details of the user's browser/device (optional)
    log_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP, -- When the activity occurred
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE -- Ensures referential integrity
);


INSERT INTO users (id, username, password, name, email, address, phone_number, user_role, account_status, account_created_at, last_updated_at, login_attempts, last_login_at)
VALUES -- Create the 'users' table

(1, 'DarkStar', 'hashed_password_1', 'Udaya Sri', 'udayasri@example.com', '123 Main Street, Colombo, Sri Lanka', '94712345678', 'Admin', 'Active', '2025-01-01 10:00:00', '2025-01-02 10:00:00', 0, '2025-01-03 15:00:00'),
(2, 'ImashaNetEng', 'hashed_password_2', 'Imasha Ayeshka', 'imasha.ayeshka@example.com', '456 High Street, Kandy, Sri Lanka', '94787654321', 'Staff', 'Active', '2025-01-01 11:00:00', '2025-01-02 12:00:00', 0, '2025-01-03 16:00:00'),
(3, 'Customer123', 'hashed_password_3', 'Nimal Sri', 'nimal.sri@example.com', '789 Park Avenue, Galle, Sri Lanka', '94798765432', 'Customer', 'Active', '2025-01-01 12:00:00', '2025-01-02 13:00:00', 1, '2025-01-03 17:00:00');

INSERT INTO UsersLog (log_id, user_id, activity, ip_address, user_agent, log_timestamp)
VALUES
(1, 1, 'Logged in', '192.168.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)', '2025-01-03 15:00:00'),
(2, 2, 'Updated profile', '192.168.0.2', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)', '2025-01-03 16:10:00'),
(3, 3, 'Failed login attempt', '192.168.0.3', 'Mozilla/5.0 (Linux; Android 11; SM-G991B)', '2025-01-03 17:15:00');
