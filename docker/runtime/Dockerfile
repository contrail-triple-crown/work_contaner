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
    HOME=/root \
    PATH=$PATH:/root/.cargo/bin \
    VOLTA_HOME=/root/.volta \
    PATH=/root/.volta/bin:$PATH

# # スクリプトのコピーと実行
# COPY scripts/install_runtime.sh /tmp/
# RUN chmod +x /tmp/install_runtime.sh && bash /tmp/install_runtime.sh 

# Python のインストール
# deadsnakes PPA を使用して最新バージョンをインストール
RUN add-apt-repository ppa:deadsnakes/ppa -y \
    && apt-get update \
    && apt-get install -y python${PYTHON_VERSION} python${PYTHON_VERSION}-venv python${PYTHON_VERSION}-dev \
    && ln -sf /usr/bin/python${PYTHON_VERSION} /usr/bin/python3 \
    && ln -sf /usr/bin/python3 /usr/bin/python \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# pip のインストールと基本パッケージのセットアップ
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python \
    && pip install --upgrade pip setuptools wheel \
    && pip install git-remote-codecommit cython numpy

# Voltaのインストール
# nodeのインストール
# npmのインストール
RUN mkdir -p /root/.volta \
    && curl https://get.volta.sh | bash \
    && volta install node@${NODE_VERSION} \
    && volta install npm@${NPM_VERSION}

# Rust のインストール
# rustup を使用して指定されたバージョンをインストール
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    && . $HOME/.cargo/env \
    && rustup default ${RUST_VERSION} \
    && rustup component add clippy rustfmt

