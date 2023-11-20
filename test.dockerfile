#FROM mysql:8.0.30 AS mysql-client
#FROM mongo:5.0.14-focal AS mongo-client
# FROM postgres:14 AS psql-client
#FROM scratch
FROM ubuntu:latest
LABEL org.opencontainers.image.authors="labring"

USER root
ENV HOME /root
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /root
COPY migration.sh /root/

RUN arch                                                                                                                        && \
    apt-get update --fix-missing                                                                                                             && \
    apt-get install -y --no-install-recommends -o Acquire::http::No-Cache=True                                                     \
    ca-certificates curl wget bind9-utils git g++ gcc libc6-dev make pkg-config vim                                                \
    ncurses-dev libtolua-dev exuberant-ctags gdb dnsutils iputils-ping net-tools mysql-server postgresql postgresql-contrib  mongodb-org      && \
    apt-get clean && rm -rf /var/lib/apt/lists/*                                                                                && \
    chmod a+x /root/migration.sh && \
    curl https://dl.min.io/client/mc/release/linux-amd64/mc --create-dirs -o /root/minio-binaries/mc \
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add -
RUN echo "deb http://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list
RUN apt-get update && apt-get install -y mongodb-org

#COPY --from=mysql-client /usr/bin/mysql /usr/bin/mysql
#COPY --from=mongo-client /usr/bin/mongosh /usr/bin/mongosh
CMD ["sh","/root/migration.sh"]