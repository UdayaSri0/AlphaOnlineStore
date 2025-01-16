<?php
require_once '../includes/session.php';
require_once '../includes/db_connect.php';
require_once '../includes/functions.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = sanitize($_POST['email']);
    $password = $_POST['password'];

    if (!empty($email) && !empty($password)) {
        try {
            $query = $db->prepare("SELECT * FROM users WHERE email = :email");
            $query->bindParam(':email', $email);
            $query->execute();
            $user = $query->fetch(PDO::FETCH_ASSOC);

            if ($user && password_verify($password, $user['password'])) {
                if ($user['account_status'] !== 'Active') {
                    $error = "Your account is {$user['account_status']}. Please contact support.";
                } else {
                    // Set session variables
                    $_SESSION['user_id'] = $user['id'];
                    $_SESSION['username'] = $user['username'];
                    $_SESSION['user_role'] = $user['user_role'];

                    // Redirect based on role
                    if (strcasecmp($user['user_role'], 'Admin') === 0) {
                        redirect('../admin/admin_dashboard.php');
                    } elseif (strcasecmp($user['user_role'], 'Staff') === 0) {
                        redirect('../staff/staff_dashboard.php');
                    } else {
                        redirect('../index.php');
                    }
                }
            } else {
                $error = "Invalid email or password.";
            }
        } catch (PDOException $e) {
            $error = "Database error: " . $e->getMessage();
        }
    } else {
        $error = "Please fill in all fields.";
    }
}
?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="/AlphaOnline/assets/css/log_style.css">
</head>
<body>
    <div class="login-container">
        <form action="" method="POST" class="login-form" id="login-form">
            <h1>Login</h1>
            <?php if (isset($error)): ?>
                <p class="error"><?= htmlspecialchars($error); ?></p>
            <?php endif; ?>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>

            <!-- Login Button -->
            <button type="submit" class="btn-login">Login</button>

            <!-- Clear Button -->
            <button type="button" class="btn-clear" onclick="clearForm()">Clear</button>

            <!-- Back Button -->
            <button type="button" class="btn-back" onclick="history.back()">Back</button>

            <p>Don't have an account? <a href="register.php">Register here</a></p>
        </form>
    </div>

    <script>
        function clearForm() {
            document.getElementById('login-form').reset();
        }
    </script>
</body>
</html>
