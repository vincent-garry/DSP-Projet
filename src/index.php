<?php
require_once 'db.php';

// Assuming $conn is the database connection from db.php
if (!$conn) {
    die("Database connection failed");
}

// Your existing code to fetch and display data
$query = "SELECT * FROM users";
$result = $conn->query($query);

if ($result === false) {
    die("Error executing query: " . $conn->error);
}

echo "Query executed successfully. ";

if ($result->num_rows > 0) {
    echo "<table>";
    echo "<tr><th>ID</th><th>Name</th></tr>";
    while($row = $result->fetch_assoc()) {
        echo "<tr><td>".$row["id"]."</td><td>".$row["name"]."</td></tr>";
    }
    echo "</table>";
} else {
    echo "0 results";
}

$conn->close();
?>