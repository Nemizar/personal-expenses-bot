FROM nginx:1.23.2-alpine

COPY ./docker/prod/common/nginx/snippets /etc/nginx/snippets
COPY ./docker/prod/nginx/conf.d /etc/nginx/conf.d

WORKDIR /app

COPY ./ ./
