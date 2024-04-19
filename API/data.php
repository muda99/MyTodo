<?php

include 'koneksi.php';


$sql = "SELECT * FROM todolist"; 


$result = $koneksi->query($sql);


if ($result->num_rows > 0) {

    $data = array();


    while($row = $result->fetch_assoc()) {
 
        $data[] = $row;
    }

    $json_output = json_encode($data);


    echo $json_output;
} else {
    echo json_encode(array('message' => 'Tidak ada hasil.'));
}

$koneksi->close();
?>
