# クライアント - 修学面談システム -

言語: 日本語 | [English](README.md)

## clientディレクトリについて

修学面談システムのクライアント側を構成するソースコードです。

クライアントは`Flutter`で開発されています。

## 開発環境

|                | バージョン               |
|----------------|---------------------|
| Android Studio | 最新の安定バージョンを使用してください |
| Flutter        | 3.24.3              |

## セットアップ

* fvm
    1. 本プロジェクトではFlutter SDKの管理に[fvm](https://fvm.app/)
       を使用しています。[こちら](https://fvm.app/documentation/getting-started/installation)を参照して**fvm**
       をインストールしてください。
    2. Flutter SDKをインストールします。バージョンは[開発環境](#開発環境)を参照してください。
   ```
   fvm install [バージョン]
   fvm use [バージョン]
   ```
  `バージョン`: 希望するFlutter SDKのバージョン（例：`2.2.3`）。

* Android Studio
    1. **Android Studio**を[インストール](https://developer.android.com/studio/install?hl=ja)して、起動してください。
    2. `Settings < Plugins`から**Flutter**プラグインをインストールしてください。
    3. `Settings < Preferences < Languages & Frameworks < Flutter`の**Flutter SDK path**
       に指定したバージョンのものを設定してください。`~/fvm/versions`にインストールしたFlutterが入っています。
    4. `Edit Configuration Settings`を以下のように設定します。

| 項目                  | 設定値                  |
|---------------------|----------------------|
| Name                | 任意のもの                |
| Dart entrypoint     | client/lib/main.dart |
| Additional run args | --web-port 8001      |

## ビルド

```
fvm flutter build [ターゲット環境]
```

`ターゲット環境`：Webアプリ向けであれば`Web`など。

## 実行

以下のコマンドでWebアプリが立ち上がります。

```
fvm flutter run --web-port 8001
```
