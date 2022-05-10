FROM python:3.9.10

ARG NODE_VERSION
ARG NPM_VERSION

ENV LANG jp_JP.UTF-8
ENV LANGUAGE jp_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ JST-9
ENV TERM xterm

# node
ENV NODE_VERSION=$NODE_VERSION
ENV NPM_VERSION=$NPM_VERSION
ENV VOLTA_HOME=$HOME/.volta
ENV PATH=$VOLTA_HOME/bin:$PATH
RUN curl https://get.volta.sh | bash &&\
    volta install node@$NODE_VERSION &&\
    volta install npm@$NPM_VERSION

# tools
RUN apt update &&\
    apt install -y less groff locales jq &&\
    sed -i -E 's/# (ja_JP.UTF-8)/\1/' /etc/locale.gen &&\
    locale-gen &&\
    update-locale LANG=ja_JP.UTF-8 &&\
    pip install --upgrade pip setuptools &&\
    pip install git-remote-codecommit

# aws cli and cdk
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" &&\
    unzip awscliv2.zip &&\
    ./aws/install &&\
    npm install -g aws-cdk
