# ベースイメージとしてUbuntu 22.04を使用
FROM ubuntu:22.04

# 環境変数の設定
ENV LANG=ja_JP.UTF-8 \
    LANGUAGE=ja_JP:ja \
    LC_ALL=ja_JP.UTF-8 \
    TZ=Asia/Tokyo \
    TERM=xterm \
    DEBIAN_FRONTEND=noninteractive

# # スクリプトのコピーと実行
# COPY scripts/install_base_tools.sh /tmp/
# RUN chmod +x /tmp/install_base_tools.sh && bash /tmp/install_base_tools.sh

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


# 作業ディレクトリの設定
WORKDIR /workspace 