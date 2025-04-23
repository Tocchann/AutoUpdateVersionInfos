[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string]$TargetPath,
    [Parameter(Mandatory=$true)]
    [int]$StartYear,
    [Parameter(Mandatory=$true)]
    [string]$BaseVersionStr,
    [Parameter(Mandatory=$true)]
    [string]$PriorVersionStr
)

begin {
    $baseVer = [System.Version]::new($BaseVersionStr)
    if( Test-Path $TargetPath ){
        $FileVersionInfo = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($TargetPath)
        $currVer = [System.Version]::new($FileVersionInfo.FileMajorPart, $FileVersionInfo.FileMinorPart, $FileVersionInfo.FileBuildPart, $FileVersionInfo.FilePrivatePart)
    }
    else{
        $currVer = [System.Version]::new($PriorVersionStr)
    }
    $today = [System.DateTime]::Now
}

process {
    # ビルド番号は、$StartYear 年1月を基準として、経過月*100 + 日 とする
    # 例: $StartYear=2024、ビルド日($today)=2025/04/15 => ((2025-2024)*12+4)*100+15 = 1615
    # 例: $StartYear=2025、ビルド日($today)=2025/04/15 => ((2025-2024)*12+4)*100+15 = 415
    $build = (($today.Year - $StartYear)*12+$today.Month)*100+$today.Day
    # Major.Minor 部分は$baseVer を優先して組み立てる
    $returnVer = [System.Version]::new($baseVer.Major, $baseVer.Minor, $build, 0 )
    # ビルドが同じバージョンの場合は、日付が同じなら、リビジョンを上げる
    if( $currVer.Major -eq $baseVer.Major -and $currVer.Minor -eq $baseVer.Minor )
    {
        if( $build -eq $currVer.Build ){
            $returnVer = [System.Version]::new($baseVer.Major, $baseVer.Minor, $build, $currVer.Revision + 1)
        }
    }
}

end {
    $returnVer.Major.ToString()
    $returnVer.Minor.ToString()
    $returnVer.Build.ToString()
    $returnVer.Revision.ToString()
}
