# This is the default command that will run when you just type "make"
# It will build and start all your services in the background.
all: up

# Builds and starts the containers.
# --build: forces a rebuild of the images if the Dockerfiles have changed.
# -d: runs the containers in detached mode (in the background).
up:
	docker compose -f ./srcs/docker-compose.yml up --build -d

# Stops and removes the containers and networks.
down:
	docker compose -f ./srcs/docker-compose.yml down

# A full cleanup.
# Stops containers, and removes containers, networks, volumes, and images.
# WARNING: This will delete your database and WordPress data.
clean:
	docker compose -f ./srcs/docker-compose.yml down -v --rmi all

# A quick way to rebuild everything from scratch.
re: clean all

# Tells 'make' that these are command names, not files.
.PHONY: all up down clean re