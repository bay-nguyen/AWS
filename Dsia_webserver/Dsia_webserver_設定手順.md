# 社内ウェブサーバ構築
### 参考したサイト（https://qiita.com/3y9Mz/items/dc3b598243ae9ce04a7c）


## ■EC2構築手順
- AWSコンソール操作
	- インスタンス名：cpweb
	- OS：Amazon Linux
	- インスタンスタイプ：t3.small
	- ディスク：SSD、gp3、30GB
	- キーペア：key-cpweb（新規作成）
	- セキュリティグループ：SG-CPWEB-SSH
	- サブネット：cpweb-pub-aza
	- パブリックIP自動割り当て：有効化
	
- サーバ基本設定
	- 日本時間設定
	- date コマンド実行し、設定変更前にUTC時間であることを確認
	-  以下のローカルタイムゾーンファイルを編集し、保存する。
   	```
   	$ vi /etc/sysconfig/clock
   	```
	- 変更内容：
 	   - ZONE="Japan"
	- サーバ再起動	
	- 再度dateコマンドを実行し、JST時間になっていることを確認する


- ホスト名設定
	- hostname コマンドで設定変更前に”XXXX.ap-northeast-1.compute.internal”になっていることを確認
	- 以下のコマンドを実行する
	```
    	$ sudo hostnamectl set-hostname cpweb01
	```
	- 再度hostnameコマンドを実行し、ホスト名がcpweb01になっていることを確認
## ■httpd設定
- インストールコマンドを実行
  ```
　　　　dnf install -y httpd
- サービス起動
　　　　systemctl start httpd
- サービス確認
　　　　systemctl status httpd
- サービス自動起動設定
　　　　systemctl enable httpd.service
- 設定後確認（enable)
　　　　systemctl is-enabled httpd.service

## ■mysql設定
　- リポジトリをインストール
　　　  dnf -y localinstall  https://dev.mysql.com/get/mysql80-community-release-el9-1.noarch.rpm
- GPGキーをインポート
　　　　systemctl start mysql
- パッケージをインストール
　　　　dnf install mysql-community-server mysql-community-client mysql-community-devel
　　　　systemctl is-enabled mysqld
- サービス起動
　　　　systemctl start mysqld
　　　　systemctl status mysqld
　　
## ■php設定
- phpインストール
　　　  dnf -y install php-fpm php-mysqli php-json php php-devel

## ■WordPress設定
　- ディレクトリ移動
　　　　cd /var/www/html
- wordpressダウンロード
　　　　wget https://ja.wordpress.org/latest-ja.tar.gz
- ファイル展開
　　　　tar -zxvf latest-ja.tar.gz
- 展開後、不要なファイルを削除する（ディスク確保のため）
　　　　rm -rf latest-ja.tar.gz


## ■DBログイン
- sudo mysql -u root -p

- 初期パスワードは以下のファイルを開いて確認する。
　　　　cat /var/log/mysqld.log

- ログイン後パスワードを変更する
　　　　ALTER USER 'root'@'localhost' IDENTIFIED BY 'Dsia_20240626#@';

## ■DB作成
　　　　`CREATE USER 'ユーザ名' IDENTIFIED BY 'パスワード';
　　　　CREATE DATABASE `データベース名`;
　　　　GRANT ALL PRIVILEGES ON `データベース名`.* TO "ユーザ名";
　　　　FLUSH PRIVILEGES;
　　　　SHOW DATABASES;
　　　　EXIT;
  `

８）Wordpressファイル修正
　　　　cd www/var/html/wordpress
　　　　cp wp-config-sample.php wp-config.php
　　　　vi wp-config.php (DB名、パスワード等、暗号キー)

９）httpd設定ファイル修正
　　・ディレクトリ移動
　　　　cd /etc/httpd/conf
　　・対象ファイル（httpd.conf）以下のようにwordpressパスを修正
　　　　/var/www/html　→　/var/www/html/wordpress

１０）httpd再起動
　　　　systemctl restart httpd

１１）ブラウザでログインする
　　　　http://＜ipアドレス＞
　　　　wordpress情報登録



※その他（必要に応じて実施する）

①プラグインを手動でアップロード時に以下の権限を付与する
chmod 0707 /wp-content/upgrade
chmod 0707 /wp-content/themes
chmod 0707 /wp-content/plugins

②FTPリダイレクト無効化
wp-config.phpにdefine('FS_METHOD', 'direct');

※以下の行より前に、追加
/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
    define('ABSPATH', dirname(__FILE__) . '/');

③サーバではpublic IPアドレスを利用する場合、サーバ停止→起動すると新しいIPが割り当てられるので、
以前のIPアドレスが無効されてサーバにアクセスできない。
そのため、データベースに登録したIPアドレスを更新する必要となる。
・mysql -u root - p
・パスワードを入力し、ログインする。
・use bitnami_wordpress;
・select * from wp_options where option_name = 'siteurl';
・update wp_options set option_value = 'http://(変更後IPアドレス)' where option_name = 'siteurl';






