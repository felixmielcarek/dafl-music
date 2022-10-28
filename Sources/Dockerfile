FROM plugins/docker
RUN apk update 
RUN apk install –y apache2 
RUN apk install –y apache2-utils 
RUN apk clean 
EXPOSE 80
CMD [“apache2ctl”, “-D”, “FOREGROUND”]