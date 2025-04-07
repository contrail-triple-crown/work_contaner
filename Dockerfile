# ベースイメージとしてUbuntu 22.04を使用
# 様々なツールをインストールするための安定した基盤となります
FROM ubuntu:22.04

# 必要な引数を定義
ARG NODE_VERSION
ARG NPM_VERSION
ARG PYTHON_VERSION
ARG RUST_VERSION

# 環境変数の設定
# 日本語環境と時間帯を設定
ENV LANG=ja_JP.UTF-8 \
    LANGUAGE=ja_JP:ja \
    LC_ALL=ja_JP.UTF-8 \
    TZ=Asia/Tokyo \
    TERM=xterm \
    DEBIAN_FRONTEND=noninteractive

# ツール用の環境変数設定
ENV NODE_VERSION=$NODE_VERSION \
    NPM_VERSION=$NPM_VERSION \
    PYTHON_VERSION=$PYTHON_VERSION \
    RUST_VERSION=$RUST_VERSION \
    PATH=$PATH:$HOME/.cargo/bin \
    VOLTA_HOME=/root/.volta \
    PATH=/root/.volta/bin:$PATH

# ベースシステムの更新とロケール設定
# 基本的なツールとライブラリをインストール
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    build-essential \
    software-properties-common \
    ca-certificates \
    gnupg \
    less \
    groff \
    locales \
    jq \
    unzip \
    vim \
    && sed -i -E 's/# (ja_JP.UTF-8)/\1/' /etc/locale.gen \
    && locale-gen \
    && update-locale LANG=ja_JP.UTF-8 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

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

# Docker のインストール
# コンテナ内から Docker コマンドを実行できるようにする
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && chmod a+r /etc/apt/keyrings/docker.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update \
    && apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# AWS CLI と CDK のインストール
# 最新バージョンの AWS CLI をインストールし、CDK も追加
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf aws awscliv2.zip \
    && npm install -g aws-cdk

# Rust のインストール
# rustup を使用して指定されたバージョンをインストール
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    && . $HOME/.cargo/env \
    && rustup default ${RUST_VERSION} \
    && rustup component add clippy rustfmt

# 作業ディレクトリの設定
WORKDIR /workspace

# コンテナ起動時のコマンド
CMD ["/bin/bash"]

