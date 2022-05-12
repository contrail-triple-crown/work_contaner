
# AWS作業コンテナ

## 概要

このコンテナは私が個人の作業用に作ったもので、主な目的としては、AWS CDKを使いたいといったものになります。  
AWS CLIを使用する為には、ホストのhomgeに.awsディレクトリが必要です。  
imageがpythonなのは元々pythonだけ使ってた名残ですが、今後個別にインストールするように修正するかもしれません。  

# 速攻立ち上げる

このコンテナを速攻で立ち上げる方法が以下になります。

## 事前準備

- AWS CLI インストール
  - configreの設定も済ませておく（.awsをコンテナでマウントしてる）
- VScode
- VScode 拡張機能：[Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## 手順

cloneしたらディレクトリに移動してVSCodeを立ち上げてコマンドパレットを開き拡張機能のコマンドを使います。

- クローン  
`git clone https://github.com/contrail-triple-crown/work_contaner.git`  
- ディレクトリ移動  
`cd work_contaner`  
- VScode起動  
`code .`  
- コマンドパレット開く  
`Ctrl + Shift + p`  
- 拡張機能のコマンドを叩く  
`remote-containers: open Folder in container`

# nodeについて

.envに環境変数を設定してます。  

- NODE_VERSION
- NPM_VERSION

nodeのバージョン管理としてvoltaを使用してますので、デフォルトでインストールされるバージョンを設定しています。  
.envの値を好きなバージョンに変更してお使いください。
