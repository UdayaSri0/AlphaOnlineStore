<?php
// Include session management, reusable functions, and database connection
require_once '../includes/session.php';
require_once '../includes/db_connect.php';
require_once '../includes/functions.php';

// Handle login form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = sanitize($_POST['email']); // Sanitize user input
    $password = $_POST['password'];

    if (!empty($email) && !empty($password)) {
        // Query the database for the user
        $query = $db->prepare("SELECT * FROM users WHERE email = :email");
        $query->bindParam(':email', $email);
        $query->execute();
        $user = $query->fetch(PDO::FETCH_ASSOC);

        // Debugging: Check if the user is found
        if (!$user) {
            $error = "No user found with the provided email.";
        } elseif (!isset($user['password'])) { // Check password column
            $error = "Password column is missing in the database.";
        } elseif (password_verify($password, $user['password'])) {
            // Store user information in the session
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['username'] = $user['username'];
            $_SESSION['role'] = $user['user_role'];

            // Redirect to the appropriate dashboard based on role
            if ($user['user_role'] === 'Admin') {
                redirect('../admin/admin_dashboard.php');
            } elseif ($user['user_role'] === 'Staff') {
                redirect('../staff/staff_dashboard.php');
            } else {
                redirect('../index.php');
            }
        } else {
            $error = "Invalid email or password.";
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
    <link rel="stylesheet" href="/AlphaOnline/assets/css/log_style.css"> <!-- Adjusted CSS path -->
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
