FROM postgres:latest

ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=invmtharun
ENV POSTGRES_DB=pmtool

COPY pmtool.sql /docker-entrypoint-initdb.d/