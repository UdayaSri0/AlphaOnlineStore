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

****************************************************************************************************************************************

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    category_id INT NOT NULL,
    brand_id INT DEFAULT NULL,
    image_url VARCHAR(255) DEFAULT NULL,
    is_active BOOLEAN DEFAULT TRUE, -- Indicates if the product is available for purchase
    is_deleted BOOLEAN DEFAULT FALSE, -- Indicates if the product is soft-deleted
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE,
    FOREIGN KEY (brand_id) REFERENCES brands(brand_id) ON DELETE SET NULL
);

CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    parent_category_id INT DEFAULT NULL, -- Allows subcategories
    description TEXT DEFAULT NULL,
    is_deleted BOOLEAN DEFAULT FALSE, -- Soft delete
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_category_id) REFERENCES categories(category_id) ON DELETE SET NULL
);


CREATE TABLE product_images (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL, -- Links to the products table
    image_url VARCHAR(255) NOT NULL, -- Path to the image file
    is_main_image BOOLEAN DEFAULT FALSE, -- Whether this is the main product image
    is_deleted BOOLEAN DEFAULT FALSE, -- Soft delete for image
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);


CREATE TABLE brands (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT DEFAULT NULL,
    website_url VARCHAR(255) DEFAULT NULL, -- Optional brand website
    is_deleted BOOLEAN DEFAULT FALSE, -- Soft delete
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE product_reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL, -- Links to the products table
    user_id INT NOT NULL, -- Links to the users table
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5), -- Rating from 1 to 5
    comment TEXT DEFAULT NULL, -- Optional review comment
    is_deleted BOOLEAN DEFAULT FALSE, -- Soft delete
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE product_discounts (
    discount_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL, -- Links to the products table
    discount_percentage DECIMAL(5, 2) NOT NULL CHECK (discount_percentage BETWEEN 0 AND 100), -- Discount percentage
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    is_deleted BOOLEAN DEFAULT FALSE, -- Soft delete
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);


########################################################################################################################################

-- Insert sample data into categories
INSERT INTO categories (category_name, parent_category_id, description, is_deleted)
VALUES 
('Electronics', NULL, 'Electronic devices and accessories', FALSE),
('Mobiles', 1, 'Smartphones and accessories', FALSE),
('Laptops', 1, 'Laptops and accessories', FALSE),
('Appliances', NULL, 'Home and kitchen appliances', FALSE);

-- Insert sample data into brands
INSERT INTO brands (brand_name, description, website_url, is_deleted)
VALUES 
('Apple', 'Leading brand in electronics', 'https://www.apple.com', FALSE),
('Samsung', 'Innovative technology solutions', 'https://www.samsung.com', FALSE),
('LG', 'Home and kitchen appliances', 'https://www.lg.com', FALSE),
('Dell', 'High-performance laptops and PCs', 'https://www.dell.com', FALSE);

-- Insert sample data into products
INSERT INTO products (product_name, description, price, stock_quantity, category_id, brand_id, image_url, is_active, is_deleted)
VALUES 
('iPhone 14', 'Latest Apple smartphone with A15 chip', 999.99, 50, 2, 1, '/images/products/iphone14.jpg', TRUE, FALSE),
('Galaxy S22', 'Samsung flagship smartphone with powerful features', 899.99, 30, 2, 2, '/images/products/galaxys22.jpg', TRUE, FALSE),
('LG Refrigerator', 'Double-door fridge with smart cooling technology', 1200.00, 10, 4, 3, '/images/products/lg_fridge.jpg', TRUE, FALSE),
('Dell XPS 13', 'Compact and high-performance laptop', 1500.00, 20, 3, 4, '/images/products/dell_xps13.jpg', TRUE, FALSE);

-- Insert sample data into product_images
INSERT INTO product_images (product_id, image_url, is_main_image, is_deleted)
VALUES 
(1, '/images/products/iphone14_main.jpg', TRUE, FALSE),
(1, '/images/products/iphone14_side.jpg', FALSE, FALSE),
(2, '/images/products/galaxys22_main.jpg', TRUE, FALSE),
(3, '/images/products/lg_fridge_main.jpg', TRUE, FALSE),
(4, '/images/products/dell_xps13_main.jpg', TRUE, FALSE);

-- Insert sample data into product_reviews
INSERT INTO product_reviews (product_id, user_id, rating, comment, is_deleted)
VALUES 
(1, 1, 5, 'Amazing phone with excellent features!', FALSE),
(1, 2, 4, 'Great phone, but slightly overpriced.', FALSE),
(2, 3, 5, 'Best smartphone I have ever used!', FALSE),
(3, 4, 4, 'Good fridge, but delivery took longer than expected.', FALSE),
(4, 5, 5, 'Compact and powerful laptop. Highly recommend!', FALSE);

-- Insert sample data into product_discounts
INSERT INTO product_discounts (product_id, discount_percentage, start_date, end_date, is_deleted)
VALUES 
(1, 10.00, '2025-01-01 00:00:00', '2025-01-15 23:59:59', FALSE),
(2, 15.00, '2025-01-05 00:00:00', '2025-01-20 23:59:59', FALSE),
(3, 5.00, '2025-01-10 00:00:00', '2025-01-25 23:59:59', FALSE),
(4, 20.00, '2025-01-15 00:00:00', '2025-01-30 23:59:59', FALSE);


*****************************************************************************************************************************************

-- Create the `orders` table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_number VARCHAR(20) UNIQUE NOT NULL, -- Unique public order identifier (e.g., "ORD12345")
    user_id INT NOT NULL, -- Links to the `users` table
    total_amount DECIMAL(10, 2) NOT NULL, -- Total price for the order
    order_status ENUM('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled', 'Returned', 'Refunded') DEFAULT 'Pending', -- Added more statuses
    shipping_address TEXT NOT NULL, -- Shipping address
    payment_method ENUM('Credit Card', 'PayPal', 'Bank Transfer', 'Cash on Delivery') DEFAULT 'Cash on Delivery', -- Payment method used
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Create the `order_items` table
CREATE TABLE order_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL, -- Links to the `orders` table
    product_id INT NOT NULL, -- Links to the `products` table
    quantity INT NOT NULL CHECK (quantity > 0), -- Quantity of this product in the order (must be > 0)
    price DECIMAL(10, 2) NOT NULL, -- Price of the product at the time of order
    subtotal DECIMAL(10, 2) GENERATED ALWAYS AS (quantity * price) STORED, -- Calculated subtotal for this product
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Create the `order_logs` table
CREATE TABLE order_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL, -- References `orders` table
    user_id INT NOT NULL, -- References `users` table
    activity TEXT NOT NULL, -- Details of the activity (e.g., "Order Placed", "Order Shipped")
    ip_address VARCHAR(45) DEFAULT NULL, -- Optional: Store IP address of the user
    log_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP, -- When the activity occurred
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);



CREATE TABLE wishlist (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL, -- References the `users` table
    product_id INT NOT NULL, -- References the `products` table
    added_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- When the item was added
    notification_sent BOOLEAN DEFAULT FALSE, -- Track if a notification has been sent
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);
