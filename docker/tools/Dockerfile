# ランタイムイメージを使用
FROM work_runtime:latest

# スクリプトのコピーと実行
COPY scripts/install_tools.sh /tmp/
RUN chmod +x /tmp/install_tools.sh && /tmp/install_tools.sh

# コンテナ起動時のコマンド
CMD ["/bin/bash"] 