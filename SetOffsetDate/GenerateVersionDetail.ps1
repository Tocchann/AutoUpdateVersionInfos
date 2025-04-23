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
    # �r���h�ԍ��́A$StartYear �N1������Ƃ��āA�o�ߌ�*100 + �� �Ƃ���
    # ��: $StartYear=2024�A�r���h��($today)=2025/04/15 => ((2025-2024)*12+4)*100+15 = 1615
    # ��: $StartYear=2025�A�r���h��($today)=2025/04/15 => ((2025-2024)*12+4)*100+15 = 415
    $build = (($today.Year - $StartYear)*12+$today.Month)*100+$today.Day
    # Major.Minor ������$baseVer ��D�悵�đg�ݗ��Ă�
    $returnVer = [System.Version]::new($baseVer.Major, $baseVer.Minor, $build, 0 )
    # �r���h�������o�[�W�����̏ꍇ�́A���t�������Ȃ�A���r�W�������グ��
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
