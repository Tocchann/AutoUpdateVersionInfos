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
    # �����ł� Major.Minor �܂ł��m�肵�Ă���΂悢�̂ŁA���܂�ׂ������Ƃ͍l���Ȃ�
    $baseVer = [System.Version]::new($BaseVersionStr)
    if( Test-Path $TargetPath ){
        $currVer = [System.Version]::new([System.Diagnostics.FileVersionInfo]::GetVersionInfo($TargetPath).FileVersion)
    }
    else{
        $currVer = [System.Version]::new($PriorVersionStr)
    }
    $today = [System.DateTime]::Now
}

process {
    # �����̓��t�����ƂɃr���h�ԍ������߂�
    # �r���h�ԍ��́A$StartYear �N1������Ƃ��āA�o�ߌ�*100 + �� �Ƃ���
    # ��: $StartYear=2024�A�r���h��($today)=2025/04/15 => ((2025-2024)*12+4)*100+15 = 1615
    # ��: $StartYear=2025�A�r���h��($today)=2025/04/15 => ((2025-2024)*12+4)*100+15 = 415
    $build = (($today.Year - $StartYear)*12+$today.Month)*100+$today.Day

    # ���r�W�������������V���o�[�W���������
    $chkNew = [System.Version]::new($baseVer.Major, $baseVer.Minor, $build, 0 )
    $chkPrev = [System.Version]::new($currVer.Major, $currVer.Minor, $currVer.Build, 0 )
    # �O��̃��r�W����
    $revision = $currVer.Revision
    # �O��r���h���� Major.Minor.Build �܂ł���v����ꍇ(���r�W�����X�V�����邩������Ȃ�)
    if( $chkNew -eq $chkPrev )
    {
        # ���J�}�[�J�[�t�@�C���p�X(�^�[�Q�b�g�p�X�� ".checkRetail" ������)�̍쐬
        $checkRetailFile = $TargetPath + ".checkRetail"

        # �O��r���h�����t�@�C�����c���Ă���(���r���h���Ă��Ȃ�)
        if( Test-Path $TargetPath ){
            # �O����J������X�V����Ă���ꍇ�����X�V����
            $buildDate = [System.IO.File]::GetLastWriteTime($TargetPath)
            if( Test-Path $checkRetailFile ){
                $releaseDate = [System.IO.File]::GetLastWriteTime($checkRetailFile)
                if( $buildDate -lt $releaseDate ){
                    # ���J�}�[�J�[�t�@�C���̂ق����V���� == ���J��͂��߂Ẵr���h�Ȃ̂ŁA�O��o�[�W�����ƈقȂ���̂ɂ���
                    $revision = $currVer.Revision + 1
                }
            }
        }
        # �^�[�Q�b�g�p�X���Ȃ��ꍇ�́A���r���h���A�Ӑ}�I�ɏ������ꍇ�̂����ꂩ�ɂȂ�B
        # ���e�[���`�F�b�N�t�@�C��������ꍇ(==���J�ς�)�́A�X�V�̕K�v����Ƃ݂Ȃ�
        elseif( Test-Path $checkRetailFile ){
            $revision = $currVer.Revision + 1
        }
    }
    # �O��r���h���� Major.Minor.Build �̂����ꂩ���قȂ� == �O��o�[�W�����Ƃ͈�v���Ȃ� == ���r�W�����̓��Z�b�g���Ă悢
    else{
        $revision = 0
    }
    $returnVer = [System.Version]::new($chkNew.Major, $chkNew.Minor, $chkNew.Build, $revision)
}

end {
    $returnVer.Major.ToString()
    $returnVer.Minor.ToString()
    $returnVer.Build.ToString()
    $returnVer.Revision.ToString()
}
