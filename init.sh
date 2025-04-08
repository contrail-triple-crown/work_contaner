#!/bin/bash

# エラーが発生したら停止
set -e

# 環境変数ファイルの確認
if [ ! -f .env ]; then
    echo "環境変数ファイルが見つかりません。.env.exampleからコピーします。"
    cp .env.example .env
    echo "環境変数ファイルを作成しました。必要に応じて編集してください。"
fi

# イメージのビルド
echo "ベースイメージをビルドしています..."
make build-base

echo "ランタイムイメージをビルドしています..."
make build-runtime

echo "ツールイメージをビルドしています..."
make build-tools

echo "開発環境イメージをビルドしています..."
make build-dev

# 開発環境の起動
echo "開発環境を起動しています..."
make up

echo "開発環境の準備が完了しました。"
echo "コンテナに接続するには: docker exec -it work_container bash"