<?php
function connectDatabase() {
    $servername = "db";
    $username = "root";
    $password = "DSPProject2024";
    $dbname = "applications";

    // Créer une connexion
    $conn = new mysqli($servername, $username, $password, $dbname);

    // Vérifier la connexion
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
    return $conn;
}
?>
