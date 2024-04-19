<?php

include 'koneksi.php';

// Mendapatkan ID data yang akan dihapus dari form atau variabel lainnya
$todolist_id = $_POST['todolist_id'];
// Query SQL untuk menghapus data
$sql = "DELETE FROM todolist WHERE todolist_id = '$todolist_id'";

// Melakukan query
if ($koneksi->query($sql) === TRUE) {
    echo "1";
} else {
    echo "0";
}

// Menutup koneksi
$koneksi->close();
?>
