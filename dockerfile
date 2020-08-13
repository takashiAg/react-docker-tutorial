FROM node:14.8.0-alpine3.12
# コンテナ内で作業するディレクトリを指定
WORKDIR /usr/src/app

EXPOSE 3000

COPY ./react-application/ .
RUN yarn install
# コンテナを起動する際に実行されるコマンド
CMD yarn start