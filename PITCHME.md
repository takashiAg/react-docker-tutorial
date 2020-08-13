### reactをdockerで動かしてみる
by ryosuke ando
http://github.com/takashiAg/
---
### 対象・聞いて欲しい人
- dockerやってみたいけど、なにやればいいかわからない人
- reactをやっていたけど、サーバーにデプロイしたことない人
---
### 今日のゴール
この講座を受けた人はこんな風になります
- dockerfileを書けるようになる。
- dockerを少しわかるようになる。
---
### とりあえずやってみよう
reactのアプリケーションは、下記コマンドを実行したら動く状態の前提です。
```
project_directory
└── react-application
    ├── README.md
    ├── node_modules
    ├── package.json
    ├── public
    ├── src
    └── yarn.lock
```
```
npx create-react-app react-application
cd react-application
yarn install
yarn start
```
---
### dockerfileを作成する
プロジェクトディレクトリいかにdockerfileというファイルを作成する。
```
project_directory
├── dockerfile
└── react-application
    ├── README.md
    ├── node_modules
    ├── package.json
    ├── public
    ├── src
    └── yarn.lock
```
---
### イメージを使う
docker hubでnodejsのイメージを検索する。
```
FROM node:14.8.0-alpine3.12
```
---
### ワークディレクトリとポート
ワークディレクトリとポートを指定
```
FROM node:14.8.0-alpine3.12
# コンテナ内で作業するディレクトリを指定
WORKDIR /usr/src/app
EXPOSE 3000
```
---

### dockerfileの中身を作成
プロジェクトの内容をdockerのイメージにコピー。
```
FROM node:14.8.0-alpine3.12
WORKDIR /usr/src/app
EXPOSE 3000
COPY ./react-application/ .
```

### dockerfileの中身を作成
ビルドやインストールのコマンドを`RUN`の後にいれる。
```
FROM node:14.8.0-alpine3.12
WORKDIR /usr/src/app
EXPOSE 3000
COPY ./react-application/ .
RUN yarn install
```
---
### 実行コマンド
実行コマンドを`CMD`の後にかく。
CMDは必ず１個まで。
```
FROM node:14.8.0-alpine3.12
WORKDIR /usr/src/app
EXPOSE 3000
COPY ./react-application/ .
RUN yarn install
CMD yarn start
```
---

### 動かしてみる
下記コマンドで実行できます。
```
## bash
docker run --rm -it -p 3000:3000 $(docker build -q .)
## fish
docker run --rm -it -p 3000:3000 (docker build -q .)
```
---
### dockerfileの中身を変更
package.lockやyarn.lockに変更がないとき、`yarn install`を実行せず、キャッシュを使うように。
package.lockやyarn.lockに変更があるとき、`yarn install`を実行し、キャッシュに保存。
```
FROM node:14.8.0-alpine3.12
# コンテナ内で作業するディレクトリを指定
WORKDIR /usr/src/app

EXPOSE 3000

# package.jsonとyarn.lockを/usr/src/appにコピー
COPY ./react-application/package.json .
COPY ./react-application/yarn.lock .
RUN yarn install

# ファイルを全部作業用ディレクトリにコピー
COPY ./react-application/ .
# コンテナを起動する際に実行されるコマンド
CMD yarn start
```

---

### 動かしてみる
下記コマンドで実行できます。
```
## bash
docker run --rm -it -p 3000:3000 $(docker build -q .)
## fish
docker run --rm -it -p 3000:3000 (docker build -q .)
```
---

### 結論
- reactをdockerで動かした。
- docker完全に理解した

---


### おわり
