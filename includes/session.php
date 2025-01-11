<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Regenerate session ID to prevent session fixation
if (!isset($_SESSION['initialized'])) {
    session_regenerate_id(true);
    $_SESSION['initialized'] = true;
}

// Set session timeout (e.g., 30 minutes)
if (isset($_SESSION['LAST_ACTIVITY']) && (time() - $_SESSION['LAST_ACTIVITY'] > 1800)) {
    session_unset(); // Unset all session variables
    session_destroy(); // Destroy the session
    header('Location: auth/login.php'); // Redirect to login
    exit;
}
$_SESSION['LAST_ACTIVITY'] = time();
?>
