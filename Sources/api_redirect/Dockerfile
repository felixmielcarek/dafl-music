#FROM httpd:2.4
#COPY ./public-html/ /usr/local/apache2/htdocs/

FROM httpd:2.4
COPY ./public-html/ /usr/local/apache2/htdocs/
RUN  mkdir -p /run/apache2/ && \
     chown www-data:www-data /run/apache2/ && \
     chmod 777 /run/apache2/

EXPOSE 80 443