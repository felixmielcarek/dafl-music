FROM mcr.microsoft.com/mssql/server:2022-latest
RUN apt-get update && apt-get upgrade -y
COPY ./sql /var/www/html
CMD ./sql/create.sql