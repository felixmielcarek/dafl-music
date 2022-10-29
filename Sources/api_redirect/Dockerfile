FROM httpd:2.4
COPY ./public-html/ /usr/local/apache2/htdocs/
CMD echo 'ServerName 127.0.0.1' >> /etc/httpd/conf/httpd.conf
CMD systemctl reload httpd