<?php

include 'koneksi.php';


$todolist_id = $_POST['todolist_id']; 
$title = $_POST['title'];  
$jenis = $_POST['jenis'];  
$tanggal = $_POST['tanggal'];  
$status = $_POST['status'];  
$id_user = $_POST['id_user'];  

// Query SQL untuk update data
$sql = "UPDATE todolist SET ";
$update_fields = [];

// Memeriksa apakah data tidak kosong, jika tidak kosong maka tambahkan ke dalam array $update_fields
if (!empty($title)) {
    $update_fields[] = "title = '$title'";
}
if (!empty($jenis)) {
    $update_fields[] = "jenis = '$jenis'";
}
if (!empty($tanggal)) {
    $update_fields[] = "tanggal = '$tanggal'";
}
if (!empty($status)) {
    $update_fields[] = "status = '$status'";
}
if (!empty($id_user)) {
    $update_fields[] = "id_user = '$id_user'";
}

// Menggabungkan semua field yang akan diupdate
$sql .= implode(", ", $update_fields);

// Menambahkan kondisi WHERE
$sql .= " WHERE todolist_id = '$todolist_id'";

// Melakukan query
if ($koneksi->query($sql) === TRUE) {
    echo "1";
} else {
    echo "0";
}

// Menutup koneksi
$koneksi->close();
?>
