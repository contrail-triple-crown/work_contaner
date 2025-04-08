# ツールイメージを使用
FROM work_tools:latest

# スクリプトのコピーと実行
COPY scripts/install_dev_packages.sh /tmp/
RUN chmod +x /tmp/install_dev_packages.sh && /tmp/install_dev_packages.sh

# コンテナ起動時のコマンド
CMD ["/bin/bash"] 