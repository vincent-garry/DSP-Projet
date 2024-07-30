<?php
$host = 'db';  // This should be the service name of your MySQL container
$user = 'root';
$pass = 'DSPProject2024';
$db = 'applications';

// Add some debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);

try {
    $conn = new mysqli($host, $user, $pass, $db);
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
    echo "Connected successfully";
} catch (Exception $e) {
    die("Connection failed: " . $e->getMessage());
}
?>