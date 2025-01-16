<?php
// Include the session handling file
require_once __DIR__ . '/includes/session.php'; // Ensure session is started only once

// Check if the user is logged in
$is_logged_in = isset($_SESSION['user_id']); // Assuming 'user_id' is set when the user logs in

// Retrieve the user's role (Assuming 'role' is stored in the session)
$user_role = $_SESSION['role'] ?? null; // Example roles: 'admin', 'staff', 'user'
$username = $_SESSION['username'] ?? 'User'; // Default name if session username is not set
$user_image = $_SESSION['user_image'] ?? 'assets/images/user.png'; // Default user image if none is set
?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Online Clothing Store</title>

  <!-- Font Awesome CSS -->
  <link
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
    rel="stylesheet"
  />
  <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
  />

  <!-- Main Stylesheet -->
  <link rel="stylesheet" href="assets/css/style.css" />
</head>

<body>
  <header>
    <div class="header-container">
      <!-- Logo -->
      <div class="logo">
        <a href="index.php"><img src="assets/images/logo.png" alt="Logo" /></a>
      </div>

      <!-- Primary Navigation with Dropdowns -->
      <nav class="nav-menu">
        <div class="dropdown">
          <button class="dropbtn">Dropdown 1</button>
          <div class="dropdown-content">
            <a href="#">Option 1</a>
            <a href="#">Option 2</a>
            <a href="#">Option 3</a>
          </div>
        </div>
        <div class="dropdown">
          <button class="dropbtn">Dropdown 2</button>
          <div class="dropdown-content">
            <a href="#">Option 1</a>
            <a href="#">Option 2</a>
            <a href="#">Option 3</a>
          </div>
        </div>
        <div class="dropdown">
          <button class="dropbtn">Dropdown 3</button>
          <div class="dropdown-content">
            <a href="#">Option 1</a>
            <a href="#">Option 2</a>
            <a href="#">Option 3</a>
          </div>
        </div>
        <div class="dropdown">
          <button class="dropbtn">Dropdown 4</button>
          <div class="dropdown-content">
            <a href="#">Option 1</a>
            <a href="#">Option 2</a>
            <a href="#">Option 3</a>
          </div>
        </div>
      </nav>

      <!-- Secondary Navigation -->
      <nav class="nav-menu">
        <a href="about.php">About</a>
        <a href="contact.php">Contact</a>
        <?php if ($is_logged_in): ?>
          <?php if ($user_role === 'admin'): ?>
            <a href="admin/admin_dashboard.php">Admin Dashboard</a>
          <?php elseif ($user_role === 'staff'): ?>
            <a href="staff/staff_dashboard.php">Staff Dashboard</a>
          <?php elseif ($user_role === 'user'): ?>
            <a href="user/dashboard.php">User Dashboard</a>
          <?php endif; ?>
        <?php else: ?>
          <a href="auth/login.php">Login</a>
          <a href="auth/register.php">Register</a>
        <?php endif; ?>
      </nav>

      <!-- User Info (Profile/Logout) -->
      <?php if ($is_logged_in): ?>
        <div class="user-info">
          <img class="user-image" src="<?= htmlspecialchars($user_image); ?>" alt="User Image" />
          <span class="username"><?= htmlspecialchars($username); ?></span>
          <div class="dropdown-menu">
            <a href="user/manage_account.php">Manage Account</a>
            <a href="user/change_password.php">Change Password</a>
            <a href="auth/logout.php">Logout</a>
          </div>
        </div>
      <?php endif; ?>
    </div>
  </header>
</body>
</html>
