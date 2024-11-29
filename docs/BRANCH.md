# Git のブランチ戦略

## ブランチについて

| ブランチ                 | 説明          |
|----------------------|-------------|
| `main`               | メインブランチです。  |
| `feature/{name}`     | 新しい機能を作ります。 |
| `fix/{name}`         | バグを直します。    |
| `improvement/{name}` | 改善タスクを行います。 |

## ラベルについて

プルリクエストを作ると、自動でプルリクエストにラベルが付きます。

ラベルは、以下のパターンで分類されます。

1. どのブランチか
2. どのディレクトリか

| ブランチ            | ラベル                |
|-----------------|--------------------|
| `feature/*`     | `type/feature`     |
| `fix/*`         | `type/bug`         |
| `improvement/*` | `type/improvement` |

| ディレクトリ          | ラベル                     |
|-----------------|-------------------------|
| `.github/*`     | `related/github`        |
| `backend/*`     | `related/backend`       |
| `client/*`      | `related/client`        |
| `docs/*`や`*.md` | `related/documentation` |

どのブランチにどのラベルが付くかは `.github/labeler.yaml` で設定されています。