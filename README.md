# AutoUpdateVersionInfos

Windows デスクトップアプリのバージョン更新処理を自動的に行う機能サンプル

前回の出力結果を見てバージョン更新をおこなうため、リビルドするとリセットされてしまうという制限があるため、改良の余地はあるかも。

サンプルとして、単純に日付をバージョンに反映するもの、基準年を起点としてバージョンを設定するもの、シンプルにRevisionをインクリメントするものの３種類を用意。

VS2022環境なら pwsh もほぼほぼ使えるはずなので、PowerShell の呼び出しは、pwsh でおこなう。これにより、CI/CD などでのビルドも影響が出ない。

## 課題

CI/CD 環境など、前回の出力結果がない場合に、以前のバージョンがわからないという欠陥がある。

とはいえ、CI/CD で前回結果を引き継げるようにするには固有の環境定義が必要になるため、このサンプルでは実装しないものとする。


## プロパティ

- `NeedSdkFileVersion`:SDKプロジェクト形式用バージョン出力指定
- `NeedCppFileVersion`:C/C++ の.rc取込用出力指定  
$(IntDir)$(ProjectName).VersionInfo.h に出力されるので、.rc で自分で取り込むこと
- `NeedNetfxFileVersion`:従来型のプロジェクト形式用バージョン出力指定。  
自動的にプロジェクトに追加するので、AssemblyInfo.cs からバージョン定義(`AssemblyVersion`, `AssemblyFileVersion`)を削除しておく必要がある。
- `AutoUpdateVersionInfo`: `BuildDate`, `OffsetDate`, `SimpleIncrement` の３種類の出力パターンのいずれかを指定
- `StartYear`: `OffsetDate` の場合、基準年
- `FileVersion` or `Version`: 基準となるバージョンを設定。Major.Minor は最低限設定する必要がある。C++以外はこのバージョンが`AssemblyVersion`になる。
