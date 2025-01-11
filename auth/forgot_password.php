<?php
require_once '../includes/db_connect.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'];

    if (!empty($email)) {
        $query = $db->prepare("SELECT * FROM users WHERE email = :email");
        $query->bindParam(':email', $email);
        $query->execute();
        $user = $query->fetch(PDO::FETCH_ASSOC);

        if ($user) {
            $reset_token = bin2hex(random_bytes(16));
            $query = $db->prepare("UPDATE users SET reset_token = :reset_token WHERE email = :email");
            $query->bindParam(':reset_token', $reset_token);
            $query->bindParam(':email', $email);

            if ($query->execute()) {
                // Send reset link via email (mock implementation)
                echo "Reset link: http://localhost/AlphaOnline/auth/reset_password.php?token=$reset_token";
            }
        } else {
            $error = "Email not found.";
        }
    } else {
        $error = "Please provide your email.";
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password</title>
</head>
<body>
    <form action="" method="POST">
        <h1>Forgot Password</h1>
        <?php if (isset($error)): ?>
            <p style="color: red;"><?= htmlspecialchars($error) ?></p>
        <?php endif; ?>
        <input type="email" name="email" placeholder="Email" required>
        <button type="submit">Send Reset Link</button>
    </form>
</body>
</html>
