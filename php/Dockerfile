FROM php:5.4-fpm

# Install env
ADD sources.list    /etc/apt/sources.list
RUN apt-get update && apt-get install -y \
        git \
        libgearman-dev \
        libmemcached-dev \
        libmcrypt-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
	libxml2-dev \
	libssl-dev \
        && rm -r /var/lib/apt/lists/*


# Install PHP extensions
COPY memcached.tgz /home/memcached.tgz
COPY memcache.tgz /home/memcache.tgz
COPY redis.tgz /home/redis.tgz
COPY mongo.tgz /home/mongo.tgz
COPY mongodb.tgz /home/mongodb.tgz
COPY memcache.tgz /home/memcache.tgz
COPY xhprof.tgz /home/xhprof.tgz
COPY cphalcon.tgz /home/cphalcon.tgz

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install zip \
        && docker-php-ext-install gd \
        && docker-php-ext-install mbstring \
        && docker-php-ext-install mcrypt \
        && docker-php-ext-install pdo_mysql \
        && docker-php-ext-install soap
RUN pecl install /home/memcached.tgz && echo "extension=memcached.so" > /usr/local/etc/php/conf.d/memcached.ini \
	&& pecl install /home/memcache.tgz && echo "extension=memcache.so" > /usr/local/etc/php/conf.d/memcache.ini \
        && pecl install /home/redis.tgz && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini \
        && pecl install /home/memcache.tgz && echo "extension=memcache.so" > /usr/local/etc/php/conf.d/memcache.ini \
        && pecl install /home/mongo.tgz && echo "extension=mongo.so" > /usr/local/etc/php/conf.d/mongo.ini \
        && pecl install /home/mongodb.tgz && echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/mongodb.ini \
        && pecl install /home/xhprof.tgz && echo "extension=xhprof.so" > /usr/local/etc/php/conf.d/xhprof.ini 
RUN cd /home \
    && tar -xvf cphalcon.tgz \
    && mv cphalcon-* phalcon \
    && cd phalcon/build && ./install && echo "extension=phalcon.so" > /usr/local/etc/php/conf.d/phalcon.ini

# PHP config
ADD php.ini    /usr/local/etc/php/php.ini
ADD php-fpm.conf    /usr/local/etc/php-fpm.conf

# Composer
#ADD composer.phar /usr/local/bin/composer
#RUN chmod 755 /usr/local/bin/composer

WORKDIR /opt

# Write Permission
RUN usermod -u 1000 www-data

EXPOSE 9000
#VOLUME ["/opt"]
