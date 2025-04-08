# ツールイメージを使用
FROM work_tools:latest

# # スクリプトのコピーと実行
# COPY scripts/install_dev_packages.sh /tmp/
# RUN chmod +x /tmp/install_dev_packages.sh && bash /tmp/install_dev_packages.sh

# pip のインストールと基本パッケージのセットアップ
RUN pip install git-remote-codecommit cython numpy
# RUN pip install git-remote-codecommit cython numpy  \
#     npm install -g typescript ts-node nodemon \
#     cargo install cargo-edit cargo-watch

# コンテナ起動時のコマンド
CMD ["/bin/bash"] 