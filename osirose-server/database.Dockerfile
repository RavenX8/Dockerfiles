FROM ravenx8/ubuntu-dev as build
WORKDIR /opt

RUN git clone https://github.com/dev-osrose/osIROSE-new.git /opt/osIROSE-new-src

FROM mariadb:latest as mysql-server
COPY --from=build /opt/osIROSE-new-src/Database/osirose.sql /docker-entrypoint-initdb.d/1-osirose.sql
COPY --from=build /opt/osIROSE-new-src/Database/logs.sql /docker-entrypoint-initdb.d/2-logs.sql
COPY --from=build /opt/osIROSE-new-src/Database/item_db.sql /docker-entrypoint-initdb.d/3-item_db.sql
COPY --from=build /opt/osIROSE-new-src/Database/skill_db.sql /docker-entrypoint-initdb.d/4-skill_db.sql