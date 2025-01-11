<?php
require_once '../includes/db_connect.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $reset_token = $_POST['reset_token'];
    $new_password = $_POST['new_password'];

    if (!empty($reset_token) && !empty($new_password)) {
        $query = $db->prepare("SELECT * FROM users WHERE reset_token = :reset_token");
        $query->bindParam(':reset_token', $reset_token);
        $query->execute();
        $user = $query->fetch(PDO::FETCH_ASSOC);

        if ($user) {
            $new_password_hash = password_hash($new_password, PASSWORD_BCRYPT);

            $query = $db->prepare("UPDATE users SET password_hash = :password_hash, reset_token = NULL WHERE reset_token = :reset_token");
            $query->bindParam(':password_hash', $new_password_hash);
            $query->bindParam(':reset_token', $reset_token);

            if ($query->execute()) {
                header('Location: login.php');
                exit;
            } else {
                $error = "Failed to reset password.";
            }
        } else {
            $error = "Invalid reset token.";
        }
    } else {
        $error = "Please fill in all fields.";
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Reset Password</title>
</head>
<body>
    <form action="" method="POST">
        <h1>Reset Password</h1>
        <?php if (isset($error)): ?>
            <p style="color: red;"><?= htmlspecialchars($error) ?></p>
        <?php endif; ?>
        <input type="hidden" name="reset_token" value="<?= htmlspecialchars($_GET['token'] ?? '') ?>">
        <input type="password" name="new_password" placeholder="New Password" required>
        <button type="submit">Reset Password</button>
    </form>
</body>
</html>
