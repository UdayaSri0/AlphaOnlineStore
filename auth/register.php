<?php
require_once '../includes/db_connect.php';
require_once '../includes/functions.php'; // Include sanitization functions

// Handle form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Sanitize and validate user input
    $username = isset($_POST['username']) ? sanitize($_POST['username']) : '';
    $name = isset($_POST['name']) ? sanitize($_POST['name']) : '';
    $email = isset($_POST['email']) ? filter_var($_POST['email'], FILTER_SANITIZE_EMAIL) : '';
    $address = isset($_POST['address']) ? sanitize($_POST['address']) : '';
    $phone_number = isset($_POST['phone_number']) ? sanitize($_POST['phone_number']) : '';
    $password = isset($_POST['password']) ? $_POST['password'] : '';

    if (!empty($username) && !empty($name) && !empty($email) && !empty($address) && !empty($phone_number) && !empty($password)) {
        if (filter_var($email, FILTER_VALIDATE_EMAIL)) { // Validate email format
            $password_hash = password_hash($password, PASSWORD_BCRYPT);

            try {
                // Insert user into the database
                $query = $db->prepare("
                    INSERT INTO users (username, name, email, address, phone_number, password, user_role) 
                    VALUES (:username, :name, :email, :address, :phone_number, :password_hash, 'Customer')
                ");
                $query->bindParam(':username', $username);
                $query->bindParam(':name', $name);
                $query->bindParam(':email', $email);
                $query->bindParam(':address', $address);
                $query->bindParam(':phone_number', $phone_number);
                $query->bindParam(':password_hash', $password_hash);

                if ($query->execute()) {
                    header('Location: login.php'); // Redirect to login page on success
                    exit;
                } else {
                    $error = "Registration failed. Please try again.";
                }
            } catch (PDOException $e) {
                // Handle duplicate username or email error
                if ($e->getCode() === '23000') {
                    $error = "An account with this email or username already exists.";
                } else {
                    $error = "An unexpected error occurred. Please try again.";
                }
            }
        } else {
            $error = "Invalid email format.";
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
    <title>Register</title>
    <link rel="stylesheet" href="../assets/css/register_style.css"> <!-- Link to your CSS file -->
</head>
<body>
    <div class="register-container">
        <h1>Register</h1>
        <form action="" method="POST">
            <?php if (isset($error)): ?>
                <p style="color: red; text-align: center;"><?= htmlspecialchars($error); ?></p>
            <?php endif; ?>
            <input type="text" name="username" placeholder="Username" required>
            <input type="text" name="name" placeholder="Full Name" required>
            <input type="email" name="email" placeholder="Email" required>
            <textarea name="address" placeholder="Address" rows="3" required></textarea>
            <input type="text" name="phone_number" placeholder="Phone Number" maxlength="15" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Register</button>
        </form>
    </div>
</body>
</html>
