$fileContent = Get-Content -Path $PSScriptRoot/ProductIDs.txt
$count = 0

#Seperate out the lines by comma
foreach ($line in $fileContent -split ",")
{
    $splitLine = $line.Split("-")
    
    #for each ID in the range
    for ($id = [double]$splitLine[0]; $id -le [double]$splitLine[1]; $id++)
    {
        $stringID = [string]$id
        $valid = $true               
        
        #loop through each length up until half
        for($i = 1; $i -lt $stringID.Length; $i++)
        {
            # only check lengths that divide evenly
            if ($stringID.Length % $i -ne 0) { continue }

            $oldSegment = $stringID.Substring(0,$i)
            $indexValid = $true

            for($index = 0; $index + $i -le $stringID.Length; $index += $i)
            {
                $newSegment = $stringID.Substring($index,$i)
                if($newSegment -ne $oldSegment) 
                {
                    $indexValid = $false
                    break       
            }

            # If this substring length worked, mark valid and stop checking
            if ($indexValid -eq $true) 
            {
                $valid = $false
                break
            }
        }

        # If repeating pattern found and its valid
        if($valid -eq $false) 
        {
            $count += $id
            write-host($id)
        }
    }
}

Write-Host($count)
