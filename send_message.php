<?php
session_start();
require_once 'includes/functions.php';
require_once 'includes/config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = sanitize($_POST['name'] ?? '');
    $email = sanitize($_POST['email'] ?? '');
    $message = sanitize($_POST['message'] ?? '');

    if (empty($name) || empty($message) || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
        header('Location: contact.php?status=error');
        exit;
    }

    $subject = "New contact message from $name";
    $body = "Name: $name\nEmail: $email\n\n$message";
    $headers = "From: $email\r\nReply-To: $email";

    @mail(ADMIN_EMAIL, $subject, $body, $headers);

    header('Location: contact.php?status=success');
    exit;
}

header('Location: contact.php');
exit;
?>
