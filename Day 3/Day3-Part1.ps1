$fileContent = Get-Content -Path "$PSScriptRoot/powerbanks.txt"

foreach ($powerbank in $fileContent -split "\n")
{
    $count = 0

    $powerbankArray = $powerbank.ToCharArray()
    $highestValue = 0
    $secondHighestValue = 0
    $highestIndex = 0

    for($index = 0; $index -lt $powerbankArray.Length; $index++)
    {
        $value = [int]$powerbankArray[$index]
        if($value -gt $highestValue) 
        {
            $highestValue = $value
            $highestIndex = $index
        }

        $newPowerbank = $powerbank.SubString($highestIndex).ToCharArray()

        foreach ($voltage in $newPowerbank)
        {
        
            $value = [int]$voltage
            if($value -gt $secondHighestValue) 
            {
                $secondHighestValue = $value
            }
        }

        $total = [string]$highestValue + [string]$secondHighestValue
        $count += [int]$total
    }


}
    
Write-Host($count)