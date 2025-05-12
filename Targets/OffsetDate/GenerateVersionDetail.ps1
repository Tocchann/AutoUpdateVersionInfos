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
    # ここでは Major.Minor までが確定していればよいので、あまり細かいことは考えない
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
    # 今日の日付をもとにビルド番号を決める
    # ビルド番号は、$StartYear 年1月を基準として、経過月*100 + 日 とする
    # 例: $StartYear=2024、ビルド日($today)=2025/04/15 => ((2025-2024)*12+4)*100+15 = 1615
    # 例: $StartYear=2025、ビルド日($today)=2025/04/15 => ((2025-2024)*12+4)*100+15 = 415
    $build = (($today.Year - $StartYear)*12+$today.Month)*100+$today.Day

    # リビジョンを除いた新旧バージョンを作る
    $chkNew = [System.Version]::new($baseVer.Major, $baseVer.Minor, $build, 0 )
    $chkPrev = [System.Version]::new($currVer.Major, $currVer.Minor, $currVer.Build, 0 )
    # 前回のリビジョン
    $revision = $currVer.Revision
    # 前回ビルド時と Major.Minor.Build までが一致する場合(リビジョン更新があるかもしれない)
    if( $chkNew -eq $chkPrev )
    {
        # 公開マーカーファイルパス(ターゲットパスに ".checkRetail" をつける)の作成
        $checkRetailFile = $TargetPath + ".checkRetail"

        # 前回ビルドしたファイルが残っている(リビルドしていない)
        if( Test-Path $TargetPath ){
            # 前回公開時から更新されている場合だけ更新する
            $buildDate = [System.IO.File]::GetLastWriteTime($TargetPath)
            if( Test-Path $checkRetailFile ){
                $releaseDate = [System.IO.File]::GetLastWriteTime($checkRetailFile)
                if( $buildDate -lt $releaseDate ){
                    # 公開マーカーファイルのほうが新しい == 公開後はじめてのビルドなので、前回バージョンと異なるものにする
                    $revision = $currVer.Revision + 1
                }
            }
        }
        # ターゲットパスがない場合は、リビルドか、意図的に消した場合のいずれかになる。
        # リテールチェックファイルがある場合(==公開済み)は、更新の必要ありとみなす
        elseif( Test-Path $checkRetailFile ){
            $revision = $currVer.Revision + 1
        }
    }
    # 前回ビルド時と Major.Minor.Build のいずれかが異なる == 前回バージョンとは一致しない == リビジョンはリセットしてよい
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
