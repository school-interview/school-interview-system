# 修学面談システム

## 概要

大学における修学面談の効率化・自動化を目指して開発しているシステムです。

### 目的

✅ 支援が必要な学生を効率的に見極め、教員の負担を軽減すること。  
✅ 学生に対して、有益な情報やサポートを平等に提供すること。

## 本システムの動かし方

### 環境

本システムのクライアント側は、`Flutter`で開発されているため、`Flutter`開発環境の構築が必要です。  
詳細は、[client / README-ja.md](https://github.com/school-interview/school-interview-system/blob/main/client/README-ja.md#開発環境)
を参照してください。

### 環境変数

`backend`フォルダ内に`.env.local`ファイルを作成して環境変数を設定する必要があります。  
設定する内容の詳細は、[backend / README.me](https://github.com/school-interview/school-interview-system/blob/main/backend/README.md#prepare-envlocal-in-backend-directory)
を参照してください。

## ディレクトリ構成

ディレクトリ構成は次の通りです。

```text
.
├── backend
├── client
├── docs
├── open-api
├── readme-img
├── llm-service
├── README-ja.md
└── README.md
```

| ディレクトリ名 | 説明                       |
| -------------- | -------------------------- |
| backend        | バックエンドのソースコード |
| llm-service    | LLM Service のソースコード |
| client         | クライアントのソースコード |
| docs           | 文書                       |
| open-api       | Open API generator         |
| readme-img     | README に使用する画像      |

## 使用技術一覧

<img src="https://img.shields.io/badge/-Flutter-02569B.svg?logo=flutter&style=flat-square" alt=""> <img src="https://img.shields.io/badge/-Dart-0175C2.svg?logo=dart&style=flat-square" alt="">
<img src="https://img.shields.io/badge/-Unity-000000.svg?logo=unity&style=flat-square" alt="">
<img src="https://img.shields.io/badge/-Python-3776AB.svg?logo=python&style=flat-square" alt="">
<img src="https://img.shields.io/badge/-Docker-1488C6.svg?logo=docker&style=flat-square" alt="">
<img src="https://img.shields.io/badge/-Android%20Studio-A4C639.svg?logo=android%20studio&style=flat-square" alt="">
