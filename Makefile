DOCKER-COMPOSE := docker compose -f srcs/docker-compose.yml

all: up

up:
	@printf "\033[0;32mBuild, recreate, start containers\033[0m\n"
	$(DOCKER-COMPOSE) up -d --build

build:	
		@printf "\033[0;32mBuild images from dockerfiles\033[0m\n"
		$(DOCKER-COMPOSE) build
	
start:
		@printf "\033[0;32mStart stopped containers\033[0m\n"
		$(DOCKER-COMPOSE) start
		
restart:
		@printf "\033[0;32mRestart stopped containers\033[0m\n"
		$(DOCKER-COMPOSE) restart

stop:
		@printf "\033[0;32mStop containers (main process receive SIGTERM) \033[0m\n"
		$(DOCKER-COMPOSE) stop
		
down:
		@printf "\033[0;32mStop and remove containers, networks\033[0m\n"
		$(DOCKER-COMPOSE) down --rmi all --volumes --remove-orphans
		
ps:
		@printf "\033[0;32mList containers\033[0m\n"
		$(DOCKER-COMPOSE) ps

images:
		@printf "\033[0;32mList images\033[0m\n"
		docker images

volume:
		@printf "\033[0;32mList volumes\033[0m\n"
		docker volume ls
		
clean: down

fclean: clean
		@printf "\033[0;32mRemoves images, containers and volumes\033[0m\n"
		sudo rm -rf /home/$(USER)/data/wordpress/*
		sudo rm -rf /home/$(USER)/data/mariadb/*
		
prune:	fclean
		@printf "\033[0;32mRemoves all unused images, containers and volumes\033[0m\n"
		sudo docker system prune -f -a

re: fclean all
		
.PHONY: all up build start restart stop down ps images volume clean fclean prune re 