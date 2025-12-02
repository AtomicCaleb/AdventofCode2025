$fileContent = Get-Content -Path $PSScriptRoot/ProductIDs.txt
$count = 0

#Seperate out the lines by comma
foreach ($line in $fileContent -split ",")
{
    $splitLine = $line.Split("-")
    
    for ($id = [double]$splitLine[0]; $id -le [double]$splitLine[1]; $id++)
    {
        #if its an odd number of digits its valid as it cant repeat
        if($id.Length % 2 -eq 0) {return}

        $stringID = [string]$id
        $halfLength = $stringID.Length / 2

        $firstHalf = $stringID.SubString(0,$halfLength)
        $secondHalf = $stringID.SubString($halfLength)

        if($firstHalf -eq $secondHalf) {$count += $id}
    }
}

Write-Host($count)
