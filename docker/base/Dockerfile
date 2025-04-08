# ベースイメージとしてUbuntu 22.04を使用
FROM ubuntu:22.04

# 環境変数の設定
ENV LANG=ja_JP.UTF-8 \
    LANGUAGE=ja_JP:ja \
    LC_ALL=ja_JP.UTF-8 \
    TZ=Asia/Tokyo \
    TERM=xterm \
    DEBIAN_FRONTEND=noninteractive

# スクリプトのコピーと実行
COPY scripts/install_base_tools.sh /tmp/
RUN chmod +x /tmp/install_base_tools.sh && /tmp/install_base_tools.sh

# 作業ディレクトリの設定
WORKDIR /workspace 