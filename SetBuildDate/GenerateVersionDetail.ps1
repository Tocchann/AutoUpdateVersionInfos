[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string]$TargetPath,
    [Parameter(Mandatory=$true)]
    [string]$BaseVersionStr
)

begin {
}

process {
    $today = [System.DateTime]::Now
    $baseVer = [System.Version]::new($BaseVersionStr)
    $returnVer = [System.Version]::new($baseVer.Major, $baseVer.Minor, $today.Year, $today.ToString("MMdd"))
}

end {
    $returnVer.Major.ToString()
    $returnVer.Minor.ToString()
    $returnVer.Build.ToString()
    $returnVer.Revision.ToString()
}
