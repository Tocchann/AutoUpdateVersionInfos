[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string]$TargetPath,
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
    $baseVer = [System.Version]::new($baseVer.Major, $baseVer.Minor, $baseVer.Build, $currVer.Revision)
}

process {
    # ��͓n���ꂽ�o�[�W�����ɍ��킹��
    $returnVer = $baseVer
    # �o�[�W�����������Ȃ烊�r�W�������J�E���g�A�b�v
    if( $currVer -eq $baseVer )
    {
        $returnVer = [System.Version]::new($currVer.Major, $currVer.Minor, $currVer.Build, $currVer.Revision + 1)
    }
}

end {
    $returnVer.Major.ToString()
    $returnVer.Minor.ToString()
    $returnVer.Build.ToString()
    $returnVer.Revision.ToString()
}
