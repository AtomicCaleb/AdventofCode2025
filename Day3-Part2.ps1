$fileContent = Get-Content -Path $PSScriptRoot/powerbanks.txt

$count = 0

foreach ($powerbank in $fileContent -split "\n")
{
    $highestValueArray= @(0) * 12 # Array to store the 12 highest digits for the current powerbank

    #loop through 12 times as we need 12 digits
    for($i = 0; $i -lt 12; $i++)
    {
        $remainingDigits = 12 - $i - 1  # How many digits we still need
        $maxIndex = $powerbank.Length - $remainingDigits - 1 #calculate length based on remaining digits

        $highestValue = -1
        $highestValueIndex = 0
        
        #loop through the set to find the highest
        for ($index = 0; $index -le $maxIndex; $index++)
        {
            #convert to string then int to not get ascii value
            $value = [int][string]$powerbank[$index]

            #find highest value out of available values
            if($value -gt $highestValue) 
            {
                $highestValue = $value
                $highestValueIndex = $index
            }
        }
        #reduce the string to after the selected number
        $powerbank = $powerbank.Substring($highestValueIndex + 1)

        #add the found value to the array of values
        $highestValueArray[$i] = $highestValue

    }
    
    $voltage = -join $highestValueArray
    $count += [double]$voltage
}

Write-Host($count)