
# 🌟 Alpha Online Store 🌟

Welcome to **Alpha Online Store**, your ultimate e-commerce platform for a seamless shopping experience. This project is a robust and scalable online clothing store built with PHP, MySQL, and a modern file structure to ensure easy management and extendability.

---

## 🚀 Features

### 🛒 **For Customers**
- **Dynamic Home Page**: A welcoming landing page with dynamic banners and featured products.
- **User Accounts**:
  - Register/Login/Logout functionality with secure authentication.
  - User Dashboard for order history and profile management.
  - Wishlist to save your favorite products.
- **Shopping Cart**:
  - Add and remove items easily.
  - Simple and secure checkout process.

### 🛠️ **For Staff**
- **Staff Dashboard**: Manage tasks with an intuitive interface.
- **Scheduling**: View and request time off or manage shifts.

### 🛡️ **For Admin**
- **Admin Dashboard**: A central hub for managing the store.
- **Product Management**: Add, edit, delete, and organize products by categories.
- **Order Management**: View and process customer orders efficiently.
- **Content Management**:
  - Update About Us and Contact Us pages.
  - Manage homepage banners and promotional content.
- **Reports and Analytics** (Optional): Gain insights into sales, inventory, and user behavior.

---

## 🖼️ **Screenshots**

| **Landing Page** | **Admin Panel** |
|-------------------|-----------------|
| ![Landing Page](assets/images/landing_page.png) | ![Admin Panel](assets/images/admin_panel.png) |

---

## 🏗️ **Tech Stack**

- **Frontend**: HTML, CSS, JavaScript
- **Backend**: PHP
- **Database**: MySQL
- **Environment**: WAMP (Windows, Apache, MySQL, PHP)

---

## 📂 **Project Structure**

```
AlphaOnlineStore/
├── .htaccess                # Security and URL rewrites
├── index.php                # Main landing page
├── auth/                    # Authentication-related scripts
│   ├── login.php            # Login page
│   ├── register.php         # Registration page
│   └── reset_password.php   # Password reset
├── admin/                   # Admin functionalities
│   ├── admin_dashboard.php  # Admin control panel
│   └── product/             # Product management
├── cart/                    # Shopping cart system
│   ├── cart.php             # View cart
│   └── checkout.php         # Checkout process
├── assets/                  # Static assets
│   ├── css/                 # Stylesheets
│   ├── js/                  # JavaScript
│   └── images/              # Images and icons
└── includes/                # Backend scripts
    ├── config.php           # Database credentials
    └── middleware.php       # Role-based access control
```

---

## ⚙️ **Setup Instructions**

### 1️⃣ **Prerequisites**
- Install **WAMP** or an equivalent LAMP/XAMPP stack.
- Clone this repository to your local machine:
  ```bash
  git clone https://github.com/UdayaSri0/AlphaOnlineStore.git
  ```

### 2️⃣ **Database Configuration**
- Import the `alpha_online_store.sql` file into your MySQL database.
- Update the `includes/config.php` file with your database credentials:
  ```php
  define('DB_HOST', 'localhost');
  define('DB_NAME', 'alpha_online_store');
  define('DB_USER', 'your_username');
  define('DB_PASS', 'your_password');
  ```

### 3️⃣ **Run the Application**
- Access the project in your browser:
  ```
  http://localhost/AlphaOnlineStore/
  ```

---

## 🔒 **Security Features**
- Password hashing using `password_hash()`.
- SQL injection prevention with prepared statements.
- Middleware to enforce role-based access control.
- Custom `.htaccess` for secure server configurations.

---

## 📊 **Future Enhancements**
- Implement payment gateway integration.
- Add an AI-based recommendation system.
- Build a progressive web app (PWA) version of the site.

---

## 🧑‍💻 **Contributors**
- **Project Lead**: [UdayaSri0](https://github.com/UdayaSri0)

---

## 💡 **Contributing**
We welcome contributions! Here’s how you can help:
1. Fork the repository.
2. Create a new feature branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add feature-name"
   ```
4. Push to your fork:
   ```bash
   git push origin feature-name
   ```
5. Submit a pull request.

---

## 📝 **License**
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

🌟 **Thank you for checking out Alpha Online Store! Happy Coding!**


- **X (Twitter)**: [@Udaya_Sri_](https://x.com/Udaya_Sri_)
- **Facebook**: [Udaya Sri Facebook](https://www.facebook.com/share/14xF3XuXpk/?mibextid=wwXIfr)
- **Instagram**: [@udayasrisri1](https://www.instagram.com/udayasrisri1/)
- **LinkedIn**: [Udaya Sri](https://www.linkedin.com/in/udaya-sri-0922b91a5/)