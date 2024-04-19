<?php

$host = "localhost"; 
$username = "id20516546_mytodo"; 
$password = "#Mytodo123#"; 
$database = "id20516546_mytodo"; 

// Membuat koneksi
$koneksi = new mysqli($host, $username, $password, $database);

// Memeriksa koneksi
if ($koneksi->connect_error) {
    die("Koneksi gagal: " . $koneksi->connect_error);
} 
?>
