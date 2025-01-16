<?php
require_once 'config.php';
require_once 'functions.php';

function startSessionIfNotStarted() {
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }
}

// Middleware to restrict access to logged-in users
function requireLogin() {
    startSessionIfNotStarted();
    if (!isset($_SESSION['user_id'])) {
        $_SESSION['error'] = "You must log in to access this page.";
        redirect(BASE_URL . 'auth/login.php');
    }
}

// Middleware to restrict access to admin-only pages
function requireAdmin() {
    startSessionIfNotStarted();
    if (!hasRole('Admin')) {
        $_SESSION['error'] = "Access denied. Admins only.";
        redirect(BASE_URL);
    }
}

// Middleware to restrict access to staff-only pages
function requireStaff() {
    startSessionIfNotStarted();
    if (!hasRole('Staff')) {
        $_SESSION['error'] = "Access denied. Staff members only.";
        redirect(BASE_URL);
    }
}

// Middleware to restrict access to general users
function requireUser() {
    startSessionIfNotStarted();
    if (!hasRole('Customer')) {
        $_SESSION['error'] = "Access denied. Users only.";
        redirect(BASE_URL);
    }
}
?>
