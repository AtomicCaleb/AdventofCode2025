$fileContent = Get-Content -Path $PSScriptRoot/safecodes.txt

$count = 0
$safeNumber = 50

foreach ($line in $fileContent)
{
    $firstChar = $line.Substring(0, 1)
    $lineValue = $line.Substring(1)

    $count += [int][Math]::Floor($linevalue / 100)

    $lineValue = $lineValue % 100

    $oldSafeNumber = $safeNumber


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

    if($safeNumber -ge 100) 
    {
        if($oldsafeNumber -gt 100) {$count++}
        $safeNumber -= 100
        
    }
    if($safeNumber -lt 0) 
    {
        $safeNumber += 100
        if ($oldSafeNumber -ne 0) {$count++}
    }

    if($safeNumber -eq 0) {$count += 1}

}

Write-Host($count)