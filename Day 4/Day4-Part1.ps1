$fileContent = Get-Content -Path $PSScriptRoot/forkliftData.txt 

Write-Host($fileContent)
$count = 0
$rowLength = 139

#combine all the content into 1 array
$fileContent = $fileContent.ToCharArray()

#left, right, down, down right, down left, up, up right, up left
$charsToCheck = @((-1),1,$rowLength, ($rowLength + 1), ($rowLength - 1), (-$rowLength), (-$rowLength + 1), (-$rowLength - 1))

#foreach character in the array
for($index = 0; $index -lt $fileContent.Length; $index++)
{
    #only continue if we are checking a pile of paper
    if($fileContent[$index] -ne "@") {continue}
    
    $adjacentPiles = 0
    
    #loop through the 8 adjacent places
    for($i = 0; $i -lt 8; $i++)
    {
        #get the current test from the check array
        $testCharIndex = $index + $charsToCheck[$i]


        #if its beyond the bounds of the array dont check it and cause an error
        $topBorderCheck = $index -lt $rowLength 
        $rightBorderCheck = $index % $rowLength -eq $rowLength - 1
        $leftBorderCheck = $index % $rowLength -eq 0
        $bottomBorderCheck = $index -gt $fileContent.Count - $rowLength

        if($testCharIndex -lt 0 -or $testCharIndex -ge $fileContent.Count) {continue}
        if($i -eq 0 -and $leftBorderCheck) {continue}
        if($i -eq 1 -and $rightBorderCheck) {continue}
        if($i -eq 2 -and $bottomBorderCheck) {continue}
        if($i -eq 3 -and ($bottomBorderCheck -or $rightBorderCheck)) {continue}
        if($i -eq 4 -and ($bottomBorderCheck -or $leftBorderCheck)) {continue}
        if($i -eq 5 -and $topBorderCheck) {continue}
        if($i -eq 6 -and ($topBorderCheck -or $rightBorderCheck)) {continue}
        if($i -eq 7 -and ($topBorderCheck -or $leftBorderCheck)) {continue}
        
        if($index -eq 25){Write-Host($testCharIndex)}

        #if the checked char is a paper add it to the count
        if ($fileContent[$testCharIndex] -eq "@")
        {
            $adjacentPiles ++
            if($index -eq 25){Write-Host($testCharIndex)}
        }
    }

    #if count is less than 4 add it
    if($adjacentPiles -lt 4) 
    {
        #$fileContent[$index] = "."
        $count++
        #Write-Host($index + 1)
    }
}

Write-Host($count)