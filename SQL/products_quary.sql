
CREATE TABLE brands (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT DEFAULT NULL,
    website_url VARCHAR(255) DEFAULT NULL, -- Optional brand website
    is_deleted BOOLEAN DEFAULT FALSE, -- Soft delete
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
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

-- Insert sample data into brands
INSERT INTO brands (brand_name, description, website_url, is_deleted)
VALUES 
('Apple', 'Leading brand in electronics', 'https://www.apple.com', FALSE),
('Samsung', 'Innovative technology solutions', 'https://www.samsung.com', FALSE),
('LG', 'Home and kitchen appliances', 'https://www.lg.com', FALSE),
('Dell', 'High-performance laptops and PCs', 'https://www.dell.com', FALSE);


-- Insert sample data into categories
INSERT INTO categories (category_name, parent_category_id, description, is_deleted)
VALUES 
('Electronics', NULL, 'Electronic devices and accessories', FALSE),
('Mobiles', 1, 'Smartphones and accessories', FALSE),
('Laptops', 1, 'Laptops and accessories', FALSE),
('Appliances', NULL, 'Home and kitchen appliances', FALSE);


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


