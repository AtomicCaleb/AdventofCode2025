$fileContent = Get-Content -Path $PSScriptRoot/safecodes.txt

$count = 0
$safeNumber = 50

foreach ($line in $filecontent)
{
    $firstChar = $line.Substring(0, 1)
    $lineValue = $line.Substring(1)

    $lineValue = $lineValue % 100

    if($firstChar -eq "L")
    {
        $safeNumber -= [int]$lineValue
    }
    
    elseif ($firstChar -eq "R")
    {
        $safeNumber += [int]$lineValue
    }

    else
    {
        write-host("invalid")
    }

    if($safeNumber -ge 100) {$safeNumber -= 100}
    if($safeNumber -lt 0) {$safeNumber = 100 + $safeNumber}

    if($safeNumber -eq 0) {$count += 1}

}

Write-Host($count)