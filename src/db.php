<?php
$host = getenv('MYSQL_HOST');
$user = getenv('MYSQL_USER');
$pass = getenv('MYSQL_PASSWORD');
$db = getenv('MYSQL_DB');

// Add some debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);

echo "Attempting to connect to MySQL...<br>";
echo "Host: $host<br>";
echo "User: $user<br>";
echo "Database: $db<br>";

try {
    $conn = new mysqli($host, $user, $pass, $db);
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
    echo "Connected successfully to MySQL<br>";
    
    // Test query
    $result = $conn->query("SELECT * FROM your_table_name");
    if ($result) {
        echo "Query executed successfully. Number of rows: " . $result->num_rows . "<br>";
        while ($row = $result->fetch_assoc()) {
            echo "ID: " . $row['id'] . ", Name: " . $row['name'] . "<br>";
        }
    } else {
        echo "Query failed: " . $conn->error . "<br>";
    }
} catch (Exception $e) {
    die("Connection failed: " . $e->getMessage());
}
?>