# 変数定義
BASE_IMAGE := work_base:latest
RUNTIME_IMAGE := work_runtime:latest
TOOLS_IMAGE := work_tools:latest
DEV_IMAGE := work_dev:latest

# デフォルトのターゲット
.PHONY: all
all: build-dev

# ベースイメージのビルド
.PHONY: build-base
build-base:
	@echo "Building base image..."
	docker build -t $(BASE_IMAGE) -f docker/base/Dockerfile .

# ランタイムイメージのビルド
.PHONY: build-runtime
build-runtime: build-base
	@echo "Building runtime image..."
	docker build -t $(RUNTIME_IMAGE) -f docker/runtime/Dockerfile .

# ツールイメージのビルド
.PHONY: build-tools
build-tools: build-runtime
	@echo "Building tools image..."
	docker build -t $(TOOLS_IMAGE) -f docker/tools/Dockerfile .

# 開発環境イメージのビルド
.PHONY: build-dev
build-dev: build-tools
	@echo "Building development image..."
	docker build -t $(DEV_IMAGE) -f docker/dev/Dockerfile .

# 開発環境の起動
.PHONY: up
up: build-dev
	@echo "Starting development environment..."
	docker-compose up -d

# 開発環境の停止
.PHONY: down
down:
	@echo "Stopping development environment..."
	docker-compose down

# イメージの削除
.PHONY: clean
clean:
	@echo "Cleaning up images..."
	docker rmi $(DEV_IMAGE) $(TOOLS_IMAGE) $(RUNTIME_IMAGE) $(BASE_IMAGE) || true

# 完全なクリーンアップ（コンテナとイメージの削除）
.PHONY: clean-all
clean-all: down clean
	@echo "Performing complete cleanup..."
	docker system prune -f

# ヘルプ
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  all        - Build all images and start development environment (default)"
	@echo "  build-base - Build base image"
	@echo "  build-runtime - Build runtime image"
	@echo "  build-tools - Build tools image"
	@echo "  build-dev  - Build development image"
	@echo "  up         - Start development environment"
	@echo "  down       - Stop development environment"
	@echo "  clean      - Remove all images"
	@echo "  clean-all  - Remove all containers and images"
	@echo "  help       - Show this help message" 