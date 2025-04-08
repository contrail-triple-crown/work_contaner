#!/bin/bash

# Python のインストール
add-apt-repository ppa:deadsnakes/ppa -y
apt-get update
apt-get install -y python${PYTHON_VERSION} python${PYTHON_VERSION}-venv python${PYTHON_VERSION}-dev
ln -sf /usr/bin/python${PYTHON_VERSION} /usr/bin/python3
ln -sf /usr/bin/python3 /usr/bin/python
apt-get clean
rm -rf /var/lib/apt/lists/*

# pip のインストールと基本パッケージのセットアップ
curl -sS https://bootstrap.pypa.io/get-pip.py | python
pip install --upgrade pip setuptools wheel

# VoltaのインストールとNode.jsのセットアップ
mkdir -p /root/.volta
curl https://get.volta.sh | bash
volta install node@${NODE_VERSION}
volta install npm@${NPM_VERSION}

# Rust のインストール
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. $HOME/.cargo/env
rustup default ${RUST_VERSION}
rustup component add clippy rustfmt 