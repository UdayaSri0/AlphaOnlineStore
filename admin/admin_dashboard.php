<?php
require_once '../includes/session.php'; // Start the session
require_once '../includes/middleware.php'; // Include middleware

requireAdmin(); // Ensure only admins can access this page
?>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="assets/css/admin_style.css">
</head>

<body>
    <header class="admin-header">
        <div class="logo">
            <a href="admin_dashboard.php">Admin Panel</a>
        </div>
        <nav class="nav-menu">
            <a href="manage_users.php">Manage Users</a>
            <a href="manage_staff.php">Manage Staff</a>
            <a href="manage_orders.php">Orders</a>
            <a href="reports/sales_report.php">Reports</a>
            <a href="marketing/promotions.php">Marketing</a>
            <a href="../auth/logout.php">Logout</a>
        </nav>
    </header>

    <div class="dashboard-container">
        <h1>Welcome to the Admin Dashboard</h1>

        <div class="stats-cards">
            <div class="card">
                <a href="manage_users.php">
                    <i class="fas fa-users"></i>
                    <h2>Users</h2>
                    <p>Manage all registered users.</p>
                </a>
            </div>

            <div class="card">
                <a href="manage_staff.php">
                    <i class="fas fa-user-tie"></i>
                    <h2>Staff</h2>
                    <p>Manage staff accounts and permissions.</p>
                </a>
            </div>

            <div class="card">
                <a href="manage_orders.php">
                    <i class="fas fa-shopping-cart"></i>
                    <h2>Orders</h2>
                    <p>View and manage customer orders.</p>
                </a>
            </div>

            <div class="card">
                <a href="product/manage_product.php">
                    <i class="fas fa-box"></i>
                    <h2>Products</h2>
                    <p>Manage products in your catalog.</p>
                </a>
            </div>

            <div class="card">
                <a href="content/manage_banners.php">
                    <i class="fas fa-images"></i>
                    <h2>Banners</h2>
                    <p>Manage promotional banners.</p>
                </a>
            </div>

            <div class="card">
                <a href="reports/sales_report.php">
                    <i class="fas fa-chart-line"></i>
                    <h2>Reports</h2>
                    <p>View analytics and sales reports.</p>
                </a>
            </div>

            <div class="card">
                <a href="marketing/promotions.php">
                    <i class="fas fa-bullhorn"></i>
                    <h2>Marketing</h2>
                    <p>Manage coupons and promotions.</p>
                </a>
            </div>
        </div>

        <div class="recent-activities">
            <h2>Recent Activities</h2>
            <ul>
                <li>User JohnDoe registered a new account.</li>
                <li>Order #12345 has been processed.</li>
                <li>New product "Winter Jacket" added.</li>
            </ul>
        </div>
    </div>

    <footer class="admin-footer">
        <p>&copy; <?= date('Y'); ?> AlphaOnline Admin Panel. All rights reserved.</p>
    </footer>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/js/all.min.js"></script>
</body>

</html>
