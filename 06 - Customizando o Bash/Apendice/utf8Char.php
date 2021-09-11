<?php

function retrieveCleanData($dNumber) {
    $tgtURL         = "http://www.ltg.ed.ac.uk/~richard/utf-8.cgi?input=$dNumber&mode=decimal";
    $originalHTML   = file_get_contents($tgtURL);

    $rawTable   = explode("<table border='2'>", $originalHTML);
    $rawTable   = explode("</table>", $rawTable[1]);
    $rawTable   = explode("\n", $rawTable[0]);

    $char = (($dNumber < 32) ? " " : html_entity_decode("&#$dNumber;"));
    $charDataBase = [$char];

    $validLines = [];
    foreach ($rawTable as $rawLine) {
        if (trim($rawLine) !== "" && strpos($rawLine, "width='300'") === false) {
            $validLines[] = $rawLine;
        }
    }


    if (count($validLines) !== 6) {
        $charDataBase = "Erro na tabela;<br />Veja o item $tgtURL";
    }
    else {
        foreach ($validLines as $i => $rawLine) {
            $data = explode("</td> <td>", $rawLine);
            $data = explode("</td>", $data[1]);
            $data = trim($data[0]);
            $charDataBase[] = $data;
        }
    }

    return $charDataBase;
}


$columnHeaders = [
    "Char"                      => 8,
    "Character name"            => 60,
    "Hex code point"            => 14,
    "Decimal code point"        => 18,
    "Hex UTF-8 bytes"           => 15,
    "Octal UTF-8 bytes"         => 17,
    "UTF-8 bytes as Latin-1"    => 22
];


$page = ((isset($_GET["p"]) === false) ? 1 : (int)$_GET["p"]);
$pageLength = 32;
$first      = (16384 * 2);
$last       = (16384 * 4);

$ini        = ($first + (($pageLength * $page) - $pageLength));
$end        = ($ini + $pageLength);
if ($end > $last) { $end = $last; }


$rawPageFile = [];
if ($ini === $first) {
    $tmpData = [];

    foreach ($columnHeaders as $col => $len) {
        $tmpData[] = str_pad($col, $len, " ", STR_PAD_RIGHT);
    }

    $rawPageFile[] = implode(" : ", $tmpData);
}



$columnHeadersLength = array_values($columnHeaders);

for ($dNumber = $ini ; $dNumber < $end; $dNumber++) {
    $tmpData = [];
    $rawData = retrieveCleanData($dNumber);

    if (is_string($rawData) === true) {
        var_dump($rawData);
        exit();
    }
    else {
        foreach ($rawData as $i => $v) {
            $tmpData[] = str_pad($v, $columnHeadersLength[$i], " ", STR_PAD_RIGHT);
        }
        $rawPageFile[] = implode(" : ", $tmpData);
    }
}

file_put_contents("utf8Char03.md", implode("\n", $rawPageFile) . "\n", FILE_APPEND);
if ($end < $last) {
    echo "<h3>Carregada página $page ($ini - $end);</h3>";
    $page++;
?>
<script>
    setTimeout(() => {
        window.location = 'utf8Char.php?p=<?php echo $page; ?>';
    }, 2000);
</script>
<?php
}
?>
