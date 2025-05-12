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
    # ��o�[�W�������ǂ��܂œ����Ă��邩�Ŗ{���͏󋵂��ς�邯�ǂ����ł͋C�ɂ����g�[�^���ŃJ�E���g�A�b�v�ɂȂ�
    $baseVer = [System.Version]::new($BaseVersionStr)
    # �O��r���h�����t�@�C��������(�Q��ڈȍ~�̃r���h)
    if( Test-Path $TargetPath ){
        $currVer = [System.Version]::new([System.Diagnostics.FileVersionInfo]::GetVersionInfo($TargetPath).FileVersion)
    }
    else{
        $currVer = [System.Version]::new($PriorVersionStr)
    }
    # ��o�[�W�������ς���Ă��邩�킩��Ȃ��̂ŁA���r�W�����������낦�Ă���
    $baseVer = [System.Version]::new($baseVer.Major, $baseVer.Minor, $baseVer.Build, $currVer.Revision)
}

process {
    # ��͓n���ꂽ�o�[�W�����ɍ��킹��
    $returnVer = $baseVer
    $revision = $baseVer.Revision
    # �o�[�W���������� == ���r�W�����A�b�v�̕K�v�����肻��
    if( $currVer -eq $baseVer )
    {
        # ���r�W�����̍X�V�͑O��r���h��Ɍ��J�������Ă���ꍇ�̓��r�W�������グ��
        # ����ȊO(���J��Q��ڈȍ~�̃r���h�܂��́A���������܂����J���Ă��Ȃ�)�͌����o�[�W�����X�V�͂��Ȃ�
        $checkRetailFile = $TargetPath + ".checkRetail"
        if( Test-Path $TargetPath ){
            # �O��r���h��Ɍ��J�����������Ȃ��Ă���ꍇ�͍X�V����̂œ��t�����m�F����
            $buildDate = [System.IO.File]::GetLastWriteTime($TargetPath)
            # ���e�[���`�F�b�N�t�@�C�����L�� == ���J�ς� == �C���X�g�[�������� == ���������[�X�Ȃ̂Ń��r�W�����A�b�v����
            if( Test-Path $checkRetailFile ){
                $releaseDate = [System.IO.File]::GetLastWriteTime($checkRetailFile)
                if( $buildDate -lt $releaseDate ){
                    # �����[�X���t���V�����ꍇ�́A���r�W�������C���N�������g����
                    $revision = $currVer.Revision + 1
                }
            }
            # ���e�[���`�F�b�N�t�@�C�����Ȃ� == �����J == �C���X�g�[���͂܂��Ȃ��̂ōX�V�͏o���邾�������Ȃ�Ȃ�(�Ӗ����Ȃ�)
        }
        # �^�[�Q�b�g�p�X���Ȃ��ꍇ�́A���r���h���A�Ӑ}�I�ɏ������ꍇ�̂����ꂩ�ɂȂ�B���̏ꍇ�͔�r�������Ȃ��̂ŋ����J�E���g�A�b�v
        elseif( Test-Path $checkRetailFile ){
            $revision = $currVer.Revision + 1
        }
    }
    $returnVer = [System.Version]::new($baseVer.Major, $baseVer.Minor, $baseVer.Build, $revision)
}

end {
    $returnVer.Major.ToString()
    $returnVer.Minor.ToString()
    $returnVer.Build.ToString()
    $returnVer.Revision.ToString()
}
