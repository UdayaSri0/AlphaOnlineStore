
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


****************

-- Insert sample data into `orders`
INSERT INTO orders (order_number, user_id, total_amount, order_status, shipping_address, payment_method)
VALUES
('ORD10001', 1, 1200.00, 'Processing', '123 Alpha Street, Tech City', 'Credit Card'),
('ORD10002', 2, 450.00, 'Shipped', '456 Beta Avenue, Metro City', 'PayPal'),
('ORD10003', 1, 350.00, 'Pending', '123 Alpha Street, Tech City', 'Cash on Delivery'),
('ORD10004', 3, 750.00, 'Cancelled', '789 Gamma Road, Capital City', 'Bank Transfer');

-- Insert sample data into `order_items`
INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES
(1, 1, 2, 500.00), -- 2 x iPhone 14
(1, 2, 1, 200.00), -- 1 x Galaxy S22 Case
(2, 3, 3, 150.00), -- 3 x Dell Laptop Bags
(3, 4, 1, 350.00), -- 1 x LG Microwave
(4, 5, 2, 375.00); -- 2 x Apple AirPods

-- Insert sample data into `order_logs`
INSERT INTO order_logs (order_id, user_id, activity, ip_address)
VALUES
(1, 1, 'Order placed successfully', '192.168.1.101'),
(1, 1, 'Order payment processed', '192.168.1.101'),
(2, 2, 'Order shipped', '192.168.1.102'),
(3, 1, 'Order awaiting payment confirmation', '192.168.1.101'),
(4, 3, 'Order cancelled by user', '192.168.1.103');

-- Insert sample data into `wishlist`
INSERT INTO wishlist (user_id, product_id, notification_sent)
VALUES
(1, 1, FALSE), -- iPhone 14
(1, 3, TRUE),  -- Dell Laptop Bag
(2, 4, FALSE), -- LG Microwave
(3, 5, FALSE); -- Apple AirPods


*****************************************************************************************************************************************