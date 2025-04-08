# ベースイメージを使用
FROM work_base:latest

# 必要な引数を定義
ARG NODE_VERSION
ARG NPM_VERSION
ARG PYTHON_VERSION
ARG RUST_VERSION

# 環境変数の設定
ENV NODE_VERSION=$NODE_VERSION \
    NPM_VERSION=$NPM_VERSION \
    PYTHON_VERSION=$PYTHON_VERSION \
    RUST_VERSION=$RUST_VERSION \
    PATH=$PATH:$HOME/.cargo/bin \
    VOLTA_HOME=/root/.volta \
    PATH=/root/.volta/bin:$PATH

# スクリプトのコピーと実行
COPY scripts/install_runtime.sh /tmp/
RUN chmod +x /tmp/install_runtime.sh && /tmp/install_runtime.sh 