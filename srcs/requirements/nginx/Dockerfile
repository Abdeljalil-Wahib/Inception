FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y nginx openssl

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./index.html /var/www/html/index.html
# Copy the SSL certificate and key
COPY ./conf/ssl/awahib.42.fr.crt /etc/nginx/ssl/
COPY ./conf/ssl/awahib.42.fr.key /etc/nginx/ssl/

CMD ["nginx", "-g", "daemon off;"]