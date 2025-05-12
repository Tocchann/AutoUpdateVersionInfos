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
    # 基準バージョンがどこまで入っているかで本当は状況が変わるけどここでは気にせずトータルでカウントアップになる
    $baseVer = [System.Version]::new($BaseVersionStr)
    # 前回ビルドしたファイルがある(２回目以降のビルド)
    if( Test-Path $TargetPath ){
        $currVer = [System.Version]::new([System.Diagnostics.FileVersionInfo]::GetVersionInfo($TargetPath).FileVersion)
    }
    else{
        $currVer = [System.Version]::new($PriorVersionStr)
    }
    # 基準バージョンが変わっているかわからないので、リビジョンだけそろえておく
    $baseVer = [System.Version]::new($baseVer.Major, $baseVer.Minor, $baseVer.Build, $currVer.Revision)
}

process {
    # 基準は渡されたバージョンに合わせる
    $returnVer = $baseVer
    $revision = $baseVer.Revision
    # バージョンが同じ == リビジョンアップの必要がありそう
    if( $currVer -eq $baseVer )
    {
        # リビジョンの更新は前回ビルド後に公開処理している場合はリビジョンを上げる
        # それ以外(公開後２回目以降のビルドまたは、そもそもまだ公開していない)は原則バージョン更新はしない
        $checkRetailFile = $TargetPath + ".checkRetail"
        if( Test-Path $TargetPath ){
            # 前回ビルド後に公開処理がおこなわれている場合は更新するので日付情報を確認する
            $buildDate = [System.IO.File]::GetLastWriteTime($TargetPath)
            # リテールチェックファイルが有る == 公開済み == インストーラがある == 同日リリースなのでリビジョンアップする
            if( Test-Path $checkRetailFile ){
                $releaseDate = [System.IO.File]::GetLastWriteTime($checkRetailFile)
                if( $buildDate -lt $releaseDate ){
                    # リリース日付より新しい場合は、リビジョンをインクリメントする
                    $revision = $currVer.Revision + 1
                }
            }
            # リテールチェックファイルがない == 未公開 == インストーラはまだないので更新は出来るだけおこなわない(意味がない)
        }
        # ターゲットパスがない場合は、リビルドか、意図的に消した場合のいずれかになる。この場合は比較条件がないので強制カウントアップ
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
