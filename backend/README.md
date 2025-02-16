# API Server

修学面談システムの API サーバーです。

## 環境構築

### Poetry のセットアップ

このプロジェクトで Python のパッケージマネージャーである、Poetry を使用しています。

Poetry のインストール方法は[Installation](https://python-poetry.org/docs/#installation)をご覧ください。

### `.env.local`の設置

`/backend/.env.local`ファイルを設置してください。内容は以下のようになりますが、値に関しては開発メンバーに連絡をして共有してもらいましょう。

```
CLIENT_ID =
CLIENT_SECRET =
REDIRECT_URI =
SESSION_SECRET_KEY =
CLIENT_URL =
LLM_SERVICE_ENDPOINT =
```

## 実行

### サーバーの起動

このプロジェクトは Docker を必要とします。
Docker Desktop をインストールしていない場合は, [公式サイト](https://docs.docker.com/desktop/install/mac-install/)からインストールしてください。

```
cd backend

//イメージのビルド
docker compose --profile db --profile backend build

//コンテナの起動
docker compose --profile db --profile  backend up
```

`http://localhost:8000`で起動します。

# 単体テスト

以下のコマンドで単体テストを実行できます。

`/backend/test`ディレクトリに単体テストファイルが格納されています。

```
docker compose --profile testing up
```

## Docker を使わずに実行

```
poetry shell
poetry install
```

### 1. Virtual Environment をアクティベート

```
poetry shell
```

### 2. パッケージのインストール

```
poetry install
```

### 3. FastAPI サーバーの起動

`backend/launch-server.sh`を実行することで起動することができます。

```
./backend/launch-server.sh
```

PowerShell スクリプトは 2025/02/16 現在用意していません 🙏。

### Self signed certificate の生成

```
cd certificate
chmod 744 generate.sh
./generate.sh
```
