#!/bin/bash

# 基本ツールのインストール
apt-get update && apt-get install -y \
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
    vim

# ロケールの設定
sed -i -E 's/# (ja_JP.UTF-8)/\1/' /etc/locale.gen
locale-gen
update-locale LANG=ja_JP.UTF-8

# クリーンアップ
apt-get clean
rm -rf /var/lib/apt/lists/* 