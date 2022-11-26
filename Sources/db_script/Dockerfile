FROM mcr.microsoft.com/mssql/server:2022-latest
USER root
ENV ACCEPT_EULA=Y
ENV MSSQL_SA_PASSWORD="$ROOT_PASSWORD"
ENV MSSQL_PID=Developer
RUN apt-get update && apt-get upgrade -y
COPY ./sql /var/lib/mysql
CMD ./sql/location.sql