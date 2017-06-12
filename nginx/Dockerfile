FROM nginx:latest

ADD  nginx.conf      /etc/nginx/nginx.conf
ADD  sites-enabled/*    /etc/nginx/conf.d/
RUN  mkdir -p /data/www/html/public && mkdir -p /data/log/nginx
COPY index.php	/data/www/html/public
RUN  chown -R www-data.www-data /data/www/html /data/log/nginx

EXPOSE 80
VOLUME ["/data/www/html"]
