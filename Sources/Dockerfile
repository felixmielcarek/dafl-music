FROM plugins/docker
RUN apk update 
RUN apk add apache2 
RUN apk add apache2-utils 
RUN apk cache -v sync 
EXPOSE 80
CMD [“apache2ctl”, “-D”, “FOREGROUND”]