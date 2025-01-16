<?php
require_once 'config.php'; // Include the configuration file
require_once 'functions.php'; // Ensure functions like isLoggedIn, redirect, and hasRole are defined

/**
 * Middleware to restrict access to logged-in users
 */
function requireLogin() {
    session_start(); // Ensure session is started
    if (!isLoggedIn()) {
        $_SESSION['error'] = "You must log in to access this page.";
        redirect(BASE_URL . 'auth/login.php');
    }
}

/**
 * Middleware to restrict access to admin-only pages
 */
function requireAdmin() {
    if (session_status() === PHP_SESSION_NONE) {
        session_start(); // Ensure the session is started
    }

    // Check if the user is logged in and has the role of 'admin'
    if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] !== 'admin') {
        $_SESSION['error'] = "Access denied. Admins only.";
        header('Location: ' . BASE_URL); // Redirect to the homepage
        exit;
    }
}


/**
 * Middleware to restrict access to staff-only pages
 */
function requireStaff() {
    session_start(); // Ensure session is started
    if (!isLoggedIn() || !hasRole('staff')) {
        $_SESSION['error'] = "Access denied. Staff members only.";
        redirect(BASE_URL);
    }
}
