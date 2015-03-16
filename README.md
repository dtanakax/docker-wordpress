# docker-wordpress

### Base Docker Image

busybox

### 説明

Wordpressデータ格納用Dockerコンテナイメージです。

[Dockerとは？](https://docs.docker.com/ "Dockerとは？")  
[Docker Command Reference](https://docs.docker.com/reference/commandline/cli/ "Docker Command Reference")

### 使用方法

git pull後に

    $ cd docker-wordpress

イメージ作成

    $ docker build -t <tag>/wordpress .

起動

    $ docker run --name <name> -d -ti <tag>/wordpress

コンテナ内へログイン

    $ docker exec -ti <name> bash

### 利用可能なボリューム

以下のボリュームが利用可能

    /var/www/html       # Nginxドキュメントルート
    /var/lib/mysql      # MariaDBデータ領域

### 環境変数

- <code>DB_NAME</code>作成するデータベース名。指定しない場合は作成されません。
- <code>DB_USER</code>DB_NAMEへアクセス可能なユーザー名。
- <code>DB_PASSWORD</code>ユーザーパスワード。指定しない場合は空パスワードになります。
- <code>DB_HOST</code>MySQLホスト名

### Figでの使用方法

[Figとは](http://www.fig.sh/ "Figとは")  

    以下はWordpress構成サンプル

        web:
          image: tanaka0323/nginx-php
          links:
            - db
          ports:
            - "8081:80"
            - "8082:443"
          volumes_from:
            - storage
            - log

        db:
          image: tanaka0323/mariadb
          environment:
            ROOT_PASSWORD: secret
            DB_NAME: wordpress
            DB_USER: wpuser
            DB_PASSWORD: wppass
          volumes_from:
            - storage
            - log

        storage:
          image: tanaka0323/wordpress
          environment:
            DB_NAME: wordpress
            DB_USER: wpuser
            DB_PASSWORD: wppass
            DB_HOST: db
          volumes:
            - /var/www/html
            - /var/lib/mysql

        log:
          image: tanaka0323/syslog
          volumes:
            - /dev
            - /var/log

