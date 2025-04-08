# 開発環境コンテナ

このプロジェクトは、開発環境をDockerコンテナとして提供するための構成です。
マルチステージビルドを採用し、効率的なビルドと柔軟な開発環境の構築を実現します。

## ディレクトリ構成

```
.
├── docker/                # Dockerfile関連
│   ├── base/             # ベースイメージ用
│   ├── runtime/          # ランタイム環境用
│   ├── tools/            # 開発ツール用
│   └── dev/              # 開発パッケージ用
├── scripts/              # インストールスクリプト
├── docker-compose.yml    # コンテナ構成定義
└── Makefile             # ビルド・管理用
```

## 前提条件

- Docker Engine 20.10.0以上
- Docker Compose V2
- Make

## 環境変数

以下の環境変数を設定する必要があります：

```bash
# .env ファイルを作成
NODE_VERSION=22.14.0
NPM_VERSION=10.9.2
PYTHON_VERSION=3.12
RUST_VERSION=stable
```

## ビルドと実行

### 基本的な使用方法

1. 環境変数の設定
```bash
cp .env.example .env
# .envファイルを編集して必要な値を設定
```

2. 開発環境の起動
```bash
make up
```

3. 開発環境の停止
```bash
make down
```

### 詳細なコマンド

- `make build-base` - ベースイメージのビルド
- `make build-runtime` - ランタイムイメージのビルド
- `make build-tools` - ツールイメージのビルド
- `make build-dev` - 開発環境イメージのビルド
- `make up` - 開発環境の起動
- `make down` - 開発環境の停止
- `make clean` - イメージの削除
- `make clean-all` - コンテナとイメージの完全な削除
- `make help` - 利用可能なコマンドの一覧表示
- `sh init.sh` - 各イメージのビルドから`make up`までを実行する

## イメージの構成

### 1. ベースイメージ (work_base:latest)
- Ubuntu 22.04
- 基本ツール（curl, git, vim等）
- 日本語環境設定

### 2. ランタイムイメージ (work_runtime:latest)
- Python環境
- Node.js環境
- Rust環境

### 3. ツールイメージ (work_tools:latest)
- Docker CLI
- AWS CLI
- AWS CDK

### 4. 開発環境イメージ (work_dev:latest)
- 開発用パッケージ
- プロジェクト固有のツール

## ボリュームマウント

以下のディレクトリがマウントされます：

- `~/.aws` → `/root/.aws` - AWS認証情報
- `/var/run/docker.sock` → `/var/run/docker.sock` - Dockerデーモン
- `.` → `/workspace` - プロジェクトディレクトリ
- `~` → `/root/host` - ホストのホームディレクトリ

## 開発フロー

1. 開発環境の起動
```bash
make up
```

2. コンテナへの接続
```bash
docker exec -it work_container bash
```

3. 開発作業
- `/workspace` ディレクトリで作業
- 必要なパッケージは `scripts/install_dev_packages.sh` に追加

4. 開発環境の停止
```bash
make down
```

## トラブルシューティング

### イメージの再ビルドが必要な場合

```bash
make clean-all
make up
```

### 特定のイメージのみ再ビルド

```bash
make build-runtime
make up
```

### ログの確認

```bash
docker-compose logs -f
```

## カスタマイズ

### 新しいパッケージの追加

1. `scripts/install_dev_packages.sh` を編集
2. 開発環境を再ビルド
```bash
make build-dev
make up
```

### 開発ツールの追加

1. `scripts/install_tools.sh` を編集
2. ツールイメージを再ビルド
```bash
make build-tools
make up
```

## セキュリティ考慮事項

- コンテナは特権モードで実行されます（`privileged: true`）
- ホストのDockerソケットがマウントされます
- AWS認証情報がマウントされます

これらの設定は開発環境用であり、本番環境では適切なセキュリティ設定が必要です。

## ライセンス

このプロジェクトはMITライセンスの下で公開されています。