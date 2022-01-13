
模索中
goのプロジェクト構成とクリーンアーキテクチャの欲張りセット
ソースはクリーンアーキテクチャ、その他ファイルはプロジェクト構成を採用

#### プロジェクト構成
https://github.com/golang-standards/project-layout/blob/master/README_ja.md
1リポジトリ1main.goの世界で満足しているしビルド紛れが少ないのでcmd/は採用しない
というよりDockerfile, Makefile, バージョン管理の扱いが分からない

#### クリーンアーキテクチャ
https://qiita.com/ogady/items/34aae1b2af3080e0fec4
MVCめいた思想

####  ファイル構成

ひとまず必要そうなもののみ

- api
    - swaggerとかprotoとかの定義ファイル

- config
    - env的な

- deployments
    - buildspecとかサービス用yaml

- scripts
    - Makefile

- internal
    - クリーンアーキテクチャしてみたい
        - 依存方向は2つ
            - Main > Injector > Presentation > UseCase > Domain
            - Injector > Infrastructure > Domain
        - utilは欲しくなったら作る
    - cmd
        - presentation層
        - usecase層を使用した外部との窓口
    - domain
        - テーブルカラムやAPI応答の構造体とかアクセスインターフェースとか
    - infra
        - DBとかAPIとの接続層
        - アクセスインターフェースの実装
    - usecase
        - domain層を使用したロジックの実装
    - injector
        - いわゆるDI
        - presentation層にinfra層を適用してmainに渡す
    - logger
        - 記載はないけど個人的に欲しい
        - 位置付けはDomain層
