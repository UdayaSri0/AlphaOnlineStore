<?php
// Function to sanitize input
function sanitize($input) {
    return htmlspecialchars(trim($input), ENT_QUOTES, 'UTF-8');
}

// Function to check if a user is logged in
function isLoggedIn() {
    return isset($_SESSION['user_id']);
}

// Function to check user role
function hasRole($role) {
    return isset($_SESSION['user_role']) && strcasecmp($_SESSION['user_role'], $role) === 0;
}

// Function to redirect to a specific URL
function redirect($url) {
    header("Location: " . $url);
    exit;
}
?>
