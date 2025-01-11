<?php
require_once 'functions.php';

// Middleware to restrict access to logged-in users
function requireLogin() {
    if (!isLoggedIn()) {
        redirect(BASE_URL . 'auth/login.php');
    }
}

// Middleware to restrict access to admin-only pages
function requireAdmin() {
    if (!isLoggedIn() || !hasRole('admin')) {
        redirect(BASE_URL);
    }
}

// Middleware to restrict access to staff-only pages
function requireStaff() {
    if (!isLoggedIn() || !hasRole('staff')) {
        redirect(BASE_URL);
    }
}
?>
