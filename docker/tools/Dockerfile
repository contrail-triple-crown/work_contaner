# ランタイムイメージを使用
FROM work_runtime:latest

# # スクリプトのコピーと実行
# COPY scripts/install_tools.sh /tmp/
# RUN chmod +x /tmp/install_tools.sh && bash /tmp/install_tools.sh

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
# アーキテクチャに応じて適切なAWS CLIをインストールし、CDKも追加
RUN ARCH=$(uname -m) \
    && if [ "$ARCH" = "aarch64" ]; then \
        curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"; \
    else \
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"; \
    fi \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf aws awscliv2.zip \
    && npm install -g aws-cdk

#
# コンテナ起動時のコマンド
CMD ["/bin/bash"] 