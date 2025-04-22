[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string]$TargetPath,
    [Parameter(Mandatory=$true)]
    [string]$BaseVersionStr
)

begin {
    $baseVer = [System.Version]::new($BaseVersionStr)
    if( Test-Path $TargetPath ){
        $FileVersionInfo = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($TargetPath)
        $currVer = [System.Version]::new($FileVersionInfo.FileMajorPart, $FileVersionInfo.FileMinorPart, $FileVersionInfo.FileBuildPart, $FileVersionInfo.FilePrivatePart)
    }
    else{
        $currVer = [System.Version]::new(0,0,0,0)
    }
}

process {
    # ��͓n���ꂽ�o�[�W�����ɍ��킹��
    $returnVer = $baseVer
    # �o�[�W�����������Ȃ烊�r�W�������J�E���g�A�b�v
    if( $currVer -eq $returnVer )
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
