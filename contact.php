<?php
include 'header.php';
?>

<div class="container">
    <h1>Contact Us</h1>
    <form action="send_message.php" method="post">
        <label for="name">Your Name:</label>
        <input type="text" id="name" name="name" required>
        
        <label for="email">Your Email:</label>
        <input type="email" id="email" name="email" required>
        
        <label for="message">Message:</label>
        <textarea id="message" name="message" rows="5" required></textarea>
        
        <button type="submit">Send</button>
    </form>
</div>

<?php
include 'footer.php';
?>
