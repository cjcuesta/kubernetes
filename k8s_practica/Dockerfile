FROM mysql
COPY ./db/db.sh /docker-entrypoint-initdb.d/db.sh
COPY ./db/my.cnf /etc/my.cnf
COPY ./db/mysqld.sh /usr/local/bin/mysqld.sh
CMD /usr/local/bin/mysqld.sh