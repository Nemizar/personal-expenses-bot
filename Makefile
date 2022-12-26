init: docker-down-clear docker-pull docker-build docker-up
up: docker-up
down: docker-down
restart: down up

docker-up:
	docker-compose up -d

docker-down:
	docker-compose down --remove-orphans

docker-down-clear:
	docker-compose down -v --remove-orphans

docker-pull:
	docker-compose pull

docker-build:
	docker-compose build --pull

build:
	docker --log-level=debug build --pull --file=docker/prod/php-fpm/Dockerfile --tag=${REGISTRY}/php-fpm:${IMAGE_TAG} .
	docker --log-level=debug build --pull --file=docker/prod/nginx/Dockerfile --tag=${REGISTRY}/nginx:${IMAGE_TAG} .

try-build:
	REGISTRY=localhost IMAGE_TAG=0 make build

push:
	docker push ${REGISTRY}/nginx:${IMAGE_TAG}
	docker push ${REGISTRY}/php-fpm:${IMAGE_TAG}

deploy:
	ssh ${HOST} -p ${PORT} 'rm -rf bot_${BUILD_NUMBER}'
	ssh ${HOST} -p ${PORT} 'mkdir bot_${BUILD_NUMBER}'
	scp -P ${PORT} docker-compose-production.yml ${HOST}:bot_${BUILD_NUMBER}/docker-compose-production.yml
	ssh ${HOST} -p ${PORT} 'cd bot_${BUILD_NUMBER} && echo "COMPOSE_PROJECT_NAME=auction" >> .env'
	ssh ${HOST} -p ${PORT} 'cd bot_${BUILD_NUMBER} && echo "REGISTRY=${REGISTRY}" >> .env'
	ssh ${HOST} -p ${PORT} 'cd bot_${BUILD_NUMBER} && echo "IMAGE_TAG=${IMAGE_TAG}" >> .env'
	ssh ${HOST} -p ${PORT} 'cd bot_${BUILD_NUMBER} && docker-compose -f docker-compose-production.yml pull'
	ssh ${HOST} -p ${PORT} 'cd bot_${BUILD_NUMBER} && docker-compose -f docker-compose-production.yml up --build --remove-orphans -d'
	ssh ${HOST} -p ${PORT} 'rm -f bot'
	ssh ${HOST} -p ${PORT} 'ln -sr bot_${BUILD_NUMBER} bot'

rollback:
	ssh ${HOST} -p ${PORT} 'cd bot_${BUILD_NUMBER} && docker-compose -f docker-compose-production.yml pull'
	ssh ${HOST} -p ${PORT} 'cd bot_${BUILD_NUMBER} && docker-compose -f docker-compose-production.yml up --build --remove-orphans -d'
	ssh ${HOST} -p ${PORT} 'rm -f bot'
	ssh ${HOST} -p ${PORT} 'ln -sr bot_${BUILD_NUMBER} bot'
