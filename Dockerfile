# See tutorial at
# https://nickjanetakis.com/blog/docker-tip-79-saving-a-postgres-database-in-a-docker-image
FROM postgres:12.4-alpine
ENV PGDATA=/data
