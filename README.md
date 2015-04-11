![wordpress latest](https://img.shields.io/badge/wordpress-latest-brightgreen.svg) ![License MIT](https://img.shields.io/badge/license-MIT-blue.svg)

docker-wordpress
=====================

Base Docker Image
---------------------

[tanaka0323/storage](https://bitbucket.org/tanaka0323/docker-storage)

説明
---------------------

Wordpressデータ格納用Dockerコンテナイメージです。

[Dockerとは？](https://docs.docker.com/)  
[Docker Command Reference](https://docs.docker.com/reference/commandline/cli/)

使用方法
---------------------

git pull後に

    $ cd docker-wordpress

イメージ作成

    $ docker build -t tanaka0323/wordpress .

起動

    $ docker run --name <name> -d \
                 -e DB_NAME="wordpress" \
                 -e DB_USER="wpuser" \
                 -e DB_PASSWORD="wppass" \
                 -e DB_HOST="db:3306" \
                 -ti tanaka0323/wordpress

コンテナ内へログイン

    $ docker exec -ti <name> bash

利用可能なボリューム
---------------------

以下のボリュームが利用可能

    /var/www/html       # Nginxドキュメントルート
    /var/lib/mysql      # MariaDBデータ領域

環境変数
---------------------

- `DB_NAME` 作成するデータベース名。指定しない場合は作成されません。
- `DB_USER` DB_NAMEへアクセス可能なユーザー名。
- `DB_PASSWORD` ユーザーパスワード。指定しない場合は空パスワードになります。
- `DB_HOST` MySQLホスト名

Docker Composeでの使用方法
---------------------

[Docker Composeとは](https://docs.docker.com/compose/)  

[設定ファイル記述例](https://bitbucket.org/tanaka0323/compose-examples)

License
---------------------

The MIT License
Copyright (c) 2015 Daisuke Tanaka

以下に定める条件に従い、本ソフトウェアおよび関連文書のファイル（以下「ソフトウェア」）の複製を取得するすべての人に対し、ソフトウェアを無制限に扱うことを無償で許可します。これには、ソフトウェアの複製を使用、複写、変更、結合、掲載、頒布、サブライセンス、および/または販売する権利、およびソフトウェアを提供する相手に同じことを許可する権利も無制限に含まれます。

上記の著作権表示および本許諾表示を、ソフトウェアのすべての複製または重要な部分に記載するものとします。

ソフトウェアは「現状のまま」で、明示であるか暗黙であるかを問わず、何らの保証もなく提供されます。ここでいう保証とは、商品性、特定の目的への適合性、および権利非侵害についての保証も含みますが、それに限定されるものではありません。 作者または著作権者は、契約行為、不法行為、またはそれ以外であろうと、ソフトウェアに起因または関連し、あるいはソフトウェアの使用またはその他の扱いによって生じる一切の請求、損害、その他の義務について何らの責任も負わないものとします。