<?php
require_once 'config.php'; // Include the configuration file

// Start the session if not already started
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Regenerate session ID to prevent session fixation
if (!isset($_SESSION['initialized'])) {
    session_regenerate_id(true);
    $_SESSION['initialized'] = true;
}

// Check if session timeout has occurred (e.g., 30 minutes of inactivity)
if (isset($_SESSION['LAST_ACTIVITY']) && (time() - $_SESSION['LAST_ACTIVITY'] > 1800)) {
    // Destroy the session and redirect to the login page
    session_unset(); // Unset all session variables
    session_destroy(); // Destroy the session
    header('Location: ' . BASE_URL . 'auth/login.php'); // Redirect to login
    exit;
}
$_SESSION['LAST_ACTIVITY'] = time(); // Update last activity timestamp

// Check if the user role is set in the session
if (!isset($_SESSION['user_role'])) {
    $_SESSION['user_role'] = 'guest'; // Default role if none is assigned
}

// Debugging: Log session details (Optional for development)
error_log("Session User ID: " . ($_SESSION['user_id'] ?? 'Not set'));
error_log("Session User Role: " . ($_SESSION['user_role'] ?? 'Not set'));

// Ensure the user role is valid
$valid_roles = ['admin', 'staff', 'user', 'guest'];
if (!in_array($_SESSION['user_role'], $valid_roles)) {
    $_SESSION['user_role'] = 'guest'; // Fallback to 'guest' role if invalid role detected
}
