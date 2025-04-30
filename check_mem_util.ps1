<#
    check_mem_util.ps1

    Script for checking RAM sage

    .SYNTAX
    	.\check_mem_util.ps1 [-WARN] [-CRIT]
    .PARAMETERS
        -WARN <int> Warning threshold for RAM utilization (%)
        -CRIT <int> Critical threshold for RAM utilization (%)
    .VERSION
        chr0w94 v0.1
#>

#requires -version 4.0
[cmdletbinding(PositionalBinding = $false)]
param(
    [Parameter(Mandatory = $false)][int]$WARN = 80,
    [Parameter(Mandatory = $false)][int]$CRIT = 90
)

function Get-mem-util 
{
    $computer = gc env:computername
    # Lets create a re-usable WMI method for memory stats
    $OperatingSystem = Get-WmiObject win32_OperatingSystem -computer $computer
    # Lets grab the free memory
    $FreeMemory = $OperatingSystem.FreePhysicalMemory
    $FreeMemoryinMb = [math]::truncate($FreeMemory/1024)
    # Lets grab the total memory
    $TotalMemory = $OperatingSystem.TotalVisibleMemorySize
    $TotalMemoryinMb = [math]::truncate($TotalMemory/1024)
    # Lets do some math for MB conversion
    $MemoryUsed =[math]::truncate(($TotalMemory - $FreeMemory)/1024) 
    $MemoryUsedPct = [math]::Round((($MemoryUsed*100)/($TotalMemory/1024)),2)

    if ($MemoryUsedPct -ge $CRIT)
    {
        Write-Host "CRITICAL: Memory utilization is $MemoryUsedPct %. Free Memory is $FreeMemoryinMb Mb from $TotalMemoryinMb Mb"
        exit 2
    }
    elseif ($MemoryUsedPct -ge $WARN)
    {
        Write-Host "WARNING: Memory utilization is $MemoryUsedPct %. Free Memory is $FreeMemoryinMb Mb from $TotalMemoryinMb Mb"
        exit 1
    }
    else
    {
        Write-Host "OK: Memory utilization is $MemoryUsedPct %. Free Memory is $FreeMemoryinMb Mb from $TotalMemoryinMb Mb"
        exit 0
    }
}

# Start function
Get-mem-util 