<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

$host = getenv('MYSQL_HOST');
$user = getenv('MYSQL_USER');
$pass = getenv('MYSQL_PASSWORD');
$db = getenv('MYSQL_DB');

echo "Attempting to connect to MySQL...<br>";
echo "Host: $host<br>";
echo "User: $user<br>";
echo "Database: $db<br>";
echo "PHP version: " . phpversion() . "<br>";
echo "MySQLi version: " . mysqli_get_client_version() . "<br>";

try {
    $conn = new mysqli($host, $user, $pass, $db);
    
    if ($conn->connect_error) {
        throw new Exception("Connection failed: " . $conn->connect_error);
    }
    
    echo "Connected successfully to MySQL<br>";
    
    $result = $conn->query("SELECT * FROM test_table");
    
    if ($result === false) {
        throw new Exception("Query failed: " . $conn->error);
    }
    
    echo "Query executed successfully. Number of rows: " . $result->num_rows . "<br>";
    
    while ($row = $result->fetch_assoc()) {
        echo "ID: " . $row['id'] . ", Name: " . $row['name'] . "<br>";
    }
    
} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "<br>";
    echo "Errno: " . $conn->connect_errno . "<br>";
    echo "Error: " . $conn->connect_error . "<br>";
}

// Debug: Show all environment variables
echo "<pre>";
print_r($_ENV);
echo "</pre>";
?>