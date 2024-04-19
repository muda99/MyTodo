<?php

include 'koneksi.php';

// Mendapatkan data dari form atau variabel lainnya
$title = $_POST['title']; 
$jenis = $_POST['jenis']; 
$tanggal = $_POST['tanggal'];
$status = $_POST['status']; 
$id_user = $_POST['id_user']; 

// Query SQL untuk insert data
$sql = "INSERT INTO todolist (todolist_id, title, jenis, tanggal, status, id_user) 
        VALUES (UUID(), '$title', '$jenis', '$tanggal', '$status', '$id_user')";

// Melakukan query
if ($koneksi->query($sql) === TRUE) {
    echo "1";
} else {
    echo "0";
}

// Menutup koneksi
$koneksi->close();
?>
