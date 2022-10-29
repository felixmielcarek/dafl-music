#FROM httpd:2.4
#COPY ./public-html/ /usr/local/apache2/htdocs/

FROM httpd:2.4
WORKDIR /usr/local/apache2/htdocs/
RUN chmod -R 755 /usr/local/apache2/htdocs/
COPY ./public-html/index.html /usr/local/apache2/htdocs/
RUN chown www-data:www-data /usr/local/apache2/htdocs/ -R