pull:
	docker pull nginx:latest
	docker pull php:5.6-fpm
	docker pull mysql:5.6
	docker pull redis:2.8
	docker pull memcached:1.4


dl:
	wget https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.3.tar.gz -O php/cphalcon.tgz
	wget https://pecl.php.net/get/gearman-1.1.2.tgz -O php/gearman.tgz
	wget https://pecl.php.net/get/redis-2.2.7.tgz -O php/redis.tgz
	wget https://pecl.php.net/get/memcached-2.2.0.tgz -O php/memcached.tgz
	wget https://pecl.php.net/get/xdebug-2.3.2.tgz -O php/xdebug.tgz
	wget https://pecl.php.net/get/msgpack-0.5.6.tgz -O php/msgpack.tgz
	wget https://pecl.php.net/get/memcache-2.2.7.tgz -O php/memcache.tgz
	wget https://pecl.php.net/get/xhprof-0.9.4.tgz -O php/xhprof.tgz
	wget https://pecl.php.net/get/mongo-1.6.14.tgz -O php/mongo.tgz
	wget https://pecl.php.net/get/mongodb-1.2.9.tgz -O php/mongodb.tgz


build:
	make build-nginx
	make build-mysql
	make build-php


build-nginx:
	docker build -t plateno/nginx ./nginx

run-nginx:
	docker run -i -d -p 80:80 -v ~/opt:/opt -t plateno/nginx

in-nginx:
	docker run -i -p 80:80 -v ~/opt:/opt -t plateno/nginx /bin/bash

build-php:
	docker build -t plateno/php ./php

run-php:
	docker run -i -d -p 9000:9000 -v ~/opt:/opt -t plateno/php

in-php:
	docker run -i -p 9000:9000 -v ~/opt:/opt -t plateno/php /bin/bash

build-mysql:
	docker build -t plateno/mysql ./mysql

run-mysql:
	docker run -i -d -p 3306:3306 -v ~/opt/data/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -t plateno/mysql

in-mysql:
	docker run -i -p 3306:3306  -v ~/data/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -t plateno/mysql /bin/bash

clean:
	docker rmi -f $(shell docker images | grep "<none>" | awk "{print \$3}")
