# AutoUpdateVersionInfos

Windows デスクトップアプリのバージョン更新処理を自動的に行う機能サンプル

前回の出力結果を見てバージョン更新をおこなうため、リビルドするとリセットされてしまうという制限があるため、改良の余地はあるかも。

サンプルとして、単純に日付をバージョンに反映するもの、基準年を起点としてバージョンを設定するもの、シンプルにRevisionをインクリメントするものの３種類を用意。

## 課題

リビルドすると、直近のビルド後イメージが消えるため、バージョンがリセットされてしまうという弊害がある。

## 解決策

ビルド時に、@(FileVersions_) を出力するようにして置き、それを次回ビルド時に取り込むようにするとリビルドしても、情報が消えない。
ただし、クリーンしてもファイルが削除されないというデメリットも出る(現状非対応)

## プロパティ

- `NeedSdkFileVersion`:SDKプロジェクト形式用バージョン出力指定
- `NeedCppFileVersion`:C/C++ の.rc取込用出力指定  
$(IntDir)$(ProjectName).VersionInfo.h に出力されるので、.rc で自分で取り込むこと
- `NeedNetfxFileVersion`:従来型のプロジェクト形式用バージョン出力指定。  
自動的にプロジェクトに追加するので、AssemblyInfo.cs からバージョン定義(`AssemblyVersion`, `AssemblyFileVersion`)を削除しておく必要がある。
- `AutoUpdateVersionInfo`: `BuildDate`, `OffsetDate`, `SimpleIncrement` の３種類の出力パターンのいずれかを指定
- `StartYear`: `OffsetDate` の場合、基準年
- `FileVersion` or `Version`: 基準となるバージョンを設定。Major.Minor は最低限設定する必要がある。C++以外はこのバージョンが`AssemblyVersion`になる。
