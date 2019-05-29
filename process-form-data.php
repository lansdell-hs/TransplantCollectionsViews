<?php>
$name = $_POST[‘name’];
$email = $_POST[’email’];
$purchasingctr = $_POST['purchasingctr'];
$KI = $_POST['KI']; 
$LI = $_POST['LI']; 
$HR = $_POST['HR']; 
$LU = $_POST['LU']; 
$PA = $_POST['PA'];  
$KP = $_POST['KP']; 
$Benchmark1 = $_POST['Benchmark1'];
$Benchmark2 = $_POST['Benchmark2'];
$Benchmark3 = $_POST['Benchmark3'];
$Benchmark4 = $_POST['Benchmark4'];
$Benchmark5 = $_POST['Benchmark5'];
$Benchmark6 = $_POST['Benchmark6'];
$Benchmark7 = $_POST['Benchmark7'];



$fp = fopen(”TXCdata.txt”, “a”);
$savestring = $name . “,” . $email . “,” . $purchasingctr . “,” . $KI . “,” . $LI . “,” . $HR . “,” . $LU . “,” . $PA . “,” . $KP . “,” . $Benchmark1 . “,” . Benchmark2 . “,” . Benchmark3 . “,” . Benchmark4 . “,” . Benchmark5 . “,” . Benchmark6 . “,” . Benchmark7 . “n”;
fwrite($fp, $savestring);
fclose($fp);
echo “<h1>You data has been saved in a text file!</h1>”;
?>
