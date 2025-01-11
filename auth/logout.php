<?php
// Include session management
require_once '../includes/session.php';

// Destroy the session and clear all session variables
session_start();
session_unset();
session_destroy();

// Redirect the user to the login page
header('Location: login.php');
exit;
?>
