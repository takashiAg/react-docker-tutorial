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
今reactのアプリケーションは作ってある状態とする
こんな感じ
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
### dockerfileの中身を作成
```
FROM node:14.8.0-alpine3.12
# コンテナ内で作業するディレクトリを指定
WORKDIR /usr/src/app

EXPOSE 3000

COPY ./react-application/ .
RUN yarn install
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
### dockerfileの中身を変更
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

### 


---


### おわり
